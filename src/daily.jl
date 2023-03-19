function get_current(city::String, i_row::Int64)

    location = fetch_lat_long(city, i_row)
    lat      = location.latitude
    long     = location.longitude
    timezone = location.timezone

    params_1 = "?latitude=$(lat)&longitude=$(long)&current_weather=true"
    params_2 = "&daily=sunrise,sunset&timezone=$(timezone)"
    current_dict = get_api_response(params_1 * params_2, URL_FORECAST)

    return current_dict

end

function get_daily(city::String, i_row::Int64)

    location = fetch_lat_long(city, i_row)
    lat      = location.latitude
    long     = location.longitude
    timezone = location.timezone

    params = ["?latitude=$(lat)&longitude=$(long)",
              "&daily=temperature_2m_max,temperature_2m_min,",
              "apparent_temperature_max,apparent_temperature_min,",
              "precipitation_sum,precipitation_hours,",
              "precipitation_probability_mean,weathercode",
              "&timezone=$(timezone)"]

    current_dict = get_api_response(join(params), URL_FORECAST)

    return current_dict

end