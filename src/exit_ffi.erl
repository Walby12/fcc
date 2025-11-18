-module(exit_ffi).
-export([do_exit/1]).

%% Function that exits the exec of the beam vm
do_exit(Code) ->
	io:format("~nexec halted with 1~n"),
    erlang:halt(Code).
