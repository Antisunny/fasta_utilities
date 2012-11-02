#!/usr/bin/perl
use warnings;
use strict;
###############################################################################
# By Jim Hester
# Date:12/10/2009
# Title:removeRedundant.pl
# Purpose:This script removes reads which map to the same location with the same bp in the same orientation
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
# removeRedundant.pl
###############################################################################

my %printedReads = ();

while(<>){
  my($readName, $strand, $chromosome, $start) = split;
  if(not exists $printedReads{"$strand$chromosome$start"}){
    print $_;
    $printedReads{"$strand$chromosome$start"} = ();
  }
}

###############################################################################
# Help Documentation
###############################################################################
__END__

=head1 NAME

removeRedundant.pl - This script removes reads which map to the same location with the same bp in the same orientation and if they are not redundant prints to stdout

=head1 SYNOPSIS

removeRedundant.pl [options] [file ...]

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

B<removeRedundant.pl> This script removes reads which map to the same location with the same bp in the same orientation

=cut

