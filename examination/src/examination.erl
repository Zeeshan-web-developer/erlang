-module(examination).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([add_student/5,searchResultByRollno/1]).
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).
stop() ->
  gen_server:cast(?MODULE, stop).

add_student(Rollno,StudentName,EngMarks,ScineceMArks,ItMarks) ->
  gen_server:call(?MODULE,{add_student,{Rollno,StudentName,EngMarks,ScineceMArks,ItMarks}}).

searchResultByRollno(Rollno) ->
  gen_server:call(?MODULE,{searchResultByRollno,{Rollno}}).

init([]) ->
  {ok, []}.

handle_call({add_student,{Rollno,StudentName,EngMarks,ScineceMArks,ItMarks}}, _From, State) ->
  NewState = [{Rollno,StudentName,EngMarks,ScineceMArks,ItMarks}|State],
  io:format("STUDENT ADMITTED: ~p~n",[NewState]),
  {reply, added, NewState};


handle_call({searchResultByRollno,{Rollno}}, _From, State) ->

  CheckROLLNO = lists:keysearch(Rollno, 1,State),
  if  CheckROLLNO==false ->
    io:format("PLEASE CHECK ROLLNO");
    true->
      {_,_,S1,S2,S3}= lists:keyfind(Rollno,1,State),

      Total=S1+S2+S3,
      if
        S1 >33->

          io:fwrite("English PAssed\n");

        true ->
          io:fwrite("English Failed\n")

      end,

      if
        S2 >33->

          io:fwrite("Science PAssed\n");

        true ->

          io:fwrite("Scince Failed\n")

      end,
      if
        S3 >33->

          io:fwrite("Histor PAssed\n");
        true ->

          io:fwrite("Hisory Failed\n")

      end,
      io:format("Total REsult is as ~n  (~w",[Total]),
      io:format("/300)~n")
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