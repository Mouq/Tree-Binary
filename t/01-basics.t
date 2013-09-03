use v6;

use Test;
use Tree::Binary;

my Tree::Binary $tree .= new;

# Method-based traversal
{
    $tree.left.left.left.right.left.value = "apple";
    is $tree.left.left.left.right.left.value, "apple", "Basic tree traversal";

    my $branch := $tree.right.left.right;
    $branch = "pear";
    is $branch, $tree.right.left.right;
    is $tree.right.left.right, "pear", "Binding branches works";

    my $squirrel = Tree::Binary.new;
    lives_ok { for ^40 { pick(^1) ?? $squirrel .= left !! $squirrel .= right } }, "Arbitrary traversal";
}

$tree .= new;
# Built-in traversal
{
    $tree.value = "coconut";
    my \🌴 = $tree.left.left.left;
    is 🌴.root, "coconut", ".root works";
}
