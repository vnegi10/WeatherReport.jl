# Run tests on functions for visualization

@testset verbose = true "Plotting with default selection" begin

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
        plt = plot_hourly_solar("Canberra", days = 3)
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

        plt = plot_hourly_solar("Madrid", 3, days = 5)
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