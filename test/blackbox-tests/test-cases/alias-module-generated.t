Test alias module for wrapped libraries that don't have a main module, i.e. the
wrap module is generated by dune.

  $ cat >dune-project <<EOF
  > (lang dune 3.5)
  > EOF

  $ cat >dune <<EOF
  > (library
  >  (name foo))
  > EOF
  $ touch bar.ml

  $ dune build
  $ cat _build/default/foo.ml-gen
  (* generated by dune *)
  
  (** @canonical Foo.Bar *)
  module Bar = Foo__Bar
  
  module Foo = struct end
  [@@deprecated "this module is shadowed"]

The final `Foo` module should not be marked as deprecated/shadowed, since it
does not shadow any module.
