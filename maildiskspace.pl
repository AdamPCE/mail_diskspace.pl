#!/usr/bin/perl
# Available under BSD License. See url for more info:
# http://www.cyberciti.biz/tips/howto-write-perl-script-to-monitor-disk-space.html
use strict;
use warnings;
use Filesys::DiskSpace;

# file system to monitor
my $dir = "/";

# warning level
my $warning_level=10;

# email setup
my $to='mail@domain.org';
my $from='mail@domain.org';
my $subject='Low Disk Space on diginh.nl';

# get df
my ($fs_type, $fs_desc, $used, $avail, $fused, $favail) = df $dir;

# calculate
my $df_free = (($avail) / ($avail+$used)) * 100.0;
#print $df_free;
#print "\n";
# compare
if ($df_free < $warning_level) {
my $out = sprintf("WARNING Low Disk Space on $dir : %0.2f%% ()\n",$df_free);
# send email using UNIX/Linux sendmail
open(MAIL, "|/usr/sbin/sendmail -t");

## Mail Header
print MAIL "To: $to\n";
print MAIL "From: $from\n";
print MAIL "Subject: $subject\n";

## Mail Body
print MAIL $out;

close(MAIL);
}
