include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function parse_input(input)
    separator = findfirst(==(""), input)
    num_stacks = length(unique(input[separator-1])) - 1
    stacks = [ [] for _ in 1:num_stacks ]
    instructions = [ parse.(Int, [ i.match for i in eachmatch(r"\d+", instr)]) for instr in input[separator+1:end] ]
    
    for i in separator-2:-1:1
        line = input[i]
        while true
            col = findlast(isletter, line)
            (col == nothing) && break
            index = Int(round(col/4, RoundUp))
            push!(stacks[index], line[col])
            line = line[begin:col-2]
        end
    end
    (stacks, instructions)
end

function solve(λ, input)
    stacks, instructions = parse_input(input)
    for (c,f,t) in instructions
        append!(stacks[t],λ([pop!(stacks[f]) for _ in 1:c ]))
    end
    join(map(pop!, stacks))
end

function p1(input::Vector{String})
    solve((x) -> x, input)
end

function p2(input::Vector{String})
    solve(reverse, input)
end

@aoc(2022, 5)
