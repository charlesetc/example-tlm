
test:
	dune build test/test.exe
	dune exec test/test.exe

list_parser:
	dune build -p list_parser
	dune install list_parser

.PHONY: list_parser test
