#!/usr/bin/env julia

module Aoc
using HTTP
export @aoc

_data_path(day) = joinpath(readchomp(`git rev-parse --show-toplevel`), "data", "day_$day.txt")

_input(day) = readlines(_data_path(day))

function _cookie()
  if "AOC_TOKEN" ∈ keys(ENV)
    return Dict("session" => ENV["AOC_TOKEN"])
  end
  error("Environement variable AOC_TOKEN not set")
end

function _get_input(year, day)
  res = HTTP.get("https://adventofcode.com/$year/day/$day/input", cookies = _cookie())
  if res.status ≠ 200
    error("Unable to fetch infput for AOC $year day $day")
  end
  return res.body
end

function _setup_aoc(year, day)
  path = _data_path(day)
  if isfile(path)
    return
  end
  open(path, "w") do f
    write(f, _get_input(year, day))
  end
end


function _run_parts(day)
  input = _input(day)
  if "precompile" ∈ ARGS
    @info "precompilation is on"
  end
  if isdefined(Main, :p1)
    if "precompile" ∈ ARGS
      i = copy(input)
      Main.p1(i)
    end
    i = copy(input)
    p1_res = @time Main.p1(i)
    @info "Part 1: $p1_res"
  else
    @info "p1() not defined. skipping..."
  end

  if isdefined(Main, :p2)
    if "precompile" ∈ ARGS
      i = copy(input)
      Main.p2(i)
    end
    i = copy(input)
    p2_res = @time Main.p2(i)
    @info "Part 2: $p2_res"
  else
    @info "p2() not defined. skipping..."
  end
end

function _run(year, day)
  _setup_aoc(year, day)
  _run_parts(day)
end

macro aoc(year, day)
  return :( _run($year, $day))
end

end
