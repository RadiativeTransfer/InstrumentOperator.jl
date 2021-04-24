# InstrumentOperator.jl
Collection of instrument line-shape methods for hyperspectral remote sensing. Basic objective is to provide composable routines to apply a variety of instrument line-shapes for the convolution and resampling of high resolution modeled radiance with an instrument operator. At the moment, we have FTS systems (sinc function convolved with assymetric box), spectrally varying lookup tables as for the Orbiting Carbon Observatory and generic distribution functions (e.g. Gaussian) as instrument kernels.

## Installation

InstrumentOperator can be installed using the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run

```julia
pkg> add https://github.com/RadiativeTransfer/InstrumentOperator.jl
```
