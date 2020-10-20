% @Author: Zeeshan  Ahmad
% @Date:   2020-10-12 15:48:06
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-14 12:16:56

-module(bookManagement).
-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").
-include("records.hrl").



init() ->
  mnesia:create_schema([node()]),
  mnesia:start().


createTables() ->
  mnesia:create_table(book,
    [{type,ordered_set},{disc_copies,[node()]},{attributes, record_info(fields,book)}]),

  mnesia:create_table(author,
    [{type,bag},{disc_copies,[node()]},{attributes, record_info(fields,author)}]).

%%  "SETTERS
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
%storing sample data
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


addBookAuthors() ->
  bookManagement:addAuthorData(1,"BALAGURUSWAMY",100),
  bookManagement:addAuthorData(2,"HARI LAXAMI",110),
  bookManagement:addAuthorData(3,"JON HAMIS",106),
  bookManagement:addAuthorData(2,"HARI LAXAMI",120),
  bookManagement:addAuthorData(1,"BALAGURUSWAMY",108),
  bookManagement:addAuthorData(4,"IMAAD",105),
  bookManagement:addAuthorData(4,"IMAAD",101),
  bookManagement:addAuthorData(4,"IMAAD",102),
  bookManagement:addAuthorData(5,"SARUBJIT KUMAR",102).



%% GETTERS

showAllBooks() ->
  F = fun() ->
    Q = qlc:q([{E#book.bId, E#book.bName, E#book.yOfPub} || E <- mnesia:table(book)]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

%getting all books complete information
getCompleteBookInfo() ->
  F = fun() ->

    Q = qlc:q([{E#author.aId,E#author.aName,F#book.bName,F#book.bId} || E <- mnesia:table(author),F <- mnesia:table(book),
      E#author.bId == F#book.bId]),
    qlc:e(Q)
      end,
  mnesia:transaction(F).

%getting particular book name and author name
getBookInfo(Bid) ->
  F = fun() ->    %using Qlc
    Q = qlc:q([{E#author.aName} || E <- mnesia:table(author),
      E#author.bId == Bid]),
    io:format("Book information is as~n"),
    io:format("Author Name:~p~n",[qlc:e(Q)])

      end,
  mnesia:transaction(F),
  Sun =                %%using mnesia read function
  fun() ->
    mnesia:read({book, Bid})
  end,
  {atomic, [Row]}=mnesia:transaction(Sun),
  io:format("Book Name:~p~n ", [Row#book.bName] ).