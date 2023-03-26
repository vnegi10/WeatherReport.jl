function get_hourly_forecast(input::CityInput)

    location = fetch_lat_long(input.city, input.i_row)
    lat      = location.latitude
    long     = location.longitude
    forecast_type = input.forecast_type

    url = get_url(forecast_type)
    params = "?latitude=$(lat)&longitude=$(long)&hourly=$(forecast_type)"
    response_dict = get_api_response(params, url)

    df_hourly = dict_to_df(response_dict, forecast_type)

    return df_hourly, location
    
end

function get_hourly_forecast(input::LocationInput)

    forecast_type = input.forecast_type
    url = get_url(forecast_type)
    params = "?latitude=$(input.lat)&longitude=$(input.long)&hourly=$(forecast_type)"
    response_dict = get_api_response(params, url)

    time_zone = response_dict["timezone"]
    df_hourly = dict_to_df(response_dict, forecast_type)

    return df_hourly, time_zone
	
end

function get_hourly_forecast(input::CityHistInput)

    location = fetch_lat_long(input.city, input.i_row)
    lat      = location.latitude
    long     = location.longitude
    forecast_type = input.forecast_type

    url = get_url(forecast_type, true)

    params = ["?latitude=$(lat)&longitude=$(long)",
              "&start_date=$(input.start_date)&end_date=$(input.end_date)",
              "&hourly=$(forecast_type)"]

    response_dict = get_api_response(join(params), url)
    df_hourly = dict_to_df(response_dict, forecast_type)

    return df_hourly, location
    
end

function get_hourly_forecast(input::LocationHistInput)

    forecast_type = input.forecast_type
    url = get_url(forecast_type, true)
    
    params = ["?latitude=$(input.lat)&longitude=$(input.long)",
              "&start_date=$(input.start_date)&end_date=$(input.end_date)",
              "&hourly=$(forecast_type)"]

    response_dict = get_api_response(join(params), url)
    time_zone = response_dict["timezone"]
    df_hourly = dict_to_df(response_dict, forecast_type)

    return df_hourly, time_zone
    
end