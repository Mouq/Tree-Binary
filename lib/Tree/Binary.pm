use v6;

# Designed to be subclassed

class Tree::Binary {
    has Tree::Binary $.parent;
    has Tree::Binary $.left;
    has Tree::Binary $.right;
    has Mu $.value;
    
    method leftIsTree {
        self.left ~~ Tree::Binary
    }

    method rightIsTree {
        self.right ~~ Tree::Binary
    }

    method root {
        self.parent ?? self.parent.root !! self
    }

    method spawn (Tree::Binary $p is rw) {
        self.parent := $p;
        self;
    }

    multi method traverse (Code &func) {
        &func(self);
        self.left.traverse(&func) if self.leftIsTree;
        self.right.traverse(&func) if self.rightIsTree;
    }

    method mirror {
        # swap left for right
        (self.left, self.right) = (self.right, self.left);
        # and recurse
        self.left.mirror if self.left;
        self.right.mirror if self.right;
        self;
    }

    method size {
        my $size = 1;
        $size += self.left.size if self.left;
        $size += self.right.size if self.right;
    }

    method height {
        my ($left_height, $right_height) = (0, 0);
        $left_height = self.left.height() if self.left;
        $right_height = self.right.height() if self.right;
        return 1 + max($left_height, $right_height);
    }
}

# vim: ft=perl6
