defmodule Calculator do

  def start do
    spawn(fn -> loop(0) end)
  end

  def loop(current_value) do
    new_value = receive do
      {:value, caller} ->
        send(caller, {:response, current_value})

      {:add, value} -> current_value + value
      {:sub, value} -> current_value - value
      {:mul, value} -> current_value * value
      {:div, value} -> current_value / value

      invalid_request ->
        IO.puts "invalid request #{invalid_request}"
        current_value
    end
    loop(new_value)
  end
end
