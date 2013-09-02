use v6;

role Tree::Binary::Sorted {
    # Comparison between value and node
#    has &.cmp = &infix:<cmp>;
    multi method cmp ($v) { self.value cmp $v }

    multi method build (@list) {
        # This won't sort for you.
        # Use .insert for that.
        my $split = +@list div 2;
        self.value = @list[$split];
        self.left.spawn(self).build(@list[^$split]);
        self.right.spawn(self).build(@list[$split ^.. *]);
        self;
    }

    multi method deconstruct () {
        my @l = self.left.?deconstruct;
        @l   ,= self.value;
        @l   ,= self.right.?deconstruct;
    }

    multi method balance () {
        # There's probably a more elegant way
        self.build(self.deconstruct);
    }

    multi method has ($thing) {
        return False unless self.value;
        given self.cmp($thing) {
            when Decrease { self.left.has($thing) }
            when Same { True }
            when Increase { self.right.has($thing) }
        }
    }

    multi method search ($thing) {
        given self.cmp($thing) {
            when Decrease { self.left.?search($thing) // self }
            when Same { self }
            when Increase { self.right.?search($thing) // self }
        }       
    }

    multi method insert (*@things) {
        for @things {
            given self.cmp($_) {
                if !self.value.defined {
                    self.value = $_;
                } else {
                    when Increase      { self.right.spawn(self).insert($_) }
                    when Decrease|Same { self.left.spawn(self).insert($_)  }
                }
            }
        }
        self.balance; # Oh geez
    }

}

# vim: ft=perl6
