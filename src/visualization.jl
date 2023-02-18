"""
"""
function plot_temp_forecast(city::String;
                            days::Int64 = 7)

    results = get_temp_forecast(city)
    df_temp, location = results[1], results[2]
    time_zone = location.timezone

    @assert days*24 ≤ nrow(df_temp) "Not enough data, try again with less days!"
    df_temp = df_temp[1:days*24, :]

    T_min, T_max = minimum(df_temp[!, :TEMP]), maximum(df_temp[!, :TEMP])

    plt = lineplot(
        df_temp[!, :TIME],
        df_temp[!, :TEMP],
        title  = "$(city): min $(T_min) °C, max $(T_max) °C",
        xlabel = "Time [days]",
        ylabel = "Temperature [°C]",
        xticks = true,
        yticks = true,
        border = :bold,
        color = :yellow,
        canvas = BrailleCanvas,
        width = 100,
        height = :auto,
        grid = true
    )

    label!(plt, :t, "Timezone: $(time_zone)")
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