#!/usr/bin/env perl
use strictures 1;

use Test::More;

{
  package SomeClass;
  use Moo;
  with 'MooX::Emulate::Class::Accessor::Fast';

  sub anaccessor { 'wibble' }
}

{
  package SubClass;
  use base qw/SomeClass/;

  sub anotherone { 'flibble' }
  __PACKAGE__->mk_accessors(qw/ anaccessor anotherone /);
}

my $someclass = SomeClass->new;
is($someclass->anaccessor, 'wibble');
$someclass->anaccessor('fnord');
is($someclass->anaccessor, 'wibble');

my $subclass = SubClass->new;
ok( not defined $subclass->anaccessor );
$subclass->anaccessor('fnord');
is($subclass->anaccessor, 'fnord');
is($subclass->anotherone, 'flibble');
$subclass->anotherone('fnord');
is($subclass->anotherone, 'flibble');

done_testing;
