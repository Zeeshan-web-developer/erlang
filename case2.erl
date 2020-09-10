-module(case2).
-export([admit/1,run/0]).

admit(Person) ->
    case Person of
        {male,Age} when Age >= 21 ->
            young_man;
       
     {female, Age} when Age >= 21 ->
            female;
       
     {male, _} ->
            boy;
    
    {female, _} ->
            girl;

        _ ->
            worong_input
    end.

run() ->
    %AdultMale = {male, 25},
    %io:format(admit(AdultMale)),
    %io:nl().
    %yes_with_cover;


    %AdultFemale = {female, 25},
    %io:format(admit(AdultFemale)),
    %io:nl().
    %yes_no_cover;

    %KidMale = {male, 5},
    %io:format(admit(KidMale)),
    %io:nl().
    %no_boy_admission


KidFemale = {female, 5},
io:format(admit(KidFemale)),
io:nl().
no_girl_admissio