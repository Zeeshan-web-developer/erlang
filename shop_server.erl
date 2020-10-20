% @Author: Zeeshan  Ahmad
% @Date:   2020-10-09 11:08:53
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-09 14:26:06
-module(shop_server).

-behavior(gen_server).

-export([start_link/0, stop/0]).

-export([code_change/3,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         init/1,
         terminate/2]).

-export([add_product/5,
         balance/1,
         product/0,
         product_info/1]).

start_link() ->
    gen_server:start_link({local, ?MODULE},
                          ?MODULE,
                          [],
                          []).

stop() -> gen_server:cast(?MODULE, stop).

add_product(Id, Tag, Type, Size, Price) ->
    gen_server:call(?MODULE,
                    {add_product, {Id, Tag, Type, Size, Price}}).

product_info(Id) ->
    gen_server:call(?MODULE, {product_info, Id}).

product() -> gen_server:call(?MODULE, {product}).

balance(Id) -> gen_server:call(?MODULE, {balance, Id}).

init(_Args) ->
    ets:new(table, [bag, named_table, {keypos, 1}]),
    {ok, []}.

handle_call({add_product, {Id, Tag, Type, Size, Price}}, _From,_State) ->   % define the state
    Price2 = Price,
    Z = ets:lookup(table, Id),
    if Z == [] ->
           ets:insert(table, [{Id, Tag, Type, Size, Price}]);
       true ->
           OldPrice = ets:lookup_element(table, Id, 5),
           K = lists:last(OldPrice),
           Latest = Price2 + K,
      ets:insert(table, [{Id, Tag, Type, Size, Latest}])
    end,
    {reply, added, r};
handle_call({product_info, Id}, _From, State) ->
    Result = ets:lookup(table, Id),
    io:format("Product details are : ~p~n", [Result]),
    {reply, done, State};
    
handle_call({product}, _From, State) ->
    io:format("Products details are : ~p~n",
              [ets:tab2list(table)]),
    {reply, total, State};
    

    handle_call({balance,Id}, _From, State) ->
        TotalBalnce = ets:lookup_element(table, Id, 5),
        TotalBalnce2= lists:last(TotalBalnce),
        io:format("Your TOTAL BILL AMOUNT : ~p~n",[TotalBalnce2]),
        {reply, total, State};

handle_call(Message, _From, State) ->
    io:format("received other handle_call message: "
              "~p~n",
              [Message]),
    {reply, ok, State}.

handle_cast(stop, State) -> {stop, normal, State};
handle_cast(Message, State) ->
    io:format("received other handle_cast call : ~p~n",
              [Message]),
    {noreply, State}.

handle_info(Message, State) ->
    io:format("received handle_info message : ~p~n",
              [Message]),
    {noreply, State}.

code_change(_OldVer, State, _Extra) -> {ok, State}.

terminate(Reason, _State) ->
    io:format("server is terminating with reason :~p~n",
              [Reason]).
