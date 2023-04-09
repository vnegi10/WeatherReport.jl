"""
    plot_box_temp(city::String = "",
                  i_row::Int64 = 1;
                  lat::Float64 = 0.0,
                  long::Float64 = 0.0,
                  year::String = "2022")

Shows the monthly boxplot distribution of hourly air temperature [°C]
at 2 meter above ground for a given location (city or lat/long).

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_temp("Eindhoven", year = "2023")
                          Eindhoven: Air temp. monthly distribution for 2023              
             Timezone: Europe/Amsterdam                 [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃               ╷           ┌─────────┬─────────┐                ╷          ┃ 
    January ┃               ├───────────┤         │         ├────────────────┤          ┃ 
            ┃               ╵           └─────────┴─────────┘                ╵          ┃ 
            ┃              ╷                 ┌──────┬─────┐        ╷                    ┃ 
   February ┃              ├─────────────────┤      │     ├────────┤                    ┃ 
            ┃              ╵                 └──────┴─────┘        ╵                    ┃ 
            ┃                ╷              ┌─────────┬───────┐              ╷          ┃ 
      March ┃                ├──────────────┤         │       ├──────────────┤          ┃ 
            ┃                ╵              └─────────┴───────┘              ╵          ┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             -10                                 5                                    20  
                                                 [°C]                                     
```
"""
function plot_box_temp(city::String = "",
                       i_row::Int64 = 1;
                       lat::Float64 = 0.0,
                       long::Float64 = 0.0,
                       year::String = "2022")

    all_months, monthly_temp, city, time_zone = get_plotting_data("temperature_2m",
                                                                  city,
                                                                  i_row,
                                                                  lat,
                                                                  long,
                                                                  year)

    plt = boxplot(
        all_months,
        monthly_temp,
        title = "$(city): Air temp. monthly distribution for $(year)",
        xlabel = "[°C]",
        border = :bold,
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
    plot_box_rain(city::String = "",
                  i_row::Int64 = 1;
                  lat::Float64 = 0.0,
                  long::Float64 = 0.0,
                  year::String = "2022")

Shows the monthly boxplot distribution of rain from large
scale weather systems of the preceding hour in millimeter [mm]
for a given location (city or lat/long).

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_rain("Mumbai", year = "2023")
                              Mumbai: Rain monthly distribution for 2023                  
             Timezone: Asia/Kolkata                     [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃┐      ╷                                                                   ┃ 
    January ┃├──────┤                                                                   ┃ 
            ┃┘      ╵                                                                   ┃ 
            ┃╷                                                                          ┃ 
   February ┃┤                                                                          ┃ 
            ┃╵                                                                          ┃ 
            ┃┐                                                                         ╷┃ 
      March ┃├─────────────────────────────────────────────────────────────────────────┤┃ 
            ┃┘                                                                         ╵┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             0                                  0.5                                    1  
                                                 [mm]                                     
```
"""
function plot_box_rain(city::String = "",
                       i_row::Int64 = 1;
                       lat::Float64 = 0.0,
                       long::Float64 = 0.0,
                       year::String = "2022")

    all_months, monthly_rain, city, time_zone = get_plotting_data("rain",
                                                                  city,
                                                                  i_row,
                                                                  lat,
                                                                  long,
                                                                  year)

    plt = boxplot(
        all_months,
        monthly_rain,
        title = "$(city): Rain monthly distribution for $(year)",
        xlabel = "[mm]",
        border = :bold,
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
    plot_box_snow(city::String = "",
                  i_row::Int64 = 1;
                  lat::Float64 = 0.0,
                  long::Float64 = 0.0,
                  year::String = "2022")

Shows the monthly boxplot distribution of snowfall amount for
the preceding hour in centimeter [cm] for a given location
(city or lat/long).

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_snow("Tromso", year = "2023")
                            Tromso: Snowfall monthly distribution for 2023                
             Timezone: Europe/Oslo                      [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃┬───┐                            ╷                                         ┃ 
    January ┃│   ├────────────────────────────┤                                         ┃ 
            ┃┴───┘                            ╵                                         ┃ 
            ┃┬───┐                                                                 ╷    ┃ 
   February ┃│   ├─────────────────────────────────────────────────────────────────┤    ┃ 
            ┃┴───┘                                                                 ╵    ┃ 
            ┃┬─┐                              ╷                                         ┃ 
      March ┃│ ├──────────────────────────────┤                                         ┃ 
            ┃┴─┘                              ╵                                         ┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             0                                   1                                     2  
                                                 [cm]                                     
```
"""
function plot_box_snow(city::String = "",
                       i_row::Int64 = 1;
                       lat::Float64 = 0.0,
                       long::Float64 = 0.0,
                       year::String = "2022")

    all_months, monthly_snow, city, time_zone = get_plotting_data("snowfall",
                                                                  city,
                                                                  i_row,
                                                                  lat,
                                                                  long,
                                                                  year)

    plt = boxplot(
        all_months,
        monthly_snow,
        title = "$(city): Snowfall monthly distribution for $(year)",
        xlabel = "[cm]",
        border = :bold,
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
    plot_box_humidity(city::String = "",
                      i_row::Int64 = 1;
                      lat::Float64 = 0.0,
                      long::Float64 = 0.0,
                      year::String = "2022")

Shows the monthly boxplot distribution of relative humidity
at 2 meter above ground for a given location (city or lat/long).

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_humidity("Dubrovnik", year = "2023")
                          Dubrovnik: Relative humidity distribution for 2023              
             Timezone: Europe/Zagreb                    [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃            ╷                        ┌────────────┬────────────┐          ╷┃ 
    January ┃            ├────────────────────────┤            │            ├──────────┤┃ 
            ┃            ╵                        └────────────┴────────────┘          ╵┃ 
            ┃       ╷               ┌───────────────────────┬──────────────┐           ╷┃ 
   February ┃       ├───────────────┤                       │              ├───────────┤┃ 
            ┃       ╵               └───────────────────────┴──────────────┘           ╵┃ 
            ┃╷                                      ┌───────────┬────────┐           ╷  ┃ 
      March ┃├──────────────────────────────────────┤           │        ├───────────┤  ┃ 
            ┃╵                                      └───────────┴────────┘           ╵  ┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             30                                  65                                  100  
                                                 [%]                                      
```
"""
function plot_box_humidity(city::String = "",
                           i_row::Int64 = 1;
                           lat::Float64 = 0.0,
                           long::Float64 = 0.0,
                           year::String = "2022")

    all_months, monthly_hum, city, time_zone = get_plotting_data("relativehumidity_2m",
                                                                  city,
                                                                  i_row,
                                                                  lat,
                                                                  long,
                                                                  year)

    plt = boxplot(
        all_months,
        monthly_hum,
        title = "$(city): Relative humidity distribution for $(year)",
        xlabel = "[%]",
        border = :bold,
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
    plot_box_windspeed(city::String = "",
                       i_row::Int64 = 1;
                       lat::Float64 = 0.0,
                       long::Float64 = 0.0,
                       year::String = "2022")

Shows the monthly box plot distribution of wind speed at 10
meter above ground for a given location (city or lat/long).

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_windspeed("Veldhoven", year = "2023")
                             Veldhoven: Wind speed distribution for 2023                  
             Timezone: Europe/Amsterdam                 [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃ ╷                   ┌─────────┬──────────┐                          ╷     ┃ 
    January ┃ ├───────────────────┤         │          ├──────────────────────────┤     ┃ 
            ┃ ╵                   └─────────┴──────────┘                          ╵     ┃ 
            ┃  ╷           ┌──────┬───────────┐                                 ╷       ┃ 
   February ┃  ├───────────┤      │           ├─────────────────────────────────┤       ┃ 
            ┃  ╵           └──────┴───────────┘                                 ╵       ┃ 
            ┃ ╷                ┌────┬─────────────┐                                  ╷  ┃ 
      March ┃ ├────────────────┤    │             ├──────────────────────────────────┤  ┃ 
            ┃ ╵                └────┴─────────────┘                                  ╵  ┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             0                                   20                                   40  
                                                [km/h]                                    
```
"""
function plot_box_windspeed(city::String = "",
                            i_row::Int64 = 1;
                            lat::Float64 = 0.0,
                            long::Float64 = 0.0,
                            year::String = "2022")

    all_months, monthly_wind, city, time_zone = get_plotting_data("windspeed_10m",
                                                                  city,
                                                                  i_row,
                                                                  lat,
                                                                  long,
                                                                  year)

    plt = boxplot(
        all_months,
        monthly_wind,
        title = "$(city): Wind speed distribution for $(year)",
        xlabel = "[km/h]",
        border = :bold,
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
    plot_box_solar(city::String = "",
                   i_row::Int64 = 1;
                   lat::Float64 = 0.0,
                   long::Float64 = 0.0,
                   year::String = "2022")

Shows the monthly box plot distribution of shortwave solar
radiation as average of the preceding hour for a given
location (city or lat/long). This is equal to the total
global horizontal irradiation.

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.
- `year::String` : Year for which data needs to be shown, e.g. "2020"

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> plot_box_solar("Canberra", year = "2023")
                         Canberra: Shortwave radiation distribution for 2023              
             Timezone: Australia/Sydney                 [Weather data by Open-Meteo.com]  
            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
            ┃┌─┬───────────────┐                      ╷                                 ┃ 
    January ┃┤ │               ├──────────────────────┤                                 ┃ 
            ┃└─┴───────────────┘                      ╵                                 ┃ 
            ┃┌┬─────────────────┐                   ╷                                   ┃ 
   February ┃┤│                 ├───────────────────┤                                   ┃ 
            ┃└┴─────────────────┘                   ╵                                   ┃ 
            ┃┬─────────────┐                     ╷                                      ┃ 
      March ┃│             ├─────────────────────┤                                      ┃ 
            ┃┴─────────────┘                     ╵                                      ┃ 
            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
             0                                 1 000                               2 000  
                                               [W/m^2]                        
```
"""
function plot_box_solar(city::String = "",
                        i_row::Int64 = 1;
                        lat::Float64 = 0.0,
                        long::Float64 = 0.0,
                        year::String = "2022")

    all_months, monthly_solar, city, time_zone = get_plotting_data("shortwave_radiation",
                                                                   city,
                                                                   i_row,
                                                                   lat,
                                                                   long,
                                                                   year)

    plt = boxplot(
        all_months,
        monthly_solar,
        title = "$(city): Shortwave radiation distribution for $(year)",
        xlabel = "[W/m^2]",
        border = :bold,
        canvas = BrailleCanvas,
        width = 75,
        height = 15,
        grid = true
    )

    label!(plt, :tl, "Timezone: $(time_zone)")
    label!(plt, :tr, ATTRIBUTION)

    return plt

end