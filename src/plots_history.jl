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

    # Get city based on user preference
    if isempty(city) && (lat == long == 0.0)
        city = get_city()
    end

    df_temp, time_zone = get_hist_temp_data(city,
                                            i_row,
                                            lat,
                                            long,
                                            start_date,
                                            end_date)

    # Get min, max air temp to show on the plot
    T_min, T_max = minimum(df_temp[!, :FORECAST]), maximum(df_temp[!, :FORECAST])

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    else
        city = fix_input_name(city)
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

    df_rain, time_zone = get_hist_data("rain",
                                       city,
                                       i_row,
                                       lat,
                                       long,
                                       start_date,
                                       end_date)

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

    df_snow, time_zone = get_hist_data("snowfall",
                                       city,
                                       i_row,
                                       lat,
                                       long,
                                       start_date,
                                       end_date)

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

    df_hum, time_zone = get_hist_data("relativehumidity_2m",
                                       city,
                                       i_row,
                                       lat,
                                       long,
                                       start_date,
                                       end_date)

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

"""
    plot_hist_windspeed(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        start_date::String = "2023-01-01",
                        end_date::String = "2023-01-10")

Shows the wind speed at 10 meter above ground for a given city
between start_date and end_date.

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
julia> plot_hist_windspeed("Veldhoven", start_date = "2022-01-01", end_date = "2022-12-31")
                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Veldhoven from 2022-01-01 to 2022-12-31⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
                        ⠀Timezone: Europe/Amsterdam⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀ 
                        ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
                     60 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                        ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                        ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                        ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                        ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                        ┃⠀⠀⠀⠀⠀⠀⡇⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀┃ 
                        ┃⡄⠀⠀⠀⠀⠀⡇⣶⠀⢸⣿⡆⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸┃ 
   Wind speed [km/h]    ┃⡇⢀⠀⠀⠀⢠⡇⣿⠀⣾⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⢠⠀⢀⡄⠀⢠⠀⠀⠀⠀⠀⠀⠀⡀⣿┃ 
                        ┃⣿⢸⠀⠀⠀⢸⣷⣿⢠⣿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⡀⠀⠀⠀⠀⠀⢸⠀⠀⣰⠀⠀⡇⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⡄⡇⡇⠀⠀⢸⠀⢸⣧⡇⢸⠀⠀⠀⠀⠀⠀⣄⣧⣿┃ 
                        ┃⣿⣿⠀⠀⡄⣿⣿⣿⣾⣿⣿⡇⠀⠀⡇⣸⡄⠀⣾⣿⡇⠀⢸⡇⠀⠀⢸⡀⣠⣿⡇⢀⡇⠀⢸⠀⠀⡄⣷⡀⠀⡇⡇⣷⢰⠀⠀⠀⠀⠀⠀⢸⠀⡇⠀⡇⡇⡇⠀⠀⢸⡀⣿⣿⡇⢸⢰⡆⢠⠀⠀⠀⣿⣿⣿┃ 
                        ┃⣿⣿⠀⣷⡇⣿⣿⣿⣿⣿⣿⣿⠀⣸⣿⣿⡇⠀⣿⣿⣧⠀⢸⣧⠀⠀⢸⣿⣿⣿⣧⢸⣷⣰⢸⢀⡆⣿⣿⣷⡀⡇⡇⣿⣼⠀⢀⠀⢰⣸⡀⣿⢠⣿⠀⡇⣿⣧⠀⣧⣿⣇⣿⣿⣿⣾⣸⣧⣸⡄⠀⠀⣿⣿⣿┃ 
                        ┃⣿⣿⢰⣿⡇⣿⣿⠈⣿⡿⢸⣿⣸⣿⣿⣿⡇⣆⣿⣿⣿⣼⣿⣿⣇⡇⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⡇⣇⣿⣿⣿⣿⣾⣿⣼⣿⡇⣿⢸⣿⢠⣷⣿⣿⣶⣿⣿⣿⡇⡏⢹⣿⣿⢿⣿⣇⡆⡄⣿⣿⠋┃ 
                        ┃⣿⣿⣿⣿⢧⣿⣿⠀⣿⠃⠘⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⡿⣿⣿⣧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣼⢹⣸⣿⣿⣿⣿⣿⣿⣿⡇⡇⢸⡟⣿⠘⣿⢿⣷⣷⣿⣿⠀┃ 
                        ┃⢹⠹⡿⣿⢸⡇⢹⠀⠿⠀⠀⢹⡟⡿⢸⣿⣿⢿⢿⠃⣿⡇⠇⢿⢸⣿⡟⣿⣿⡏⠹⣿⠟⢿⢿⢿⣿⢿⣿⣿⣿⣿⠻⡿⣿⠁⣿⣿⣿⡇⢹⣿⣿⠘⣿⢿⢻⠻⣿⣿⠛⢹⡇⡇⢸⠃⡟⠀⡟⢸⣿⣿⢿⢹⠀┃ 
                      0 ┃⠀⠀⠃⠸⠸⡇⠀⠀⠀⠀⠀⠸⠁⠀⠀⠁⠟⠸⠀⠀⠟⠃⠀⠀⠸⢹⠇⠁⠀⠁⠀⠻⠀⠈⠘⠸⡏⠘⠏⠸⠘⠹⠀⠇⠁⠀⠻⠛⠏⠀⠸⠃⣿⠀⠋⠸⠈⠀⠃⠘⠀⠘⠃⠁⠈⠀⠃⠀⠁⠈⠏⠹⠀⠈⠀┃ 
                        ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
                        ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀ 
                        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
```
"""
function plot_hist_windspeed(city::String = "",
                             i_row::Int64 = 1;
                             lat::Float64 = 0.0,
                             long::Float64 = 0.0,
                             start_date::String = "2023-01-01",
                             end_date::String = "2023-01-10")

    df_wind, time_zone = get_hist_data("windspeed_10m",
                                       city,
                                       i_row,
                                       lat,
                                       long,
                                       start_date,
                                       end_date)

    plt = df_to_plot(city,
                     df_wind,
                     start_date,
                     end_date,
                     lat = lat,
                     long = long,
                     xlabel = "Time [days]",
                     ylabel = "Wind speed [km/h]",
                     color = :green,
                     time_zone = time_zone)

    return plt

end

"""
    plot_hist_solar(city::String = "",
                    i_row::Int64 = 1;
                    lat::Float64 = 0.0,
                    long::Float64 = 0.0,
                    start_date::String = "2023-01-01",
                    end_date::String = "2023-01-10")

Shows the shortwave solar radiation as average of the preceding hour
for a given location (city or lat/long) between start_date and end_date.
This is equal to the total global horizontal irradiation.

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
julia> plot_hist_solar("Veldhoven", start_date = "2022-01-01", end_date = "2022-12-31")
                                   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Veldhoven from 2022-01-01 to 2022-12-31⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
                                   ⠀Timezone: Europe/Amsterdam⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀[Weather data by Open-Meteo.com]⠀ 
                                   ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
                               900 ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⢠⡆⡀⢀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢀⡀⡆⣸⣿⢸⠀⡆⡄⢸⠀⣼⡇⣇⢸⠀⠀⢠⣾⣷⣆⡀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⡇⣿⣿⣼⡇⡇⣷⣾⠀⣿⡇⣿⢸⣄⠀⢸⣿⣿⣿⣇⣶⣿⡇⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢸⣿⣿⣿⣿⣿⣿⡇⡇⣿⣿⣆⣿⣷⣿⢸⣿⡆⢸⣿⣿⣿⣿⣿⣿⡇⠀⢸⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⢀⣸⣿⣼⣿⣿⣿⣿⣿⣿⡇⣇⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣴⣾⣦⣷⡄⡆⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣄⢸⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿⣿⣿⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡇⡀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⢸⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⡇⡇⣿⢸⢸⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
   Shortwave radiation [W/m^2]     ┃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣇⣷⣿⢸⣾⣿⡇⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⠀⢸⣤⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⠀⠀⠀⢀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⠀⣀⣼⡄⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⠀⠀⠀⢸⢠⡇⣼⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣸⣿⣿⡇⣿⣷⢠⡄⠀⠀⠀⠀⠀⠀⠀┃ 
                                   ┃⠀⣶⣿⢀⣾⢸⡇⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⣇⣿⣿⣸⣷⠀⡀⢰⣿⠀⠀⡄┃ 
                                   ┃⣧⣿⣿⣼⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢠⣿⣸⣿⣇⣄⣧┃ 
                                   ┃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿┃ 
                                 0 ┃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿┃ 
                                   ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
                                   ⠀2022-01-01T00:00:00⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀2022-12-31T23:00:00⠀ 
                                   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Time [days]⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
```
"""
function plot_hist_solar(city::String = "",
                         i_row::Int64 = 1;
                         lat::Float64 = 0.0,
                         long::Float64 = 0.0,
                         start_date::String = "2023-01-01",
                         end_date::String = "2023-01-10")

    df_solar, time_zone = get_hist_data("shortwave_radiation",
                                        city,
                                        i_row,
                                        lat,
                                        long,
                                        start_date,
                                        end_date)
    
    plt = df_to_plot(city,
                     df_solar,
                     start_date,
                     end_date,
                     lat = lat,
                     long = long,
                     xlabel = "Time [days]",
                     ylabel = "Shortwave radiation [W/m^2]",
                     color = :green,
                     time_zone = time_zone)

    return plt

end