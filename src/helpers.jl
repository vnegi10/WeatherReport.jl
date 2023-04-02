function fetch_lat_long(city::String, i_row::Int64)

	city = fix_city_name(city)
	
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
        error("Coordinates for city not found!")
    else
        lat  = df_city[!, :LATITUDE][i_row]
        long = df_city[!, :LONGITUDE][i_row]
        timezone = df_city[!, :TIMEZONE][i_row]
    end

    return GeogCoord(lat, long, timezone)
	
end

function url_to_df(url::String)

    df_cities = DataFrame()

    try
        df_cities = CSV.File(HTTP.get(url,
                             require_ssl_verification = false).body,
                             header = 1) |> DataFrame
    catch
        error("Unable to load cities database, check if $(url) is accessible!")
    end
	
    return df_cities
	
end

function fix_city_name(city::String)

	return [uppercase(city[1]), lowercase(city[2:end])] |> join

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

    # Filter DataFrame to start from current hour
    df_data = from_current_time(df_data)

    @assert days*24 ≤ nrow(df_data) "Not enough data, try again with less days!"
    df_data = df_data[1:days*24, :]

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
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

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
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

    TIME     = map(x -> parse(DateTime, x),
                   response_dict["hourly"]["time"])
    FORECAST = map(x -> convert(Float64, x),
                   response_dict["hourly"][forecast_type])

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
        # Historical data has a delay of up to a week
        end_time = Dates.Date(time) - Dates.Day(7)

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