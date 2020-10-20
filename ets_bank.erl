
-module(ets_bank).
-author("suman").

%% API
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([new_account/5,get_details/1,get_total_data/0,update_data/2,delete_data/1]).

start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop() ->
  gen_server:cast(?MODULE, stop).


new_account(Accnum,Name,Acctype,Branch,Area) ->
  gen_server:call(?MODULE, {new_account, {Accnum,Name,Acctype,Branch,Area}}).

get_details(Accnum) ->
  gen_server:call(?MODULE,{get_details,Accnum}).

get_total_data() ->
  gen_server:call(?MODULE,{get_total_data}).

update_data(Key,Name) ->
  gen_server:call(?MODULE,{update_data,{Key,Name}}).
delete_data(Accnum) ->
  gen_server:call(?MODULE,{delete_data,Accnum}).

init(_Args) ->
  ets:new(table,[ordered_set,named_table,{keypos,1}]),
  {ok, []}.

handle_call({new_account,{Accnum,Name,Acctype,Branch,Area}}, _From, _State) ->
  N = ets:insert(table,[{Accnum,Name,Acctype,Branch,Area}]),
  io:format("new account holder data : ~p~n",[N]),
  {reply, added, N};
handle_call({get_details,Key}, _From, State) ->
  Result = ets:lookup(table,Key),
  io:format("data of the particular key : ~p~n",[Result]),
  {reply, done, State};
handle_call({get_total_data}, _From, State) ->
  io:format("total data : ~p~n",[ets:tab2list(table)]),
  {reply, total,State};
handle_call({update_data,{Key,Name}}, _From, _State) ->
  Newdata = ets:update_element(table,Key,{2,Name}),
  io:format("updated account holder data: ~p~n",[Newdata]),
  {reply, updated, Newdata};
handle_call({delete_data,Key}, _From, _State) ->
  Newdata = ets:delete(table,Key),
  io:format("updated account holder data: ~p~n",[Newdata]),
  {reply, deleted, Newdata};
handle_call(Message, _From, State) ->
  io:format("received other handle_call message: ~p~n",[Message]),
  {reply, ok, State}.

handle_cast(stop,State) ->
  {stop,normal,State};
handle_cast(Message, State) ->
  io:format("received other handle_cast call : ~p~n",[Message]),
  {noreply,State}.

handle_info(Message, State) ->
  io:format("received handle_info message : ~p~n",[Message]),
  {noreply,State}.

code_change(_OldVer, State, _Extra) ->
  {ok,State}.

terminate(Reason, _State) ->
  io:format("server is terminating with reason :~p~n",[Reason]).