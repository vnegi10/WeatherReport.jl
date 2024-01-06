function set_city(city::String)
    @set_preferences!("city" => city)
    @info "$(city) has been set as the preferred location"
end

function get_city()
    return @load_preference("city", default = "")
end

function fetch_lat_long(city::String, i_row::Int64)

	city = fix_input_name(city)
	
    df_city = filter(row -> ~ismissing(row.CITY) &&
                             row.CITY == city, DF_CITIES)

    if nrow(df_city) > 1
        @info "More than one match found, showing report for location in row $(i_row)."
        @info "You can select another location by its row index."
        "$(println(df_city))"
    end

    lat, long = 0, 0
    timezone  = ""

    if isempty(df_city)
        # Find closest match to inform the user
        find_match = closest_match(city)

        # Add lines to highlight the message
        println("------------------------------------------------")
        @info("$(city) not found, did you mean $(find_match[1])?")
        println("------------------------------------------------")

        # Better to throw an error and let the user select the closest match if
        # needed
        error("Coordinates for city not found!")
    else
        lat  = df_city[!, :LATITUDE][i_row]
        long = df_city[!, :LONGITUDE][i_row]
        timezone = df_city[!, :TIMEZONE][i_row]
    end

    return GeogCoord(lat, long, timezone)
	
end

function closest_match(city::String)

    all_valid_cities = filter(x -> ~ismissing(x), DF_CITIES.CITY)

    # https://en.wikipedia.org/wiki/Levenshtein_distance
    dist = Levenshtein()
    find_match = findnearest(city, all_valid_cities, dist)

    return find_match

end

function csv_to_df(path::String)

    df_cities = DataFrame()

    try
        df_cities = CSV.read(path, DataFrame)
    catch
        error("Unable to load cities database, check if $(path) is valid!")
    end
	
    return df_cities
	
end

function fix_input_name(input::String)

    # Check if there is a space in the name, e.g. "The Hague"
    input_parts = split(input, " ")

    if length(input_parts) == 1
        fixed_name = [uppercase(input[1]),
                      lowercase(input[2:end])] |> join
    else
        for (i, value) in enumerate(input_parts)
            input_parts[i] = [uppercase(value[1]),
                              lowercase(value[2:end])] |> join
        end
        fixed_name = join(input_parts, " ")
    end

    return fixed_name

end

function from_current_time(df_hourly::DataFrame)

    time = now()
    curr_day   = Dates.day(time)
    curr_month = Dates.month(time)
    curr_year  = Dates.year(time)
    curr_hour  = Dates.hour(time)

    time_match = DateTime(curr_year, curr_month, curr_day, curr_hour)

    df_current = filter(row -> row.TIME ≥ time_match, df_hourly)

    return df_current

end

function df_to_plot(city::String,
                    df_data::DataFrame;
                    days::Int64,
                    lat::Float64,
                    long::Float64,
                    xlabel::String,
                    ylabel::String,
                    color::Symbol,
                    time_zone::String)

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    # Filter DataFrame to start from current hour
    df_data = from_current_time(df_data)

    @assert days*24 ≤ nrow(df_data) "Not enough data, try again with less days!"
    df_data = df_data[1:days*24, :]

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    else
        city = fix_input_name(city)
    end

    plt = lineplot(
        df_data[!, :TIME],
        df_data[!, :FORECAST],
        title  = "$(city)",
        xlabel = xlabel,
        ylabel = ylabel,
        xticks = true,
        yticks = true,
        border = :bold,
        color = color,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end

function df_to_plot(city::String,
                    df_data::DataFrame,
                    start_date::String,
                    end_date::String;
                    lat::Float64,
                    long::Float64,
                    xlabel::String,
                    ylabel::String,
                    color::Symbol,
                    time_zone::String)

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    else
        city = fix_input_name(city)
    end

    plt = lineplot(
        df_data[!, :TIME],
        df_data[!, :FORECAST],
        title  = "$(city) from $(start_date) to $(end_date)",
        xlabel = xlabel,
        ylabel = ylabel,
        xticks = true,
        yticks = true,
        border = :bold,
        color = color,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end

function get_url(forecast_type::String, hist::Bool = false)

    url = ""

    if forecast_type in HOURLY_FORECAST
        hist ? url = URL_HIST : url = URL_FORECAST
    elseif forecast_type in HOURLY_AIR_QUALITY
        url = URL_AIR
    else 
        error("Forecast type is currently not supported!")
    end

    return url

end

function dict_to_df(response_dict::Dict, forecast_type::String)

    TIME = map(x -> parse(DateTime, x),
               response_dict["hourly"]["time"])

    # Filter out absent data marked as nothing
    all_values = response_dict["hourly"][forecast_type]
    valid_values = filter(x -> !isnothing(x), all_values)

    FORECAST = map(x -> convert(Float64, x), valid_values)

    # Make sure both columns are of equal length
    TIME = TIME[1:length(FORECAST)]

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly

end

function check_dates(start_date::String, end_date::String)

    fmt = "yyyy-mm-dd"
    t1 = DateTime(start_date, fmt)
    t2 = DateTime(end_date, fmt)

    @assert t1 < t2 "End date cannot be before start date!"

    return nothing

end

function get_monthly_data(df_data::DataFrame)

    monthly_data = Vector{Vector{Float64}}()
    all_months = map(x -> Dates.monthname(x), df_data[!, :TIME]) |> unique

    for month in all_months
        df_filter = filter(row -> Dates.monthname(row.TIME) == month, df_data)
        push!(monthly_data, df_filter[!, :FORECAST])
    end

    return all_months, monthly_data

end

function convert_dates(year::String)

    time = now()
    curr_year = Dates.year(time)
    
    start_date = "$(year)-01-01"
    if year == "$(curr_year)"
        # Historical data has a delay of up to two weeks
        end_time = Dates.Date(time) - Dates.Day(14)

        # Ensure format is YYYY-MM-DD
        end_month = Dates.month(end_time)
        end_month = lpad("$(end_month)", 2, "0")

        end_day = Dates.day(end_time)
        end_day = lpad("$(end_day)", 2, "0")

        end_date = "$(year)-$(end_month)-$(end_day)"
    else
        end_date = "$(year)-12-31"
    end

    return start_date, end_date

end

function get_time_range(num_years::Int64)

    time = now()
    curr_year = Dates.year(time)

    start_year = curr_year - num_years
    start_date = "$(start_year)-01-01"

    # Historical data has a delay of up to two weeks
    end_date = "$(Dates.Date(time) - Dates.Day(14))"

    return start_date, end_date

end

function compare_yearly_data(df_data::DataFrame, month::String)

    # Fix names with improper case, e.g. "jan", "JAn" -> "Jan"
    month = fix_input_name(month)

    df_month = filter(row -> occursin(month, Dates.monthname(row.TIME)), df_data)
    years = map(x -> Dates.year(x), df_month[!, :TIME]) |> unique

    all_years = String[]
    yearly_data = Vector{Vector{Float64}}()

    for year in years
        push!(all_years, "$(year)")
        df_filter = filter(row -> Dates.year(row.TIME) == year, df_month)
        push!(yearly_data, df_filter[!, :FORECAST])
    end

    return all_years, yearly_data

end

function get_plotting_data(variable, city, i_row, lat, long, year)

    start_date, end_date = convert_dates(year)

    df_data = DataFrame()
    time_zone = ""

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    if ~isempty(city)
        input = CityHistInput(city,
                              variable,
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)

        df_data, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput(variable,
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_data, time_zone = results[1], results[2]
    end

    all_months, monthly_data = get_monthly_data(df_data)

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    else
        city = fix_input_name(city)
    end

    return all_months, monthly_data, city, time_zone

end

function get_plotting_data(variable, city, i_row, lat, long, month, num_years)

    start_date, end_date = get_time_range(num_years)

    df_data = DataFrame()
    time_zone = ""

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    if ~isempty(city)
        input = CityHistInput(city,
                              variable,
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)

        df_data, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput(variable,
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_data, time_zone = results[1], results[2]
    end

    all_years, yearly_data = compare_yearly_data(df_data, month)

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    else
        city = fix_input_name(city)
    end

    return all_years, yearly_data, city, time_zone

end

function get_hourly_data(variable, city, i_row, lat, long)

    df_data = DataFrame()
    time_zone = ""

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    if ~isempty(city)
        input = CityInput(city, variable, i_row)
        results = get_hourly_forecast(input)
        df_data, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationInput(variable, lat, long)
        results = get_hourly_forecast(input)
        df_data, time_zone = results[1], results[2]
    end

    return df_data, time_zone

end

function get_hist_data(variable, city, i_row, lat, long, start_date, end_date)

    check_dates(start_date, end_date)

    df_hist = DataFrame()
    time_zone = ""

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    if ~isempty(city)
        input = CityHistInput(city,
                              variable,
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)
        df_hist, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput(variable,
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)
        df_hist, time_zone = results[1], results[2]
    end

    return df_hist, time_zone

end

function get_hist_temp_data(city, i_row, lat, long, start_date, end_date)

    check_dates(start_date, end_date)

    df_temp, df_app_temp = [DataFrame() for i = 1:2]
    time_zone = ""

    if ~isempty(city)
        input = CityHistInput(city,
                              "temperature_2m",
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)

        df_temp, location = results[1], results[2]
        time_zone = location.timezone

        input.forecast_type = "apparent_temperature"
        df_app_temp = get_hourly_forecast(input)[1]
    else
        input = LocationHistInput("temperature_2m",
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_temp, time_zone = results[1], results[2]

        input.forecast_type = "apparent_temperature"
        df_app_temp = get_hourly_forecast(input)[1]
    end

    try
        insertcols!(df_temp,
                    ncol(df_temp)+1,
                    :APP_TEMP => df_app_temp[!, :FORECAST])
    catch
        @info "Unable to add apparent temperature, value set to zeros!"
        insertcols!(df_temp,
                    ncol(df_temp)+1,
                    :APP_TEMP => fill(0.0, nrow(df_temp)))
    end

    return df_temp, time_zone

end

function try_catch_hist_data(variable, city, i_row, lat, long, start_date, end_date)

    df_data = DataFrame()

    try
        df_data, _ = get_hist_data(variable, city, i_row, lat, long, start_date, end_date)
    catch
        @info "Unable to fetch historical data for $(variable)"
    end

    return df_data

end

function collect_all_data(city, i_row, lat, long, start_date, end_date)

    # Vector of DataFrames to store all the data
    df_all = DataFrame[]

    # Temp. data uses a different function, so we add it first
    # to df_all
    df_temp = DataFrame()

    try
        df_temp, _ = get_hist_temp_data(city,
                                        i_row,
                                        lat,
                                        long,
                                        start_date,
                                        end_date)
    catch
        @info "Unable to fetch historical data for hourly temperature"
    end

    rename!(df_temp, Dict(:FORECAST => "temperature_2m"))
    push!(df_all, df_temp)

    variables = ["rain",
                 "snowfall",
                 "relativehumidity_2m",
                 "windspeed_10m",
                 "shortwave_radiation"]

    for variable in variables
        df_data = try_catch_hist_data(variable,
                                      city,
                                      i_row,
                                      lat,
                                      long,
                                      start_date,
                                      end_date)

        if ~isempty(df_data)
            rename!(df_data, Dict(:FORECAST => "$(variable)"))
        end

        push!(df_all, df_data)
    end

    # Convert DateTime to String format for SQLite database since DateTime
    # ends up being stored as a blob
    for df_each in df_all
        df_each[!, :TIME] = map(x -> Dates.format(x, "yyyy-mm-dd HH:MM:SS"),
                                df_each[!, :TIME])
    end

    return df_all

end

function save_to_db(df_input::DataFrame, db_name::String, table_name::String)

    db_save = SQLite.DB(db_name)

    SQLite.load!(df_input,
                 db_save,
                 table_name;
                 temp = false,
                 ifnotexists = false,
                 replace = false,
                 on_conflict = nothing,
                 analyze = false)

end

# Execute test in a try-catch block
function execute_test(call_func)

    try
        call_func
    catch e
        global errors = true
        showerror(stdout, e, backtrace())
        println()
    end

end

#=function get_cities_lat_long(file::String)

	all_lines  = readlines(file)
	
	city_name, time_zone = [String[] for i = 1:2]
	lat, long  = [Float64[] for i = 1:2]

	for line in all_lines
		
		line_parts = split(line, "\t")

		# City name
		push!(city_name, line_parts[3])

		# IANA timezone ID
		push!(time_zone, line_parts[18])

		# City coordinates
		push!(lat, parse(Float64, line_parts[5]))
		push!(long, parse(Float64, line_parts[6]))

	end

	df_cities = DataFrame(CITY = city_name,
	                      TIMEZONE = time_zone,
	                      LATITUDE = lat,
	                      LONGITUDE = long)

	return df_cities
	
end=#