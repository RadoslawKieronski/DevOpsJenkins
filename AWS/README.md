Project is created in specification:
remote-host container is going to connect to db container and extract mysql backup from remote-host (by using db container) and finally make database backup to AWS S3 bucket.
Connection from 'remote-host' container with AWS S3 bucket is done with user 'rado' and his secret key.

1. 'docker exec -it remote-host bash' - login to remote-host container
2. 'mysql -u root -h db_host -p' - login to mysql database
3. create sample objects in the database:
 3.1 'create database testdb;'
 3.2 'use testdb'
 3.3 'create table info (name varchar(2), lastname varchar(20), age int(2));'
 3.4 'insert into info values ('Rado', 'Kiero', 30);'
 3.5 'select * from info'
4. 'exit'

5. 'mysqldump -u root -h db_host -p testdb > /tmp/db.sql' - save database in /tmp/db.sql.
    Example: '[root@50df54faf8c1 /]# mysqldump -u root -p testdb > /tmp/db.sql'
    

6. before doing backup to s3, need to export aws user credentials on the 'remote-host' container:
   'export AWS_ACCESS_KEY_ID=XXXX'
   'export AWS_SECRET_ACCESS_KEY=XXX'

7. after export credentials type on 'remote-host':
   'aws s3 cp /tmp/db.sql s3://jenkins-mysql-backup-course2/db.sql'
   
    5.6.7. YOU CAN OMMIT BY USING:'script.sh WITH ADDED 5 PARAMETERS ON THE 'remote-host'. MORE DETAILS IN 'script.sh'.
    Also remember to edit docker file for the 'remote-host' - 'RUN chmod 700 /tmp' to be able to execute te script.sh.

verify if new objects are added to AWS S3 bucket.

prerequisite:
1. S3 bucket created.
2. User has created with permissions to S3 bucket.
