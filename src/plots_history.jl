"""
"""
function plot_hist_temp(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        start_date::String = "2023-01-01",
                        end_date::String = "2023-01-10")

    df_temp, df_app_temp = [DataFrame() for i = 1:2]
    time_zone = ""

    if ~isempty(city)
        results = get_hourly_forecast(city,
                                      "temperature_2m",
                                      i_row,
                                      start_date,
                                      end_date)

        df_temp, location = results[1], results[2]
        time_zone = location.timezone

        df_app_temp = get_hourly_forecast(city,
                                          "apparent_temperature",
                                          i_row,
                                          start_date,
                                          end_date)[1]
    else
        results = get_hourly_forecast("temperature_2m", lat, long)
        df_temp, time_zone = results[1], results[2]

        df_app_temp = get_hourly_forecast("apparent_temperature", lat, long)[1]
    end

    try
        insertcols!(df_temp,
                    ncol(df_temp)+1,
                    :APP_TEMP => df_app_temp[!, :FORECAST])
    catch
        @info "Unable to add apparent temperature, value set to zeros!"
        insertcols!(df_temp,
                    ncol(df_temp)+1,
                    :APP_TEMP => fill(0.0, nrow(df_temp)))
    end

    # Get min, max air temp to show on the plot
    T_min, T_max = minimum(df_temp[!, :FORECAST]), maximum(df_temp[!, :FORECAST])

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    end

    plt = lineplot(
        df_temp[!, :TIME],
        [df_temp[!, :FORECAST] df_temp[!, :APP_TEMP]],
        title  = "$(city): min $(T_min) °C, max $(T_max) °C from $(start_date) to $(end_date))",
        xlabel = "Time [days]",
        ylabel = "[°C]",
        name   = ["Air temperature" "Feels like"],
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