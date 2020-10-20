% @Author: Zeeshan  Ahmad
% @Date:   2020-10-08 16:00:57
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-08 16:13:40
-module(license_server).
-behaviour(gen_server).
-author("Mumin Mushtaq").
-export([start_link/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

-export([user/4, user_info/1, user_data/0, update_user/4, find_user/1, delete/1]).
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []). % this starts the Gen server

stop() ->
    gen_server:cast(?MODULE, stop).       

user(Id, Name, Address, Lic_issued) ->
    gen_server:call(?MODULE, {user, {Id, Name, Address,Lic_issued}}).

user_info(Id) ->
    gen_server:call(?MODULE, {user_info, Id}).

user_data() ->
    gen_server:call(?MODULE, {user_data}).

update_user(Id, Name, Address, Lic_issued) ->
    gen_server:call(?MODULE,{update_user, {Id, Name, Address, Lic_issued}}).

delete(Id) ->
    gen_server:call(?MODULE,{delete,Id}).

find_user(Name) ->
        gen_server:call(?MODULE, {find_user, Name}).

init(_Args) ->  
    {ok,[]}.

handle_call({user, {Id, Name, Address, Lic_issued}}, _From, State) ->   
    NewState = [{Id, Name, Address, Lic_issued}|State],
    io:format(" License details of User: ~p~n", [NewState]),
    {reply, added, NewState};   

handle_call({user_info,Id}, _From, State) ->
    Result = lists:keyfind(Id,1,State),
    {reply, Result, State};

handle_call({user_data}, _From, State) ->
    {reply, lists:reverse(State), State};

handle_call({update_user,{Id, Name, Address, Lic_issued}}, _From, State) ->
    NewState = lists:keyreplace(Id, 1, State,{Id, Name, Address, Lic_issued}),
    io:format(" User details are updated : ~p~n",[NewState]),
    {reply, updated, NewState};

handle_call({delete, Id}, _From, State) ->
    NewState = lists:keydelete(Id,1,State),
    io:format(" The user is dormented : ~p~n",[NewState]),
    {reply, deleted, NewState};

    handle_call({find_user,Name}, _From, State) ->
        Check = lists:keysearch(Name, 2,State),
        if Check==false ->
            io:format("THIS NAME HAS NOT ANY LICENCE ISSUED");
            true->
            io:format(" USED DETAILS ~p~n",[Check])
        end,
       {reply, ok, State};
        
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