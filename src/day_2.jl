include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

win_conditions = Dict(
    "A X" => 3,
    "A Y" => 6,
    "A Z" => 0,
    "B X" => 0,
    "B Y" => 3,
    "B Z" => 6,
    "C X" => 6,
    "C Y" => 0,
    "C Z" => 3,
)
should_play = Dict(
    "A X" => 'Z',
    "A Y" => 'X',
    "A Z" => 'Y',
    "B X" => 'X',
    "B Y" => 'Y',
    "B Z" => 'Z',
    "C X" => 'Y',
    "C Y" => 'Z',
    "C Z" => 'X',
)
score_table = Dict('X' => 1, 'Y' => 2, 'Z' => 3)

function p1(input::Vector{String})
    sum([ win_conditions[i] + score_table[i[3]] for i in input ])
end

function transform_input(x)
    arr = collect(x)
    arr[3] = should_play[x]
    join(arr)
end

function p2(input::Vector{String})
    input = map(transform_input, input)
    sum([ win_conditions[i] + score_table[i[3]] for i in input ])
end

@aoc(2022, 2)
