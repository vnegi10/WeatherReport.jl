function get_temp_forecast(city::String)

	location = fetch_lat_long(city)
	lat      = location.latitude
	long     = location.longitude

	params    = "?latitude=$(lat)&longitude=$(long)&hourly=temperature_2m"
	temp_dict = get_api_response(params)

	TIME = map(x -> parse(DateTime, x),
               temp_dict["hourly"]["time"])

	TEMP = map(x -> convert(Float64, x),
            temp_dict["hourly"]["temperature_2m"])

	df_temp = DataFrame(TIME = TIME,
	                    TEMP = TEMP)

	return df_temp, location

end