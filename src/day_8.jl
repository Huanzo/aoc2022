include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

directions() = [[-1, 0], [1, 0], [0, -1], [0, 1]]

parse_grid(input::Vector{String}) = [ parse.(Int, collect(i)) for i in input]

function visible()
end

function p1(input::Vector{String})
    grid = parse_grid(input)
    xlen = length(grid)
    ylen = length(grid[1])
    visible = 0

    for x in 1:xlen, y in 1:ylen
        if (x == 1 || x == xlen || y == 1 || y == ylen) 
            visible += 1
            continue
        end
        curr = grid[x][y]
        tops = map((x) -> x[y], grid[begin:x-1])
        btms = map((x) -> x[y], grid[x+1:end])
        lefts = grid[x][begin:y-1]
        rights = grid[x][y+1:end]
        if curr > maximum(tops)
            visible += 1
            continue
        elseif curr > maximum(btms)
            visible += 1
            continue
        elseif curr > maximum(lefts)
            visible += 1
            continue
        elseif curr > maximum(rights)
            visible += 1
            continue
        end
    end
    visible
end

function p2(input::Vector{String})
    grid = parse_grid(input)
    xlen = length(grid)
    ylen = length(grid[1])
    res = 0

    for x in 1:xlen, y in 1:ylen
        tmp = 1
        for (i, j) in directions()
            curr = 0
            dx = x + i
            dy = y + j
            while 0 < dx <= xlen && 0 < dy <= ylen
                curr += 1
                (grid[dx][dy] >= grid[x][y]) && (break)
                dx += i
                dy += j
            end
            tmp*=curr
        end
        res = max(res, tmp)
    end
    res
end

@aoc(2022, 8)
