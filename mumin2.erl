% @Author: Zeeshan  Ahmad
% @Date:   2020-10-07 18:04:16
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-07 22:45:41
-module(mumin2).
-behaviour(gen_server).
-author("Mumin Mushtaq").
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([vegetables/5,veg_info/1,all_vegetables/0,find/0]).

start_link() ->
    gen_server:start_link({local,?MODULE},?MODULE,[],[]). 

stop() ->
    gen_server:cast(?MODULE,stop).       

vegetables(Id,Home_veg,Spices,Round_veg,Child_special) ->
    gen_server:call(?MODULE,{vegetables,{Id,Home_veg,Spices,Round_veg,Child_special}}).

veg_info(Id) ->
    gen_server:call(?MODULE,{veg_info,Id}).

all_vegetables() ->
    gen_server:call(?MODULE,{all_vegetables}).

find() ->
   gen_server:call(?MODULE,{find}).

init(_Args) ->   
    ets:new(table,[bag,named_table,{keypos,1}]),
    {ok, []}.

handle_call({vegetables,{Id,Home_veg,Spices,Round_veg,Child_special}}, _From, _State) ->   % define the state
N = ets:insert(table,[{Id,Home_veg,Spices,Round_veg,Child_special}]),
io:format("MY SABXI STORE : ~p~n",[N]),
{reply, added, N};

handle_call({veg_info,Id}, _From, State) ->
    Result = ets:lookup(table,Id),
    io:format("SAbzi detail : ~p~n",[Result]),
    {reply, done, State};

handle_call({all_vegetables}, _From, State) ->
 io:format("ALL HOTEL INFORMATION : ~p~n",[ets:tab2list(table)]),
  {reply, total,State};

    handle_call({find}, _From,_State) ->
        Z=ets:match(table,{'_','_','_','_','$1'}),
         {reply, Z, _State};

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