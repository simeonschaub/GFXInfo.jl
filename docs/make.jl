using GFXInfo
using Documenter

DocMeta.setdocmeta!(GFXInfo, :DocTestSetup, :(using GFXInfo); recursive=true)

makedocs(;
    modules=[GFXInfo],
    authors="Simeon David Schaub <simeon@schaub.rocks> and contributors",
    sitename="GFXInfo.jl",
    format=Documenter.HTML(;
        canonical="https://simeonschaub.github.io/GFXInfo.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/simeonschaub/GFXInfo.jl",
    devbranch="main",
)
