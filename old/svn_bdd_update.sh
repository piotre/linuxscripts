#!/bin/sh
LOG_MYSQL='avzvzevezes'
P_MYSQL='fezfezDSFgfmsins'
BDD_NAME='adfefezes';
if [ -f sqltmp/$BDD_NAME.sql ]
then
svn update
mysql -u $LOG_MYSQL $BDD_NAME --password=$P_MYSQL -e "show tables" | grep -v Tables_in | grep -v "+" | awk '{print "drop table " $1 ";"}' | mysql -u $LOG_MYSQL $BDD_NAME --password=$P_MYSQL
mysql -u $LOG_MYSQL $BDD_NAME --password=$P_MYSQL < sqltmp/$BDD_NAME.sql
echo MISE A JOUR SVN + BDD TERMINEE
else 
  echo ERREUR UPDATE BDD : sqltmp/$BDD_NAME.sql n existe pas
fi
