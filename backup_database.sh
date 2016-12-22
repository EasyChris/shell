#!/bin/bash
#chris@afox.cc
# ./bashup_database.sh db_name user pass | host
BACK_TIME=$(date +%Y%m%d%h%s)
#database name
DATA_NAME=$1
#user
USER=$2
#pass
PASS=$3
#HOST
HOST=$4
if [ -z $HOST ]
then
	HOST="localhost"
fi
params=$#
#filename
FILENAME="database_${DATA_NAME}_backup_${BACK_TIME}.sql"
if [[ $params == 3 || $params == 4 ]]
then
	echo "Start backup DB:${DATA_NAME} "
	if $(mysqldump -h ${HOST} -u${USER} -p${PASS} ${DATA_NAME} > "${FILENAME}");
	then
        	echo "  Dumped successfully!"
	else
	        echo "  Failed dumping this database!"
    	fi
	if $(gzip -c ${FILENAME} > "${FILENAME}.gz");
	then
		echo "gzip successfully!"
	else
		echo "gzip fail"
	fi
	if $(rm -rf ${FILENAME});
	then
		echo "Completed backup"
	fi

	echo "Your DB:${DATA_NAME} backUp successfully Completed"
	echo " "
else
	echo "=============== ERROR ================"
	echo "please run ./database_base.sh db_name user pass | host"
	echo "================ ERROR END============"
fi
