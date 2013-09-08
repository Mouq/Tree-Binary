use v6;

use Test;
use Tree::Binary;

plan 4;

my Tree::Binary $tree   .= new;
my Tree::Binary $branch .= new;

# Assigning and manipulating sub-trees
{
    $branch.right.value = 42;
    $tree.left = $branch;
    is $tree.left.right.value, 42, "Assigning sub-trees to tree branches";
    
    $branch.left.value = "astr";
    is $tree.left.left.value, "astr", "Assignments are deep";
    $branch.value = Inf;
    is $tree.left.value, Inf, "Assignments are deep";
}

$tree   .= new;
$branch .= new;
# Recusive assignment
{
    $tree.value = "Tr";
    $branch.value = "ee";
    $tree.parent = $branch;
    $branch.parent = $tree;
    is $branch.parent.parent.parent.value, $tree.value, "Upward recursion works";

    #TODO: More
}
