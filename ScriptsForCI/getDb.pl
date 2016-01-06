use LWP::UserAgent;

$user_agent = new LWP::UserAgent;

$request = new HTTP::Request('GET', 'http://artifactory.jda.com/artifactory/simple/INV/com/redprairie/dcs/dcs-db-sql-win64/dcs-release-8.2-bootstrapped-build-SNAPSHOT/');

$response = $user_agent->request($request);

$text = $response->{_content};
#print $text;

while($text=~/href="([^"]*\.zip)"/ig)
{
	$lstDbFile = $1;
}

print "Got latest db file:", $lstDbFile,"\n" ;

print "Downloading it...";

my $browser = LWP::UserAgent->new();
my $content = $browser->get($lstDbFile)->content();

open(TMPFP, ">D:\\dbbackup\\8.2Fitness\\fit-82.zip") || die "cannot open file $!";
binmode(TMPFP);
print TMPFP $content;

close(TMPFP);

#unzip the zip file
system("unzip -o D:\\dbbackup\\8.2Fitness\\fit-82.zip -d D:\\dbbackup\\8.2Fitness") == 0 or die "system failed: $?"
