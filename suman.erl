% @Author: Zeeshan  Ahmad
% @Date:   2020-10-12 14:58:44
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-12 15:38:54
%
-module(suman).
-author("suman").

%% API
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([area_triangle/2,area_square/1,area_rectangle/2,area_paralellogram/2,area_trapezium/3
  ,area_circle/1,area_ellipse/2,area_sector/2]).



start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop() ->
  gen_server:cast(?MODULE, stop).
  
area_triangle(Base,Height) ->
  gen_server:call(?MODULE,{area_triangle,{Base,Height}}).
  
area_square(Side) ->
  gen_server:call(?MODULE,{area_square,{Side}}).
  
area_rectangle(Length,Breadth) ->
  gen_server:call(?MODULE,{area_rectangle,{Length,Breadth}}).
  
area_paralellogram(Base,Height) ->
  gen_server:call(?MODULE,{area_paralellogram,{Base,Height}}).
area_trapezium(A,B,Height) ->
  gen_server:call(?MODULE,{area_trapezium,{A,B,Height}}).
area_circle(Radius) ->
  gen_server:call(?MODULE,{area_circle,{Radius}}).
area_ellipse(A,B) ->
  gen_server:call(?MODULE,{area_ellipse,{A,B}}).
area_sector(Radius,Angle) ->
  gen_server:call(?MODULE,{area_sector,{Radius,Angle}}).



init([]) ->
  State=[{triangle_area,0},{square_area,0},{rectangle_area,0},{paralellogram_area,0},{trapezium_area,0},
  {circle_area,0},{ellipse_area,0},{sector_area,0}],
  {ok,State}.

handle_call({area_triangle,{Base,Height}}, _From, State) ->
  F=(1/2*Base*Height),
  io:format("area of the traiangle is : ~p~n",[F]),
  Result= lists:keystore(triangle_area,1,State,{(1/2*Base*Height)}),
  io:format("area of triangle stored in the state: ~p~n",[Result]),
  {reply, ok, Result};


handle_call({area_square,{Side}}, _From, State) ->
  F=(Side*Side),
  io:format("area of the square is : ~p~n",[F]),
  Result= lists:keystore(square_area,1,State,{square_area,(Side*Side)}),
  io:format("area of square stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
  
handle_call({area_rectangle,{Length,Breadth}}, _From, State) ->
  F=(Length*Breadth),
  io:format("area of the rectangle is : ~p~n",[F]),
  Result= lists:keystore(rectangle_area,1,State,{rectangle_area,(Length*Breadth)}),
  io:format("area of rectangle stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
handle_call({area_paralellogram,{Base,Height}}, _From, State) ->
  F=(Base*Height),
  io:format("area of the paralellogram is : ~p~n",[F]),
  Result= lists:keystore(paralellogram_area,1,State,{paralellogram_area,(Base*Height)}),
  io:format("area of paralellogram stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
handle_call({area_trapezium,{A,B,Height}}, _From, State) ->
  F=(1/2*(A+B)*Height),
  io:format("area of the trapezium is : ~p~n",[F]),
  Result= lists:keystore(trapezium_area,1,State,{trapezium_area,(1/2*(A+B)*Height)}),
  io:format("area of trapezium stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
handle_call({area_circle,{Radius}}, _From, State) ->
  F=(3.141592653589793238*Radius*Radius),
  io:format("area of the circle is : ~p~n",[F]),
  Result= lists:keystore(circle_area,1,State,{circle_area,(3.141592653589793238*Radius*Radius)}),
  io:format("area of circle stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
handle_call({area_ellipse,{A,B}}, _From, State) ->
  F=(3.141592653589793238*A*B),
  io:format("area of the ellipse is : ~p~n",[F]),
  Result= lists:keystore(ellipse_area,1,State,{ellipse_area,(3.141592653589793238*A*B)}),
  io:format("area of ellipse stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
handle_call({area_sector,{Radius,Angle}}, _From, State) ->
  F=(1/2*Radius*Radius*Angle), %angle should be in terms of pi
  io:format("area of the sector is : ~p~n",[F]),
  Result= lists:keystore(sector_area,1,State,{sector_area,(1/2*Radius*Radius*Angle)}),
  io:format("area of sector stored in the state: ~p~n",[Result]),
  {reply, ok, Result};
%{square,{Side}}                ->  Side*Side;
%{rectangle,{Width,Height}}     ->  Width*Height;
%{paralellogram,{Base,Height}}  ->  Base*Height;
%{trapezium,{A,B,Height}}       ->  1/2(A+B)*Height;
%{circle,{Radius}}              ->  3.141592653589793238*Radius;
%{ellipse,{A,B}}                ->  3.141592653589793238*A*B;
%{sector,{Radius,Angle}}        ->  1/2*Radius*Radius*Angle

%io:format("received other handle_call message: ~p~n",[Message]),
%{reply, ok, Result};

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

