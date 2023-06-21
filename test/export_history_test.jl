# Run tests on exporting historical data to SQLite database

@testsetup module TestDatabase
    using WeatherReport
    export_to_sqlite("Veldhoven",
                      start_date = "2022-01-01",
                      end_date = "2022-01-31")
end

@testitem "SQLite database" setup = [TestDatabase] begin

    @testset "Check if file is present" begin
        @test joinpath(@__DIR__, "..", "export", "Veldhoven_all.sqlite") |> isfile
    end

end