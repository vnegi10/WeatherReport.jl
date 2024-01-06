# Run tests on plotting functions for weather forecast API

@testitem "Plotting hourly forecast data with default selection" begin

    using Suppressor

    @testset "plot_hourly_temp" begin
        plt = plot_hourly_temp("Veldhoven", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_rain" begin
        plt = plot_hourly_rain("Osaka", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_snow" begin
        plt = plot_hourly_snow("Helsinki", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_humidity" begin
        plt = plot_hourly_humidity("Singapore", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_windspeed" begin
        plt = plot_hourly_windspeed("Zurich", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_solar" begin
        plt = plot_hourly_solar("Amsterdam", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "show_current" begin
        result = @capture_out show_current("Oslo")
        @test length(result) > 0
    end

    @testset "show_daily" begin
        result = @capture_out show_daily("Zurich")
        @test length(result) > 0
    end

end

@testitem "Plotting hourly forecast data with multiple matches" begin

    using Suppressor

    @testset "plot_hourly_temp" begin
        plt = plot_hourly_temp("Madrid", 2, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_temp("Madrid", 4, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_rain" begin
        plt = plot_hourly_rain("Madrid", 3, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_rain("Madrid", 6, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_snow" begin
        plt = plot_hourly_snow("Madrid", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_snow("Madrid", 5, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_humidity" begin
        plt = plot_hourly_humidity("Dublin", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_humidity("Dublin", 7, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_windspeed" begin
        plt = plot_hourly_windspeed("Dublin", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_windspeed("Dublin", 5, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_solar" begin
        plt = plot_hourly_solar("Madrid", 1, days = 5)
        @test sizeof(plt) > 0

        plt = plot_hourly_solar("Madrid", 2, days = 5)
        @test sizeof(plt) > 0
    end

    @testset "show_current" begin
        result = @capture_out show_current("Madrid", 2)
        @test length(result) > 0

        result = @capture_out show_current("Madrid", 4)
        @test length(result) > 0
    end

    @testset "show_daily" begin
        result = @capture_out show_daily("Madrid", 1)
        @test length(result) > 0

        result = @capture_out show_daily("Madrid", 4)
        @test length(result) > 0
    end

end

@testitem "Plotting hourly forecast data with lat/long input" begin

    @testset "plot_hourly_temp" begin
        # Denver
        plt = plot_hourly_temp(lat = 39.7392, long = -104.985, days = 3) 
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_rain" begin
        # Delhi
        plt = plot_hourly_rain(lat = 28.6519, long = 77.2315, days = 4)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_snow" begin
        # Oslo
        plt = plot_hourly_snow(lat = 59.9127, long = 10.7461, days = 5)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_humidity" begin
        # Sydney
        plt = plot_hourly_humidity(lat = -33.8678, long = 151.207, days = 5)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_windspeed" begin
        # Copenhagen
        plt = plot_hourly_windspeed(lat = 55.6759, long = 12.5655, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_solar" begin
        # Copenhagen
        plt = plot_hourly_solar(lat = 55.6759, long = 12.5655, days = 1)
        @test sizeof(plt) > 0
    end

end

@testitem "Self location" begin

    using Suppressor

    @testset "where_am_i" begin
        result = @capture_out where_am_i()
        @test length(result) > 0
    end

end

@testitem "Plotting hourly forecast data with user preference" begin

    using Suppressor

    @testset "plot_hourly_temp" begin
        set_city("Tokyo")
        plt = plot_hourly_temp()
        @test sizeof(plt) > 0
    end

    @testset "show_current" begin
        set_city("Madrid")
        result = @capture_out show_current()
        @test length(result) > 0
    end

    @testset "show_daily" begin
        set_city("London")
        result = @capture_out show_daily()
        @test length(result) > 0
    end

end