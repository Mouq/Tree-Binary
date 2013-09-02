use v6;

use Tree::Binary;

say "1..1";
say "ok 1 Parses and compiles";

my Tree::Binary $t;
$t.value = "ok 2 Setting node values works";
say $t.value;

