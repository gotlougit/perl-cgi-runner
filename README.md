# Perl CGI Runner

This is a small Perl script which lets you run Perl CGI scripts easily without
having any HTTP servers specifically in your code.

It is intended specifically for development purposes in order for developers to
run the program without setting up Apache.

To use, simply run

`perl cgi_runner.pl /path/to/your/perl/cgi/script`

Note: all the dependencies are managed using Nix. You should use Nix and direnv to
use this project, since it will install all the dependencies and take care of everything
for you.
