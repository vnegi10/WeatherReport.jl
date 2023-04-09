# Run tests on yearly plotting functions (box plots) for historical data API

@testset verbose = true "Plotting with default selection" begin

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Veldhoven",
                                num_years = 5,
                                month = "Jan")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        plt = compare_box_rain("Veldhoven",
                                num_years = 5,
                                month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        plt = compare_box_snow("Oslo",
                                num_years = 5,
                                month = "Dec")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with multiple matches" begin

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Madrid",
                               2,
                               num_years = 5,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_temp("Madrid",
                               4,
                               num_years = 5,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        plt = compare_box_rain("Madrid",
                               2,
                               num_years = 5,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_rain("Madrid",
                               4,
                               num_years = 2,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        plt = compare_box_snow("Madrid",
                               2,
                               num_years = 4,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_snow("Madrid",
                               3,
                               num_years = 2,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with lat/long input" begin

    @testset "compare_box_temp" begin
        # Denver
        plt = compare_box_temp(lat = 39.7392,
                               long = -104.985,
                               num_years = 5,
                               month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        # Chennai
        plt = compare_box_rain(lat = 13.0878,
                               long = 80.2785,
                               num_years = 5,
                               month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        # Oslo
        plt = compare_box_snow(lat = 59.9127,
                               long = 10.746,
                               num_years = 5,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

end