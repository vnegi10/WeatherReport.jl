"""
    compare_box_temp(city::String = "",
                     i_row::Int64 = 1;
                     lat::Float64 = 0.0,
                     long::Float64 = 0.0,
                     month::String = "Jan",
                     num_years::Int64 = 5)

Compares the boxplot distribution of hourly air temperature [°C]
at 2 meter above ground for a given location (city or lat/long)
for a given month across a given number of years.

# Arguments
- `city::String` : Valid city name, e.g. "Oslo", "Paris", "Amsterdam" etc.
- `i_row::Int64` : In case of more than one match for a given location,
                   select the desired timezone by providing the row index
                   from the printed DataFrame. Default is set to 1.

# Mandatory keywords
- `month::String` : Month for which data needs to be compared, e.g. "Jan", "March" etc.
- `num_years::Int64` : Number of years across which the data will be compared

# Optional keywords
- `lat::Float64` : Geographical WGS84 coordinate of the location (°S < 0, °N > 0)
- `long::Float64` : Geographical WGS84 coordinate of the location (°W < 0, °E > 0)

# Example
```julia-repl
julia> compare_box_temp("Chandigarh", num_years = 5, month = "May")
                  Chandigarh: Air temp. comparison for May over last 5 years          
         Timezone: Asia/Kolkata                     [Weather data by Open-Meteo.com]  
        ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ 
        ┃             ╷               ┌─────────┬────────┐           ╷              ┃ 
   2018 ┃             ├───────────────┤         │        ├───────────┤              ┃ 
        ┃             ╵               └─────────┴────────┘           ╵              ┃ 
        ┃               ╷          ┌──────────┬────────┐               ╷            ┃ 
   2019 ┃               ├──────────┤          │        ├───────────────┤            ┃ 
        ┃               ╵          └──────────┴────────┘               ╵            ┃ 
        ┃             ╷            ┌────────┬───────┐               ╷               ┃ 
   2020 ┃             ├────────────┤        │       ├───────────────┤               ┃ 
        ┃             ╵            └────────┴───────┘               ╵               ┃ 
        ┃             ╷           ┌───────┬───────┐             ╷                   ┃ 
   2021 ┃             ├───────────┤       │       ├─────────────┤                   ┃ 
        ┃             ╵           └───────┴───────┘             ╵                   ┃ 
        ┃                  ╷           ┌───────┬───────┐           ╷                ┃ 
   2022 ┃                  ├───────────┤       │       ├───────────┤                ┃ 
        ┃                  ╵           └───────┴───────┘           ╵                ┃ 
        ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 
         10                                  30                                   50  
                                             [°C]                                     
```
"""
function compare_box_temp(city::String = "",
                          i_row::Int64 = 1;
                          lat::Float64 = 0.0,
                          long::Float64 = 0.0,
                          month::String = "Jan",
                          num_years::Int64 = 5)

    all_years, yearly_temp, city, time_zone = get_plotting_data("temperature_2m",
                                                                city,
                                                                i_row,
                                                                lat,
                                                                long,
                                                                month,
                                                                num_years)

    plt = boxplot(
        all_years,
        yearly_temp,
        title = "$(city): Air temp. comparison for $(month) over last $(num_years) years",
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