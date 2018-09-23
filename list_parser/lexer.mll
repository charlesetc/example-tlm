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
