-module(counter).
-export([start_counter/0, add_counter/0, get_counter/0]).

% Function that inits the counter and an ets table
start_counter() ->
    ets:new(counter_ref_table, [set, public, named_table]),
    CounterRef = counters:new(1, [atomics]),
    ets:insert(counter_ref_table, {the_ref, CounterRef}),
    ok.

%% Helper function that returns the counter in the ets table
get_ref() ->
    case ets:lookup(counter_ref_table, the_ref) of
        [{the_ref, Ref}] -> Ref;
        [] -> 
            error({counter_not_started, "Must run exit_ffi:start_counter/0 first"})
    end.

%% Funtion that adds 1 to the counter
add_counter() ->
    CounterRef = get_ref(),
    counters:add(CounterRef, 1, 1).

%% Function the return the value tied to the counter
get_counter() ->
    CounterRef = get_ref(),
    counters:get(CounterRef, 1).
