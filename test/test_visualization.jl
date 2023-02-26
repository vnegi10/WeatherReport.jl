# Run tests on functions for visualization

@testset verbose = true "Plotting with default selection" begin

    @testset "plot_temp_hourly" begin
        plt = plot_temp_hourly("Veldhoven", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_rain_hourly" begin
        plt = plot_rain_hourly("Osaka", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_snow_hourly" begin
        plt = plot_snow_hourly("Helsinki", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_humidity_hourly" begin
        plt = plot_humidity_hourly("Singapore", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_windspeed_hourly" begin
        plt = plot_windspeed_hourly("Zurich", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_solar_hourly" begin
        plt = plot_solar_hourly("Canberra", days = 3)
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

@testset verbose = true "Plotting with multiple matches" begin

    @testset "plot_temp_hourly" begin
        plt = plot_temp_hourly("Madrid", 2, days = 3)
        @test sizeof(plt) > 0

        plt = plot_temp_hourly("Madrid", 4, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_rain_hourly" begin
        plt = plot_rain_hourly("Madrid", 3, days = 3)
        @test sizeof(plt) > 0

        plt = plot_rain_hourly("Madrid", 6, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_snow_hourly" begin
        plt = plot_snow_hourly("Madrid", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_snow_hourly("Madrid", 5, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_humidity_hourly" begin
        plt = plot_humidity_hourly("Dublin", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_humidity_hourly("Dublin", 7, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_windspeed_hourly" begin
        plt = plot_windspeed_hourly("Dublin", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_windspeed_hourly("Dublin", 5, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_solar_hourly" begin
        plt = plot_solar_hourly("Madrid", 1, days = 5)
        @test sizeof(plt) > 0

        plt = plot_solar_hourly("Madrid", 3, days = 5)
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