use v6;

# Designed to be subclassed

class Tree::Binary {
    has Tree::Binary $.left is rw;
    has Tree::Binary $.right is rw;
    has Tree::Binary $.parent is rw;
    has $.value is rw;

    method spawn (Tree::Binary $p is rw) {
        # No parent wants their children
        # thinking that they're orphans
        $!parent := $p;
        self;
    }

    # So one can use them immediately
    multi submethod left is rw {
        $!left // ($!left .= new).spawn(self);
        $!left;
    }
    multi submethod right is rw {
        $!right // ($!right .= new).spawn(self);
        $!right;
    }

    multi submethod left (Tree::Binary $t) {
        $!left = Tree::Binary.new($t);
        $!left;
    }
    multi submethod right (Tree::Binary $t) {
        $!right = Tree::Binary.new($t);
        $!right;
    }

    method root is rw {
        $.parent ?? $.parent.root !! self
    }

    multi method traverse (Code &func) {
        &func(self);
        $.left.traverse(&func) if $.left;
        $.right.traverse(&func) if $.right;
        self;
    }

    method mirror {
        # swap left for right
        ($.left, $.right) = ($.right, $.left);
        # and recurse
        $.left.mirror if $.left;
        $.right.mirror if $.right;
        self;
    }

    method size {
        my $size = 1;
        $size += $.left.size if $.left;
        $size += $.right.size if $.right;
    }

    method height {
        my ($left_height, $right_height) = (0, 0);
        $left_height = $.left.height() if $.left;
        $right_height = $.right.height() if $.right;
        return 1 + max($left_height, $right_height);
    }
}

# vim: ft=perl6
