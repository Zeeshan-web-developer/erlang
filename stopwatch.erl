% @Author: Zeeshan  Ahmad
% @Date:   2020-10-08 09:33:27
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-12 14:51:37
%This program is a stopwatch program
 
-module(stopwatch).
-behaviour(gen_server).
-export([start_link/0, stop/0]).
-export([startClock/0, stopClock/0, displayReading/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-record(record_vairable, 
    {
  mode = stopped,
  startTime = 0,
  stopTime = 0}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() ->
  gen_server:cast(?MODULE, stop).


startClock() ->
  gen_server:cast(?MODULE, startTimer).

stopClock() ->
  gen_server:cast(?MODULE, stopTimer).

displayReading() ->
  gen_server:call(?MODULE, readTimer).


init([]) ->  %intialization of state
  {ok, #record_vairable{
  mode = stopped,
  startTime = 0,
  stopTime = 0
  }}.

handle_cast(stop,State) ->
  io:format("SERVER IS STOPPING"),
  {stop,normal,State};

%%State is here just like new Varaible for record to update
handle_cast(startTimer, State) ->
  %timestamp  gives current sytem time in microseconds
  StartTime = erlang:timestamp(),
  io:format("Stopwatch Started~n"),
  {noreply, State#record_vairable{mode = running, startTime = StartTime}};

handle_cast(stopTimer, State) ->
  StopTime = erlang:timestamp(),
  io:format("Stopwatch Stopped~n"),
  {noreply, State#record_vairable{mode = stopped, stopTime = StopTime}};

handle_cast(Message, State) ->
  io:format("received other handle_cast call : ~p~n",[Message]),
  {noreply,State}.


%================================
%when we start genser ,at that time read timer will  call this function
%=======================================================
handle_call(readTimer, _From, State = #record_vairable{mode = running}) ->
  io:format("READ TIMER IN RUNNNING MODE~n"),
  Now = erlang:timestamp(),
  Diff = timeDifference(Now, State#record_vairable.startTime),
  {reply, Diff, State};

%================================
%when we stop genser ,at that time read timer will  call this function
%=======================================================
handle_call(readTimer, _From, State = #record_vairable{mode = stopped}) ->
  io:format("READ TIMER IN AFTER STOPPING WATCH~n"),
  Diff = timeDifference(State#record_vairable.stopTime, State#record_vairable.startTime),
  {reply, Diff, State};

handle_call(Message, _From, State) ->
  io:format("received other handle_call message: ~p~n",[Message]),
  {reply, ok, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(Reason, _State) ->
  io:format("Stopwatch server is shutting down with Reason: ~p~n",[Reason]),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.


%This function calculates difference bw startig  time and and last time
timeDifference(Final,Initial) ->
  DiffMicroSecs = timer:now_diff(Final,Initial),
  DiffMicroSecs.