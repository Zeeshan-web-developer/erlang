% @Author: Zeeshan  Ahmad
% @Date:   2020-10-09 14:41:05
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-09 14:45:22
-module(cache1).
-behaviour(gen_server).
-export([start_link/0, stop/0]).
-export([add/2, delete/1, get/1, size/0, state/0,update/2]).

-export([code_change/3,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         init/1,
         terminate/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE},
                          ?MODULE,
                          [],
                          []).

add(Key, Value) ->
    gen_server:cast(?MODULE, {add, {Key, Value}}).

get(Key) -> gen_server:call(?MODULE, {get, Key}).

delete(Key) -> gen_server:cast(?MODULE, {delete, Key}).

update(Key,Value) -> 
    gen_server:cast(?MODULE, {update,{Key,Value}}).


state() -> gen_server:call(?MODULE, {get_state}).

size() -> gen_server:call(?MODULE, {map_size(put)}).

stop() -> gen_server:stop(?MODULE).

init([]) -> {ok, #{}}.

handle_call({get, Key}, _From, State) ->
    Response = maps:get(Key, State, undefined),
    {reply, Response, State};
handle_call({get_state}, _From, State) ->
    Response = {current_state, State},
    {reply, Response, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast({add, {Key, Value}}, State) ->
    NewState = maps:put(Key, Value, State),
    {noreply, NewState};

 handle_cast({update, {Key, Value}}, State) ->
        NewState = maps:update(Key, Value, State),
        {noreply, NewState};
        
handle_cast({delete, Key}, State) ->
    NewState = maps:remove(Key, State),
    {noreply, NewState};
handle_cast(_Msg, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.
