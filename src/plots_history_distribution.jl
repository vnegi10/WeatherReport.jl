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

    start_date, end_date = convert_dates(year)

    df_temp = DataFrame()
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
    else
        input = LocationHistInput("temperature_2m",
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_temp, time_zone = results[1], results[2]
    end

    all_months, monthly_temp = get_monthly_data(df_temp)

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    end

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

    start_date, end_date = get_time_range(num_years)

    df_temp = DataFrame()
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
    else
        input = LocationHistInput("temperature_2m",
                                  lat,
                                  long,
                                  start_date,
                                  end_date)
        results = get_hourly_forecast(input)

        df_temp, time_zone = results[1], results[2]
    end

    all_years, yearly_temp = compare_yearly_data(df_temp, month)

    if isempty(city)
        city = ["lat:", "$(lat)", ", ", "long:", "$(long)"] |> join
    end

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