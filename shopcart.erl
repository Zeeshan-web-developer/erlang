% @Author: Zeeshan  Ahmad
% @Date:   2020-10-01 10:38:52
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-01 10:47:38
-module(shopcart).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([add_item/3,get_item/1,total_cart/0,update_cart/2,update_cost/2,delete_item/1]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE,[],[]).

stop() ->
    gen_server:cast(?MODULE, stop).

add_item(Key,Item,Cost) ->
    gen_server:call(?MODULE, {add_item,{Key, Item, Cost}}).

get_item(Key) ->
    gen_server:call(?MODULE, {get_item,Key}).

total_cart() ->
    gen_server:call(?MODULE, {total_cart}).

update_cart(Key,Item) ->
    gen_server:call(?MODULE, {update_cart,{Key,Item}}).

update_cost(Key,Cost) ->
    gen_server:call(?MODULE, {update_cost,{Key,Cost}}).

delete_item(Key) ->
    gen_server:call(?MODULE, {delete_item, Key}).

init(_Args) ->
    ets:new(table,[ordered_set,named_table,{keypos,1}]),
    {ok, []}.

handle_call({add_item, {Key, Item, Cost}}, _From, State) ->
    Cart = ets:insert(table,[{Key,Item, Cost}]),
    io:format("items in the cart : ~p~n",[Cart]),
    {reply, added, State};
handle_call({get_item, Key}, _From, State) ->
    Result = ets:lookup(table, Key),
    {reply, Result, State};

handle_call({total_cart}, _From, State) ->
    N = ets:tab2list(table),
    io:format("total items in the cart :~p \n", [N]),
    {reply, N, State};
    
handle_call({update_cart, {Key, Item}}, _From, State) ->
    Newcart = ets:update_element(table, Key, {2, Item}),
    io:format("updated cart: ~p \n", [Newcart]),
    {reply, updated_cart, State};
handle_call({update_cost, {Key, Cost}}, _From, State) ->
    M = ets:update_element(table, Key, {3, Cost}),
    io:format("updated cart: ~p \n", [M]),
    {reply, updated_cart, State};
handle_call({delete_item, Key}, _From, State) ->
    NewCart = ets:delete(table, Key),
    io:format("new cart: ~p \n", [NewCart]),
    {reply, item_deleted, State};
   
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
   
 case Message of
        {get_item, Key} ->
            Result = ets:lookup(table, Key),
        {shopcart_client, 'clients@LAPTOP-LD37CFAL'} ! {get_item, Result},
       {noreply, Result};
        
        {total_cart} ->
            N = ets:tab2list(table),
            io:format("total items in the cart :~p \n", [N]),
        {shopcart_client, 'clients@LAPTOP-LD37CFAL'} ! {total_cart, N},
        {noreply, N};
 
        {update_cart, {Key,Item}} ->
            Newcart = ets:update_element(table, Key, {2, Item}),
            io:format("updated cart: ~p \n", [Newcart]),
            {shopcart_client, 'clients@LAPTOP-LD37CFAL'} ! {update_cart, Newcart},
            {noreply, State};
        
        {update_cost, {Key,Cost}} ->
            Newcart = ets:update_element(table, Key, {3, Cost}),
            io:format("updated cart: ~p \n", [Newcart]),
            {shopcart_client, 'clients@LAPTOP-LD37CFAL'} ! {update_cart, Newcart},
            {noreply, State};

        {delete_item, Key} ->
            NewCart = ets:delete(table, Key),
            io:format("new cart: ~p \n", [NewCart]),
            {shopcart_client, 'clients@LAPTOP-LD37CFAL'} ! {delete_item, NewCart},
            {noreply, State}
      end.

code_change(_OldVer, State, _Extra) ->
    
    {ok,State}.
terminate(Reason, _State) ->
    io:format("server is terminating with reason :~p~n",[Reason]).