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
```julia-repl
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

    check_dates(start_date, end_date)

    df_temp, df_app_temp = [DataFrame() for i = 1:2]
    time_zone = ""

    if ~isempty(city)
        input = CityHistInput(city,
                              "temperature_2m",
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)

        df_temp, location = results[1], results[2]
        time_zone = location.timezone

        input.forecast_type = "apparent_temperature"
        df_app_temp = get_hourly_forecast(input)[1]
    else
        input = LocationHistInput("temperature_2m",
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_temp, time_zone = results[1], results[2]

        input.forecast_type = "apparent_temperature"
        df_app_temp = get_hourly_forecast(input)[1]
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

"""
    plot_hist_rain(city::String = "",
                   i_row::Int64 = 1;
                   lat::Float64 = 0.0,
                   long::Float64 = 0.0,
                   start_date::String = "2023-01-01",
                   end_date::String = "2023-01-10")

Shows the hourly rain from large scale weather systems 
of the preceding hour in millimeter [mm] for a given 
city between start_date and end_date.

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
```julia-repl
julia> plot_hist_rain("Haldwani", start_date = "2022-01-01", end_date = "2022-12-31")
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Haldwani from 2022-01-01 to 2022-12-31⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
                ⠀Timezone: Asia/Kolkata⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀ 
                ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
             20 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
   Rain [mm]    ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⢸⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢸⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢸⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡆⣸⠀⠀⠀⢠⢸⡇⠀⡆⡄⠀⠀⠀⠀⠀⡄⢸⠀⠀⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⠀⠀⠀⠀⠀⠀⡇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⣿⠀⢸⠀⢸⢸⣇⠀⡇⡇⠀⠀⠀⠀⡀⣷⣸⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                ┃⠀⡀⠀⠀⢰⠀⢠⡇⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⠀⢸⠀⠀⡆⠀⠀⠀⠀⠀⢸⣿⣿⢠⢸⣇⢸⣿⣿⢰⡇⣷⡇⣦⣶⢀⣿⣿⣿⠀⠀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
              0 ┃⣸⣷⣆⣀⣾⣀⣸⣇⣇⣀⣀⣆⣀⣀⣀⣠⣀⣀⣀⣀⣀⣇⣸⣀⣠⣿⣿⣸⣤⣆⣧⣀⣀⣀⣤⣀⣿⣿⣿⣿⣾⣿⣾⣿⣿⣿⣇⣿⣧⣿⣿⣼⣿⣿⣿⣆⣶⡟⣇⣰⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀┃ 
                ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
                ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀ 
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
```
"""
function plot_hist_rain(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        start_date::String = "2023-01-01",
                        end_date::String = "2023-01-10")

    check_dates(start_date, end_date)

    df_rain = DataFrame()
    time_zone = ""

    if ~isempty(city)
        input = CityHistInput(city,
                              "rain",
                               i_row,
                               start_date,
                               end_date)
        results = get_hourly_forecast(input)
        df_rain, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput("rain",
                                   lat,
                                   long,
                                   start_date,
                                   end_date)
        results = get_hourly_forecast(input)
        df_rain, time_zone = results[1], results[2]
    end

    plt = df_to_plot(city,
                     df_rain,
                     start_date,
                     end_date,
                     lat = lat,
                     long = long,
                     xlabel = "Time [days]",
                     ylabel = "Rain [mm]",
                     color = :red,
                     time_zone = time_zone)

    return plt

end

"""
    plot_hist_snow(city::String = "",
                   i_row::Int64 = 1;
                   lat::Float64 = 0.0,
                   long::Float64 = 0.0,
                   start_date::String = "2023-01-01",
                   end_date::String = "2023-01-10")

Shows the snowfall amount for the preceding hour in
centimeter [cm] for a given location (city or lat/long).

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
```julia-repl
julia> plot_hist_snow("Tromso", start_date = "2022-01-01", end_date = "2022-12-31")
                   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Tromso from 2022-01-01 to 2022-12-31⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
                   ⠀Timezone: Europe/Oslo⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀ 
                   ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
                 3 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
   Snowfall [cm]   ┃⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⢸⣿⢠⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀┃ 
                   ┃⠀⠀⣿⣿⢸⠀⠀⠀⠀⠀⠀⢸⡀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⢀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀┃ 
                   ┃⡀⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⢸⡇⡄⠀⢸⢸⠀⠀⠀⠀⠀⠀⢠⢸⠀⡇⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢀⠀⠀⢸⠀⠀⠀⠀⣼⠀⠀⠀⣄⡀┃ 
                   ┃⡇⡄⣿⣿⣿⠀⠀⠀⡀⠀⠀⣿⣧⡇⠀⢸⣾⠀⠀⠀⠀⢀⠀⢸⢸⢸⣧⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢸⠀⠀⢸⠀⠀⠀⠀⣿⠀⢀⠀⣿⡇┃ 
                   ┃⣷⣧⣿⣿⣿⣤⠀⡄⡇⡆⠀⣿⣿⡇⡀⢸⣿⣦⣰⠀⠀⣾⠀⢸⣾⣼⣿⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⣿⣼⡆⢀⢸⠀⠀⠀⢰⣿⠀⢸⣄⣿⡇┃ 
                 0 ┃⣿⣿⣿⣿⣿⣿⣆⣷⣷⣇⣀⣿⣿⣷⣇⣸⣿⣿⣿⣄⣶⣿⣀⣾⣿⣿⣿⣼⣇⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣇⣸⣿⣿⣇⣸⣸⣀⣀⣀⣸⣿⣀⣾⣿⣿⣿┃ 
                   ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
                   ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀ 
                   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
```
"""
function plot_hist_snow(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        start_date::String = "2023-01-01",
                        end_date::String = "2023-01-10")

    check_dates(start_date, end_date)

    df_snow = DataFrame()
    time_zone = ""

    if ~isempty(city)
        input = CityHistInput(city,
                              "snowfall",
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)
        df_snow, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput("snowfall",
                                   lat,
                                   long,
                                   start_date,
                                   end_date)
        results = get_hourly_forecast(input)
        df_snow, time_zone = results[1], results[2]
    end

    plt = df_to_plot(city,
                     df_snow,
                     start_date,
                     end_date,
                     lat = lat,
                     long = long,
                     xlabel = "Time [days]",
                     ylabel = "Snowfall [cm]",
                     color = :white,
                     time_zone = time_zone)

    return plt

end

"""
    plot_hist_humidity(city::String = "",
                       i_row::Int64 = 1;
                       lat::Float64 = 0.0,
                       long::Float64 = 0.0,
                       start_date::String = "2023-01-01",
                       end_date::String = "2023-01-10")

Shows the relative humidity at 2 meter above ground
for a given city between start_date and end_date.

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
```julia-repl
julia> plot_hist_humidity("Chennai", start_date = "2022-01-01", end_date = "2022-12-31")
                         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Chennai from 2022-01-01 to 2022-12-31⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
                         ⠀Timezone: Asia/Kolkata⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀ 
                         ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
                     100 ┃⠀⠀⣄⠀⣠⠀⠀⡀⠀⠀⢠⠀⡄⢰⣧⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⡀⠀⠀⠀⠀⣠⡀⠀⠀⠀⠀⣀⠀⣠⣠⣴⠀⠀⠀⡀⢀⢀⠀⣦⡀⡀⠀⠀⠀⠀⣿┃ 
                         ┃⡇⣦⣿⣶⣿⡇⣿⡇⠀⠀⣿⢰⣿⢸⣿⣿⣿⣷⣶⣾⣰⠀⡀⣶⣆⣷⡆⣾⡆⠀⠀⠀⠀⠀⡄⣆⢠⡆⡀⠀⠀⣷⣿⣶⡇⠀⢰⠀⣦⣿⣷⣶⠀⠀⡄⣿⠀⣿⣿⣿⡇⣼⣿⣷⣼⣿⢰⣿⣿⣧⣾⣿⡄⢸⣿┃ 
                         ┃⣧⣿⣿⣿⣿⣷⣿⡇⠀⡀⣿⣼⣿⢸⣿⣿⣿⣿⣿⣿⣿⣼⣷⣿⣿⣿⣇⣿⣷⡀⠀⠀⡀⢀⣿⣿⣸⣧⣇⠀⣰⣿⣿⣿⣇⠀⢸⣶⣿⣿⣿⣿⣰⡇⡇⣿⣄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣾⣿┃ 
                         ┃⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⡇⢸⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⠀⣼⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿┃ 
                         ┃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⢰⣧⣼⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⡇⣿⣿⣿⣿⣿⢿⣿⣿⡿⣿┃ 
                         ┃⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⡇⣿⡿⣿⣿⣿⢸⣿⣿⡇⣿┃ 
                         ┃⣿⣿⡏⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⢿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⢿⣿⡇⣿⠁⢻⡇⠉⡿⢻⠀⢹⣿⡇⣿┃ 
   Rel. humidity [%]     ┃⣿⢿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿⠸⣿⣿⣿⣿⡏⣿⢿⣿⣿⣿⡟⣿⠘⠋⠹⢸⣿⡇⢸⠀⢸⡇⠀⡇⠘⠀⠸⡟⡇⢿┃ 
                         ┃⠻⢸⠁⢸⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⠀⣿⣿⣿⣿⠃⠋⠸⣿⣿⣿⡇⣿⠀⠀⠀⢸⡇⡇⠘⠀⠈⡇⠀⠃⠀⠀⠀⠇⠀⠸┃ 
                         ┃⠀⠈⠀⢸⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⡏⢿⣿⣿⣿⣿⣿⡟⢿⣿⣿⠉⣿⣿⠘⠇⢸⠀⣿⣿⣿⣿⠀⠀⠀⣿⣿⣿⡇⢸⠀⠀⠀⢸⡇⠇⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                         ┃⠀⠀⠀⠘⠈⠀⢸⢻⡿⢿⣿⣿⡏⣿⣿⣿⡿⢻⣿⡿⠇⣿⣿⣿⣿⢿⣿⠃⢸⣿⣿⣿⣿⣿⠁⠀⣿⣿⠀⢻⡿⠀⠀⠈⠀⣿⣿⣿⠇⠀⠀⠀⠀⣿⣿⠀⠈⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                         ┃⠀⠀⠀⠀⠀⠀⠀⠸⠁⠀⢸⣿⡇⢿⣿⣿⡇⠈⡇⠀⠀⢻⠈⣿⣿⢸⣿⠀⢸⡏⣿⣿⢻⣿⠀⠀⠃⠀⠀⢸⡇⠀⠀⠀⠀⢻⠇⠈⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                         ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠘⡿⡟⠀⠀⠁⠀⠀⠀⠀⠁⢻⠀⠁⠀⠘⠀⣿⠉⢸⡏⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                         ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠋⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                      30 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
                         ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀ 
                         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
```
"""
function plot_hist_humidity(city::String = "",
                            i_row::Int64 = 1;
                            lat::Float64 = 0.0,
                            long::Float64 = 0.0,
                            start_date::String = "2023-01-01",
                            end_date::String = "2023-01-10")

    check_dates(start_date, end_date)

    df_hum = DataFrame()
    time_zone = ""

    if ~isempty(city)
        input = CityHistInput(city,
                              "relativehumidity_2m",
                              i_row,
                              start_date,
                              end_date)
        results = get_hourly_forecast(input)
        df_hum, location = results[1], results[2]
        time_zone = location.timezone
    else
        input = LocationHistInput("relativehumidity_2m",
                                   lat,
                                   long,
                                   start_date,
                                   end_date)
        results = get_hourly_forecast(input)
        df_hum, time_zone = results[1], results[2]
    end

    plt = df_to_plot(city,
                     df_hum,
                     start_date,
                     end_date,
                     lat = lat,
                     long = long,
                     xlabel = "Time [days]",
                     ylabel = "Rel. humidity [%]",
                     color = :green,
                     time_zone = time_zone)

    return plt

end