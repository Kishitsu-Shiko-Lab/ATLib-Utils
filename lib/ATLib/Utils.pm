package ATLib::Utils;
use 5.016_001;
use version; our $VERSION = version->declare('v0.2.3');
use strict;
use warnings;
use utf8;

use Exporter qw{ import };
use Scalar::Util qw{ looks_like_number blessed};

our @EXPORT_OK = qw{ is_number is_int get_inner_type_name as_type_of equals};

# Export Functions
sub is_number
{
    my ($target) = @_;

    if (!(defined $target))
    {
        return 0;
    }

    if (looks_like_number($target))
    {
        if ($target =~ m{^-? [0-9]+ (?: (?:. [0-9]+ )? | (?:. [0-9]+ [eE] -? [0-9]+ ))?$}xms)
        {
            return 1;
        }
    }
    return 0;
}

sub is_int
{
    my ($target) = @_;

    if (!(defined $target))
    {
        return 0;
    }

    if (looks_like_number($target))
    {
        if ($target =~ m{^-? [0-9]+$}xms)
        {
            return 1;
        }
    }
    return 0;
}

sub get_inner_type_name
{
    my ($type_name) = @_;

    if (!defined $type_name)
    {
        return q{};
    }

    if ($type_name =~ m{^Maybe \[ ([\w:]+) \]}xms)
    {
        return $1;
    }
    return $type_name;
}

sub as_type_of
{
    my ($type_name, $target) = @_;

    if ($type_name =~ m{^Maybe \[ ([\w:]+) \]$}xms)
    {
        if (!(defined($target)))
        {
            return 1;
        }
        $type_name = $1;
    }

    if ($type_name eq q{Bool})
    {
        if (!(defined $target))
        {
            return 0;
        }
        if (is_int($target))
        {
            if ($target == 0 || $target == 1)
            {
                return 1;
            }
        }
        return 0;
    }

    if ($type_name eq q{Num})
    {
        return is_number($target);
    }

    if ($type_name eq q{Int})
    {
        return is_int($target);
    }

    if ($type_name eq q{Str})
    {
        if (defined $target && !ref($target))
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }

    if (blessed $target)
    {
        if ($target->isa($type_name))
        {
            return 1;
        }
        return 0;
    }

    if ($type_name =~ m{ Ref | FileHandle }xms)
    {
        if (ref($target))
        {
            return 1;
        }
        return 0;
    }

    return 0;
}

sub equals
{
    my ($T, $this, $that) = @_;

    # Compare undef, and get real type name.
    if ($T =~ m{^Maybe \[ ([\w:]+)\]$}xms)
    {
        if (as_type_of($T, $this) && as_type_of($T, $that))
        {
            if (!(defined $this))
            {
                if (!(defined $that))
                {
                    # undef == undef
                    return 1;
                }
                return 0;
            }
        }
        $T = $1;
    }

    if (!as_type_of($T, $this))
    {
        return 0;
    }
    if (!as_type_of($T, $that))
    {
        return 0;
    }

    if ($T =~ m{ Bool | Num | Int }xms)
    {
        if ($this == $that)
        {
            return 1;
        }
        return 0;
    }

    if ($T =~ m{ Str }xms)
    {
        if ($this eq $that)
        {
            return 1;
        }
        return 0;
    }

    if (ref($this) && ref($that))
    {
        if (scalar($this) eq scalar($that))
        {
            return 1;
        }
    }
    return 0;
}

1;
__END__

=encoding utf8

=head1 名前

ATLib::Utils - ユーティリティ関数をインポートします。

=head1 バージョン

この文書は ATLib::Utils version v0.2.0 について説明しています。

=head1 概要

    use ATLib::Utils;

    my $result = 0;
    $result = is_number(undef);     # $result == 0
    $result = is_number("");        # $result == 0
    $result = is_number("string");  # $result == 0
    $result = is_number(123);       # $result == 1
    $result = is_number(1.23);      # $result == 1
    $result = is_number("123");     # $result == 1
    $result = is_number("1.23");    # $result == 1
    $result = is_number($object);   # $result == 0
    $result = is_number($ref);      # $result == 0

    $result = is_int(undef);        # $result == 0
    $result = is_int("");           # $result == 0
    $result = is_int("string");     # $result == 0
    $result = is_int(123);          # $result == 1
    $result = is_int(1.23);         # $result == 0
    $result = is_int("123");        # $result == 1
    $result = is_int("1.23");       # $result == 0
    $result = is_int($object);      # $result == 0
    $result = is_int($ref);         # $result == 0

    $inner_type_name = get_inner_type_name(q{ATLib::Std::String});          # ATLib::Std::String
    $inner_type_name = get_inner_type_name(q{Maybe[ATLib::Std::String]});   # ATLib::Std::String

    $result = as_type_of(q{Bool}, undef);                   # $result == 0
    $result = as_type_of(q{Maybe[Bool]}, undef);            # $result == 1
    $result = as_type_of(q{Bool}, 0);                       # $result == 1
    $result = as_type_of(q{Bool}, 1);                       # $result == 1
    $result = as_type_of(q{Bool}, "string");                # $result == 0

    $result = as_type_of(q{Num}, undef);                    # $result == 0
    $result = as_type_of(q{Maybe[Num]}, undef);             # $result == 1
    $result = as_type_of(q{Num}, 123);                      # $result == 1
    $result = as_type_of(q{Num}, 1.23);                     # $result == 1
    $result = as_type_of(q{Num}, "string");                 # $result == 0

    $result = as_type_of(q{Int}, undef);                    # $result == 0
    $result = as_type_of(q{Maybe[Int]}, undef);             # $result == 0
    $result = as_type_of(q{Int}, 123);                      # $result == 1
    $result = as_type_of(q{Int}, 1.23);                     # $result == 0
    $result = as_type_of(q{Int}, "string");                 # $result == 0

    $result = as_type_of(q{<Class Name>}, undef);           # $result == 0
    $result = as_type_of(q{Maybe[<Class Name>]}, undef);    # $result == 1
    $result = as_type_of(q{<Class Name>}, $object);         # $result == 1
    $result = as_type_of(q{<Class Name>}, $ref);            # $result == 0

    $result = as_type_of(q{Ref}, undef);                    # $result == 0
    $result = as_type_of(q{Maybe[Ref]}, undef);             # $result == 1
    $result = as_type_of(q{Ref}, $object);                  # $result == 0
    $result = as_type_of(q{Ref}, $ref);                     # $result == 1

    $result = equals(q{Maybe[Int]}, undef, undef);          # $result == 1
    $result = equals(q{Maybe[Int]}, 123, undef);            # $result == 0
    $result = equals(q{Maybe[Int]}, 123, 123);              # $result == 1
    $result = equals(q{Maybe[Int]}, undef, 123);            # $result == 0
    $result = equals(q{Maybe[Int]}, "string", 123);         # $result == 0
    $result = equals(q{Maybe[Int]}, 123, "string");         # $result == 0

    $result = equals(q{Maybe[Num]}, undef, undef);          # $result == 1
    $result = equals(q{Maybe[Num]}, 1.23, undef);           # $result == 0
    $result = equals(q{Maybe[Num]}, 1.23, 1.23);            # $result == 1
    $result = equals(q{Maybe[Num]}, undef, 1.23);           # $result == 0
    $result = equals(q{Maybe[Num]}, "string", 1.23);        # $result == 0
    $result = equals(q{Maybe[Num]}, 1.23, "string");        # $result == 0

    $result = equals(q{Maybe[Str]}, undef, undef);          # $result == 1
    $result = equals(q{Maybe[Str]}, "undef", "undef");      # $result == 1
    $result = equals(q{Maybe[Str]}, "string", undef);       # $result == 0
    $result = equals(q{Maybe[Str]}, "string", "string");    # $result == 1
    $result = equals(q{Maybe[Str]}, undef, "string");       # $result == 0
    $result = equals(q{Maybe[Str]}, 123, "123");            # $result == 1
    $result = equals(q{Maybe[Str]}, "123", 123);            # $result == 1

    $result = equals(q{Int}, undef, undef);                 # $result == 0
    $result = equals(q{Int}, 123, undef);                   # $result == 0
    $result = equals(q{Int}, 123, 123);                     # $result == 1
    $result = equals(q{Int}, undef, 123);                   # $result == 0
    $result = equals(q{Int}, "string", 123);                # $result == 0
    $result = equals(q{Int}, 123, "string");                # $result == 0

    $result = equals(q{Num}, undef, undef);                 # $result == 0
    $result = equals(q{Num}, 1.23, undef);                  # $result == 0
    $result = equals(q{Num}, 1.23, 1.23);                   # $result == 1
    $result = equals(q{Num}, undef, 1.23);                  # $result == 0
    $result = equals(q{Num}, "string", 1.23);               # $result == 0
    $result = equals(q{Num}, 1.23, "string");               # $result == 0

    $result = equals(q{Str}, undef, undef);                 # $result == 0
    $result = equals(q{Str}, "", "");                       # $result == 1
    $result = equals(q{Str}, "string", undef);              # $result == 0
    $result = equals(q{Str}, "string", "string");           # $result == 1
    $result = equals(q{Str}, undef, "string");              # $result == 0
    $result = equals(q{Str}, 123, "123");                   # $result == 1
    $result = equals(q{Str}, "123", 123);                   # $result == 1

=head1 説明

ATLib::Utils はユーティリティ関数を提供します。

=head1 関数

=head2 C<< $result = is_number($target) >>

$target が数値かどうかを判定します。

=head2 C<< $result = is_int($target)  >>

$target が整数かどうかを判定します。

=head2 C<< $inner_type_name = get_inner_type_name($type_name);  >>

L<< Mouse >> の型名 $type_nameのうち、Maybe[]を含まない型を取得します。

=head2 C<< $result = as_type_of($type_name, $target)  >>

$target の型が $type_name の型かどうかを判定します。
$type_name は L<< Mouse >> の型名に準拠していて、以下に示すとおりです。

=over 4

=item *

Bool

=item *

Int

=item *

Num

=item *

E<lt> Class Name E<gt>

=item *

Ref

=item *

Maybe[ E<lt>type_name E<gt> ]

=back

=head2 C<< $result = equals($type_name, $this, $that)  >>

$type_name の型で $this と $that の等価性を判定します。
型Strと、型Int、Numの比較については指定した $type_name により
Perlの比較演算子==、またはeqに従います。
未定義値 undef 同士の比較においては、$type_nameがMaybe[...]の場合は真、以外は偽となります。
$type_name は L<< Mouse >> の型名に準拠していて、以下に示すとおりです。

=over 4

=item *

Bool

=item *

Int

=item *

Num

=item *

E<lt> Class Name E<gt>

=item *

Ref

=item *

Maybe[ E<lt>type_name E<gt> ]

=back

=head1 インストール方法

$cpanm L<< https://github.com/Kishitsu-Shiko-Lab/ATLib-Utils.git >>

=head1 AUTHOR

atdev01 E<lt>mine_t7 at hotmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020-2022 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.

=cut
