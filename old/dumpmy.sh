#!/bin/sh
MY_VERSION="1.6"

# Location of the configuration file for this firewall:
#######################################################
CONFIG_FILE=/etc/ows/owsbackup.conf

# Working backup directory
##########################
B_DIR="/var/backup/"

# Binaries
##########
TAR="$(which tar)"
GZIP="$(which gzip)"
FTP="$(which ftp)"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
RM="$(which rm)"
LOGGER="$(which logger)"
MAIL="$(which exim4)"

# Check if config file exists and if so load it
###############################################
if [ -e "$CONFIG_FILE" ]; then
  source $CONFIG_FILE
else
  echo -e "\033[40m\033[1;31mERROR: Could not read configuration file $CONFIG_FILE!\033[0m"
  echo "Please, check the file's location and (root) rights."
  exit 2
fi

# Clean backup folder before working
####################################
$RM -f $B_DIR/*.sql
$RM -f $B_DIR/dpl

# Backup liste des paquets
##########################
dpkg -l > $B_DIR/dpl
$TAR -cqzf $B_DIR/dpl.tgz $B_DIR/dpl
$TAR -cqzf $B_DIR/lib_dpkg.tgz /var/lib/dpkg
$TAR -cqzf $B_DIR/vmlinuz.tgz /vmlinuz
# Backup etc
############
$TAR -cqzf $B_DIR/etc.tgz /etc

## OLD BACKUP PROCEDURE
# backup mysql
#mysql -uroot -p$P_MYSQL < /var/backup/databases.sql.list | grep -v Database > /var/backup/databases.txt
#for db in $(cat < /var/backup/databases.txt)
#do
##echo dumpin $db
##gestion version mysql
##mysqldump --log-error=/var/backup/error_dump_mysql.log $db -uroot -p$P_MYSQL $OPT_MYSQL > /var/backup/$db.sql
#mysqldump  $db -uroot -p$P_MYSQL $OPT_MYSQL > /var/backup/$db.sql
#if [ "$?" == "1" ] ; then
#	logger -t "[OWSBACKUP]" Warning: $db has not been dumped correctly. Please dump it manualy !
#  SUJET="[OWSBACKUP] Warning: $db has not been dumped correctly on `hostname`"
#  DEST="adminserveur@ows.fr"
#	MSG="OWSBACKUP dump reported some errors while backuping $db. Please check it out."
#	mail -s "$SUJET" "DEST" < $MSG
#fi
#done
##tar
#for db in `ls /var/backup/*.sql`
#do
#	tar -cvvzf $db.tgz $db
#	rm -rf $db
#done

#chmod 600 /var/backup/*.sql.tgz

## NEW PROCEDURE
# We wanna dump all mysql databases
# then create 1 folder per datase
# then create 1 file per table
# the compress it in .tar.gz
###################################
# Binarys !

# Start !
# Liste databases
DB_LISTE="$($MYSQL -uroot -p$P_MYSQL -Bse 'show databases')"

# Process the dump/gz and folder creation process
for db in $DB_LISTE
do
	# Create each folders
	mkdir $B_DIR/sql/$db
	for table in `echo "show tables" | $MYSQL -uroot -p$P_MYSQL $db|grep -v Tables_in_`;
	do
		FILE=$B_DIR/sql/$db/$table.sql
		# Create each files 
		echo $tables; $MYSQLDUMP --add-drop-table --allow-keywords -q -c -u root -p$P_MYSQL $db $table > $FILE
		# Check if something went wrong (meh ?)
		if [ "$?" != "0" ] ; then
			# If something wrong sends a Syslog Alert and an email to the sysadmin
			$LOGGER -t "[OWSBACKUP]" Warning: $table in $db has not been dumped correctly. Please Verify !
			SUJET="[OWSBACKUP] Warning: $table in $db has not been dumped correctly on `hostname`"
			DEST="adminserveur@ows.fr"
			MSG="Subject: $SUJET \
			OWSBACKUP dump reported some errors while backuping $table in $db. Please check it out."
			echo $MSG | $MAIL -f `hostname`-server@ows.fr "$DEST"
		fi
	done
done

# Now we create 1 big tar.gz of everything
#FILENAME=$B_DIR/mysqlbackup-`hostname`.tar.gz
#TOCOMPRESS=$B_DIR/sql/
#$TAR -zcvf $FILENAME $TOCOMPRESS
##mv $FILENAME $B_DIR
# Clean working folder
#rm -Rf $B_DIR/sql/*
#chmod 600 $B_DIR/*.tar.gz
chmod 600 $B_DIR/*
exit 0
#######
# END #
#######


#TODO revoir le test pour les mysqldump
# if test -s /var/backup/alldbmy.sql.tgz  && test $? -eq 0 ; then
# 	echo ok
# else
#     touch /var/backup/alldbmy.sql.tgz
# 	chmod 600 /var/backup/alldbmy.sql.tgz
# 	hostname1=`hostname`
#     corpsmess=`host $hostname1`
#     subject="Pb mysqldump $hostname1 $corpsmess"
#     echo $subject | mail -s " $subject " adminserver@ows.fr
# fi

