include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc
using Graphs

directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

function build_graph(input::Vector{String})
    grid = hcat(collect.(input)...)

    start = findfirst(==('S'), grid)
    dest = findfirst(==('E'), grid)
    grid[start] = 'a'
    grid[dest] = 'z'

    grid = map(x -> x - 'a', grid)
    graph = SimpleDiGraph(length(grid))

    for (i, h) in enumerate(grid)
        ic = CartesianIndices(grid)[i]

        neighs = map(x -> ic + CartesianIndex(x), directions)
        for d in filter(x -> checkbounds(Bool, grid, x), neighs)
            if grid[d] <= h+1
                add_edge!(graph, i, LinearIndices(grid)[d])
            end
        end
    end
    (start, dest, grid, graph)
end

function p1(input::Vector{String})
    start, dest, grid, graph = build_graph(input)

    solution = dijkstra_shortest_paths(graph, LinearIndices(grid)[start])
    solution.dists[LinearIndices(grid)[dest]]
end


function p2(input::Vector{String})
    start, dest, grid, graph = build_graph(input)
    sources = findall(==(0), grid)

    solution = dijkstra_shortest_paths(graph, map(x -> LinearIndices(grid)[x], sources))
    solution.dists[LinearIndices(grid)[dest]]
end

@aoc(2022, 12)
