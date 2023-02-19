function get_snow_forecast(city::String)

	location = fetch_lat_long(city)
	lat      = location.latitude
	long     = location.longitude
	
	params    = "?latitude=$(lat)&longitude=$(long)&hourly=snowfall"
	snow_dict = get_api_response(params)

    TIME = map(x -> parse(DateTime, x), snow_dict["hourly"]["time"])
	SNOW = map(x -> convert(Float64, x), snow_dict["hourly"]["snowfall"])

    df_snow = DataFrame(TIME = TIME,
                        SNOW = SNOW)

    return df_snow, location
	
end