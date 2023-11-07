#!/usr/bin/perl -w

###
# showchars - Print a character map of ASCII and extended region
# Author: Jeremy Dolan
#
# This work is public domain. The author hereby releases all copyright. «jd»
# This software is provided free and “as is”, without warranties of any kind,
# express or implied, including but not limited to the warranties of fitness
# for a particular purpose or merchantability. In no event shall the author be
# liable for any damages arising in any way out of the use of this software.
###


# Some terminals (e.g., OSX Terminal.app with the default profile) expect UTF-8
# Thus, "wide" characters with their high bit set (0xa0-0xff) will not render
# We need to set Perl's encoding for STDOUT to utf8 to account for this
# useful ref: https://en.wikibooks.org/wiki/Perl_Programming/Unicode_UTF-8

# Prepare Perl to output utf8 strings to STDOUT when $LANG contains 'UTF-8'
if ("$ENV{LANG}" =~ /UTF-8/) {
    $unicode_declared = 1;
    binmode STDOUT, ":encoding(utf8)";
}

print "Character map for ASCII (0x00-0x7f) plus extended region (0x80-0xff)\n";
print "Extension is most commonly ISO-8859-1 (\"Latin1\")\n";
print "     hex  oct  dec";
for (my $i = 0; $i < 256; $i++) {
    # start a new row every 16 chars
    if ($i % 16 == 0) {
        print "\n";

        # print character map region groups:
        #   original control and glyphs (C0, G0), and extended (C1, G1)
        if    ($i == 0x00) { print "C0   "; $ctrl = 1; }
        elsif ($i == 0x20) { print "G0   "; $ctrl = 0; }
        elsif ($i == 0x80) { print "C1   "; $ctrl = 1; }
        elsif ($i == 0xa0) { print "G1   "; $ctrl = 0; }
        else               { print "     "; }

        # print index value in hex/oct/dec
        printf("0x%02x 0%03o %3d", $i, $i, $i);

        # don't print control characters; skip to next row
        if ($ctrl) {
            $i += 15;
            next;
        }
    }

    # add extra spacing every 8 chars
    if ($i % 8 == 0) {
        print "  ";
    }

    printf(" %c", $i) unless $i == 127;
}
print "\n\n";


# hacky add-on to show codepage 437
if (defined $ARGV[0] and $ARGV[0] =~ "^--437\$") {
    if (not $unicode_declared) {
        print "warning: --437 specified but \$LANG does not advertise " .
            "Unicode capability\n";
    }

    # scraped from https://en.wikipedia.org/wiki/Code_page_437
    @codepage_437_unicode_locations =  (0x00C7, 0x00FC, 0x00E9, 0x00E2, 0x00E4,
        0x00E0, 0x00E5, 0x00E7, 0x00EA, 0x00EB, 0x00E8, 0x00EF, 0x00EE, 0x00EC,
        0x00C4, 0x00C5, 0x00C9, 0x00E6, 0x00C6, 0x00F4, 0x00F6, 0x00F2, 0x00FB,
        0x00F9, 0x00FF, 0x00D6, 0x00DC, 0x00A2, 0x00A3, 0x00A5, 0x20A7, 0x0192,
        0x00E1, 0x00ED, 0x00F3, 0x00FA, 0x00F1, 0x00D1, 0x00AA, 0x00BA, 0x00BF,
        0x2310, 0x00AC, 0x00BD, 0x00BC, 0x00A1, 0x00AB, 0x00BB, 0x2591, 0x2592,
        0x2593, 0x2502, 0x2524, 0x2561, 0x2562, 0x2556, 0x2555, 0x2563, 0x2551,
        0x2557, 0x255D, 0x255C, 0x255B, 0x2510, 0x2514, 0x2534, 0x252C, 0x251C,
        0x2500, 0x253C, 0x255E, 0x255F, 0x255A, 0x2554, 0x2569, 0x2566, 0x2560,
        0x2550, 0x256C, 0x2567, 0x2568, 0x2564, 0x2565, 0x2559, 0x2558, 0x2552,
        0x2553, 0x256B, 0x256A, 0x2518, 0x250C, 0x2588, 0x2584, 0x258C, 0x2590,
        0x2580, 0x03B1, 0x00DF, 0x0393, 0x03C0, 0x03A3, 0x03C3, 0x00B5, 0x03C4,
        0x03A6, 0x0398, 0x03A9, 0x03B4, 0x221E, 0x03C6, 0x03B5, 0x2229, 0x2261,
        0x00B1, 0x2265, 0x2264, 0x2320, 0x2321, 0x00F7, 0x2248, 0x00B0, 0x2219,
        0x00B7, 0x221A, 0x207F, 0x00B2, 0x25A0, 0x00A0);

    print "codepage 437 in Unicode:\n";

    for my $i (0 .. $#codepage_437_unicode_locations) {
        printf("0x%04x %1\$c", $codepage_437_unicode_locations[$i]);
        if (($i+1) % 8 == 0) {
            print "\n";
        } elsif (($i+1) % 4 == 0) {
            print "   ";
        } else {
            print "  ";
        }
    }
} else {
    print "(Use --437 to show old-school codepage 437 chars with " .
         "new-school Unicode addrs)\n";
}
