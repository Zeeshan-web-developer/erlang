% @Author: Zeeshan  Ahmad
% @Date:   2020-10-07 11:21:48
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-07 11:40:59
-module(cache).
-behaviour(gen_server).

-export([start_link/0]).
-export([get/1, put/2, state/0, delete/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

put(Key, Value) ->
    gen_server:cast(?MODULE, {put, {Key, Value}}).

get(Key) ->
    gen_server:call(?MODULE, {get, Key}).

delete(Key) ->
    gen_server:cast(?MODULE, {delete, Key}).

state() ->
    gen_server:call(?MODULE, {get_state}).

stop() ->
    gen_server:stop(?MODULE).

init([]) ->
    {ok, #{}}.


handle_call({get, Key}, _From, State) ->
    Response = maps:get(Key, State, undefined),
    {reply, Response, State};

handle_call({get_state}, _From, State) ->
    Response = {current_state, State},
    {reply, Response, State};

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.


handle_cast({put, {Key, Value}}, State) ->
    NewState = maps:put(Key, Value, State),
    {noreply, NewState};


handle_cast({delete, Key}, State) ->
    NewState = maps:remove(Key, State),
    {noreply, NewState};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.