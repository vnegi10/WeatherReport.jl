# Run tests on functions for visualization

@testset verbose = true "Plotting functions" begin

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

    @testset "show_current_weather" begin
        result = @capture_out show_current_weather("Oslo")
        @test length(result) > 0
    end

end