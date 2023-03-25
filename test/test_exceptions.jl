@testset "Check if expected error appears when city is not found" begin

    @test_throws ErrorException("Coordinates for city not found!") plot_hourly_temp("EEdinhoven")

end

@testset "Check if expected error appears when URL is not found" begin

    # Incorrect URL
    url = "https://raw.githubusercontent.com/dummy10/GeoNames_analysis/master/cities500_lat_long.csv"

    @test_throws ErrorException("Unable to load cities database, check if $(url) is accessible!") WeatherReport.url_to_df(url)

end

@testset "Check if expected error appears when unknown forecast type is used" begin

    # Not supported
    forecast_type = "tempest"

    @test_throws ErrorException("Forecast type is currently not supported!") WeatherReport.get_url(forecast_type)

end

@testset "Check if expected error appears when end date is before start date" begin

    @test_throws AssertionError("End date cannot be before start date!") plot_hist_temp("Veldhoven", start_date = "2000-03-01", end_date = "2000-01-01")

end