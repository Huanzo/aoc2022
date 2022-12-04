include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function assignment_pairs(λ, line)
    a, b = split(line, ',')
    s1,e1,s2,e2 = parse.(Int,[split(a, '-'); split(b, '-')])
    λ(s1:e1, s2:e2)
end

function p1(input::Vector{String})
    count(map((x) -> assignment_pairs((a, b) -> (a ⊆  b || b ⊆  a), x), input))
end

function p2(input::Vector{String})
    count(map((x) -> assignment_pairs((a, b) -> length(intersect(a, b)) > 0, x), input))
end

@aoc(2022, 4)
