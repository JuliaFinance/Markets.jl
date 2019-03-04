module Markets

using Reexport
@reexport using Positions, Dates
export FX

const time = Ref{DateTime}()

include("fx.jl")

end # module
