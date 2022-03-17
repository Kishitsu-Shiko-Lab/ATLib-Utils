#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 10;

#1
use_ok('ATLib::Utils', qw{ is_number });

#2 $result = is_number(undef);     # $result == 0
is(is_number(undef), 0);

#3 $result = is_number("");        # $result == 0
is(is_number(""), 0);

#4 $result = is_number("string");  # $result == 0
is(is_number("string"), 0);

#5 $result = is_number(123);       # $result == 1
is(is_number(123), 1);

#6 $result = is_number(1.23);      # $result == 1
is(is_number(1.23), 1);

#7 $result = is_number("123");     # $result == 1
is(is_number("123"), 1);

#8 $result = is_number("1.23");    # $result == 1
is(is_number("1.23"), 1);

#9 $result = is_number($object);   # $result == 0
my $object = bless({}, "ATLib::Utils::Test");
is(is_number($object), 0);

#10 $result = is_number($ref);      # $result == 0
my $scalar = 'Hello.';
my $scalar_ref = \$scalar;
is(is_number($scalar_ref), 0);

done_testing();
__END__