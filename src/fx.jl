module FX

using ..Positions

const FI = FinancialInstruments

struct CurrencyPair{A<:Real,update}
    bid::A
    ask::A
end
CurrencyPair(bid,ask) = CurrencyPair{typeof(bid),identity}(bid,ask)

update(c::CurrencyPair{A,F}) where {A,F} = F(c)

convert(::Type{P},x::P) where P<:Position = x
function generatepair(base::Currency{B},currency::Currency{C},bid::A,ask::A=bid) where {B,C,A<:Real}
    pair = Symbol(B,C)
    @eval FX const $(pair) = Ref{CurrencyPair}()
    @eval FX $(pair)[] = CurrencyPair($bid,$ask)
    baseccy = Position(getproperty(FI,B),1.)
    ccy = Position(getproperty(FI,C),1.)
    @eval FX begin
        function convert(::Type{$(typeof(baseccy))},x::$(typeof(ccy)))
            rate = $(pair)[].bid
            return $(typeof(baseccy))(x.amount/rate)
        end
    end
    return nothing
end

end # module
