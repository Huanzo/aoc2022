include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function sliding(in, w::Int64; step::Int = 1)
	((@view in[i:i+w-1]) for i in 1:step:length(in)-w+1)
end

function find_packet_start(buffer, len)
    counter = 0
    for window in sliding(buffer, len)
        length(unique(window)) == len && (return counter + len)
        counter += 1
    end
end

function p1(input::Vector{String})
    find_packet_start(input[begin], 4)
end

function p2(input::Vector{String})
    find_packet_start(input[begin], 14)
end

@aoc(2022, 6)
