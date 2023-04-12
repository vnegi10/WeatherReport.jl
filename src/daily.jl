function generate_dict(city::String, i_row::Int64)

    location = fetch_lat_long(city, i_row)
    lat      = location.latitude
    long     = location.longitude
    timezone = location.timezone

    params_dict = Dict(
                  "current" => ["?latitude=$(lat)&longitude=$(long)&current_weather=true",
                                "&daily=sunrise,sunset&timezone=$(timezone)"],
                  "daily" => ["?latitude=$(lat)&longitude=$(long)",
                              "&daily=temperature_2m_max,temperature_2m_min,",
                              "apparent_temperature_max,apparent_temperature_min,",
                              "precipitation_sum,precipitation_hours,",
                              "precipitation_probability_mean,weathercode",
                              "&timezone=$(timezone)"]
                  )

    return params_dict

end

function get_forecast(input::CityInput)

    params_dict = generate_dict(input.city, input.i_row)
    params = params_dict[input.forecast_type]
    current_dict = get_api_response(join(params), URL_FORECAST)

    return current_dict

end