PROJECT = http_json
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy jsx liver

dep_cowboy_commit = 2.13.0
dep_jsx = git https://github.com/talentdeficit/jsx v3.1.0
dep_liver = git https://github.com/erlangbureau/liver 0.9.4

include erlang.mk
