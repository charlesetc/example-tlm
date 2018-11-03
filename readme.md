
# List TLM Example

[Relit](https://github.com/cyrus-/relit) is a way to extend [Reason](http://reasonml.github.io/)'s syntax to support custom literals, while still producing readable code.

Here's an example of a TLM (typed literal macro) implemented using Relit.

To run it, first make sure you have OCaml version 4.07.0. Then:

```
opam install ppx_relit

git clone https://github.com/charlesetc/example-tlm
cd example-tlm

make list_parser
make test
```

---

### Some highlights!

---

The whole point ([test/test.re](test/test.re)):

```reason
module String = {
  include String;
  include List_example.N({
    type t = string;
  });
};

let l = String.$list `( "hi", "there", "you",)`;

let () = String.concat("! ", l) |> print_endline;
```

Is that a list literal that's not built into the language? Woah...

---

The notation definition ([list_example/list_example.re](list_example/list_example.re)):

```ocaml
module N = (A: {type t;}) => {
  notation $list at list(A.t) {
    lexer List_parser.Lexer
    parser List_parser.Parser.parse
    in package list_parser;
    dependencies = {
      module List = List;
      type t = A.t;
    };
  };
};
```
---

The entire lexer ([list_parser/lexer.mll](list_parser/lexer.mll)):

```ocaml
{
open Lexing
open Parser
open Relit
}

rule read =
  parse
  | _ {
    let segment = Relit.Segment.read_to "," lexbuf in
    SPLICED_EXP(segment) }
  | eof      { EOF }
```

---

The entire parser ([list_parser/parser.mly](list_parser/parser.mly)):


```reason
%{
  open Migrate_parsetree.Ast_404
  open Longident
  open Parsetree
  let loc = Relit.loc
%}

%token <Relit.Segment.t> SPLICED_EXP
%token EOF

%start <Migrate_parsetree.Ast_404.Parsetree.expression> parse

%%

parse:
  | splice = SPLICED_EXP l = parse
    { [%expr [%e Relit.ProtoExpr.spliced splice [%type: t]] :: [%e l ]] }
  | EOF
    { [%expr []] }
```

---

You just read **the entire TLM example!**

---

### Todo:

* Fix required trailing commas
