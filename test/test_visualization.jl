# Run tests on functions for visualization

@testset verbose = true "Plotting functions" begin

    @testset "plot_temp_forecast" begin
        plt = plot_temp_forecast("Veldhoven", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_rain_forecast" begin
        plt = plot_rain_forecast("Osaka", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "plot_snow_forecast" begin
        plt = plot_snow_forecast("Helsinki", days = 3)
        @test sizeof(plt) > 0
    end

    @testset "show_current_weather" begin
        result = @capture_out show_current_weather("Oslo")
        @test length(result) > 0
    end

end