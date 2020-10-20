-module(palindrone).
-export([palindrome/1]).

palindrome(_, _, 0) ->
    true;
palindrome(A, I, N) ->
    Left = string:to_lower(lists:nth(I, A)),
    Right = string:to_lower(lists:nth(length(A) - I + 1, A)),
    case Left == Right of
        true ->
            palindrome(A, I + 1, N - 1);
        _ -> false
    end.

palindrome([]) ->
    false;
palindrome([_]) ->
    true;
palindrome(A) when length(A) > 1 ->
    palindrome(A, 1, length(A) div 2).