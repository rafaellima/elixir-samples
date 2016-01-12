#without processes
run_query = fn(query_def) ->
  :timer.sleep(2000)
  "#{query_def} result"
end
run_query.('query 1')

1..5 |>
  Enum.map(&run_query.("query #{&1}"))


# with concurrency
spawn(fn -> IO.puts(run_query.("query 1")) end)
