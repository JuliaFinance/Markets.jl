module Markets

using Reexport
@reexport using Currencies
export Market

struct Market{C<:Currency}
    name::String
    # Yield curves
    # Equity prices
    # Etc
end

end # module
