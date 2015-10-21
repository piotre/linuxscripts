#!/usr/bin/perl -w


for ($p=30;$p>1;$p--)
    {
    print "webalizer -pc /usr/share/admin/webalizer/etc/apprendre-a-lire.com.conf /var/log/apache/apprendre-a-lire.com.log.".$p.".gz\n";
    system "webalizer -pc /usr/share/admin/webalizer/etc/apprendre-a-lire.com.conf /var/log/apache/apprendre-a-lire.com.log.".$p.".gz";
    sleep(1);
    }
exit;

