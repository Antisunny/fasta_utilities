#!/usr/bin/perl
use warnings;
use strict;
###############################################################################
# By Jim Hester
# Date:03/21/2011
# Title:getPairs.pl
# Purpose:this script gets the pairs of the files in the first file from the second file, pairs are matched by header name
###############################################################################

###############################################################################
# Code to handle help menu and man page
###############################################################################
use Getopt::Long;
use Pod::Usage;
my $man = 0;
my $help = 0;
GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
pod2usage(2) if $help;
pod2usage(-verbose => 2) if $man;
pod2usage("$0: No files given.")  if ((@ARGV == 0) && (-t STDIN));
###############################################################################
# getPairs.pl
###############################################################################

local $/ = "@";

my %headers;

my $firstFile = shift;

open FIRST, $firstFile;

my $head1 = <FIRST>;
while(<FIRST>){
  if(/^(.+?)(\/[12])|\n/){
    my($header) = $1;
    $headers{$header}++;
  }
}
close FIRST;

use JimBar;

my $bar = JimBar->new();
my $head2 = <>;
while(<>){
  if(/^(.+?)(\/[12])|\n/){
    my($header) = $1;
    if(exists $headers{$header}){
      chomp;
      print "@",$_;
    }
  }
}
$bar->done();
###############################################################################
# Help Documentation
###############################################################################
__END__

=head1 NAME

getPairs.pl - this script gets the pairs of the files in the first file from the second file, pairs are matched by header name

=head1 SYNOPSIS

getPairs.pl [options] [file ...]

Options:
      -help
      -man               for more info

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<getPairs.pl> this script gets the pairs of the files in the first file from the second file, pairs are matched by header name

=cut

