
#!/usr/bin/perl

use strict;
use warnings;
use Template;


# output to give to template process
my $template_vars = {
    'time' => $time,
    'points' => \@points
};
################################################################################
# Template output
################################################################################
my $template = Template->new({
    ABSOLUTE => 1,
});
copy($template_file, $html_output_file) or die "Copy failed: $!";
$template->process($html_output_file, $template_vars, $html_output_file) || die $template->error();
