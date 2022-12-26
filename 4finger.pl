use strict;
use URI::Escape;
use HTTP::Cookies;
use LWP::UserAgent;
my $ua=LWP::UserAgent->new;
$ua->agent("user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36");
my $request=HTTP::Request->new("GET"=>'http://www.4fingers.com.my/Outlets-4FINGERS');
$request->header("Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9");
$request->header("Accept-Language"=>"en-GB,en-US;q=0.9,en;q=0.8");
$request->header("Host"=>"www.4fingers.com.my");
$request->header("Connection"=>"keep-alive");
my $res=$ua->request($request);
my $code=$res->code;
my $code1=$res->status_line;
print"\nStatus_code::$code1 :: $code\n";
if($code==200)
{
	my $content=$res->content();
	open(FF,">content1.html");
	print FF $content;
	close FF;	
	while($content=~m/(<div class=[^>]*?>\s*[^>]*?\s*<span\s*class=[^>]*?>\s*[\w\W]*?\s*<\/div>\s*<\/div>\s*<\/div>\s*<\/div>)/igs)
	{
		my $blk=$1;
		if($blk=~m/<div class=[^>]*?>\s*([^>]*?)\s*<span class=[^>]*?>\s*/is)
			{
				$name=$1;
				print"name:::$name\n";
			}
		if($blk=~m/<p class="[^>]*?">([^>]*?)\s*<\/p>\s*<p class="[^>]*?">([^>]*?)\s*<\/p>\s*<p class="[^>]*?">([^>]*?)\s*<\/p>\s*<br \/>/is)
			{
                $address=$1;
                print"ADDRESS1:::$address\n";
				$address=$2;
                print"ADDRESS2:::$address\n";
				$address=$3;
                print"ADDRESS3:::$address\n";
			 }

		if($blk=~m/<p\s*class\=\"address\">Telephone\:<\/p>\s*<\/div>\s*<div\s*class\=\"col-sm-6 no-padding\"\s*style\=\"text-align\:\s*left\;\s*margin-left\:\s*3%;\">\s*<p\s*class\=\"address\">\s*([^>]*?)\s*<\/p>/is)
			{
				$telephone=$1;
				print"TELEPHONE:::$telephone\n";
			}	
			open(FF,">>4finger.txt");
            print FF "$disname,\t$name,\t$address,\t$operatinghours,\t$telephone\n";
            close FF;
	}
}
             