#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 69;

#1
use_ok('ATLib::Utils', qw{ equals });

# Type of Int?
#2 $result = equals(q{Maybe[Int]}, undef, undef);          # $result == 1
is(equals(q{Maybe[Int]}, undef, undef), 1);

#3 $result = equals(q{Maybe[Int]}, 123, undef);            # $result == 0
is(equals(q{Maybe[Int]}, 123, undef), 0);

#4 $result = equals(q{Maybe[Int]}, 123, 123);              # $result == 1
is(equals(q{Maybe[Int]}, 123, 123), 1);

#5 Perl specific
is(equals(q{Maybe[Int]}, 123, "123"), 1);

#6 Perl specific ex
is(equals(q{Maybe[Int]}, 123, "123.0"), 0);

#7 Perl specific
is(equals(q{Maybe[Int]}, "123", 123), 1);

#8 Perl specific ex
is(equals(q{Maybe[Int]}, "123.0", 123), 0);

#9 Perl specific
is(equals(q{Maybe[Int]}, "123", "123"), 1);

#10 Perl specific ex
is(equals(q{Maybe[Int]}, "123.0", "123.0"), 0);

#11 $result = equals(q{Maybe[Int]}, undef, 123);            # $result == 0
is(equals(q{Maybe[Int]}, undef, 123), 0);

#12 $result = equals(q{Maybe[Int]}, "string", 123);         # $result == 0
is(equals(q{Maybe[Int]}, "string", 123), 0);

#13 $result = equals(q{Maybe[Int]}, 123, "string");         # $result == 0
is(equals(q{Maybe[Int]}, 123, "string"), 0);

# Type of Num?
#14 $result = equals(q{Maybe[Num]}, undef, undef);          # $result == 1
is(equals(q{Maybe[Num]}, undef, undef), 1);

#15 $result = equals(q{Maybe[Num]}, 1.23, undef);           # $result == 0
is(equals(q{Maybe[Num]}, 1.23, undef), 0);

#16 $result = equals(q{Maybe[Num]}, 1.23, 1.23);            # $result == 1
is(equals(q{Maybe[Num]}, 1.23, 1.23), 1);

#17 Perl specific
is(equals(q{Maybe[Num]}, 1.23, "1.23"), 1);

#18 Perl specific ex
is(equals(q{Maybe[Num]}, 1.23, "1.230"), 1);

#19 Perl specific
is(equals(q{Maybe[Num]}, "1.23", 1.23), 1);

#20 Perl specific ex
is(equals(q{Maybe[Num]}, "1.230", 1.23), 1);

#21 $result = equals(q{Maybe[Num]}, undef, 1.23);           # $result == 0
is(equals(q{Maybe[Num]}, undef, 1.23), 0);

#22 $result = equals(q{Maybe[Num]}, "string", 1.23);        # $result == 0
is(equals(q{Maybe[Num]}, "string", 1.23), 0);

#23 $result = equals(q{Maybe[Num]}, 1.23, "string");        # $result == 0
is(equals(q{Maybe[Num]}, 1.23, "string"), 0);

# Type of Str?
#24 $result = equals(q{Maybe[Str]}, undef, undef);          # $result == 1
is(equals(q{Maybe[Str]}, undef, undef), 1);

#25 $result = equals(q{Maybe[Str]}, "undef", "undef");      # $result == 1
is(equals(q{Maybe[Str]}, "undef", "undef"), 1);

#26 $result = equals(q{Maybe[Str]}, "string", undef);       # $result == 0
is(equals(q{Maybe[Str]}, "string", undef), 0);

#27 $result = equals(q{Maybe[Str]}, "string", "string");    # $result == 1
is(equals(q{Maybe[Str]}, "string", "string"), 1);

#28 $result = equals(q{Maybe[Str]}, undef, "string");       # $result == 0
is(equals(q{Maybe[Str]}, undef, "string"), 0);

#29 $result = equals(q{Maybe[Str]}, 123, "123");            # $result == 1
is(equals(q{Maybe[Str]}, 123, "123"), 1);

#30 Perl specific
is(equals(q{Maybe[Str]}, 123, "123.0"), 0);

#31 $result = equals(q{Maybe[Str]}, "123", 123);            # $result == 1
is(equals(q{Maybe[Str]}, "123", 123), 1);

#32 Perl specific
is(equals(q{Maybe[Str]}, "123.0", 123), 0);

# Type of Int
#33 $result = equals(q{Int}, undef, undef);                 # $result == 0
is(equals(q{Int}, undef, undef), 0);

#34 $result = equals(q{Int}, 123, undef);                   # $result == 0
is(equals(q{Int}, 123, undef), 0);

#35 $result = equals(q{Int}, 123, 123);                     # $result == 1
is(equals(q{Int}, 123, 123), 1);

#36 Perl specific
is(equals(q{Int}, 123, "123"), 1);

#37 Perl specific ex
is(equals(q{Int}, 123, "123.0"), 0);

#38 $result = equals(q{Int}, undef, 123);                   # $result == 0
is(equals(q{Int}, undef, 123), 0);

#39 $result = equals(q{Int}, "string", 123);                # $result == 0
is(equals(q{Int}, "string", 123), 0);

#40 $result = equals(q{Int}, 123, "string");                # $result == 0
is(equals(q{Int}, 123, "string"), 0);

# Type of Num
#41 $result = equals(q{Num}, undef, undef);                 # $result == 0
is(equals(q{Num}, undef, undef), 0);

#42 $result = equals(q{Num}, 1.23, undef);                  # $result == 0
is(equals(q{Num}, 1.23, undef), 0);

#43 $result = equals(q{Num}, 1.23, 1.23);                   # $result == 1
is(equals(q{Num}, 1.23, 1.23), 1);

#44 Perl specific
is(equals(q{Num}, 1.23, "1.23"), 1);

#45 Perl specific
is(equals(q{Num}, "1.23", 1.23), 1);

#46 Perl specific ex
is(equals(q{Num}, 1.23, "1.230"), 1);

#47 Perl specific ex
is(equals(q{Num}, "1.230", 1.23), 1);

#48 Perl specific
is(equals(q{Num}, "1.23", "1.23"), 1);

#49 $result = equals(q{Num}, undef, 1.23);                  # $result == 0
is(equals(q{Num}, undef, 1.23), 0);

#50 $result = equals(q{Num}, "string", 1.23);               # $result == 0
is(equals(q{Num}, "string", 1.23), 0);

#51 $result = equals(q{Num}, 1.23, "string");               # $result == 0
is(equals(q{Num}, 1.23, "string"), 0);

#52 Perl specific
is(equals(q{Num}, "", ""), 0);

#53 Perl specific
is(equals(q{Num}, 0, ""), 0);

#54 Perl specific
is(equals(q{Num}, "", 0), 0);

# Type of Str
#55 $result = equals(q{Str}, undef, undef);                 # $result == 0
is(equals(q{Str}, undef, undef), 0);

#56 $result = equals(q{Str}, "", "");                       # $result == 1
is(equals(q{Str}, "", ""), 1);

#57 $result = equals(q{Str}, "string", undef);              # $result == 0
is(equals(q{Str}, "string", undef), 0);

#58 $result = equals(q{Str}, "string", "string");           # $result == 1
is(equals(q{Str}, "string", "string"), 1);

#59 $result = equals(q{Str}, undef, "string");              # $result == 0
is(equals(q{Str}, undef, "string"), 0);

#60 $result = equals(q{Str}, 123, "123");                   # $result == 1
is(equals(q{Str}, 123, "123"), 1);

#61 $result = equals(q{Str}, "123", 123);                   # $result == 1
is(equals(q{Str}, "123", 123), 1);

#62 Perl specific
is(equals(q{Str}, 123, 123), 1);

# Type of reference (object)
my $class_name = q{ATLib::Utils::Test};
my $object1 = bless({}, $class_name);
my $object2 = bless({}, $class_name);
my $object_differ = bless({}, q{ATLib::Utils::Test::Different});
#63
is(equals($class_name, undef, undef), 0);

#64
is(equals($class_name, $object1, undef), 0);

#65
is(equals($class_name, undef, $object1), 0);

#66
is(equals($class_name, $object1, $object1), 1);

#67
is(equals($class_name, $object1, $object2), 0);

#68
is(equals($class_name, $object_differ, $object_differ), 0);

#69
is(equals(q{ATLib::Utils::Test::Different}, $object_differ, $object_differ), 1);

done_testing();
__END__