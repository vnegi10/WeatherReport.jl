function fetch_lat_long(city::String)
	
	df_city = filter(row -> ~ismissing(row.CITY) &&
                             row.CITY == city, DF_CITIES)
	lat, long = 0, 0
    timezone  = ""

	if isempty(df_city)
        error("Coordinates for city not found!")
	else
        lat  = df_city[!, :LATITUDE][1]
        long = df_city[!, :LONGITUDE][1]
        timezone = df_city[!, :TIMEZONE][1]
	end

	return GeogCoord(lat, long, timezone)
	
end

function url_to_df(url::String)
	
	df = CSV.File(HTTP.get(url,
	                       require_ssl_verification = false).body,
                           header = 1) |> DataFrame
	
	return df
	
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