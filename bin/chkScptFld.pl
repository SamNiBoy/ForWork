
#Get the branch we are at.
$brh = `git status | grep "On branch"`;

#Remove anything before '/';
$brh =~ s/.*\///;

#Remove end '\n';
$brh =~ s/\n//;

print "Checking script folder for branch ", $brh;

if ($brh =~ /^\d\.\d/)
{
    print "\nBranch is JDA style version...\n";
    
    #Get tag like "8.2.1.0"
    $tag = $brh."\.[0-9]\.[0-9]\$";

    @res = `git tag | grep $tag | sort -r`;

    $lstTag = $res[0];

    print "Latest tag is:", $lstTag;
    
    $fldPtn =$brh;
    
    #fldPth will be like "8\.2\.1\.0";
    $fldPtn =~ s/\./\\\./;
   
    @fldlst = `ls -l | awk '{print \$9}' | grep \"\^$fldPtn\" | sort -r`;
    
    $lstFld = $fldlst[0];
    
    $lstFld =~ s/.*?([^ ]+$)/\1/;
    
    print "Laster created folder is: ", $lstFld;
    
    if ($lstTag =~/$lstFld/)
    {
    	print "Last folder matches with lastest tag, put script into the last folder: ", $lstFld;
    }
    else
    {
    	print "Last folder does not match with lastest tag, need new folder for script: ", $lstTag;
    }

}
elsif($brh =~ /\d{4}\.\d/)
{
	   print "\nBranch is RedPrairie style version...\n";
	   
	  #Get tag like "2012.2.4"
    $tag = $brh."\.[0-9]\$";

    @res = `git tag | grep $tag | sort -r`;

    $lstTag = $res[0];

    print "Latest tag is:", $lstTag;
    
    $fldPtn =$brh;
    
    #fldPth will be like "2012\.2"
    $fldPtn =~ s/\./\\\./;
   
    @fldlst = `ls -l | awk '{print \$9}' | grep \"\^$fldPtn\" | sort -r`;
    
    $lstFld = $fldlst[0];
    
    $lstFld =~ s/.*?([^ ]+$)/\1/;
    
    print "Laster created folder is: ", $lstFld;
    
    if ($lstTag =~/$lstFld/)
    {
    	print "Last folder matches with lastest tag, put script into the last folder: ", $lstFld;
    }
    else
    {
    	print "Last folder does not match with lastest tag, need new folder for script: ", $lstTag;
    }
}
