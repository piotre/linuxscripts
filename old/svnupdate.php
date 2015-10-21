<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> - SVN control</title>
<style>
p,a,h1,h2,h3,h4 {
        color: #422;
        font-family: verdana, serif;
        font-size: 0.9em;
}
a {
        color: #448;
        text-decoration: none;
}
a:hover {
        color: #aaa;
        text-decoration: underline;
}
</style>
</head>
<body>
<h1>Local SVN Repository Controller</h1>
<p> Action : <a href="?a=infos">[ View infos ]</a> - <a href="?a=logs">[ View logs ]</a> - <a href="?a=update">[ Update from external SVN ]</a> </p>

<p>
<?php

$svn_dir_path = $_SERVER["DOCUMENT_ROOT"];
$svnuser="julien";
$svnpassword="*******";
#####  attention : $svn_dir_path.'/svn_log_result.log'; doit etre accessible en ecriture

if (isset($_GET['a']))
{

	if ($_GET['a'] == 'logs') {
			$tempfile = $svn_dir_path.'/svn_log_result.log';
			$ret = shell_exec("sudo /usr/bin/svn log --no-auth-cache --username=".$svnuser." --password=".$svnpassword." --limit 120 $svn_dir_path > $tempfile");
			$retour = file_get_contents($tempfile);
			$retour = str_replace("\n\n---", "\n", $retour);
			$retour = nl2br($retour);
			echo $retour;
	} 
	elseif ($_GET['a'] == 'infos') {
			$retour = shell_exec("sudo /usr/bin/svn --no-auth-cache info $svn_dir_path");
			$retour = nl2br($retour);
			echo $retour;
	} 
	elseif ($_GET['a'] == 'update') {
      $retour = shell_exec("LANG=fr_FR.UTF-8 && sudo /usr/bin/svn --no-auth-cache --username=".$svnuser." --password=".$svnpassword." update ".$svn_dir_path);
    	echo "<p>".nl2br($retour)."</p>";
			
			if ($retour) echo "<p>SVN updated</p>";
			else echo "pas d'update à faire a priori, ou erreur svn update, probleme de droits ou de certificat ssl";
	}
}
?>

</body>
</html>


