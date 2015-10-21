#!/bin/sh
LOG_MYSQL='huguenin'
P_MYSQL='vzvz34'
BDD_NAME='huguenin';
cd /home/dev/huguenin/huguenin/www/
mysqldump $BDD_NAME -u$LOG_MYSQL -p$P_MYSQL > sqltmp/$BDD_NAME.sql
#tar -cvvzf /home/dev/dalloz/dallozformation/www/sqltemp/sites_default_files.tgz sites/default/files
svn commit -m 'script de dump de base + commit auto +  tar default/files'

