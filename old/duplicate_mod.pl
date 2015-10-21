#!/usr/bin/perl
if (!$ARGV[1])
{
		print "'duplicate_mod.pl' - duplique un module drupal + renommage du module\n";
    print "Usage : duplicate_mod.pl NOM_MODULE_A_DUPLIQUER NUM_NOUVEAU_MODULE\n";
    print "Ex : /home/piotre/allscripts/duplicate_mod.pl /home/dev/oditfrance/oditfrance/sites/all/modules/owsbloc /home/dev/oditfrance/oditfrance/sites/all/modules/owslib\n";
    print "OU : cd /home/dev/oditfrance/oditfrance/sites/all/modules/ && /home/piotre/allscripts/duplicate_mod.pl owsbloc owslib\n";
    exit;
}

#script pour les repertoires CVS recursivement

$reptoduplicate = shift(@ARGV);
# $ARGV[0];
foreach $reptocreate (@ARGV)
    {
     if (-d $reptocreate)
         {
         print "Le module $reptocreate existe \n";
         }
     elsif (!-d $reptoduplicate)
         {
         print "Le module $reptoduplicate n existe pas\n";
         }
     else
         {
		print "copie du  module $reptoduplicate vers $reptocreate\n";
        system ("cp -Rp $reptoduplicate ".$reptocreate);
 		system ("mv ".$reptocreate."/".$reptoduplicate.".info ".$reptocreate."/".$reptocreate.".info");
 		system ("mv ".$reptocreate."/".$reptoduplicate.".module ".$reptocreate."/".$reptocreate.".module");
 		system ("mv ".$reptocreate."/".$reptoduplicate.".install ".$reptocreate."/".$reptocreate.".install");
 		system ("mv ".$reptocreate."/".$reptoduplicate.".admin.inc ".$reptocreate."/".$reptocreate.".admin.inc");
		$maj_reptocreate=ucfirst($reptocreate);
		$maj_reptoduplicate=ucfirst($reptoduplicate);
		
		print $maj_reptocreate." $reptocreate\n";
 		system ("perl -pi -e 's/$maj_reptoduplicate/$maj_reptocreate/g' ".$reptocreate."/*");
 		system ("perl -pi -e 's/$reptoduplicate/$reptocreate/g' ".$reptocreate."/*");
         }
	}
