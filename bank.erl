% @Author: Zeeshan  Ahmad
% @Date:   2020-10-19 11:25:29
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-19 11:25:29
-module(bank).
-export([
			size/1,		% - number of accounts in the bank
			accounts/2,	% - type of accounts held by client
			balance/3,	% - balance of an account
			open/3,		% - open a new account
			close/3,	% - close an account
			deposit/4,	% - make a deposit
			withdraw/4	% - withdraw from an account
		]).

% size
% Return the number of accounts in the bank.
size(List) -> {ok, length(List)}.

% accounts
% Return a list of account types held by an accountholder.
accounts(Bank, Owner) ->
	{ok, h_accounts(Bank, Owner, [])}.

% accounts recursive helper function
% handle empty bank
h_accounts([], _Owner, _Accounts) -> [];
% add account type of head to the current list
h_accounts([{Owner, Type, _Balance}|T], Owner, Accounts) ->
	Accounts ++ [Type] ++ h_accounts(T, Owner, Accounts);
% recurse through the rest of the list
h_accounts([_H|T], Owner, Accounts) ->
	Accounts ++ h_accounts(T, Owner, Accounts).

% balance
% Return the balance of an account, if it exists.
balance([], _Owner, _Type) -> {error, "No such account"};
balance([{Owner, Type, Balance}|_T], Owner, Type) -> {ok, Balance};
balance([_H|T], Owner, Type) -> balance(T, Owner, Type).

% open
% Open a new bank account.
open(Bank, Owner, Type) ->
	Result = h_open([], Bank, Owner, Type),
	case Result of
		{error, _Message}	-> Result;
		NewBank				-> {ok, NewBank}
	end.

% open recursive helper function
h_open(NewBank, [], Owner, Type) ->
	[{Owner, Type, 0} | NewBank];
h_open(_NewBank, [{Owner, Type, _Balance}|_T], Owner, Type) -> 
	{error, "Duplicate account"};
h_open(NewBank, [H|T], Owner, Type) -> 
	h_open([H | NewBank], T, Owner, Type).

% close
% Close out an existing bank account and return
% the closing balance.
close(Bank, Owner, Type) ->
	Result = h_close([], Bank, Owner, Type),
	case Result of
		{error, _Message}	-> Result;
		{NewBank, Amount}	-> {ok, NewBank, Amount}
	end.

% close recursive helper function
h_close(_NewBank, [], _Owner, _Type) -> 
	{error, "No such account"};
h_close(NewBank, [{Owner, Type, Balance}|T], Owner, Type) -> 
	{NewBank ++ T, Balance};
h_close(NewBank, [_H|T], Owner, Type) -> 
	h_close([_H | NewBank], T, Owner, Type).

% deposit
% Make a deposit into an existing bank account
deposit(Bank, Owner, Type, Amount) ->
	Result = h_deposit([], Bank, Owner, Type, Amount),
	case Result of
		{error, _Message}	-> Result;
		NewBank				-> {ok, NewBank}
	end.
% deposit recursive helper function
h_deposit(_NewBank, [], _Owner, _Type, _Amount) ->
	{error, "No such account"};
h_deposit(NewBank, [{Owner, Type, Balance}|T], Owner, Type, Amount) ->
	% return an error message if the amount is negative
	% using a case here to familiarize myself with the erlang syntax
	case Amount < 0 of
		true			-> {error, "Negative amount"};
		false 			-> NewBank ++ [{Owner, Type, Balance + Amount}] ++ T
	end;
h_deposit(NewBank, [_H|T], Owner, Type, Amount) -> 
	h_deposit([_H | NewBank], T, Owner, Type, Amount).

% withdraw
% Make a withdraw from an existing bank account
withdraw(Bank, Owner, Type, Amount) ->
	Result = h_withdraw([], Bank, Owner, Type, Amount),
	case Result of
		{error, _Message}	-> Result;
		NewBank				-> {ok, NewBank}
	end.
% withdraw recursive helper function
h_withdraw(_NewBank, [], _Owner, _Type, _Amount) ->
	{error, "No such account"};
% return an error message if the amount is negative
% using 'when' syntax here to familiarize myself more with it.
h_withdraw(_NewBank, _Bank, _Owner, _Type, Amount) when Amount < 0 ->
	{error, "Negative amount"};
h_withdraw(NewBank, [{Owner, Type, Balance}|T], Owner, Type, Amount) ->
	Remainder = Balance - Amount,
	case Remainder < 0 of 
		false				-> (NewBank ++ [{Owner, Type, Remainder}]) ++ T;
		true				-> {error, "Overdrawn"}
	end;
h_withdraw(NewBank, [_H|T], Owner, Type, Amount) -> 
	h_withdraw([_H | NewBank], T, Owner, Type, Amount).