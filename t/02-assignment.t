use v6;

use Test;
use Tree::Binary;

plan 1;

my Tree::Binary $tree .= new;

# Assigning and manipulating sub-trees
{
    my $branch = Tree::Binary.new;
    $branch.right.value = 42;
    $tree.left = $branch;
    is $tree.left.right.value, 42, "Assigning sub-trees to tree branches";
}
