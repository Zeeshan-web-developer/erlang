% @Author: Zeeshan  Ahmad
% @Date:   2020-10-01 17:32:52
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-01 17:34:44
-module(user_mnesia).
-export([insert/5,select/1,select_user/1,select_all/0,init/0,delete/1]).
-include_lib("stdlib/include/qlc.hrl"). % simple queries are written with query list comprehensions. 
 
-record(details,{id,name,designation,address,state}).  % creating three fields
  
init() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(details,
        [{disc_copies,[node()]},
             {attributes,record_info(fields,details)} ]).
 
insert(Id,Name,Designation,Address,State) ->
    Return = fun() ->              % anonymous function 
         mnesia:write(
         #details{ id=Id,  % #cricket is name of record & is used to insert data in the record
                   name=Name, 
                   designation=Designation,
                   address=Address,
                   state=State
                   })
               end,
         mnesia:transaction(Return).
  
select(Id) ->
    Return = fun() ->
            mnesia:read({details,Id})
        end,
    {atomic, [Find]}=mnesia:transaction(Return),
    io:format("~p~p~p~p~n", [Find#details.name, Find#details.designation, Find#details.address, Find#details.state]).

update(tab, Key, Name,Designation,Address,State) ->
    fun() ->
        [P] = mnesia:wread({Tab, Key}),
        mnesia:write(P#details{name=Name,designation=Designation,address=Address,state=State})
io:format("Record Updated sucessfully"),    
end.

delete(Id) ->
    Return = (fun() ->
        mnesia:delete_object(details,Id,write)end).
    end,
    {atomic,Results} = mnesia:transaction(Return),
    io:format("Deleted REcord id=~w",Id),
    Results.


select_user(Name) ->
    Return = fun() ->
            mnesia:match_object({details,'_',Name,'_', '_', '_'} ) % match object does pattern matching. 
            % don't care conditions are used to check only which data is in the database.
        end,
    {atomic,Results} = mnesia:transaction(Return),
    Results.
 
select_all() -> 
    mnesia:transaction( 
    fun() ->
        qlc:eval( qlc:q(
            [ X || X <- mnesia:table(details) ] % list comprehension
        )) 
    end ).