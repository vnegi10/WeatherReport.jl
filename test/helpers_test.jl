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

@testitem "Resolve city names without changing valid capitalization" tags = [:helpers] begin

    test_cases = [
        (["Sankt Peter-Ording", "sankt peter-ording"], 54.30363, 8.64138, "Europe/Berlin"),
        (["Pas de la Casa", "PAS DE LA CASA"], 42.54277, 1.73361, "Europe/Andorra"),
        (["l'Alcora", "L'ALCORA"], 40.06667, -0.2, "Europe/Madrid"),
        (["The Hague", "the hague"], 52.07667, 4.29861, "Europe/Amsterdam"),
        (["Villiers-en-Desœuvre", "VILLIERS-EN-DESŒUVRE"], 48.95, 1.5, "Europe/Paris"),
    ]

    for (city_names, latitude, longitude, timezone) in test_cases
        for city in city_names
            location = WeatherReport.fetch_lat_long(city, 1)

            @test location.latitude == latitude
            @test location.longitude == longitude
            @test location.timezone == timezone
        end
    end

end

@testitem "Prefer exact city matches before case-insensitive matches" tags = [:helpers] begin

    exact_matches = WeatherReport.match_city_rows("MacArthur")
    @test size(exact_matches, 1) == 2
    @test all(==("MacArthur"), exact_matches.CITY)

    fallback_matches = WeatherReport.match_city_rows("MACARTHUR")
    @test size(fallback_matches, 1) == 4
    @test Set(fallback_matches.CITY) == Set(["Macarthur", "MacArthur"])

end

@testitem "Normalize month capitalization independently" tags = [:helpers] begin

    @test WeatherReport.normalize_month_name("jan") == "Jan"
    @test WeatherReport.normalize_month_name("JAn") == "Jan"
    @test WeatherReport.normalize_month_name("march") == "March"

end

@testitem "Verify if location preference is set correctly" tags = [:helpers, :preferences] begin

    set_city("Haldwani")
    @test WeatherReport.get_city() == "Haldwani"

    set_city("Veldhoven")
    @test WeatherReport.get_city() == "Veldhoven"

end
