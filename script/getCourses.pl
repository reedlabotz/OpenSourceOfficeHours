#!/usr/bin/perl
use warnings;
use strict;
use URI;
use Web::Scraper;

open FILE, ">courses_seed.rb" or die $!;


# website to scrape
my $urlToScrape = "http://courses.illinois.edu/cis/2011/spring/catalog/index.html";

# prepare data
my $teamsdata = scraper {
 # we will save the urls from the teams
 process "div.ws-subject-row div.ws-course-title a", 'urls[]' => '@href';
 # we will save the team names
 process "div.ws-subject-row div.ws-course-title a", 'names[]' => 'TEXT';
};
# scrape the data
my $res = $teamsdata->scrape(URI->new($urlToScrape));

# print the second field (the teamname)
for my $i (0 .. $#{$res->{names}}) {
 print "Grabbing " . $res->{names}[$i];
 print "\n";
 
 # prepare data
 my $teamsdata = scraper {
  # we will save the urls from the teams
  process "div.ws-row div.ws-course-number", 'numbers[]' => 'TEXT';
  # we will save the team names
  process "div.ws-row div.ws-course-title a", 'titles[]' => 'TEXT';
 };
 # scrape the data
 my $res = $teamsdata->scrape(URI->new($res->{urls}[$i]));

 # print the second field (the teamname)
 for my $i (0 .. $#{$res->{numbers}}) {
    my $dep = "";
    my $num = "";
   ($dep,$num) = split(/[\ \t\n]+/,$res->{numbers}[$i]);
  my $name = $res->{titles}[$i];
  print "$dep $num - $name";
  print "\n";
  
  
  # put the data in a file
  print FILE "Course.create(:name => \"$name\", :number => \"$num\", :department => \"$dep\")";
  print FILE "\n";
  
 }
 print "-----------------------------------------------------------\n";
 sleep(3);
}


close FILE;
