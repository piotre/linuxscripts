#!/usr/bin/perl -w
	
local @list;
$Dir="/usr/share/admin/webalizer/etc/";
$cmd = "find $Dir -type f";
open(LISTFILE, "$cmd|");
@list = <LISTFILE>;
close(LISTFILE);
foreach $file (@list) 
	{
 	chomp($file);
	$site=$file;
	$site=~ s/^.*\/(.*)\.conf/$1/;
# 	print $file;
	print $site."\n";
	for ($p=39;$p>0;$p--)
		{
		print "webalizer -pc ".$file." /var/log/apache/".$site.".log.".$p.".gz\n";
		system "webalizer -pc ".$file." /var/log/apache/".$site.".log.".$p.".gz";
		sleep(1);
		}
	}
# $file="/usr/share/admin/webalizer/etc/bordas-vento.fr.conf";
# $site="bordas-vento.fr";
exit;

