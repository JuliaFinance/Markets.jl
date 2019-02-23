module Markets

using Reexport
@reexport using Currencies
export Market

struct Market
    name::String
    # Yield curves
    # Equity prices
    # Etc
end

end # module
