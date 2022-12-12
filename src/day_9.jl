include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

offsets = Dict('L' => (-1, 0), 'R' => (1, 0), 'U' => (0, 1), 'D' => (0, -1))

function p1(input::Vector{String})
    headx, heady = (0,0)
    tailx, taily = (0,0)
    map = Dict((0,0) => true)
    for i in input
        x, y = offsets[i[1]]
        for _ in 1:parse(Int, split(i)[2])
            headx += x
            heady += y
            while max(abs(tailx - headx), abs(taily - heady)) > 1
                if abs(tailx - headx) > 0
                    tailx += headx > tailx ? 1 : -1
                end
                if abs(taily - heady) > 0
                    taily += heady > taily ? 1 : -1
                end
                map[(tailx, taily)] = true
            end
        end
    end
    length(keys(map))
end

function p2(input::Vector{String})
    rope = [ [0, 0] for _ in 1:10 ]
    map = Dict((0,0) => true)
    for i in input
        x, y = offsets[i[1]]
        for _ in 1:parse(Int, split(i)[2])
            head = rope[1]
            rope[1] = [head[1] + x, head[2] + y]

            for ri in 2:10
                prevx, prevy = rope[ri-1]
                currx, curry = rope[ri]
                while max(abs(currx - prevx), abs(curry - prevy)) > 1
                    if abs(currx - prevx) > 0
                        currx += prevx > currx ? 1 : -1
                    end
                    if abs(curry - prevy) > 0
                        curry += prevy > curry ? 1 : -1
                    end
                end
                rope[ri] = [currx, curry]
            end
            last = rope[end]
            map[(last[1], last[2])] = true
        end
    end
    length(keys(map))
end

@aoc(2022, 9)
