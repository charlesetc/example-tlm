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
