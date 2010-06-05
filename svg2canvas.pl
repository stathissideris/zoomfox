#!/usr/bin/perl

use warnings;
use strict;
use Regexp::Common;

#http://www.w3.org/TR/SVG/paths.html#PathDataMovetoCommands
#Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates.

#Important: If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.

my $context = "ctx";
my $svg = "m 28.00377,16.734 -17.40625,10.3437 5.03125,0 0,12.1875 10.09375,0 0,-5.8125 4.5625,0 0,5.8125 10.09375,0 0,-12.1875 5.03125,0 -7.28125,-4.3125 0,-4.4687 -3.78125,0 0,2.2187 -6.34375,-3.7812 z";
my @tokens = split(/\s+/, $svg);

my $currentCommand;
my $moveToTokenCount;

print $context.".beginPath();\n";
my ($posX, $posY) = (0, 0);
foreach my $token (@tokens) {
	if($token eq 'm') {
		$currentCommand = "moveTo";
		$moveToTokenCount = 0;
	} elsif ($token =~ /($RE{num}{real}),($RE{num}{real})/ and ($currentCommand eq 'moveTo' or $currentCommand eq 'lineTo')) {
		$posX += $1; 
		$posY += $2;
		if($moveToTokenCount >= 1) { $currentCommand = 'lineTo'; }
		print $context.'.'.$currentCommand."($posX,$posY);\n";
		$moveToTokenCount++;
	} elsif($token eq 'z') {
		print $context.".closePath();\n";
	}
}
