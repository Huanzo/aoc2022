include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function split_by(λ, a::Vector)
    out = []
    tmp = []
    for e in a
        if λ(e)
            push!(out, tmp)
            tmp = []
        else
            push!(tmp, parse(Int, e))
        end
    end
    out
end

calories_per_elf(in::Vector{String}) = map((x) -> sum(x), split_by(==(""), in))


function p1(input::Vector{String})
    maximum(calories_per_elf(input))
end


function p2(input::Vector{String})
    sum(sort(calories_per_elf(input))[end-2:end])
end

@aoc(2022, 1)
