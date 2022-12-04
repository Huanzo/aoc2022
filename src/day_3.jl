include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

priority = ['a':'z'; 'A':'Z']

function p1(input::Vector{String})
    sum([ findfirst(==(intersect(i[begin:sizeof(i)÷2], i[sizeof(i)÷2+1:end])[1]), priority) for i in input ])
end

function p2(input::Vector{String})
    sum([ findfirst(==(foldl(intersect, input[i:i+2])[1]), priority) for i in 1:3:length(input) ])
end

@aoc(2022, 3)
