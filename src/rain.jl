function get_rain_forecast(city::String)

	location = fetch_lat_long(city)
	lat      = location.latitude
	long     = location.longitude
	
	params    = "?latitude=$(lat)&longitude=$(long)&hourly=rain"
	rain_dict = get_api_response(params)

    TIME = map(x -> parse(DateTime, x), rain_dict["hourly"]["time"])
	RAIN = map(x -> convert(Float64, x), rain_dict["hourly"]["rain"])

    df_rain = DataFrame(TIME = TIME,
                        RAIN = RAIN)

    return df_rain, location
	
end