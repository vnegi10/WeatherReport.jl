using Documenter
using WeatherReport

makedocs(
    sitename = "WeatherReport",
    format = Documenter.HTML(),
    modules = [WeatherReport]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/vnegi10/WeatherReport.jl.git",
    devbranch = "main"
)