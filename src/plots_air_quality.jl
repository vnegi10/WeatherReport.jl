"""
"""
function plot_hourly_pm(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        days::Int64 = 6)

    df_pm1, df_pm2 = [DataFrame() for i = 1:2]
    time_zone = ""

    if ~isempty(city)
        results = get_hourly_forecast(city, "pm10", i_row)
        df_pm1, location = results[1], results[2]
        time_zone = location.timezone

        df_pm2 = get_hourly_forecast(city, "pm2_5", i_row)[1]
    else
        results = get_hourly_forecast("pm10", lat, long)
        df_pm1, time_zone = results[1], results[2]

        df_pm2 = get_hourly_forecast("pm2_5", lat, long)[1]
    end

    try
        insertcols!(df_pm1,
                    ncol(df_pm1)+1,
                    :PM_2_5 => df_pm2[!, :FORECAST])
    catch
        @info "Unable to add pm < 2.5 μm, value set to zeros!"
        insertcols!(df_pm1,
                    ncol(df_pm1)+1,
                    :PM_2_5 => fill(0.0, nrow(df_pm1)))
    end

    # Filter DataFrame to start from current hour
    df_pm1 = from_current_time(df_pm1)

    @assert days*24 ≤ nrow(df_pm1) "Not enough data, try again with less days!"

    # Select based on given number of days
    df_pm1 = df_pm1[1:days*24, :]

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    end

    plt = lineplot(
        df_pm1[!, :TIME],
        [df_pm1[!, :FORECAST] df_pm1[!, :PM_2_5]],
        title  = "$(city)",
        xlabel = "Time [days]",
        ylabel = "[μg/m^3]",
        name   = ["Part. matter < 10 μm" "Part. matter < 2.5 μm"],
        xticks = true,
        yticks = true,
        border = :bold,
        color = [:yellow :cyan],
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
        grid = true
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end