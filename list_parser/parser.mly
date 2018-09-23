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
