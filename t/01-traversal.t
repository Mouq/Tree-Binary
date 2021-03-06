use v6;

use Test;
use Tree::Binary;

plan 9;

my Tree::Binary $tree .= new;

# Method-based traversal
{
    $tree.left;
    $tree.left.value = "orange";
    is $tree.left.value, "orange", "**Very** basic tree traversal";

    $tree.left.left.left.right.left.value = "apple";
    is($tree.left.left.left.right.left.value, "apple", "Basic tree traversal");

    my $branch := $tree.right.left.right;
    $branch.value = "pear";
    is $branch.value, $tree.right.left.right.value;
    is $tree.right.left.right.value, "pear", "Binding branches";

    my $squirrel = Tree::Binary.new;
    lives_ok { for ^40 { pick(^1) ?? $squirrel .= left !! $squirrel .= right } }, "Arbitrary traversal";
}

$tree .= new;
# Built-in traversal
{
    $tree.value = "coconut";
    # \🌴 = …
    my $palm = $tree.left.left.left;
    my $maple = $tree.left.left.right;
    is $palm.root.value, "coconut", ".root";

    $tree.left.left.value = "bark"; 
    is $palm.parent.value, "bark", ".parent";
    is $maple.parent.value, "bark", ".parent";
}

$tree .= new;
# Traverse with function
{
    $tree.left.value = "a";
    $tree.value = "b";
    $tree.right.value = "l";
    $tree.right.left.value = "d";
    $tree.right.right.value = "o";

    my @v;
    $tree.traverse({@v.push(.value)});
    is @v.sort, $tree.list.sort, ".traverse";
}

