function plot_temp_forecast(city::String)

    df_temp = get_temp_forecast(city)

    plt = lineplot(
        df_temp[!, :TIME],
        df_temp[!, :TEMP],
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

    return plt

end