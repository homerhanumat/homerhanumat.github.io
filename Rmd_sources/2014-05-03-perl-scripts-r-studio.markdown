---
layout: post
title: "Course Management with the RStudio Server"
date: 2014-05-03 01:00:00
comments: true
categories: [Tech Note]
published: true
status: publish
---
 
 
 
* will be replaced by TOC
{:toc}
 


 
 
## Introduction
 
At my institution we teach both elementary and upper-level undergraduate statistics using R, in the environment of the [RStudio Linux server](https://www.rstudio.com/ide/download/) installed and configured on our campus network.  Although students are made aware of the existence of the desktop version of RStudio and eventually are encouraged to install it on their personal machines, the default course environment is that of the server.
 
One reason for this choice is that the server allows us---instructors working in consultation with our sysadmin---to standardize the R environment (R version, installed packages, etc.) for all class members, so that if we add a feature or fix a problem we have some reasonable confidence that it will work for everyone.
 
Another reason---which constitutes the theme of this post---is that the server environment facilitates course management, especially in technical respects specific to a statistics course, where standard online content management systems such as Moodle or Blackboard may fall short.  The aim of this post is to record, for colleagues at our institution and for folks at other institutions who are considering making the switch to R, the principal ways in which in we have tweaked the server for course-management purposes.  R and RStudio are wonderful free software, but like all free software, they come with a certain "cost of ownership", and those costs can be considerable if (like me) you begin with little in the way of programming/hacking skills.  I hope that the following information will reduce the ownership costs for others who choose to teach with R in a similar vein.
 
## Installation
 
I assume that you have persuaded your sysadmin to install and configure some version of the [RStudio Linux server](https://www.rstudio.com/ide/download/).  My sysadmin chose to set up the Cent OS version, and configured it so that all members of the campus community can access it by means of their username and password.
 
If your personal machine runs Linux---either the Ubuntu or Cent OS distribution---it's a good idea to brush up on (or acquire) some very basic command-line skills and to install the server on your own machine as well, so you can replicate some of the strategies described below.  Just a little bit of knowledge of the innards---file permissions, etc.---pays off handsomely in being able to work with your sysadmin to diagnose and resolve quickly any problems that arise.  I myself run Ubuntu, but have not found significant differences between how the server works for me and how it works on campus.
 
 
## Establishing a "Common Source" Folder
 
Ask your sysadmin to grant superuser privileges t oyou and other course instructors.  Then one of you should create a folder in your Home directory on the server that will serve as a common source for course material.  The sysadmin can create a symbolic link to the folder and can set permissions so that all users may read files in the folder but only you and fellow instructors can write to it.  This folder serves as the repository for assignments, solutions, syllabi, etc.
 
If you are not the owner of the folder, you can get to it using the ellipses button in the upper right-hand corner of the Files pane.  Simply enter the path-name as specified by your sysadmin.  For one of our courses it is simply: `/mat111`.
 
From there you can navigate the directory structure in the Files pane, in the usual way.  To reset the Files pane view back to your Home directory, push the Ellipses button again and enter: `~`.
 
All of the foregoing will make sense to you once your have studied Unix-like directory structures.
 
## Automated Assignment Collection/Return
 
### Student Usernames
 
Once our elementary  students have acquired some proficiency with R, we introduce them to R Markdown and require them to turn in certain homework  and project assignments as R Markdown documents.  We write comments into a copy of the assignment and return it to the student.  One of the best arguments for teaching in the server environment is that this collection and return process can be automated.  Here's how we do it these days.
 
First of all, each instructor should create a text file consisting of the network usernames of student in his or her course (or section thereof), one username per line, and name it something like `students.txt`.
 
Save the file in your Home directory on the server.
 
### Encrypting Your Password
 
You are going to create some sub-directories in Home directories of your students, so for this you will need to act as a superuser.  This action will in turn require you to provide your password to the computer.  For security reasons, you don't want to send out the password every time you perform a superuser action, so you need to encrypt your password and provide a key in its place.  For this purpose our sysadmin has written the following Perl script:
 
``` perl
#!/usr/bin/perl -w
 
use strict;
use Crypt::RC4;
 
 
my($clearText,$passwordFile,$key);
 
foreach my $item(@ARGV) {
 
        if ($item =~ m/--password=/i) {
                $clearText = substr($item,11,length($item)-11);
        }
 
 
        if ($item =~ m/--file=/i) {
                $passwordFile = substr($item,7,length($item)-7);
        }
 
 
        if ($item =~ m/--key=/i) {
                $key = substr($item,6,length($item)-6);
        }
 
 
}
 
 
if (!$passwordFile || !$clearText || !$key) {
print "\n USAGE: perl createpasswordfile.pl --password=<domain password> --key=<password file key> --file=<secure password file>\n\n";
exit;
}
 
my($encryptedPassword) = RC4($key,$clearText);
 
my($OUTPUTFILE);
open ($OUTPUTFILE, ">$passwordFile") or die "Could not open $passwordFile\n";
print $OUTPUTFILE "$encryptedPassword";
close ($OUTPUTFILE);
 
system("chmod 400 $passwordFile");
 
print "\n\nPassword file $passwordFile written.\n";
```
 
The above script, and others to follow, are house in `/scripts`.  You will use it to create an encrypted version of your password that is stored in a new file in your Home directory.  To run the script, issue the following (suitably modified) command in R:
 

    system("perl /scripts/createpasswordfile.pl --password=<YourPassword> --key=<YourChosenKey> --file=</path/to/YourFavFileName.txt>")

 
After you run the script, clear your R History:  you don't want to leave your password hanging out in the open.
 
 
### Create Subdirectories
 
Here is the Perl script that we currently use to create `submit` and `returned` directories in the Home directory of each student in the class.  Obviously your sysadmin will modify it to suit the file structure of your server.
 
``` perl
#!/usr/bin/perl -w
 
use strict;
use constant TRUE => -1;
use constant FALSE => 0;
#************************ PARAMETERS *********************************************************
 
my($sourceRoot) = "/home/FAST";
my($group) = "admins";
my($userDirective) = "FAST\\\\";
my($permissions) = "770";
#*********************************************************************************************
 
 
#collect commandline arguments
 
 
 
sub showUsage {
 
print "\nUSAGE: perl createdirectories.pl --studentfile=<filename> [--source=<source path> (Alternate source path) --email=<email address> (Email for submission report) --group=<group name> (Security Group) --permissions=<nnn> (Default Directory Permissions)]\n\n";
exit;
 
}
 
 
my($studentfile,$sendEmail,$summaryLine,$recipientAddress);
$sendEmail = FALSE;
 
foreach my $item(@ARGV) {
 
 
        if ($item =~ m/--studentfile=/i) {
                $studentfile = substr($item,14,length($item)-14);
        }
 
        if ($item =~ m/--source=/i) {
                 $sourceRoot = substr($item,9,length($item)-9);
        }
 
        if ($item =~ m/--email=/i) {
                $sendEmail = TRUE;
                $recipientAddress = substr($item,8,length($item)-8);
        }
 
  if ($item =~ m/--group=/i) {
                $group = substr($item,8,length($item)-8);
        }
 
 	if ($item =~ m/--permissions=/i) {
                $permissions = substr($item,14,length($item)-14);
        }
 
}
 
 
 
if (!$studentfile) {
&showUsage;
}
 
 
$summaryLine = "\nDirectory Permission Updates:\n--------------------------\n\n";
 
my($INPUTFILE);
open ($INPUTFILE, "<$studentfile") or die "Could not open $studentfile\n";
 
while (<$INPUTFILE>) {
        
	$_ =~ s/\cM\cJ|\cM|\cJ/\n/g;  # Re-format Windows files
	my($inputLine) = $_;
        chomp ($inputLine);
 
	unless ($inputLine =~ /^\s*$/) {
 
 
		my($submitPath) = $sourceRoot . "/" . $inputLine . "/submit";
		my($returnPath) = $sourceRoot . "/" . $inputLine . "/returned";
		my($mynotesPath) = $sourceRoot . "/" . $inputLine ."/mynotes";
	
		unless (-e $submitPath) { 
			system ("mkdir $submitPath"); #or die "\nCould not create directory $submitPath.\n"; 
			$summaryLine = $summaryLine . "\nCreated submit path $submitPath for user $inputLine.\n";
		} else {
			$summaryLine = $summaryLine . "\nSubmit path $submitPath for user $inputLine already exists.\n";
		}
	
		unless (-e $returnPath) { 
			system ("mkdir $returnPath");  #or die "\nCould not create directory $returnPath.\n"; 
			$summaryLine = $summaryLine . "\nCreated return path $returnPath for user $inputLine.\n";
		} else {
			$summaryLine = $summaryLine . "\nReturn path $returnPath for user $inputLine already exists.\n";
		}
			
 		unless (-e $mynotesPath) {
                	system ("mkdir $mynotesPath");  #or die "\nCould not create directory $returnPath.\n";
                	$summaryLine = $summaryLine . "\nCreated mynotes path $mynotesPath for user $inputLine.\n";
        	} else {
                	$summaryLine = $summaryLine . "\nmynotes path $mynotesPath for user $inputLine already exists.\n";
        	}
 
 
		my($securityToken) = $userDirective . $inputLine . ":" . $group;
	
		system("chown $securityToken $submitPath");
		$summaryLine = $summaryLine . "\nChanged ownership of submit path $submitPath to $securityToken.\n";
        
		system("chown $securityToken $returnPath");
		$summaryLine = $summaryLine . "\nChanged ownership of return path $returnPath to $securityToken.\n";
 	
		system("chown $securityToken $mynotesPath");
        	$summaryLine = $summaryLine . "\nChanged ownership of mynotes path $mynotesPath to $securityToken.\n";
 
        
		system("chmod $permissions $submitPath");
		$summaryLine = $summaryLine . "\nChanged permissions of submit path $submitPath to $permissions.\n";
        
		system("chmod $permissions $returnPath");
 		$summaryLine = $summaryLine . "\nChanged permissions of return path $returnPath to $permissions.\n";
 
		system("chmod $permissions $mynotesPath");
        	$summaryLine = $summaryLine . "\nChanged permissions of mynotes path $mynotesPath to $permissions.\n";
 
 
	}
 
}
 
close ($INPUTFILE);
 
$summaryLine = $summaryLine . "\n";
 
print $summaryLine;
 
if ($sendEmail == TRUE) {
        print "\nSending summary email to $recipientAddress.\n";
        my ($emailSubject) = "Subject: RStudio directories updated";
        my ($sendmailObject) = "/usr/sbin/sendmail -F RStudio_Grades\@georgetowncollege.edu -t";
        my ($replyAddress) = "Reply-to: RStudio_Grades\@georgetowncollege.edu";
        my ($recipient) = "To: $recipientAddress";
        open (SENDMAIL, "|$sendmailObject") or die "Cannot open $sendmailObject: $!";
        print SENDMAIL $emailSubject;
        print SENDMAIL "\n";
        print SENDMAIL $recipient;
        print SENDMAIL "\n";
        print SENDMAIL $replyAddress;
        print SENDMAIL "\n";
        print SENDMAIL "Content-type: text/plain\n\n";
        print SENDMAIL "\n";
        print SENDMAIL $summaryLine;
        print SENDMAIL "\n";
        print SENDMAIL ".";
        close (SENDMAIL);
}
```
To run the script, issue the following R command, suitably modified:
 

    system("perl createdirectories.pl --studentfile=<StudentFileName>")

 
There are options to receive an email report confirming the creation of the directories, and to set permissions for them as well.  Currently we use the default settings.
 
### Collect Assignments
 
Students save an assignment into their `submit` directory, named according to some convention that you establish.  Specifics vary, but the name must end with an underscore followed by the student username.  For example:  `HW05_jdoe.Rmd` is the fifth homework assignment, submitted by the student with username `jdoe`.
 
The Perl script for collection of assignments is as follows:
 
``` perl
#!/usr/bin/perl -w
 
use strict;
use File::Find;
use constant TRUE => -1;
use constant FALSE => 0;
#************************ PARAMETERS *********************************************************
 
 
my($sourceRoot) = "/home/FAST";
 
#*********************************************************************************************
 
 
#collect commandline arguments
 
 
 
sub showUsage {
 
print "\nUSAGE: perl collecthomework.pl --instructor=<name> --assignment=<name> --studentfile=<filename> \n Optional Parameters:\n\n[--source=<source path> (Alternate source path)\n--destination=<destination path> (Alternate destination path)\n --remove (Remove homework files after copying them)\n --email=<email address> (Email for submission report)]\n\n";
exit;
 
}
 
 
my($instructor,$assignment,$studentfile,$destinationRoot,$sendEmail,$recipientAddress);
 
$sendEmail = FALSE;
 
foreach my $item(@ARGV) {
 
  if ($item =~ m/--instructor=/i) {
		$instructor = substr($item,13,length($item)-13);
	}
 
 
 	if ($item =~ m/--assignment=/i) {
                $assignment = substr($item,13,length($item)-13);
        }
 
 
	if ($item =~ m/--studentfile=/i) {
                $studentfile = substr($item,14,length($item)-14);
        }
 
 	if ($item =~ m/--source=/i) {
		 $sourceRoot = substr($item,9,length($item)-9);                
        }
 
	if ($item =~ m/--destination=/i) {
                 $destinationRoot = substr($item,14,length($item)-14);
        }
 
	if ($item =~ m/--email=/i) {
                $sendEmail = TRUE;
		$recipientAddress = substr($item,8,length($item)-8);
        }
 
 
 
}
 
 
if (!$instructor || !$assignment || !$studentfile) {
&showUsage;
}
 
 
if (!$destinationRoot) {
	$destinationRoot = "/home/FAST/" . $instructor . "/homework";
}
 
 
my($noSubmissionYet) = "\nThe following students have not submitted homework yet:\n------------------------------------------------------------";
my($summaryLine) = "\nHomework assignments retrieved for assignment $assignment:\n-------------------------------------";
 
 
my($INPUTFILE);
open ($INPUTFILE, "<$studentfile") or die "Could not open $studentfile\n";
 
while (<$INPUTFILE>) {
 
 	$_ =~ s/\cM\cJ|\cM|\cJ/\n/g;  # Re-format Windows files
        my($inputLine) = $_;
        chomp ($inputLine);
 
        unless ($inputLine =~ /^\s*$/) {
 
 
 
 
 
        my(@searchFolders) = ($sourceRoot . "/" . $inputLine . "/submit");
	my(@foundProjects);
 
        find( sub { push @foundProjects, $File::Find::name if /$assignment/i }, @searchFolders);
 
	
        my($projectFile);
 
        foreach $projectFile(@foundProjects) {
 
		print "\nFound $projectFile.";
 
                my ($destinationFolder) = $destinationRoot . "/" . $assignment . "/" . $inputLine;
                unless (-e $destinationFolder) {
                        system ("mkdir -p $destinationFolder");
                }
 
                $destinationFolder = $destinationFolder . "/";
                system ("cp -f $projectFile $destinationFolder");
		$summaryLine = $summaryLine . "\n $inputLine submitted file: $projectFile";		
 
	}
 
	if (!@foundProjects) {
		$noSubmissionYet = $noSubmissionYet . "\n$inputLine";
	}
 
 
	}
 
}
 
close ($INPUTFILE);
 
$summaryLine = $summaryLine . "\n\n" . $noSubmissionYet . "\n\n";
 
print $summaryLine;
 
if ($sendEmail == TRUE) {
	print "\nSending summary email to $recipientAddress.\n";
	my ($emailSubject) = "Subject: RStudio projects submitted for assignment $assignment";
	my ($sendmailObject) = "/usr/sbin/sendmail -F RStudio_Grades\@georgetowncollege.edu -t";
	my ($replyAddress) = "Reply-to: RStudio_Grades\@georgetowncollege.edu";
	my ($recipient) = "To: $recipientAddress";
	open (SENDMAIL, "|$sendmailObject") or die "Cannot open $sendmailObject: $!";
	print SENDMAIL $emailSubject;
	print SENDMAIL "\n";
	print SENDMAIL $recipient;
	print SENDMAIL "\n";
	print SENDMAIL $replyAddress;
	print SENDMAIL "\n";
	print SENDMAIL "Content-type: text/plain\n\n";
	print SENDMAIL "\n";
	print SENDMAIL $summaryLine;
	print SENDMAIL "\n";
	print SENDMAIL ".";
	close (SENDMAIL);
 
 
}
```
To run the script issue a command like the following:
 

    system("perl /scripts/collecthomework.pl --instructor=<yourUsername> --assignment=<assignCode> --studentfile=students.txt")

 
 
If you would like to receive an email with a list of all students from whom you got an assignment, run this instead:
 

    system("perl /scripts/collecthomework.pl --instructor=<yourUsername> --assignment=<assignCode> --studentfile=students.txt --email=<yourEmailAddress>")

 
You can run the collection script as often as you like:  it will pick up newly-submitted assignments but will not overwrite assignments collected from other students in a previous run.
 
 
### Return Assignments
 
All of the assignments you collect appear in a `homework` folder in your Home directory, in sub-directories by assignment name and sub-sub-directories by student username.  Navigate to the assignments one by one.  For each assignment, open the R Markdown file and save it with an additional tag in the file name that will mark it out as the graded/commented copy to be returned to the student.  We use `_com` as our tag, creating files like this:  `HW05_jdoe_com.Rmd`.
 
For returning assignments, we have the following Perl script:
 
``` perl
#!/usr/bin/perl -w
 
use strict;
use File::Find;
use Crypt::RC4;
use constant TRUE => -1;
use constant FALSE => 0;
#************************ PARAMETERS *********************************************************
 
 
my($sourceRoot) = "/home/FAST/";
my($group) = "admins";
my($userDirective) = "FAST\\\\";
my($permissions) = "770";
 
#*********************************************************************************************
 
 
#collect commandline arguments
 
 
 
sub showUsage {
 
print "\nUSAGE: perl returnhomework.pl --path=<name> --flag=<name> --studentfile=<filename> \n Optional Parameters:\n\n[--email=<email address> (Email for submission report) --key=<password file key> --passwordfile=<password file>]\n\n";
exit;
 
}
 
 
my($path,$flag,$studentfile,$destinationRoot,$sendEmail,$recipientAddress,$key,$passwordFile,$decryptedPassword);
 
$sendEmail = FALSE;
 
 
foreach my $item(@ARGV) {
 
 
 
   if ($item =~ m/--flag=/i) {
                $flag = substr($item,7,length($item)-7);
        }
 
 
	if ($item =~ m/--studentfile=/i) {
                $studentfile = substr($item,14,length($item)-14);
        }
 
 	if ($item =~ m/--path=/i) {
		 $path = substr($item,7,length($item)-7);                
        }
 
	if ($item =~ m/--destination=/i) {
                 $destinationRoot = substr($item,14,length($item)-14);
        }
 
	if ($item =~ m/--email=/i) {
                $sendEmail = TRUE;
		$recipientAddress = substr($item,8,length($item)-8);
        }
 
 
	if ($item =~ m/--key=/i) {
                $key = substr($item,6,length($item)-6);
        }
 
	if ($item =~ m/--passwordfile=/i) {
                $passwordFile = substr($item,15,length($item)-15);
        }
 
 
 
 
}
 
 
if ($passwordFile) {
 
	my($INPUTFILE);
	open ($INPUTFILE, "<$passwordFile") or die "Could not open $passwordFile\n";
 
	while (<$INPUTFILE>) {
        	my($inputLine) = $_;
        	chomp ($inputLine);
 
		$decryptedPassword = RC4($key,$inputLine);
	}
	
}
 
 
if (!$path || !$flag || !$studentfile) {
&showUsage;
}
 
 
unless ( $path =~ s|/\s*$|/| ) 
{
    $path = $path . "/";
}
 
 
if (!$destinationRoot) {
	$destinationRoot = "/home/FAST/";
}
 
my($summaryLine) = "\nHomework graded in folder $path:\n-------------------------------------";
 
 
my($INPUTFILE);
open ($INPUTFILE, "<$studentfile") or die "Could not open $studentfile\n";
 
while (<$INPUTFILE>) {
 
 	$_ =~ s/\cM\cJ|\cM|\cJ/\n/g;  # Re-format Windows files
        my($inputLine) = $_;
        chomp ($inputLine);
 
        unless ($inputLine =~ /^\s*$/) {
 
 
 
        my(@searchFolders) = ($path .  $inputLine);
	my(@foundProjects);
 
        find( sub { push @foundProjects, $File::Find::name if /$flag/i }, @searchFolders);
 
	
        my($projectFile);
 
        foreach $projectFile(@foundProjects) {
 
		print "\nFound $projectFile.";
 
                my ($destinationFolder) = $destinationRoot . $inputLine . "/returned";
                unless (-e $destinationFolder) {
                        system ("mkdir -p $destinationFolder");
                }
 
                $destinationFolder = $destinationFolder . "/";
 
 		my($securityToken) = $userDirective . $inputLine . ":" . $group;
        	
                system ("cp -f $projectFile $destinationFolder");
		
		my($folderWildcard) = $destinationFolder . "*";
	
 
		if ($passwordFile) {
                	system("echo $decryptedPassword | sudo chown $securityToken $folderWildcard");
                	system ("echo $decryptedPassword | sudo chmod 770 $folderWildcard");
		} else {
			system("chown $securityToken $folderWildcard");
                	system("chmod 770 $folderWildcard");
		}
 
		
		$summaryLine = $summaryLine . "\n $inputLine returned $projectFile to $destinationFolder\n";		
 
 
	}
 
 
	}
 
}
 
close ($INPUTFILE);
 
$summaryLine = $summaryLine . "\n";
 
print $summaryLine;
 
if ($sendEmail == TRUE) {
	print "\nSending summary email to $recipientAddress.\n";
	my ($emailSubject) = "Subject: RStudio projects graded and returned.";
	my ($sendmailObject) = "/usr/sbin/sendmail -F RStudio_Grades\@georgetowncollege.edu -t";
	my ($replyAddress) = "Reply-to: RStudio_Grades\@georgetowncollege.edu";
	my ($recipient) = "To: $recipientAddress";
	open (SENDMAIL, "|$sendmailObject") or die "Cannot open $sendmailObject: $!";
	print SENDMAIL $emailSubject;
	print SENDMAIL "\n";
	print SENDMAIL $recipient;
	print SENDMAIL "\n";
	print SENDMAIL $replyAddress;
	print SENDMAIL "\n";
	print SENDMAIL "Content-type: text/plain\n\n";
	print SENDMAIL "\n";
	print SENDMAIL $summaryLine;
	print SENDMAIL "\n";
	print SENDMAIL ".";
	close (SENDMAIL);
 
 
}
```
 
To run the script, you need the key for your encrypted password.  Run a command like the following:
 

    system("perl /scripts/returnhomework.pl --path=/path/to/yourUsername/homework/HW05/ --flag=_com --studentfile=/usr/local/sbin/YourUsername-YourCourse.txt --key=YourChosenKey --passwordfile=password_file_YourUsername.txt")

 
Note that the sysadmin has established, for each instructor, a file in `/usr/local/sbin` of student usernames for the instructor's course.  As students drop your course and you edit your local student file accordingly, the two files may fall out of sync, but the return script will still work correctly for students still enrolled in the course.
 
 
## Bumps on the Road
 
All in all, the server environment has proven to be quite useful for our courses.  Nevertheless, there are a few complications and potential problems to keep in mind.
 
* Students can read from the Common Source, directory, but cannot write to it.  If a student wishes to perform an "knitting" type of action to a file in the Common Source directory---e.g., knitting an R Markdown to HTML or previewing an R Presentation document---then she must save a copy into her Home directory and perform the knitting operations upon it.  The same often goes for other instructors (default file permissions are still a bit unclear to us).
* [Shiny apps](https://www.rstudio.com/shiny/) are wonderful.  We put them into the [ancillary package](https://github.com/homerhanumat/tigerstats) that we use for our own elementary course, so that R users can run them locally once the package is installed, or run them locally after downloading them from the package's Git Hub repository.  However, at many institutions the firewalls don't permit execution of the Shiny scripts.  If this is the case at your own institution and you want your students to work with Shiny apps, then you must either install and configure the Shiny server or deploy the apps yourself on a site hosted by RStudio, e.g., [http://shinyapps.io/](http://shinyapps.io/).  We have experimented with both venues and are pleased with the results.
* A small percentage of users eventually experience mysterious problems---e.g., loss of ability to knit an R markdown document more than once in a single server session---that we have not been able to diagnose and resolve completely.  If the problem becomes sufficiently severe, a student could always use the desktop version, but this in itself creates a course management problem.  Larger institutions than ours may wish to consider paying for the Enterprise version of the RStudio server, and the support that accompanies it.
 
## Props to the Sysadmin
 
We are grateful for the work of Scott Switzer, who serves as Server System Manager in the Office of Information Technology Services at Georgetown College.  Scott manages the RStudio server and the College's Shiny server, created the Perl scripts in this post, helped establish other website support for our elementary statistics course, and at an early stage played the role of informal command-line guru to the the author of this post.  If you have the good fortune to work with a such a sysadmin your own institution, make sure that she gets lots of love and special ice cream!
 
