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