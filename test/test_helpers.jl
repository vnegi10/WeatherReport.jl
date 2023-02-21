@testset "Check if cities database is accessible" begin

    url = "https://raw.githubusercontent.com/vnegi10/GeoNames_analysis/master/cities500_lat_long.csv"

    df_cities = WeatherReport.url_to_df(url)
    rows, cols = size(df_cities)

    @test cols == 4
    @test rows == 199564

end