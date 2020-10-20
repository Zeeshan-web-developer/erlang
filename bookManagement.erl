% @Author: Zeeshan  Ahmad
% @Date:   2020-10-12 15:48:06
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-12 15:48:06

-module(bookManagement).
-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").
-include("records.hrl").



init() ->
  mnesia:create_schema([node()]),
  mnesia:start().


createTables() ->
  mnesia:create_table(book,
    [{type,ordered_set},{attributes, record_info(fields,book)}]),
   
 mnesia:create_table(author,
    [{type,bag},{attributes, record_info(fields,author)}]).
%%
%%  "SETTERS"
%%
%This functions creates student database
addBook(Bid,Bname,Yofpub) ->
  Fun = fun() ->
    mnesia:write(#book{bId=Bid,
                          bName=Bname,
                          yOfPub=Yofpub})

        end,
  mnesia:transaction(Fun).

addAuthorData(Aid,Aname,Bid) ->
  Fun = fun() ->
    mnesia:write(#author{aId=Aid,
                          aName=Aname,
                          bId=Bid})

        end,
  mnesia:transaction(Fun).


%% ADDING CONTENT

addSomeBooks() ->
  bookManagement:addBook(100,"C IN DEPTH",2005),
  bookManagement:addBook(101,"ERLANG FOR BEGINNERS",1999),
  bookManagement:addBook(102,"JAVA THE MODERN",2004),
  bookManagement:addBook(103,"DATA STRUCTURE BY CRLF",1987),
  bookManagement:addBook(104,"ERLANG FOR WEB APPS",1895),
  bookManagement:addBook(105,"HELLO ERLANG",2005),
  bookManagement:addBook(106,"MOBILE REPAIRING",1992),
  bookManagement:addBook(107,"DAILY MAGZINE",1987),
  bookManagement:addBook(108,"TYPESCRIPT VERSION-4",1888),
  bookManagement:addBook(109,"HTML5 FOR NOOBES",1988),
  bookManagement:addBook(110,"REACTJS FOR PROFESSIONALS",2012),
  bookManagement:addBook(106,"MOBILE REPAIRING",1992),
  bookManagement:addBook(107,"DAILY MAGZINE",1987),
  bookManagement:addBook(108,"TYPESCRIPT VERSION-4",1888),
  bookManagement:addBook(109,"HTML5 FOR NOOBES",1988),
  bookManagement:addBook(120,"REACTJS FOR PROFESSIONALS",2012).


  addAuthorBooks() ->
    bookManagement:addAuthorData(1,"BALAGURUSWAMY",100),
    bookManagement:addAuthorData(2,"HARI LAXAMI",110),
    bookManagement:addAuthorData(3,"JON HAMIS",106),
    bookManagement:addAuthorData(4,"IMAAD",105),
    bookManagement:addAuthorData(5,"SARUBJIT KUMAR",102).
  
 
  
%% GETTERS

showAllBooks() ->
  F = fun() ->
    Q = qlc:q([{E#book.bId, E#book.bName, E#book.yOfPub} || E <- mnesia:table(book)]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).
