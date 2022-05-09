# 名前

ATLib::Utils - ユーティリティ関数をインポートします。

# バージョン

この文書は ATLib::Utils version v0.2.0 について説明しています。

# 概要

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

# 説明

ATLib::Utils はユーティリティ関数を提供します。

# 関数

## `$result = is_number($target)`

$target が数値かどうかを判定します。

## `$result = is_int($target)`

$target が整数かどうかを判定します。

## `$inner_type_name = get_inner_type_name($type_name);`

[Mouse](https://metacpan.org/pod/Mouse) の型名 $type\_nameのうち、Maybe\[\]を含まない型を取得します。

## `$result = as_type_of($type_name, $target)`

$target の型が $type\_name の型かどうかを判定します。
$type\_name は [Mouse](https://metacpan.org/pod/Mouse) の型名に準拠していて、以下に示すとおりです。

- Bool
- Int
- Num
- < Class Name >
- Ref
- Maybe\[ &lt;type\_name > \]

## `$result = equals($type_name, $this, $that)`

$type\_name の型で $this と $that の等価性を判定します。
型Strと、型Int、Numの比較については指定した $type\_name により
Perlの比較演算子==、またはeqに従います。
未定義値 undef 同士の比較においては、$type\_nameがMaybe\[...\]の場合は真、以外は偽となります。
$type\_name は [Mouse](https://metacpan.org/pod/Mouse) の型名に準拠していて、以下に示すとおりです。

- Bool
- Int
- Num
- < Class Name >
- Ref
- Maybe\[ &lt;type\_name > \]

# インストール方法

$cpanm [https://github.com/Kishitsu-Shiko-Lab/ATLib-Utils.git](https://github.com/Kishitsu-Shiko-Lab/ATLib-Utils.git)

# AUTHOR

atdev01 &lt;mine\_t7 at hotmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2020-2022 atdev01.

This library is free software; you can redistribute it and/or modify
it under the same terms of the Artistic License 2.0. For details,
see the full text of the license in the file LICENSE.
