% @Author: Zeeshan  Ahmad
% @Date:   2020-09-28 09:53:21
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-20 22:41:32
-module(miStore).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([addNewPhone/3,newPhoneHandler/3,buyItem/2,showAllItems/0]).
start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).
stop() ->
  gen_server:cast(?MODULE, stop).
  
  addNewPhone(SubBrand,Price,Quantity)->
    add(SubBrand,Price,Quantity).
  newPhoneHandler(SubBrand,Price,Quantity) ->
  gen_server:call(?MODULE,{newPhoneHandler,{SubBrand,Price,Quantity}}).

 buyItem(SubBrand,Quantity) ->
    gen_server:call(?MODULE,{buyItem,{SubBrand,Quantity}}).
  
    showAllItems() ->
      gen_server:call(?MODULE,{showAllItems}).
init([]) ->
  State=[],
  {ok, State}.

%main brand




handle_call({newPhoneHandler,{SubBrand,Price,Quantity}}, _From, State) ->
  Check = lists:keyfind(SubBrand,1,State),
  if Check =/=false ->
    io:format("Product Already Present~n"),
    {reply,ok,State};
 true->
   if Quantity==0 ->
       io:format("U cannot Add a Product With Zero Quantity"),
      {reply,ok, State};
      true->
  NewState = [{SubBrand,Price,Quantity}|State],
  io:format("~nNew Product Added: ~p~n",[NewState]),
  {reply,ok, NewState} 
   end
  end;
  
  
  handle_call({buyItem,{SubBrand,Quantity1}}, _From, State) ->
 Result= lists:keyfind(SubBrand,1,State),
 if  Result==false ->
    io:format("Item is out of Stock"),
  {reply,ok, State};
true->
    {_,_,Quantity}= lists:keyfind(SubBrand,1,State),
    if Quantity =< 0->
      NS=lists:keydelete(SubBrand,1,State),
      io:format("Item is out of Stock"),
      {reply,ok,NS};
      true->
       if Quantity1 > Quantity->
           io:format("Only ~p pieces are Available",[Quantity]),
           {reply,ok,State};
          true->
            io:format("Item Placed Sucessfully"),
            {SubBrand,Price,Quantity}= lists:keyfind(SubBrand,1,State),
            NewState = lists:keyreplace(SubBrand,1,State,{SubBrand,Price,Quantity-Quantity1}),
      {reply,ok,NewState}
       end
end
end;

%THis function total unique items
handle_call({showAllItems}, _From, State) ->
  {reply,lists:reverse(State), State};
  
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



%Checking Input Values
add(SubBrand,Price,Quantity)->
Check=is_integer(Price),
Check1=is_integer(Quantity),
CheckItemName=is_integer(SubBrand),
if 
     Check==true ->
         if 
            Check1 ==true ->
              if 
                CheckItemName =/=true ->        
               miStore:newPhoneHandler(SubBrand,Price,Quantity); 
                true -> 
                   io:fwrite("Product Name Cannot Be Integer Value~n")
             end;       
            true -> 
               io:fwrite("PLEASE ENTER CORRECT Quantity VALUE~n")
         end;
      true -> 
         io:fwrite("Please Enter Input in Correct Format~n") 
   end.