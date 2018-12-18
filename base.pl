#!/usr/bin/perl

#===============================================================================
# Imports
#===============================================================================

use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use Log::Log4perl;

#================================================================================
# Version
#===============================================================================
our $VERSION = '18.36';

#===============================================================================
# Init
#===============================================================================
my $l4p_properties = <<EOT;
log4perl.rootLogger                                = INFO, Screen

log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.stderr                    = 0
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
log4perl.appender.Screen.layout.ConversionPattern  = [%d{ISO8601}] [%5p] %m%n
EOT
Log::Log4perl->init(\$l4p_properties) if (not Log::Log4perl->initialized);
my $logger = Log::Log4perl->get_logger();

my $opt_version;
my $opt_help;

#===============================================================================
# Options management
#===============================================================================

GetOptions (
   "version|v"   => \$opt_version,
   'help|h|?'    => \$opt_help,
) or pod2usage(1);

pod2usage(0) if ($opt_help);
pod2usage(
   '-exitval'  => 0,
   '-verbose'  => 99,
   '-sections' => 'VERSION',
) if ($opt_version);

#===============================================================================
# Main
#===============================================================================

#===============================================================================
# End
#===============================================================================
__END__

=head1 NAME

base.pl

=head1 SYNOPSIS

base.pl

=head1 DESCRIPTION

TODO

=head1 OPTIONS AND ARGUMENTS

=over 7

=item B<--tag> STRING

Specify the version name.

=item B<-v, --version>

Print version and exits.

=item B<-h, --help>

Print a brief help message and exits.

=back

=head1 VERSION

v18.36

=head1 AUTHORS

IRA NewPDM (MKA)

=cut
