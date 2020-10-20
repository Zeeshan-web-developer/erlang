% @Author: Zeeshan  Ahmad
% @Date:   2020-10-09 08:58:58
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-09 09:44:06
-module(chatroom).

-behaviour(gen_server).

-export([login/2, logout/0, say/1, users/0, who/2]).

-export([start_link/0]). % convenience call for startup

-export([code_change/3,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         init/1,
         terminate/2]).

                          % gen_server callbacks

-define(SERVER, ?MODULE).

start_link() ->
    gen_server:start_link({local, ?SERVER},
                          ?MODULE,
                          [],
                          []).

login(UserName, ServerRef) ->
    gen_server:call(?MODULE,
                    {login, {UserName, ServerRef}}).

logout() -> gen_server:call(?MODULE, {logout}).

say(Text) -> gen_server:call(?MODULE, {say, {Text}}).

who(Person, ServerRef) ->
    gen_server:call(?MODULE, {who, {Person, ServerRef}}).

users() -> gen_server:call(?MODULE, {users}).

init([]) -> {ok, []}.

handle_call({login, {UserName, ServerRef}}, From,
            State) ->
    {FromPid, _FromTag} = From,
    case lists:keymember({UserName, ServerRef}, 1, State) of
        true ->
            NewState = State,
            Reply = {error,
                     "User " ++ UserName ++ " already in use."};
        false ->
            NewState = [{{UserName, ServerRef}, FromPid} | State],
            Reply = {ok, "Logged in."}
    end,
    {reply, Reply, NewState};
handle_call(logout, From, State) ->
    {FromPid, _FromTag} = From,
    case lists:keymember(FromPid, 2, State) of
        true ->
            NewState = lists:keydelete(FromPid, 2, State),
            Reply = {ok, logged_out};
        false ->
            NewState = State,
            Reply = {error, not_logged_in}
    end,
    {reply, Reply, NewState};
handle_call({say, Text}, From, State) ->
    {FromPid, _FromTag} = From,

    case lists:keymember(FromPid, 2, State) of
        true ->
            {value, {{SenderName, SenderServer}, _}} =
                lists:keysearch(FromPid, 2, State),
            % For debugging: get the list of recipients.
            RecipientList = [{RecipientName, RecipientServer}
                             || {{RecipientName, RecipientServer}, _} <- State,
                                {RecipientName, RecipientServer} /=
                                    {SenderName, SenderServer}],
            io:format("Recipient list: ~p~n", [RecipientList]),

            [gen_server:cast({person, RecipientServer},
                             {message, {SenderName, SenderServer}, Text})
             || {{RecipientName, RecipientServer}, _} <- State,
                RecipientName /= SenderName];
        false -> ok
    end,
    {reply, ok, State};
handle_call({who, {Person, ServerRef}}, _From, State) ->
    Found = lists:keyfind({Person, ServerRef}, 1, State),

    case Found of
        {{_FromUser, _FromServer}, Pid} ->
            Reply = gen_server:call(Pid, get_profile);
        _ -> Reply = "Cannot find that user"
    end,
    {reply, Reply, State};
handle_call(users, _From, State) ->
    UserList = [{UserName, UserServer}
                || {{UserName, UserServer}, _} <- State],
    {reply, UserList, State};
handle_call(Request, _From, State) ->
    {ok, {error, "Unhandled Request", Request}, State}.

handle_cast(_Request, State) -> {noreply, State}.

handle_info(Info, State) ->
    io:format("Received unknown message ~p~n", [Info]),
    {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.
