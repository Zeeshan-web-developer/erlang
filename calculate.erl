%This program Calculates the How many operations are Done and How Many errors Occured
% @Author: Zeeshan  Ahmad
% @Date:   2020-10-08 15:46:38
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-08 22:50:54
-module(calculate).
-behaviour(gen_server).
-export([start_link/0, double/1, square/1, status/0,stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2, code_change/3]).
-record(state, {tolatOpDone, totalError_Occured}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
    
stop() ->
        gen_server:cast(?MODULE, stop).  
double(N) ->
     gen_server:call(?MODULE, {doubl, N}).  %missing function cheking error
square(N) -> 
    gen_server:call(?MODULE, {square, N}).
status()   -> 
    gen_server:call(?MODULE, status).
    

%% gen_server callbacks
init([]) ->            
    {ok, #state{tolatOpDone=0, totalError_Occured=0}}.

handle_call(status, _From, State=#state{tolatOpDone=Ops, totalError_Occured=Wtfs}) ->
    io:format("Total operation Done=~w~nTotal Errors Occured=~p~n",[Ops,Wtfs]),
    {reply, {Ops, Wtfs}, State}; 

handle_call({double, N}, _From, State=#state{tolatOpDone=Ops}) ->
    {reply, N*2, State#state{tolatOpDone=Ops+1}};

handle_call({square, N}, _From, State=#state{tolatOpDone=Ops}) ->
    {reply, N*N, State#state{tolatOpDone=Ops+1}};

handle_call({_, _N}, _From, State=#state{totalError_Occured=Wtfs}) ->
    io:format("Handle call error"),
    {reply, error, State#state{totalError_Occured=Wtfs+1}}.


handle_cast(stop,State) ->
        io:format("SERVER IS STOPPING"),
        {stop,normal,State};
        
handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.