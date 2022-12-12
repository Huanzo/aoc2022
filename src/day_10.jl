include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function p1(input::Vector{String})
    x = 1
    cycles = []
    for i in input
        if i == "noop"
        push!(cycles, x)
        else
            num = parse(Int, split(i)[2])
            push!(cycles, x)
            push!(cycles, x)
            x += num
        end
    end
    sum = 0
    for i in 20:40:220
        sum += cycles[i] * i
    end
        sum
end


function p2(input::Vector{String})
    x = 1
    cycles = []
    for i in input
        if i == "noop"
        push!(cycles, x)
        else
            num = parse(Int, split(i)[2])
            push!(cycles, x)
            push!(cycles, x)
            x += num
        end
    end
    cycle = 0
    while cycle < length(cycles)
        x = cycles[cycle+1]
        if abs(x - (cycle%40)) < 2
            print("#")
        else
            print(".")
        end
        cycle+=1
        if cycle % 40 == 0
            print("\n")
        end
    end
end

@aoc(2022, 10)
