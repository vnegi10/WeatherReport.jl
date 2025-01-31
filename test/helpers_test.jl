@testitem "Check if cities database is available" tags = [:helpers] begin

    path = joinpath(@__DIR__,
                    "..",
                    "database",
                    "cities500_lat_long.csv")

    df_cities = WeatherReport.csv_to_df(path)
    rows, cols = size(df_cities)

    @test cols == 4
    @test rows == 199564

end

@testitem "Verify if closest match for an incorrect city name is found" tags = [:helpers] begin

    path = joinpath(@__DIR__,
                    "..",
                    "database",
                    "cities500_lat_long.csv")

    df_cities = WeatherReport.csv_to_df(path)
    all_valid_cities = filter(x -> ~ismissing(x), df_cities.CITY)

    @test WeatherReport.closest_match("Halwani", all_valid_cities)[1] == "Haldwani"
    @test WeatherReport.closest_match("amsteldam", all_valid_cities)[1] == "Amsterdam"

end

@testitem "Verify if location preference is set correctly" tags = [:helpers] begin

    set_city("Haldwani")
    @test WeatherReport.get_city() == "Haldwani"

    set_city("Veldhoven")
    @test WeatherReport.get_city() == "Veldhoven"

end