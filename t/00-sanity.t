use v6;

use Tree::Binary;

say "1..2";
say "ok 1 Parses and compiles";

my Tree::Binary $t .= new;
$t.value = "ok 2 Setting node values works";
say $t.value;

