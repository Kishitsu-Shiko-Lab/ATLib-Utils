#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 10;

#1
use_ok('ATLib::Utils', qw{ is_int });

#2 $result = is_int(undef);        # $result == 0
is(is_int(undef), 0);

#3 $result = is_int("");           # $result == 0
is(is_int(""), 0);

#4 $result = is_int("string");     # $result == 0
is(is_int("string"), 0);

#5 $result = is_int(123);          # $result == 1
is(is_int(123), 1);

#6 $result = is_int(1.23);         # $result == 0
is(is_int(1.23), 0);

#7 $result = is_int("123");        # $result == 1
is(is_int("123"), 1);

#8 $result = is_int("1.23");       # $result == 0
is(is_int("1.23"), 0);

#9 $result = is_int($object);      # $result == 0
my $object = bless({}, "ATLib::Utils::Test");
is(is_int($object), 0);

#10 $result = is_int($ref);         # $result == 0
my $scalar = '123';
my $scalar_ref = \$scalar;
is(is_int($scalar_ref), 0);

done_testing();
__END__