% @Author: Zeeshan  Ahmad
% @Date:   2020-10-14 23:28:11
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-15 15:51:41
-module(alaramManager).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([setAlaram/3,checkAllAlarams/0,removeSavedAlaram/1,checkAlaram/1]).

start_link() ->
  gen_server:start_link({local,?MODULE}, ?MODULE, [], []).

stop() ->
  gen_server:cast(?MODULE, stop).

setAlaram(Time,Message,Status) ->
  gen_server:call(?MODULE,{setAlaram,{Time,Message,Status}}).

checkAllAlarams() ->
  gen_server:call(?MODULE,{checkAllAlarams}).

removeSavedAlaram(Time) ->
  gen_server:call(?MODULE,{removeSavedAlaram,Time}).


checkAlaram(Time) ->
  gen_server:call(?MODULE,{checkAlaram,Time}).

init(_Args) ->
  {ok, []}.


handle_call({setAlaram, {Time,Message,Status}}, _From, State) ->
  NewAlaramSet = alaramDbHandler:setNewAlaram(Time,Message,Status),
  Newstate = [NewAlaramSet | State],
  {reply, saved, Newstate};

handle_call({checkAlaram, Time}, _From, State) ->
  AlaramTime = alaramDbHandler:checkAlaram(Time),

  if
    AlaramTime ==[] ->
      io:format("Alaram not set");
    true->
      AlaramTime2 = alaramDbHandler:checkAlaram1(Time),
      % io:format("Exact Time~p",[AlaramTime2]),
      if

        AlaramTime2 <0 ->
          io:fwrite("Invalid Time");
        AlaramTime2 >0 ,AlaramTime2 <12 ->
          io:fwrite("ALARAM IS SET IN THE MORNING TIME");
        AlaramTime2 >= 12,AlaramTime2 <17->
          io:fwrite("ALARAM IS SET IN AFTER NOON TIME");
        AlaramTime2 >= 17,AlaramTime2 =<21->
          io:fwrite("ALARAM IS SET IN THE EVENING TIME");
        true ->
          io:fwrite("ALARAM IS SET IN THE NIGHT MODE")
      end

  end,
  {reply,ok, State};

handle_call({checkAllAlarams}, _From, State) ->
  Newstate = alaramDbHandler:checkAllAlarams(),
  io:format("TOTAL ALARAMS DATA~n"),
  io:format("~p", [Newstate]),
  {reply,ok, State};
handle_call({removeSavedAlaram, Time}, _From, _State) ->
  NewState = alaramDbHandler:removeAlaram(Time),
  io:format("Removed sucessfully: ~p~n",[NewState]),
  {reply, deleted, NewState};
handle_call(_Request, _From, State) ->
  io:format("received other handle_cast call"),
  {reply, {error, unknown_call}, State}.
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