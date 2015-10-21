#!/usr/bin/perl
#script pour les repertoires .svn recursivement

$Dir = $ARGV[0];

sub delsvn
    {
    local @list;
    $Dir=$_[0];
    if ($Dir eq "")
        {
        exit;
        }
    $cmd = "find $Dir -type d";
    open(LISTFILE, "$cmd|");
    @list = <LISTFILE>;
    close(LISTFILE);
    foreach $file (@list)
        {
        chomp($file);
        if ($file=~ /^.*\/.svn$/)
            {
            system ("rm -rf $file");
            print "rm -rf ".$file."\n";
            }
        else
            {
            if ($Dir ne $file)
                {
                print "delsvn(".$file.")\n";
                delsvn($file);
                }
            }
        }
    }

delsvn($Dir);

