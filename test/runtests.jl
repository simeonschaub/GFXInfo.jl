using GFXInfo
using Test

@testset "GFXInfo.jl" begin
    gpu = try
        active_gpu()
    catch e
        @warn "No active GPU found" exception=(e, catch_backtrace())
        nothing
    end
    if gpu !== nothing
        @test @show(gpu.vendor) isa String
        @test @show(gpu.model) isa String
        @test @show(gpu.family) isa String
        @test @show(gpu.device_id) isa UInt32
    end
end
