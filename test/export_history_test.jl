# Run tests on exporting historical data to SQLite database

@testsetup module TestDatabase

    export db, df_snow, df_rain, df_temp

    using WeatherReport, SQLite, DataFrames

    db_path = joinpath(@__DIR__, "..", "export", "Veldhoven_all.sqlite")

    # Remove existing database otherwise new data gets appended to it
    if isfile(db_path)
        rm(db_path)
    end

    export_to_sqlite("Veldhoven",
                      start_date = "2022-01-01",
                      end_date = "2022-01-31")
    
    db = SQLite.DB(db_path)

    df_snow = DBInterface.execute(db, "SELECT * FROM snowfall") |> DataFrame
    df_rain = DBInterface.execute(db, "SELECT * FROM rain") |> DataFrame
    df_temp = DBInterface.execute(db, "SELECT * FROM temperature_2m") |> DataFrame
end

@testitem "SQLite database" setup = [TestDatabase] begin

    using SQLite

    @testset "Check number of tables" begin
        @test SQLite.tables(db) |> length == 6
    end

    @testset "Check snowfall data size" begin
        rows, cols = size(df_snow)

        @test rows == 744
        @test cols == 2
    end

    @testset "Check rain data" begin
        df_filter = filter(row -> row.rain > 0, df_rain)
        rows, cols = size(df_filter)

        @test rows == 152
        @test cols == 2

        @test df_rain[!, :rain][2] ≈ 0.1
        @test df_rain[!, :rain][742] ≈ 0.1

    end

    @testset "Check temperature data" begin
        df_filter = filter(row -> row.temperature_2m > 5.5, df_temp)
        rows, cols = size(df_filter)

        @test rows == 208
        @test cols == 3

        @test df_temp[!, :temperature_2m][1] ≈ 12.3
        @test df_temp[!, :temperature_2m][744] ≈ 3.5

        @test df_temp[!, :APP_TEMP][2] ≈ 11.3
        @test df_temp[!, :APP_TEMP][743] ≈ -0.6
    end

end