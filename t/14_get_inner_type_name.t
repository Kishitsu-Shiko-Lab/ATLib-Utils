#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4;

#1
use_ok(q{ATLib::Utils}, qw{get_inner_type_name});

#2
my $type_name = q{ATLib::Std::String};
is(get_inner_type_name($type_name), $type_name);

#3
is(get_inner_type_name(qq{Maybe[$type_name]}), $type_name);

#4
is(get_inner_type_name(undef), q{});

done_testing();

