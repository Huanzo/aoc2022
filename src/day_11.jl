include(joinpath(readchomp(`git rev-parse --show-toplevel`), "aoc.jl"))
import .Aoc: @aoc

function parse_monkeys(input::Vector{String})
    curr_monkey = -1
    monkeys = Dict()
    ops = Dict()
    tests = Dict()
    conditions = Dict()
    for i in input
        line = strip(i)
        if line == ""
            continue
        end
        if line[1:6] == "Monkey"
            curr_monkey += 1
            continue
        end
        if line[1:8] == "Starting"
            items = split(line, ':')[2]
            items = split(items, ',')
            items = map((x) -> parse(Int, strip(x)), items)
            monkeys[curr_monkey] = items
            continue
        end
        if line[1:9] == "Operation"
            op = strip(split(line, '=')[2])
            op = split(op)
            ops[curr_monkey] = op
            continue
        end
        if line[1:4] == "Test"
            div_by = parse(Int, split(line)[end])
            tests[curr_monkey] = [div_by]
            continue
        end
        if line[1:2] == "If"
            to = parse(Int, split(line)[end])
            push!(tests[curr_monkey], to)
            continue
        end
    end
    (monkeys, ops, tests, conditions)
end

function run(turns, monkeys, ops, tests, conditions, worry_level_fn)
    inspects = Dict()

    for turn in 1:turns
        for m in 0:length(keys(monkeys))-1
            while length(monkeys[m]) > 0
                if haskey(inspects, m)
                    inspects[m] += 1
                else
                    inspects[m] = 1
                end
                wl = popfirst!(monkeys[m])
                op = ops[m]
                operand1 = op[1] == "old" ? wl : parse(Int, op[1])
                operand2 = op[3] == "old" ? wl : parse(Int, op[3])
                operator = op[2]
                wl = eval(Meta.parse("$operand1 $operator $operand2"))
                wl = worry_level_fn(wl)
                if wl % tests[m][1] == 0
                    push!(monkeys[tests[m][2]], wl)
                else
                    push!(monkeys[tests[m][3]], wl)
                end
            end
        end
    end
    inspects
end

function p1(input::Vector{String})
    monkeys, ops, tests, conditions = parse_monkeys(input)
    inspections = run(20, monkeys, ops, tests, conditions,  x -> x % 3)
    res = sort(collect(values(inspections)))[end-1:end]
    res[1] * res[2]
end


function p2(input::Vector{String})
    monkeys, ops, tests, conditions = parse_monkeys(input)
    lcm = 1
    for i in values(tests)
        lcm *= i[1]
    end
    inspections = run(10000, monkeys, ops, tests, conditions, x -> x % lcm)
    res = sort(collect(values(inspections)))[end-1:end]
    res[1] * res[2]
end

@aoc(2022, 11)
