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
log4perl.rootLogger                                = INFO, Screen, LogFile

log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
log4perl.appender.Screen.layout.ConversionPattern  = [%d{ISO8601}] [%5p] %m%n

log4perl.appender.LogFile                           = Log::Log4perl::Appender::File
log4perl.appender.LogFile.filename                  = ${log_dir}/install_cws_${log_date}.log
log4perl.appender.LogFile.layout                    = Log::Log4perl::Layout::PatternLayout
log4perl.appender.LogFile.layout.ConversionPattern  = [%d{ISO8601}] [%5p] %m%n
EOT

Log::Log4perl->init(\$l4p_properties);
my $logger = Log::Log4perl->get_logger ('Screen');
$logger = Log::Log4perl->get_logger('LogFile') if ($logfile);

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
# Functions
#===============================================================================
sub parse_json {
   my $file = shift;

   format_json_file($file);

   my $json = JSON->new;
   $json->relaxed([1]);
   my $href;

   local($/);
   my $fh = IO::File->new($file, 'r');
   if (not defined $fh) {
      $logger->error("open $file failed: $!");
      return;
   }
   my $str = <$fh>;
   $fh->close;

   eval { $href = $json->decode($str); };
   if ($@) {
      $logger->logdie($@);
   }

   return $href;
}

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
