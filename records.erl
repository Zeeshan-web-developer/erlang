-module (records).
-compile([export_all]).


-record(person, {
        name = zeeshan,
        age,

        status = single
    }).




run() ->
    P1 = #person{name="Joe Doe", age="25"},

    io:format("Created person ~p~n", [P1#person.name]),
    io:format("Created person ~p~n", [P1#person.age]),
    io:format("Created person ~p~n", [P1#person.status]),

    io:format("Record fields: ~p~n", [record_info(fields, person)]),

    io:format("Record size: ~p~n", [record_info(size, person)]).