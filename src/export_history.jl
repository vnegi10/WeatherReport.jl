"""
"""
function export_to_sqlite(city::String = "",
                          i_row::Int64 = 1;
                          lat::Float64 = 0.0,
                          long::Float64 = 0.0,
                          start_date::String = "2023-01-01",
                          end_date::String = "2023-01-10")

    df_all = collect_all_data(city,
                              i_row,
                              lat,
                              long,
                              start_date,
                              end_date)

    save_dir = joinpath(@__DIR__, "..", "export")

    if ~isdir(save_dir)
        mkdir(save_dir)
    end

    db_name = ""
    if ~isempty(city)
        db_name = "$(city)_all.sqlite"
    else
        db_name = "$(lat)_$(long)_all.sqlite"
    end

    for df_input in df_all
        table_name = names(df_input)[2]
        save_to_db(df_input, joinpath(save_dir, db_name), table_name)
    end

end