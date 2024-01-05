@testitem "Check if cities database is available" begin

    path = joinpath(@__DIR__,
                    "..",
                    "database",
                    "cities500_lat_long.csv")

    df_cities = WeatherReport.csv_to_df(path)
    rows, cols = size(df_cities)

    @test cols == 4
    @test rows == 199564

end

@testitem "Verify if closest match for an incorrect city name is found" begin

    @test WeatherReport.closest_match("Halwani")[1] == "Haldwani"
    @test WeatherReport.closest_match("amsteldam")[1] == "Amsterdam"

end