# Extracting MYSQL database backup and placing it to the AWS S3 Bucket


1st part: remote-host container is going to connect to db container and extract mysql backup from remote-host (by using db container) and finally make database backup to AWS S3 bucket.(1-7)
2nd part: jenkins job that connects throw ssh to remote_host and takes backup from MySql database and place it to AWS S3 Bucket.

## Prerequisite:
1. S3 bucket created.
2. User has created with permissions to S3 bucket.
Connection from 'remote-host' container with AWS S3 bucket is done with user 'rado' and his secret key.

## 1st PART:

1. _'docker exec -it remote-host bash'_ - -login to remote-host container
2. _'mysql -u root -h db_host -p'_ - login to mysql database
3. create sample objects in the database:
   - _'create database testdb;'_
   - _'use testdb'_
   - _'create table info (name varchar(2), lastname varchar(20), age int(2));'_
   - _'insert into info values ('Rado', 'Kiero', 30);'_
   - _'select * from info'_
4. _'exit'_
5. _'mysqldump -u root -h db_host -p testdb > /tmp/db.sql'_ - save database in /tmp/db.sql.
    Example: '[root@50df54faf8c1 /]# mysqldump -u root -p testdb > /tmp/db.sql'
6. before doing backup to s3, need to export aws user credentials on the 'remote-host' container:
   _'export AWS_ACCESS_KEY_ID=XXXX'_
   _'export AWS_SECRET_ACCESS_KEY=XXX'_
7. after export credentials type on 'remote-host':
   _'aws s3 cp /tmp/db.sql s3://jenkins-mysql-backup-course2/db.sql'_
   
    **5.6.7. YOU CAN OMMIT BY USING**:'script.sh WITH ADDED 5 PARAMETERS ON THE 'remote-host'. MORE DETAILS IN 'script.sh'.
    Also remember to edit docker file for the 'remote-host' - _'RUN chmod 700 /tmp'_ to be able to execute te script.sh.

**verify if new objects are added to AWS S3 bucket.**

## 2nd PART:
Using Jenkins to hide the sensitive data (credentials):
1. Install required credential plugins
2. Go to 'credentials' -> 'GLobal Credentials' -> 'add credentials' in Jenkins
3. For MySQL secret: Kind : 'secret text', Secret: '1234' ID: 'DB_PASSWORD' (ID is doesnt matter)
4. For AWS secret: Kind : 'secret text', Secret: '<Amazon_Secret_Key>' ID: 'AWS_SECRET' (ID is doesnt matter)

5. Create w new job
   - this script is parametherized (select the box)
   - Add 3 string parameters:
    Name: 'DB_HOST' Default Value: 'db_host'
    Name: 'DB_NAME' Default Value: 'testdb'
    Name: 'BUCKET_NAME' Default Value: 'jenkins-mysql-backup-course2'

   - Use secret test(s) or file(s) (select the box)
   - Add 'secret text'
   - Add Variable: 'DB_PASSWORD' Credentials: 'DB_PASSWORD'
       Add Variable: 'AWS_SECRET' Credentials: 'AWS_SECRET'

   - Build steps: 'Execute shell script on remote host using ssh'
    Command: _/tmp/script.sh/script.sh $DB_HOST $DB_PASSWORD $DB_NAME $AWS_SECRET $BUCKET_NAME_

