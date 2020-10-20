% @Author: Zeeshan  Ahmad
% @Date:   2020-10-16 12:52:19
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-16 17:07:33
-module(projectManagement).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([addStudent/3,getStudents/0,addProjects/2,assignProject/2,addTeamLeader/2,getParticipants/1]).


start_link() ->
  gen_server:start_link({local,?MODULE},?MODULE,[],[]).

stop() ->
  gen_server:cast(?MODULE, stop).

%storing the student data
addStudent(Rollno,Name,Semester) ->
  gen_server:call(?MODULE,{addStudent,{Rollno,Name,Semester}}).
%storing project ?with their Id and project Name
addProjects(PId,PName) ->
  gen_server:call(?MODULE,{addProjects,{PId,PName}}).
%assigning project to students
assignProject(StudentName,ProjectName) ->
  gen_server:call(?MODULE,{assignProject,{StudentName,ProjectName}}).
%adding team leader information
addTeamLeader(LeaderName,ProjectName) ->
  gen_server:call(?MODULE,{addTeamLeader,{LeaderName,ProjectName}}).
%getting all students data
getStudents() ->
  gen_server:call(?MODULE,{getStudents}).

%giving student infomation ,project and team leader
getParticipants(Pid) ->
  gen_server:call(?MODULE,{getParticipants,Pid}).

init(_Args) ->
  {ok, []}.

handle_call({addStudent,{Rollno,Name,Semster}}, _From, _State) ->
  Result=projectManagementMn:addStudent(Rollno,Name,Semster),
  {reply,true,Result};

handle_call({addProjects,{PId,PName}}, _From, _State) ->
  Result=projectManagementMn:addProjects(PId,PName),
  {reply,true,Result};

handle_call({assignProject,{StudentName,ProjectName}}, _From, _State) ->
  Result=projectManagementMn:assignProject(StudentName,ProjectName),
  {reply,true,Result};

handle_call({addTeamLeader,{LeaderName,ProjectName}}, _From, _State) ->
  Result=projectManagementMn:addTeamLeader(LeaderName,ProjectName),
  {reply,true,Result};

handle_call({getStudents}, _From, State) ->
  projectManagementMn:getStudents(),
  {reply, ok,State};


handle_call({getParticipants,Pid}, _From, State) ->
  projectManagementMn:getParticipants(Pid),
  {reply, ok,State};

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

     