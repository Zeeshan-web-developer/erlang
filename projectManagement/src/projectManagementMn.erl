% @Author: Zeeshan  Ahmad
% @Date:   2020-10-16 12:54:10
% @Last Modified by:   Zeeshan  Ahmad
% @Last Modified time: 2020-10-16 17:20:13
-module(projectManagementMn).
-behaviour(gen_server).
-export([start_link/0,stop/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,code_change/3,terminate/2]).
-export([addStudent/3,getStudents/0,addProjects/2,assignProject/2,addTeamLeader/2,getParticipants/1]).
-include_lib("stdlib/include/qlc.hrl").
-include("records.hrl").

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
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(student,[{disc_copies,[node()]},{attributes,record_info(fields,student)}]),
  mnesia:create_table(team_leader,
    [{attributes, record_info(fields, team_leader)}]),

  mnesia:create_table(project,
    [{attributes, record_info(fields,project)}]),

  mnesia:create_table(student_project,
    [{attributes, record_info(fields,student_project)}]),
  {ok, []}.

handle_call({addStudent,{Rollno,Name,Semester}}, _From, _State) ->
  Row = #student{rollno=Rollno,sname=Name,semester=Semester},
  N = fun()->
    mnesia:write(Row)
      end,
  {atomic,Result} = mnesia:transaction(N),
  io:format("Student Information Saved: ~p  ~p ~p~n",[Rollno,Name,Semester]),
  {reply,success,Result};

handle_call({addProjects,{PId,PName}}, _From, _State) ->
  Row = #project{id=PId,pname=PName},
  N = fun()->
    mnesia:write(Row)
      end,
  {atomic,Result} = mnesia:transaction(N),
  io:format("Project Saved: ~p  ~p~n",[PId,PName]),
  {reply,success,Result};

handle_call({assignProject,{Name,ProjectName}}, _From, _State) ->
  Row = #student_project{sname=Name,projectName=ProjectName},
  N = fun()->
    mnesia:write(Row)
      end,
  {atomic,Result} = mnesia:transaction(N),
  io:format("Project Assigned Successfully: ~p  ~p~n",[Name,ProjectName]),
  {reply,success,Result};

handle_call({addTeamLeader,{LeaderName,ProjectName}}, _From, _State) ->
  Row = #team_leader{leadername=LeaderName,projectName=ProjectName},
  N = fun()->
    mnesia:write(Row)
      end,
  {atomic,Result} = mnesia:transaction(N),
  assignProject(LeaderName,ProjectName),
  io:format("Project Assigned Successfully: ~p  ~p~n",[LeaderName,ProjectName]),
  {reply,success,Result};

handle_call({getStudents},_From,_State) ->
  F = fun() ->
    Q = qlc:q([{E#student.rollno, E#student.sname, E#student.semester} || E <- mnesia:table(student)]),
    qlc:e(Q),
    io:format("All Student Information is as~n"),
    io:format("~p~n",[qlc:e(Q)])
      end,
  mnesia:transaction(F),
  {reply,feteched,_State};

handle_call({getPartipants,Project},_From,_State) ->
  F = fun() ->
    Q = qlc:q([E#student_project.sname || E <- mnesia:table(student_project),
      E#student_project.projectName == Project]),
    qlc:e(Q)
      end,
  mnesia:transaction(F),
  {reply,feteched,_State};

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
