function get_hourly_forecast(city::String,
                             forecast_type::String,
                             i_row::Int64)

    location = fetch_lat_long(city, i_row)
    lat      = location.latitude
    long     = location.longitude

    url = get_url(forecast_type)
    
    params        = "?latitude=$(lat)&longitude=$(long)&hourly=$(forecast_type)"
    response_dict = get_api_response(params, url)

    TIME     = map(x -> parse(DateTime, x),
                   response_dict["hourly"]["time"])
    FORECAST = map(x -> convert(Float64, x),
                   response_dict["hourly"][forecast_type])

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly, location
    
end

function get_hourly_forecast(forecast_type::String,
                             lat::Float64,
                             long::Float64)

    url = get_url(forecast_type)

    params        = "?latitude=$(lat)&longitude=$(long)&hourly=$(forecast_type)"
    response_dict = get_api_response(params, url)

    time_zone = response_dict["timezone"]

    TIME     = map(x -> parse(DateTime, x),
                   response_dict["hourly"]["time"])
    FORECAST = map(x -> convert(Float64, x),
                   response_dict["hourly"][forecast_type])

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly, time_zone
	
end

function get_hourly_forecast(city::String,
                             forecast_type::String,
                             i_row::Int64,
                             start_date::String,
                             end_date::String)

    location = fetch_lat_long(city, i_row)
    lat      = location.latitude
    long     = location.longitude

    url = get_url(forecast_type, true)
    
    params = ["?latitude=$(lat)&longitude=$(long)",
              "&start_date=$(start_date)&end_date=$(end_date)",
              "&hourly=$(forecast_type)"]

    response_dict = get_api_response(join(params), url)

    TIME     = map(x -> parse(DateTime, x),
                   response_dict["hourly"]["time"])
    FORECAST = map(x -> convert(Float64, x),
                   response_dict["hourly"][forecast_type])

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly, location
    
end

function get_hourly_forecast(forecast_type::String,
                             lat::Float64,
                             long::Float64,
                             start_date::String,
                             end_date::String)

    url = get_url(forecast_type, true)
    
    params = ["?latitude=$(lat)&longitude=$(long)",
              "&start_date=$(start_date)&end_date=$(end_date)",
              "&hourly=$(forecast_type)"]

    response_dict = get_api_response(join(params), url)

    time_zone = response_dict["timezone"]

    TIME     = map(x -> parse(DateTime, x),
                   response_dict["hourly"]["time"])
    FORECAST = map(x -> convert(Float64, x),
                   response_dict["hourly"][forecast_type])

    df_hourly = DataFrame(TIME = TIME,
                          FORECAST = FORECAST)

    return df_hourly, time_zone
    
end