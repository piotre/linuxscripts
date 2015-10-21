#!/usr/bin/perl

# $chaine="perl -pi -e 's/width=\\\\\"176\\\\\"/width=\\\\\"153\\\\\"/gi'";
$chaine1="perl -pi -e 's/<p align=\\\\\"center\\\\\"><font face=\\\\\"Arial\\\\\" color=\\\\\"#FFFF80\\\\\"><font size=\\\\\"3\\\\\"><strong>-(.*)-<\\\/strong><\\\/font><big> <\\\/big><\\\/font>/<b class=titren><img src=\\\\\"\\\"\.\\\$path\.\\\"images\\\/puce\.gif\\\\\" border=0 align=absmiddle>\$1<img src=\\\\\"\\\"\.\\\$path\.\\\"images\\\/puce\.gif\\\\\" border=0 align=absmiddle><\\\/b>/gi'";
$chaine2="perl -pi -e 's/<font face=\\\\\"Arial\\\\\" color=\\\\\"#FFFF80\\\\\"><font size=\\\\\"3\\\\\"><strong>-(.*)-<\\\/strong><\\\/font><big> <\\\/big><\\\/font>/<b class=titren><img src=\\\\\"\\\"\.\\\$path\.\\\"images\\\/puce\.gif\\\\\" border=0 align=absmiddle>\$1<img src=\\\\\"\\\"\.\\\$path\.\\\"images\\\/puce\.gif\\\\\" border=0 align=absmiddle><\\\/b>/gi'";
print $chaine1."\n";

system $chaine1." adherents/rechercheconsu.php";
system $chaine2." adherents/rechercheconsu.php";
# system $chaine1." * biens/* utilisateurs/* adherents/* proprietaires/* annonces/*";
