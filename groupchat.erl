% @Author: Zeeshan  Ahmad
% @Date:   2020-09-29 09:40:28
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-28 15:40:28
-module(groupchat).
-behaviour(gen_server).
-export([start_link/0, stop/0, message/2, get_count/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

stop() ->
    gen_server:cast(?MODULE, stop). 
    

message(Name,Dept) ->
    gen_server:cast(?MODULE, {message, {Name,Dept}}).

get_count() ->
    gen_server:call(?MODULE, {get_count}).


init({}) ->
    {ok, []}.

handle_cast({message,{Name,Dept}},State) ->
    io:format("its ~s", [Name]),
    io:format(" From ~s  Department ~n", [Dept]),
    Newstate = [{Name,Dept} | State ],
    State1  = lists:usort(Newstate),
    {noreply, State1};

handle_cast(Msg, State) ->   %THIS FUNCTION IS IF WE PASS LESS THAN TWO OR MORE THAN
                            %ARGUMENTS IN message() function
    error_logger:warning_msg("Bad message: ~p~n", [Msg]),
    {noreply, State}.     

handle_call({get_count}, _From, State) ->
    io:format("ALL EMPLOYEE DATABASE: ~p \n", [State]),
    {reply, get_count, State}.


handle_info(Info, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Info]),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.