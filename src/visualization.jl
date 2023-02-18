function plot_temp_forecast(city::String;
                            days::Int64 = 7)

    results = get_temp_forecast(city)
    df_temp, location = results[1], results[2]
    time_zone = location.timezone

    @assert days*24 ≤ nrow(df_temp) "Not enough data, try again with less days!"
    df_temp = df_temp[1:days*24, :]

    t_min, t_max = minimum(df_temp[!, :TEMP]), maximum(df_temp[!, :TEMP])

    plt = lineplot(
        df_temp[!, :TIME],
        df_temp[!, :TEMP],
        title  = "$(city): min $(t_min) °C, max $(t_max) °C",
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