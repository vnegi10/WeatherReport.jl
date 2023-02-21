function get_hourly_forecast(city::String, forecast_type::String)

	location = fetch_lat_long(city)
	lat      = location.latitude
	long     = location.longitude
	
	params        = "?latitude=$(lat)&longitude=$(long)&hourly=$(forecast_type)"
	response_dict = get_api_response(params)

    TIME     = map(x -> parse(DateTime, x), response_dict["hourly"]["time"])
	FORECAST = map(x -> convert(Float64, x), response_dict["hourly"][forecast_type])

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly, location
	
end