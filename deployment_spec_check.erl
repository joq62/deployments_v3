-module(deployment_spec_check).

-export([
	 start/0,
	 %% Support
	 all_files/0,
	 all_info/0
	]).


-define(DirSpecs,".").

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    
    check(all_info()),
    init:stop(),
    ok.

check([])->
    io:format("Ok, no errors!! ~n");
check([L|T])->
    io:format("Checking ~p~n",[L]),
    true=proplists:is_defined(name,L),
    true=proplists:is_defined(controllers,L),
    true=proplists:is_defined(workers,L),
    true=proplists:is_defined(cookie,L),
    true=proplists:is_defined(application_info_specs,L),
    true=proplists:is_defined(deployment_info_specs,L),
    true=proplists:is_defined(host_info_specs,L),

    true=proplists:is_defined(deployments,L),
    check(T).

   

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
all_files()->
    {ok,Files}=file:list_dir(?DirSpecs),
    DeplFiles=[filename:join(?DirSpecs,Filename)||Filename<-Files,
							    ".depl_spec"=:=filename:extension(Filename)],
    DeplFiles.    
all_info()->
    L1=[file:consult(DeplFile)||DeplFile<-all_files()],
%    io:format(" L1 ~p~n",[L1]),
    [Info||{ok,Info}<-L1].


%find(DeplId)->
    
    
