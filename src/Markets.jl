module Markets

using Reexport
@reexport using Positions
export FX

const time = Ref{DateTime}()

module FX

using ..Positions

const FI = FinancialInstruments

struct CurrencyPair{A<:Real}
    bid::A
    ask::A
end

function generatepair(base::Currency{B},currency::Currency{C},bid::A,ask::A=bid) where {B,C,A<:Real}
    pair = Symbol(B,C)
    @eval FX const $(pair) = Ref{CurrencyPair}()
    @eval $(pair)[] = CurrencyPair($bid,$ask)
    baseccy = Position(getproperty(FI,B),1.)
    ccy = Position(getproperty(FI,C),1.)
    @eval begin
        function Base.convert(::Type{$(typeof(baseccy))},x::$(typeof(ccy)))
            rate = $(pair)[].bid
            return $(typeof(baseccy))(x.amount/rate)
        end
    end
end

end

end # module
