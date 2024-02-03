@testitem "Expected error appears when city is not found" tags = [:exceptions] begin

    @test_throws ErrorException("Coordinates for city not found!") plot_hourly_temp("EEdinhoven")

end

@testitem "Expected error appears when path is invalid" tags = [:exceptions] begin

    # Incorrect path
    invalid_path = joinpath(@__DIR__,
                            "..",
                            "dummy",
                            "cities500_lat_long.csv")

    @test_throws ErrorException("Unable to load cities database, check if $(invalid_path) is valid!") WeatherReport.csv_to_df(invalid_path)

end

@testitem "Expected error appears when unknown forecast type is used" tags = [:exceptions] begin

    # Not supported
    forecast_type = "tempest"

    @test_throws ErrorException("Forecast type is currently not supported!") WeatherReport.get_url(forecast_type)

end

@testitem "Expected error appears when end date is before start date" tags = [:exceptions] begin

    @test_throws AssertionError("End date cannot be before start date!") plot_hist_temp("Veldhoven", start_date = "2000-03-01", end_date = "2000-01-01")

end