% @Author: Zeeshan  Ahmad
% @Date:   2020-09-29 16:53:24
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-09-28 17:11:55
-module(standup).
-behaviour(gen_server).
-export([start_link/0, stop/0, message/2, get_count/0, on_leave/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

stop() ->
    gen_server:cast(?MODULE, stop). 
    

message(Name,Dept) ->
    gen_server:cast(?MODULE, {message, {Name,Dept}}).

get_count() ->
    gen_server:call(?MODULE, {get_count}).

on_leave() ->
    gen_server:call(?MODULE, {on_leave}).

    init([]) ->
        State = [],
        {ok, State}.

handle_cast({message,{Name,Dept}},  State) ->
    io:format("Hi Good Morning , this is  ~s!~n", [Name]),
    io:format("DEPT NAME  ~s!~n", [Dept]),
    Newstate = [Name | State ],
    State1  = lists:usort(Newstate),
    {noreply, State1};

handle_cast(Msg, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Msg]),
    {noreply, State}.

handle_call({get_count}, _From, State) ->
    io:format("People present today: ~p \n", [State]),
    
    io:format("Number of people today: ~p \n", [length(State)]),
    {reply, get_count, State};

handle_call({on_leave}, _From, State) ->
    Onleave = 14 - (length(State)),
    io:format("People on leave today: ~p \n", [Onleave]),
    {reply, on_leave, State};
    

handle_call(Request, _From, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Request]),
    {reply, {error, unknown_call}, State}.




handle_info(Info, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Info]),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.