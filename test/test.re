module String = {
  include String;
  include List_example.N({
    type t = string;
  });
};

let l = String.$list `("hi","there","you")`;

let () = String.concat("! ", l) |> print_endline;
