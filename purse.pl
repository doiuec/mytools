use strict;
use warnings;
use utf8;
use open ":utf8";
binmode STDIN, ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

open(DATAFILE, "< log.txt") or die("Error:$!");

my $page;
{ local $/ = undef;
$page = <IN>;
}

my time;
if($page =~ ml(SRC)|s){
  $time = $1;
}

#while(my $line = <DATAFILE>){
#  chomp($line);
#  print "$line¥n";
#}
