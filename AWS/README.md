Project is created in specification:
1st part: remote-host container is going to connect to db container and extract mysql backup from remote-host (by using db container) and finally make database backup to AWS S3 bucket.(1-7)
2nd part: jenkins job that takes backup from MySql database and place it to AWS S3 Bucket.

Connection from 'remote-host' container with AWS S3 bucket is done with user 'rado' and his secret key.

1st PART:

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

Prerequisite:
1. S3 bucket created.
2. User has created with permissions to S3 bucket.

2nd PART:
Using Jenkins to hide the sensitive data (credentials):
1. Install required credential plugins
2. Go to 'credentials' -> 'GLobal Credentials' -> 'add credentials' in Jenkins
3. For MySQL secret: Kind : 'secret text', Secret: '1234' ID: 'DB_PASSWORD' (ID is doesnt matter)
4. For AWS secret: Kind : 'secret text', Secret: '<Amazon_Secret_Key>' ID: 'AWS_SECRET' (ID is doesnt matter)
5. Create w new job
   5.1 this script is parametherized (select the box)
   5.2 Add 3 string parameters:
    Name: 'DB_HOST' Default Value: 'db_host'
    Name: 'DB_NAME' Default Value: 'testdb'
    Name: 'BUCKET_NAME' Default Value: 'jenkins-mysql-backup-course2'
   5.3.  Use secret test(s) or file(s) (select the box)
   5.4 Add 'secret text'
   5.5 Add Variable: 'DB_PASSWORD' Credentials: 'DB_PASSWORD'
       Add Variable: 'AWS_SECRET' Credentials: 'AWS_SECRET'
   5.6 Build steps: ''Execute shell script on remote host using ssh'
    Command: /tmp/script.sh/script.sh $DB_HOST $DB_PASSWORD $DB_NAME $AWS_SECRET $BUCKET_NAME 
