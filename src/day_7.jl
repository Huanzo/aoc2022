include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function size_of_dir(dirs::Dict{String, Int}, subdirs::Dict{String, Array{String}}, dir::String)
    size = dirs[dir]
    for sub in subdirs[dir]
        sub in keys(dirs) && (size += size_of_dir(dirs, subdirs, sub))
    end
    size
end

function join_path(s1, s2)
    s2 == ".." ? join(split(s1, '/')[begin:end-1], '/') : s1 * '/' * s2
end

function build_dirs(input::Vector{String})
    dirs = Dict{String, Int}()
    subdirs = Dict{String, Array{String}}()
    pwd = ""

    for i in input
        if i[1] == '$'
            cmd = split(i[3:end])
            if cmd[1] == "cd"
                pwd = cmd[2] == "/" ?  "/" : join_path(pwd, cmd[2])
                if pwd ∉ keys(dirs)
                    dirs[pwd] = 0
                    subdirs[pwd] = []
                end
            end
        else
            size, name = split(i)
            if size == "dir"
                push!(subdirs[pwd], join_path(pwd, name))
            else
                dirs[pwd] += parse(Int, size)
            end
        end
    end

    (dirs, subdirs)
end

function p1(input::Vector{String})
    dirs, subdirs = build_dirs(input)
    total = 0
    for dir in keys(dirs)
        size = size_of_dir(dirs, subdirs, dir)
        size <= 100000 && (total+=size)
    end
    total
end

function p2(input::Vector{String})
    dirs, subdirs = build_dirs(input)
    free = 70000000 - size_of_dir(dirs, subdirs, "/")
    res = 0
    for dir in keys(dirs)
        size = size_of_dir(dirs, subdirs, dir)
        (free + size >= 30000000) && (res == 0 || res > size) && (res=size)
    end
    res
end

@aoc(2022, 7)
