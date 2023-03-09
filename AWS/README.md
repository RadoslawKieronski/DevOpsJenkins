Project is created in specification:
remote-host container is going to connect to db container and extract mysql backup from remote-host (by using db container) and finally make database backup to AWS S3 bucket.
Connection from 'remote-host' container with AWS S3 bucket is done with user 'rado' and his secret key.

'docker exec -it remote-host bash' - login to remote-host container
'mysql -u root -h db_host -p' - login to mysql database
create sample objects:
'MySQL [testdb]> INSERT INTO info2 VLAUES (rado, kier, 32);', 
'exit'

'mysqldump -u root -h db_host -p testdb > /tmp/db.sql' - save database in /tmp/db.sql file
example: '[root@50df54faf8c1 /]# mysqldump -u root -p testdb > /tmp/db.sql'

before doing backup to s3, need to export aws user credentials on 'remote-host':
'export AWS_ACCESS_KEY_ID=XXXX'
'export AWS_SECRET_ACCESS_KEY=XXX'

after export credentials type on 'remote-host':
'aws s3 cp /tmp/db.sql s3://jenkins-mysql-backup-course2/db.sql'

verify if new objects are added to AWS S3 bucket.
