#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Monster addition problem 
# Matthew Crick
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use Test::More qw(no_plan);
use feature qw(say state current_sub);
use Time::HiRes qw(time);

my %C;
 
sub count_encounters_rec($@)                                                    # Count valid configurations
 {my ($T, @M) = @_;                                                             # Target difficulty, Monsters

  return 1 if $T == 0;                                                          # Return 1 if permutation achieves target
  return 0 if $T  < 0 or @M == 0;                                               # Return 0 if permutation does not or runs if no Monsters 
  
  my ($m, @m) = @M;                                                             # Seperates a monster from Monsters 
  $C{join ' ', @_} //= __SUB__->($T, @m) + __SUB__->($T - $$m[1], @M);          # Perturb the parameters towards the base case
 }

sub test                                                                        #
 {my ($T, @M) = @_;
  count_encounters_rec $T, @M                                                   #
 }
 
my $t = time;

if (1)                                                                          #
 {my $n = test 1, [qw(tiger 1)];
  is_deeply $n, 1;
 }

if (1)                                                                          #
 {my $n = test 2, [qw(tiger 1)], [qw(lion 1)];
  is_deeply $n, 3;
 }

if (1)                                                                          #
 {my $n = test 4, [qw(tiger 1)], [qw(lion 1)], [qw(zebra 2)];
  is_deeply $n, 9;
 }
 
if (1)                                                                          #
 {my $n = test 15, [qw(bear 5)],[qw(imp 2)], [qw(kobold 3)], [qw(dragon 10)];
  is_deeply $n, 9;
 }
 
if (1)                                                                          #
 {my $a = test 15, [qw(bear 5)],[qw(imp 2)], [qw(kobold 3)], [qw(dragon 10)];
  is_deeply $a, 9;
 }
 
if (1)                                                                          #
 {my $c = test 25, [qw(tiger 4)],[qw(panda 7)], [qw(lizards 6)], [qw(lion 9)], [qw(elephant 13)];
  is_deeply $c, 8;
 }

if (1)                                                                          #
 {my $c = test 15, [qw(tiger 4)],[qw(panda 7)], [qw(lizards 6)], [qw(lion 9)], [qw(elephant 13)];
  is_deeply $c, 2;
 }

if (1)                                                                          #
 {my $c = test 15, [qw(bear 5)],[qw(imp 2)], [qw(kobold 3)], [qw(dragon 10)];
  is_deeply $c, 9;
 }
 
if (1)                                                                          #
 {my $c = test 87, [qw(bear 5)],[qw(imp 2)], [qw(kobold 3)], [qw(dragon 10)];
  is_deeply $c, 504;
 } 
say "time is ", sprintf("time: %7.2f", (time - $t) * 1000);                     # Time test
