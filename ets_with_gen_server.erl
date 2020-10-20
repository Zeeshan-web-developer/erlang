
% @Program Def:In this program i am using genserver with ets table 
%to store information of various hotels like HotelName,HotelLocation,DishesAvailable,
%ets.BASICALLY THE PURPOSE OF THIS PROGRAM IS ?HOW CAN WE USE ETS WITH GENSERVER
% @Author: Zeeshan  Ahmad
% @Date:   2020-09-30 14:03:52
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-01 10:52:49

-module(ets_with_gen_server).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([hotelsInfo/5,tableRename/2,showHotelDetail/1,deleteTable/0,showAllHotels/0,updateData/2,deleteData/1]).


%%This function is used to start the genserver
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

%#This function is used to start the genserver
stop() ->
  gen_server:cast(?MODULE, stop).

%%This function creates a new record for each hotel
hotelsInfo(HotelPin,HotelName,HotelLocation,RoomsAvailable,HotelContact) ->
  gen_server:call(?MODULE, {hotelsInfo, {HotelPin,HotelName,HotelLocation,RoomsAvailable,HotelContact}}).


%%This function GIVES THE INFORMATION OF HOTEL WITH THE HOTEL PIN
showHotelDetail(HotelPin) ->
  gen_server:call(?MODULE,{showHotelDetail,HotelPin}).

  tableRename(OldName,Newname) ->
    gen_server:call(?MODULE,{showHotelDetail,{OldName,Newname}}).

%%This function is used to show all hotel present in our ets table
showAllHotels() ->
  gen_server:call(?MODULE,{showAllHotels}).

  updateData(RecordNumber,HotelName) ->
    gen_server:call(?MODULE,{updateData,{RecordNumber,HotelName}}).
  
deleteData(RecordNumber) ->
    gen_server:call(?MODULE,{deleteData,RecordNumber}).

%This function deletes whole table
deleteTable() ->
            gen_server:call(?MODULE,{deleteTable}).

  init(_Args) ->
    ets:new(table,[ordered_set,named_table,{keypos,1}]),
    {ok, []}.

%----inserts new hotel information
handle_call({hotelsInfo,{HotelPin,HotelName,HotelLocation,RoomsAvailable,HotelContact}}, _From, _State) ->
  N = ets:insert(table,[{HotelPin,HotelName,HotelLocation,RoomsAvailable,HotelContact}]),
  io:format("NEW HOTEL ADDED : ~p~n",[N]),
  {reply, added, N};

%--------show a particular hotel detail based on row  number
handle_call({showHotelDetail,RecordNumber}, _From, State) ->
  Result = ets:lookup(table,RecordNumber),
  io:format("HOTEL INFORMATION : ~p~n",[Result]),
  {reply, done, State};

%---show all hotels present on ets table
handle_call({showAllHotels}, _From, State) ->
  io:format("ALL HOTEL INFORMATION : ~p~n",[ets:tab2list(table)]),
  {reply, total,State};

%--updating hotel name basedon record number
handle_call({updateData,{RecordNumber,HotelName}}, _From, _State) ->
  Newdata = ets:update_element(table,RecordNumber,{2,HotelName}),
  io:format("Hotel Details Updated: ~p~n",[Newdata]),
  {reply, updated, Newdata};

%----delete the table
  handle_call({deleteTable}, _From, _State) ->
    Newdata = ets:delete(table),
    io:format("Hotel Deleted: ~p~n",[Newdata]),
    {reply, deleted, Newdata};


handle_call({deleteData,RecordNumber}, _From, _State) ->
  Newdata = ets:delete(table,RecordNumber),
  io:format("Hotel Deleted: ~p~n",[Newdata]),
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
  io:format("server is terminating with ~p reason ~n",[Reason]).