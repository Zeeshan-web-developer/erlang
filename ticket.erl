% @Author: Zeeshan  Ahmad
% @Date:   2020-10-01 12:42:39
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-06 09:17:03
-module(ticket).
-export([start_link/0,stop/0]).
-export([addTiket_Info/2,totalTiketsAvailable/0,bookMyTrain/4]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).



start_link()->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop()->
  gen_server:cast({?MODULE,stop}).

addTiket_Info(Tickets,TiketNumber)->
  gen_server:call(?MODULE,{addTiket_Info,{Tickets,TiketNumber}}).

totalTiketsAvailable()->
  gen_server:call(?MODULE,{totalTiketsAvailable}).

bookMyTrain(Name,PersonAddrss,Source,Destination)->
  gen_server:call(?MODULE,{bookMyTrain,{Name,PersonAddrss,Source,Destination}}).



init([])->
    ets:new(table,[ordered_set,named_table,{keypos,2}]),
    {ok,0}.

handle_call({addTiket_Info,{Tickets,TiketNumber}},_From,State)->
     ets:insert(table,[{Tickets,TiketNumber}]),
     io:format("TICKET ADDED WITH TICKET NUMBER : ~p~n",[TiketNumber]),
     N= State + 1,
    {reply,added,N};


handle_call({totalTiketsAvailable},_From,State) ->
  if State == 0
     -> io:format("NO RESEERVATION IS AVAILABLE .~n "),
  {reply,ok,State};
    true -> 
        io:format("TOTAL NUMBER OF TICKETS AVAILABLE  WITH TIKET NUMBER: ~p~n",[ets:tab2list(table)]),
      {reply,done,State}
  end;


handle_call({bookMyTrain,{Name,PersonAddrss,Source,Destination}},_From,State)->
  LS = (State -1),
  if LS < 0
     -> io:format("NO RESERVATION IS AVAILABLE ~n"),
  {reply,ok,State};
    true -> 
    RecordNumber=State,
        io:format("TICKET BOOKED SUCESSFULLY~n"),
        io:format("TICKET INFORMATION IS AS~n"),
        io:format("---------------------------~n"),
        io:format("Name         : ~p~n",[Name]),
        io:format("ADDRESS      : ~p~n",[PersonAddrss]),
        io:format("SOURCE       : ~p~n",[Source]),
        io:format("DESTINATION  : ~p~n",[Destination]),
        ets:delete(table,RecordNumber),
{reply,done,LS}
  end;




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



