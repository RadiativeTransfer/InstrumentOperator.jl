#####
##### Types for describing an Instrument Operations (convolution, resampling)
#####

"""
    type AbstractInstrumentOperator
Abstract AbstractInstrumentOperator type 
"""
abstract type AbstractInstrumentOperator end

"""
    type AbstractInstrument
Abstract Instrument type 
"""
abstract type AbstractInstrument end

"""
    struct FixedKernelInstrument{FT}

A struct which provides all parameters for the convolution with a kernel, which is identical across the instrument spectral axis

# Fields
$(DocStringExtensions.FIELDS)
"""
struct FixedKernelInstrument{FT} <: AbstractInstrumentOperator
    "convolution Kernel" 
    kernel::OffsetArray{FT,1}
    "Output spectral grid"
    ν_out::Array{FT,1}
end;

"""
    struct VariableInstrument{FT}

        A struct which provides all parameters for the convolution with a kernel, which varies across the instrument spectral axis

# Fields
$(DocStringExtensions.FIELDS)
"""
struct VariableKernelInstrument{FT,AA} <: AbstractInstrumentOperator
    "convolution Kernel" 
    kernel::OffsetArray{FT,2,AA}
    "Output spectral grid"
    ν_out::Array{FT,1}
    "Output index grid"
    ind_out::Array{Int,1}
end;

struct FTSInstrument{FT} <: AbstractInstrument
    "Maximum Optical Path Difference (cm)"
    MOPD::FT
    "Field of View (rad)"
    FOV::FT
    "Assymmetry parameter"
    β::FT
end

"""
    type AbstractNoiseModel
Abstract AbstractNoiseModel type 
"""
abstract type AbstractNoiseModel end

"""
    struct GratingNoiseModel{FT}

A struct which stores important variable to compute the noise of a grating spectrometer

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef  struct GratingNoiseModel <: AbstractNoiseModel
    "Integration time `[s]`" 
    integration_time::Unitful.Time
    "Detector pixel size (assuming quadratic) `[μm]`"
    detector_size::Unitful.Length
    "Detector quantum efficiency"
    FPA_qe
    "grating efficiency"
    grating_efficiency
    "effective Transmission of the optics (Telescope and other optical elements)"
    effTransmission
    "F-number"
    Fnumber
    "Spectral Sampling Interval SSI `[μm]`"
    SSI::Unitful.Length
    "Readout noise `[e⁻¹]`"
    readNoise
    "Dark current `[e⁻¹/s]`"
    dark_current::PerTime
    # "Slit width `[μm]`"
    # slit_width::Unitful.Length
end;

function createGratingNoiseModel(ET, DS, FPA_qe, grating_efficiency, effTransmission, fnumber, SSI, RN, DC) 
    # @info "Creating instrument model"
    GratingNoiseModel(
       uconvert(u"s",ET),
       uconvert(u"μm",DS),
       FPA_qe, grating_efficiency, effTransmission,
       fnumber,
       uconvert(u"μm",SSI),
       RN,
       uconvert(u"s^-1",DC))
end

function Base.show(io::IO, m::GratingNoiseModel)
    compact = get(io, :compact, false)

    if !compact
        println("Instance of GratingNoiseModel:")
        println("Integration time       = ", m.integration_time)
        println("Detector size          = ", m.detector_size)
        println("FPA Quantum efficiency = ", m.FPA_qe)
        println("Grating efficiency     = ", m.grating_efficiency)
        println("Effective Transmission = ", m.effTransmission)
        println("F-number               = ", m.FPA_qe)
        println("Spectral Sampling      = ", m.SSI)
        println("Readout noise          = ", m.readNoise)
        println("Dark_current           = ", m.dark_current)
    else
        show(io, "Instance of GratingNoiseModel")
    end
end