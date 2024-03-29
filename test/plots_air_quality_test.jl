# Run tests on plotting functions for air quality API

@testitem "Plotting hourly air quality data with default selection" tags = [:plots, :air] begin

    @testset "plot_hourly_pm" begin
        plt = plot_hourly_pm("Veldhoven", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_dust" begin
        plt = plot_hourly_dust("Doha", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_haze" begin
        plt = plot_hourly_haze("Haldwani", days = 1)
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting hourly air quality data with multiple matches" tags = [:plots, :air] begin

    @testset "plot_hourly_pm" begin
        plt = plot_hourly_pm("Madrid", 2, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_pm("Madrid", 4, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_dust" begin
        plt = plot_hourly_dust("Cairo", 1, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_dust("Cairo", 3, days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_haze" begin
        plt = plot_hourly_haze("Cairo", 1, days = 2)
        @test sizeof(plt) > 0

        plt = plot_hourly_haze("Cairo", 2, days = 4)
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting hourly air quality data with lat/long input" tags = [:plots, :air] begin

    @testset "plot_hourly_pm" begin
        # Denver
        plt = plot_hourly_pm(lat = 39.7392, long = -104.985, days = 3) 
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_dust" begin
        # Delhi
        plt = plot_hourly_dust(lat = 28.6519, long = 77.2315, days = 4)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_haze" begin
        # Cairo
        plt = plot_hourly_haze(lat = 30.0444, long = 31.2357, days = 2)
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting air quality data with user preference" tags = [:plots, :air] begin

    @testset "plot_hourly_pm" begin
        set_city("Bengaluru")
        plt = plot_hourly_pm(days = 1)
        @test sizeof(plt) > 0
    end

    @testset "plot_hourly_haze" begin
        set_city("Haldwani")
        plt = plot_hourly_haze(days = 1)
        @test sizeof(plt) > 0
    end

end