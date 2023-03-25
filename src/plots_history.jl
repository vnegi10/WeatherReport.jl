"""
    plot_hist_temp(city::String = "",
                   i_row::Int64 = 1;
                   lat::Float64 = 0.0,
                   long::Float64 = 0.0,
                   start_date::String = "2023-01-01",
                   end_date::String = "2023-01-10")

Shows the hourly air temperature [°C] at 2 meter above
ground and 'feels like' temperature for a given city between
start_date and end_date.

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `start_date::String` : Starting day in ISO8601 date format, e.g. "2023-02-01"
- `end_date::String` : Ending day in ISO8601 date format, e.g. "2023-02-25"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia
julia> plot_hist_temp("Veldhoven", start_date = "2022-01-01", end_date = "2022-12-31")
             ⠀⠀⠀⠀⠀⠀Veldhoven: min -5.9 °C, max 36.4 °C from 2022-01-01 to 2022-12-31)⠀⠀⠀⠀⠀                
             ⠀Timezone: Europe/Amsterdam⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀                
             ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓                
        36.4 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ Air temperature
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢠⠀⠀⠀⠀⢸⡇⡀⠀⡄⢠⡄⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ Feels like     
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⣼⢸⠀⠀⠀⢰⢸⡇⡇⢠⡇⢸⣇⠀⣿⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃                
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⢀⠀⠀⣿⣼⢰⡀⠀⣸⢸⣿⣇⣾⡇⣿⣿⣴⣿⢀⣿⡇⣠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃                
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣼⣇⡇⠀⢸⢠⣤⣿⣿⣾⣷⣠⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣇⣿⠀⠀⠀⠀⡀⠀⠀⠀⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃                
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⢸⠀⡀⠀⠀⢸⣿⣿⣿⣷⢠⣾⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣀⠀⢀⡇⡀⣀⣤⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃                
             ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠀⣾⣶⠀⠀⢸⣷⣷⣇⣼⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⢿⣿⢻⡿⠛⣿⢻⣿⣿⣿⣿⣠⣿⣀⣾⣷⣇⣿⣿⣿⣧⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠┃                
   [°C]      ┃⡆⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⢠⣿⣧⣿⣿⡆⣄⢸⣿⣿⣿⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⣿⡏⢻⣿⣿⡟⣿⠘⢸⠇⢸⡇⠀⢸⠀⡟⠃⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⢸┃                
             ┃⣷⠀⠀⠀⠀⢰⣀⣸⣦⣾⣴⣇⣴⣸⣿⣿⣿⣿⡇⣿⣾⣿⣿⣿⣿⣿⡿⣿⢸⣿⣿⡿⠛⣿⠛⡇⠘⠻⡟⠃⢻⠀⠈⠀⢸⠀⠀⠈⠀⠃⠀⠀⠈⣿⣿⣿⣿⣿⣿⢿⡏⠋⣿⣿⣿⣿⣄⣷⡆⠀⠀⠀⣰⣷⣿┃                
             ┃⣿⣠⠀⣇⣆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿⣿⣿⡿⡇⠇⠈⠿⣿⡇⠀⠸⠀⠃⠀⠀⠀⠀⠈⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⢻⡟⣿⢻⢻⡟⢸⠁⠀⠹⣿⢿⣿⣿⣿⣷⢀⠀⠀⣿⣿⣿┃                
             ┃⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⠃⠁⠀⠀⠀⠁⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢻⠀⢸⡇⠈⠀⠀⠀⡟⢸⡟⣿⣿⢻⣸⡆⠀⡿⢻⣿┃                
             ┃⣸⣿⣿⣿⣿⣿⣇⣿⣿⣟⣿⣿⣿⣿⣇⣿⣿⣿⣿⣿⣿⣹⣃⣘⣙⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣈⣀⣘⣇⣀⣀⣀⣀⣃⣀⣇⣿⣸⣸⣿⣿⣴⣇⣸⣿┃                
             ┃⢸⣿⣿⡟⣿⡏⠇⠻⢻⠀⢿⣿⢿⣿⠇⢸⠟⠀⣿⡇⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠸⡟⣿⣿⡇⠈⠁┃                
             ┃⠀⠹⠃⠀⠸⠀⠀⠀⠸⠀⠀⢸⠸⣿⠀⠀⠀⠀⢹⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⢸⣿⡇⠀⠀┃                
        -9.8 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀┃                
             ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛                
             ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀                
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                
```
"""
function plot_hist_temp(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        start_date::String = "2023-01-01",
                        end_date::String = "2023-01-10")

    fmt = "yyyy-mm-dd"
    t1 = DateTime(start_date, fmt)
    t2 = DateTime(end_date, fmt)

    @assert t1 < t2 "End date cannot be before start date!"

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
        results = get_hourly_forecast("temperature_2m",
                                       lat,
                                       long,
                                       start_date,
                                       end_date)

        df_temp, time_zone = results[1], results[2]

        df_app_temp = get_hourly_forecast("apparent_temperature",
                                           lat,
                                           long,
                                           start_date,
                                           end_date)[1]
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