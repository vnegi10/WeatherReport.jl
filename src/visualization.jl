"""
"""
function plot_temp_forecast(city::String;
                            days::Int64 = 7)

    results = get_hourly_forecast(city, "temperature_2m")
    df_temp, location = results[1], results[2]
    time_zone = location.timezone

    @assert days*24 ≤ nrow(df_temp) "Not enough data, try again with less days!"
    df_temp = df_temp[1:days*24, :]

    T_min, T_max = minimum(df_temp[!, :FORECAST]), maximum(df_temp[!, :FORECAST])

    plt = lineplot(
        df_temp[!, :TIME],
        df_temp[!, :FORECAST],
        title  = "$(city): min $(T_min) °C, max $(T_max) °C",
        xlabel = "Time [days]",
        ylabel = "Temperature [°C]",
        xticks = true,
        yticks = true,
        border = :bold,
        color = :yellow,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
        grid = true
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end

"""
"""
function show_current_weather(city::String)

    current_dict = get_current(city)

    timezone     = current_dict["timezone"]
    timezone_abb = current_dict["timezone_abbreviation"]

    elevation  = current_dict["elevation"]
    wind_speed = current_dict["current_weather"]["windspeed"]
    temp       = current_dict["current_weather"]["temperature"]
    code       = current_dict["current_weather"]["weathercode"]
    condition  = WEATHER_CODES[code]

    dt_sunrise = parse(DateTime, current_dict["daily"]["sunrise"][1])
    dt_sunset  = parse(DateTime, current_dict["daily"]["sunset"][1])

    t_sunrise  = "$(dt_sunrise |> hour):$(dt_sunrise |> minute)"
    t_sunset   = "$(dt_sunset |> hour):$(dt_sunset |> minute)"

    data = [timezone elevation wind_speed temp condition t_sunrise t_sunset]
    header = (["Timezone", "Elevation", "Wind speed", "Temperature", "Condition", "🌅", "🌆"],
              ["[$(timezone_abb)]", "[m]", "[km/h]",      "[°C]",     "[]",     "[hh:mm]", "[hh:mm]"])

    p_table = pretty_table(data;
                           header = header)

    return p_table

end

"""
"""
function plot_rain_forecast(city::String;
                            days::Int64 = 7)

    results = get_hourly_forecast(city, "rain")
    df_rain, location = results[1], results[2]
    time_zone = location.timezone

    @assert days*24 ≤ nrow(df_rain) "Not enough data, try again with less days!"
    df_rain = df_rain[1:days*24, :]

    plt = lineplot(
        df_rain[!, :TIME],
        df_rain[!, :FORECAST],
        title  = "$(city)",
        xlabel = "Time [days]",
        ylabel = "Rain [mm]",
        xticks = true,
        yticks = true,
        border = :bold,
        color = :red,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end

"""
"""
function plot_snow_forecast(city::String;
                            days::Int64 = 7)

    results = get_snow_forecast(city)
    df_snow, location = results[1], results[2]
    time_zone = location.timezone

    @assert days*24 ≤ nrow(df_snow) "Not enough data, try again with less days!"
    df_snow = df_snow[1:days*24, :]

    plt = lineplot(
        df_snow[!, :TIME],
        df_snow[!, :SNOW],
        title  = "$(city)",
        xlabel = "Time [days]",
        ylabel = "Snowfall [cm]",
        xticks = true,
        yticks = true,
        border = :bold,
        color = :white,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end