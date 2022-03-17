#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 24;

#1
use_ok('ATLib::Utils', qw{ as_type_of });

# Type of Bool
#2 $result = as_type_of(q{Bool}, undef);                   # $result == 0
is(as_type_of(q{Bool}, undef), 0);

#3 $result = as_type_of(q{Maybe[Bool]}, undef);            # $result == 1
is(as_type_of(q{Maybe[Bool]}, undef), 1);

#4 $result = as_type_of(q{Bool}, 0);                       # $result == 1
is(as_type_of(q{Bool}, 0), 1);

#5 $result = as_type_of(q{Bool}, 1);                       # $result == 1
is(as_type_of(q{Bool}, 1), 1);

#6 $result = as_type_of(q{Bool}, "string");                # $result == 0
is(as_type_of(q{Bool}, "string"), 0);

# Type of Num
#7 $result = as_type_of(q{Num}, undef);                    # $result == 0
is(as_type_of(q{Num}, undef), 0);

#8 $result = as_type_of(q{Maybe[Num]}, undef);             # $result == 1
is(as_type_of(q{Maybe[Num]}, undef), 1);

#9 $result = as_type_of(q{Num}, 123);                      # $result == 1
is(as_type_of(q{Num}, 123), 1);

#10 $result = as_type_of(q{Num}, 1.23);                     # $result == 1
is(as_type_of(q{Num}, 1.23), 1);

#11 $result = as_type_of(q{Num}, "string");                 # $result == 0
is(as_type_of(q{Num}, "string"), 0);

# Type of Int
#12 $result = as_type_of(q{Int}, undef);                    # $result == 0
is(as_type_of(q{Int}, undef), 0);

#13 $result = as_type_of(q{Maybe[Int]}, undef);             # $result == 1
is(as_type_of(q{Maybe[Int]}, undef), 1);

#14 $result = as_type_of(q{Int}, 123);                      # $result == 1
is(as_type_of(q{Int}, 123), 1);

#15 $result = as_type_of(q{Int}, 1.23);                     # $result == 0
is(as_type_of(q{Int}, 1.23), 0);

#16 $result = as_type_of(q{Int}, "string");                 # $result == 0
is(as_type_of(q{Int}, "string"), 0);

# Type of Object
#17 $result = as_type_of(q{<Class Name>}, undef);           # $result == 0
is(as_type_of(q{ATLib::Utils::Test}, undef), 0);

#18 $result = as_type_of(q{Maybe[<Class Name>]}, undef);    # $result == 1
is(as_type_of(q{Maybe[ATLib::Utils::Test]}, undef), 1);

#19 $result = as_type_of(q{<Class Name>}, $object);         # $result == 1
my $class_name = q{ATLib::Utils::Test};
my $object = bless({}, $class_name);
is(as_type_of($class_name, $object), 1);

#20 $result = as_type_of(q{<Class Name>}, $ref);            # $result == 0
my $scalar = '123';
my $scalar_ref = \$scalar;
is(as_type_of($class_name, $scalar_ref), 0);

#Type of reference
#21 $result = as_type_of(q{Ref}, undef);                    # $result == 0
is(as_type_of(q{Ref}, undef), 0);

#22 $result = as_type_of(q{Maybe[Ref]}, undef);             # $result == 1
is(as_type_of(q{Maybe[Ref]}, undef), 1);

#23 $result = as_type_of(q{Ref}, $object);                  # $result == 0
is(as_type_of(q{Ref}, $object), 0);

#24 $result = as_type_of(q{Ref}, $ref);                     # $result == 1
is(as_type_of(q{Ref}, $scalar_ref), 1);


done_testing();
__END__