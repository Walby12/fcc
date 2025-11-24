-module(exit_ffi).
-export([do_exit/1]).

%% Function that halts the exec of the program
do_exit(Code) ->
	io:format("~nexecution halted with 1~n"),
    erlang:halt(Code).
