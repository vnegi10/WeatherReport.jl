# Run tests on plotting functions for air quality API

@testset verbose = true "Plotting with default selection" begin

    @testset "plot_hourly_pm" begin
        plt = plot_hourly_pm("Veldhoven", days = 3)
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with multiple matches" begin

    @testset "plot_hourly_pm" begin
        plt = plot_hourly_pm("Madrid", 2, days = 3)
        @test sizeof(plt) > 0

        plt = plot_hourly_pm("Madrid", 4, days = 3)
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with lat/long input" begin

    @testset "plot_hourly_pm" begin
        # Denver
        plt = plot_hourly_pm(lat = 39.7392, long = -104.985, days = 3) 
        @test sizeof(plt) > 0
    end

end