@testset "Check if expected error appears when city is not found" begin

    @test_throws ErrorException("Coordinates for city not found!") plot_hourly_temp("EEdinhoven")

end

@testset "Check if expected error appears when URL is not found" begin

    # Incorrect URL
    url = "https://raw.githubusercontent.com/dummy10/GeoNames_analysis/master/cities500_lat_long.csv"

    @test_throws ErrorException("Unable to load cities database, check if $(url) is accessible!") WeatherReport.url_to_df(url)

end