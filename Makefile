all:
	rm -rf *~ *.beam *_crash.dump
check:
	rm -rf *~ *.beam *_crash.dump;
	erlc *.erl;
	erl -run deployment_spec_check start
