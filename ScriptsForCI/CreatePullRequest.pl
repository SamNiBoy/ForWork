#call this command with parameter 'commitID WMD-xxxx target_branch1 target_branch2 -T"pull request title" @ReviewerID
#CreatePullRequest.pl 222116c WMD-12345 release/8.2 release/9.1 -T"Your Pull Request Title" @n1015874
#by Sam Ni 2016/03/01

sub printHelp() {
	print "\nAuto create pull request script help:\n";
	print "1. Make sure run the script in the root directory of repository, like 'WMD'\n";
	print "2. Invoke it as 'perl createpullrequest.pl commitID JiraID target_branch1 target_branch2 -T\"pull request title\" \@ReviewerID \n";
	print "3. For example 'perl createpullrequest.pl 222116c WMD-12345 release/8.2 release/9.1 -T\"Fixed a core dump issue for allocation\" \@n1015874 \n";
}

if ($#ARGV < 4) {
	print "At least 5 parameters are required.\n";
	printHelp();
	exit(0);
}

#parse parameters:
foreach $argidx(0 .. $#ARGV) {

	if ($argidx == 0) {
		$commitID = $ARGV[$argidx];
	}
	elsif ($argidx == 1) {
		$jira = $ARGV[$argidx];
	}
	elsif ($ARGV[$argidx]=~/^-T/ig) {
		$title = $ARGV[$argidx];
	}
	elsif($ARGV[$argidx]=~/^@/ig) {
		$reviewer = $ARGV[$argidx];
	}
	else {
		@target_branch = (@target_branch, $ARGV[$argidx]);
	}
}

#validate parameters:
if ($title eq '') {
	print "You need to provide a title for your pull request!\n";
	printHelp();
	exit(0);
}
elsif ($reviewer eq '') {
	print "You need to provide a reviewer for your pull request!\n";
	printHelp();
	exit(0);
}
elsif (@target_branch == 0) {
	print "At least one target branch is required!\n";
	printHelp();
	exit(0);
}


#print parameters:
print "\nCommit: ", $commitID;
print "\nJira: ", $jira;
print "\nTitle: ", substr($title, 2);
print "\nReviewer: ", substr($reviewer, 1);

$idx = 0;
while($idx < @target_branch) {
		print "\nTarget branch:$target_branch[$idx]";
	  $idx++;
}

#Now creating pull request for each target branch:
$idx = 0;
$repush_mode = 0;
$ori_title = $title;
@brhs = ();
@pulreqs = ();
while($idx < @target_branch) {

	  print "\n\n\nNow handling target branch: $target_branch[$idx]\n";
	  
		print "\nStep 1. Checking out branch:$target_branch[$idx]...\n";
	if (system("git checkout -f $target_branch[$idx]") == 0) {
    	print "\nChecked out branch:$target_branch[$idx] successe.\n";
	    	
    	#We only pull one time when it's first time.
    	if ($idx == 0) {
    	    print "\nStep 2. Pull remote $target_branch[$idx]...\n";
    	    if (system("git reset --hard HEAD^") == 0 &&
    	        system("git merge") == 0) {
    	        print "\nPulled branch:$target_branch[$idx] successe.\n";
    	    }
    	    else {
    	    	 die "\nCan not pull for:$target_branch[$idx], exit...\n";
    	    }
        }
        else {
          print "\nStep 2. Merge $target_branch[$idx]...\n";
    	    if (system("git reset --hard HEAD^") == 0 &&
    	        system("git merge") == 0) {
    	        print "\nMerged branch:$target_branch[$idx] successe.\n";
    	    }
	        else {
		          die "\nCan not merge for:$target_branch[$idx], exit...\n";
	        }
        }

        print "\nStep 3. Cherry pick commit $commitID to $target_branch[$idx]...\n";
        if (system("git cherry-pick $commitID") == 0) {
            print "\nCherry picked commit $commitID to branch:$target_branch[$idx] successe.\n";
        }
        else {
              print "\nCherry picked commit $commitID to branch:$target_branch[$idx] failed, continue...\n";
              $idx++;
              continue;
        }

        #Get the name of remote new branch, for exmaple if target branch is 'release/8.2' then the name will be 'WMD-xxxx_8.2'.
        $sufix = rindex($target_branch[$idx], "\/");
        if ($sufix >= 0) {
            $sufix_name = substr($target_branch[$idx], $sufix + 1);
        }
        else {
            $sufix_name = $target_branch[$idx];
        }
        $remote_branch_name = "fix/$jira\_$sufix_name";

        print "\nStep 4. push to remote with new branch '$remote_branch_name'...\n";

        if (system("git push origin HEAD:$remote_branch_name") == 0) {
            print "\nPushed new remote branch '$remote_branch_name' success...\n";
        }
        else {
            print "\nPushed new remote branch '$remote_branch_name' failed, try removing remote branch...\n";

            if (system("git push origin :$remote_branch_name") == 0) {

                $repush_mode = 1;
                print "\n removed remote branch '$remote_branch_name' success, try recreating remote branch...\n";

                if (system("git push origin HEAD:$remote_branch_name") == 0) {
                    print "\nPushed new remote branch '$remote_branch_name' success...\n";
                }
                else {
                    print "\nPush remote new branch '$remote_branch_name' failed, continue...\n";
                    $idx++;
                    continue;
                }
            }
            else {
                print "\nPush remote new branch '$remote_branch_name' failed, continue...\n";
                $idx++;
                continue;
            }
        }

        if ($repush_mode == 0) {
            #Add ", jiraID and branch sufix for title msg.
            $title = "-T\"$jira\_$sufix_name ".substr($ori_title, 2)."\"";
            
            print "\nStep 5. Creating pull request from '$remote_branch_name' to '$target_branch[$idx]'.\n";

            $cmd = "stash pull-request origin/$remote_branch_name origin/$target_branch[$idx] $title $reviewer";
            if ($pulreq = `$cmd`) {
                print "\nCreated pull request from $remote_branch_name to $target_branch[$idx] successe.\n";
                @brhs = (@brhs, $sufix_name);
                @pulreqs = (@pulreqs, $pulreq);
            }
            else {
                  print "\nCreated pull request from $remote_branch_name to $target_branch[$idx] failed, continue.\n";
            }
        }
        else {
            print "\nStep 5. repush target branch mode, skip creating pull request from '$remote_branch_name' to '$target_branch[$idx]'.\n";
        }
	}
	else {
		print "\nCan not check out $target_branch[$idx], continue...\n";
	}
    $idx++;
}

$pulcnt = @pulreqs;
print "Step 6. Total $pulcnt pull requests created:\n";

foreach $bidx (0 .. $#brhs)
{
    print "$brhs[$bidx]:$pulreqs[$bidx]";
}

$cmd = "git show $commitID | grep +++";
if ($filelst=`$cmd`)
{
     print "$filelst";
}
