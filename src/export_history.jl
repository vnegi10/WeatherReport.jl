"""
"""
function export_to_sqlite(city::String = "",
                          i_row::Int64 = 1;
                          lat::Float64 = 0.0,
                          long::Float64 = 0.0,
                          start_date::String = "2023-01-01",
                          end_date::String = "2023-01-10")

    # Vector of DataFrames to store all the data
    df_all = DataFrame[]

    # Temp. data uses a different function, so we add it first
    # to df_all
    df_temp = DataFrame()

    try
        df_temp, _ = get_hist_temp_data(city,
                                        i_row,
                                        lat,
                                        long,
                                        start_date,
                                        end_date)
    catch
        @info "Unable to fetch historical data for hourly temperature"
    end

    push!(df_all, df_temp)

    variables = ["rain",
                 "snowfall",
                 "relativehumidity_2m",
                 "windspeed_10m",
                 "shortwave_radiation"]

    for variable in variables
        df_data = try_catch_hist_data(variable,
                                      city,
                                      i_row,
                                      lat,
                                      long,
                                      start_date,
                                      end_date)

        push!(df_all, df_data)
    end

    return df_all

end