
test: list_example list_parser 
	rebuild \
		-cflags "-ppx ppx_relit" \
		-pkg list_example \
		-pkg relit_helper \
		test/test.byte

list_example:
	rebuild -pkg relit_helper \
		list_example/list_example.cmo \
		list_example/list_example.cma \
		list_example/list_example.cmx

list_parser:
	rebuild \
		-use-ocamlfind \
		-use-menhir \
		-package ppx_tools \
		-package ppx_tools.metaquot \
		-package ocaml-migrate-parsetree \
		-package relit_helper \
		list_parser/parser.cmo \
		list_parser/lexer.cmo \
		list_parser/list_parser.cmo

install: list_example list_parser
	ocamlfind install list_example \
		_build/list_example/* list_example/META
	ocamlfind install list_parser \
		_build/list_parser/* list_parser/META

clean:
	ocamlfind remove list_example
	ocamlfind remove list_parser
	rm -rf _build

.PHONY: list_parser list_example install test clean
