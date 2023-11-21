#!/usr/bin/perl

# https://metacpan.org/pod/HTTP::Server::Simple
# /versions/perl-5.8.7/bin/perl -MHTTP::Server::Simple test2.pl

use strict;
use warnings;

# Check if a script file is provided as a command-line argument
if (@ARGV != 1) {
    die "Usage: $0 <script_file>\n";
}

my $script_file = $ARGV[0];

{
    package MyWebServer;

    use HTTP::Server::Simple::CGI;
    use base qw(HTTP::Server::Simple::CGI);

    my %dispatch = (
        '/' => \&resp_index,
    );

    sub handle_request {
        my $self = shift;
        my $cgi  = shift;

        my $path    = $cgi->path_info();
        my $handler = $dispatch{$path};

        if (ref($handler) eq "CODE") {
            print "HTTP/1.0 200 OK\r\n";
            $handler->($cgi);

        } else {
            print "HTTP/1.0 404 Not found\r\n";
            print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
        }
    }
    sub resp_index {
        my $cgi = shift;
        print "HTTP/1.0 200 OK\r\n";
        my $out = qx(perl $script_file);
        # Print the captured output
        print $out;
        # Use the captured output in the CGI response
        $cgi->html($out);
    }
}

# start the server on port 8080
MyWebServer->new(8085)->run();

