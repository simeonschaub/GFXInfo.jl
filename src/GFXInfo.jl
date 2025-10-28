module GFXInfo

using gfxinfo_c_bindings_jll

export active_gpu

mutable struct GPU
    handle::Ptr{Cvoid}
    GPU(handle::Ptr{Cvoid}) = finalizer(new(handle)) do gpu
        @ccall libgfxinfo_c_bindings.gfxinfo_free_gpu(getfield(gpu, :handle)::Ptr{Cvoid})::Cvoid
    end
end

function active_gpu()
    handle = @ccall libgfxinfo_c_bindings.gfxinfo_active_gpu()::Ptr{Cvoid}
    if handle == C_NULL
        error("No active GPU found")
    end
    return GPU(handle)
end

function Base.getproperty(gpu::GPU, name::Symbol)
    handle = getfield(gpu, :handle)
    if name === :vendor
        ptr = @ccall libgfxinfo_c_bindings.gfxinfo_get_vendor(handle::Ptr{Cvoid})::Cstring
    elseif name === :model
        ptr = @ccall libgfxinfo_c_bindings.gfxinfo_get_model(handle::Ptr{Cvoid})::Cstring
    elseif name === :family
        ptr = @ccall libgfxinfo_c_bindings.gfxinfo_get_family(handle::Ptr{Cvoid})::Cstring
    elseif name === :device_id
        return @ccall libgfxinfo_c_bindings.gfxinfo_get_device_id(handle::Ptr{Cvoid})::UInt32
    else
        throw(FieldError(gpu, name))
    end
    str = unsafe_string(ptr)
    @ccall libgfxinfo_c_bindings.gfxinfo_free_string(ptr::Cstring)::Cvoid
    return str
end

Base.propertynames(::GPU) = (:vendor, :model, :family, :device_id)

end
