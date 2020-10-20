

-module(art).
-compile(export_all).
-include_lib("stdlib/include/qlc.hrl").
 
-record(painting,{index, artist, title}).
  
init() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(painting,
        [{ram_copies, [node()] },
             {attributes,record_info(fields,painting)}]).
 
insert( Index, Artist, Title) ->
    Sun = fun() ->
         mnesia:write(
         #painting{ index=Index,
                   artist=Artist, 
                        title=Title    } )
               end,
         mnesia:transaction(Sun).



      
select( Index) ->
    Sun = 
        fun() ->
            mnesia:read({painting, Index})
        end,
    {atomic, [Row]}=mnesia:transaction(Sun),
    io:format(" ~p ~p ~n ", [Row#painting.artist, Row#painting.title] ).

select_some( Artist) ->
    Sun = 
        fun() ->
            mnesia:match_object({painting,Artist, '_' } )
        end,
    {atomic, Results} = mnesia:transaction( Sun),
    Results.
 




select_all() -> 
    mnesia:transaction( 
    fun() ->
        qlc:eval( qlc:q(
            [ X || X <- mnesia:table(painting) ] 
        )) 
    end ).