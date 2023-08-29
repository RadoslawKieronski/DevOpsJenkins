1. Install plugin 'maven integration'
2. Install plugin 'git'
3. Setup Maven in jenkins(Manage Jenkins -> Tools):

   ![image](https://github.com/RadoslawKieronski/DevOpsJenkins/assets/64900997/72e4c413-9dc2-4e60-9134-bd7351f5ca8c)
4. Clone github repo and build a maven JAR file with jenkins job:
_Goal for build from 'https://github.com/jenkins-docs/simple-java-maven-app/blob/master/jenkins/Jenkinsfile'_

![image](https://github.com/RadoslawKieronski/DevOpsJenkins/assets/64900997/b603dcb8-f1ab-4f1f-b590-1f746ceb6af8)
![image](https://github.com/RadoslawKieronski/DevOpsJenkins/assets/64900997/b0464128-1755-4bbe-9835-6f7073dbdb38)

Output from the job(path for the JAR file):
_[INFO] Building jar: /var/jenkins_home/workspace/maven-job/target/my-app-1.0-SNAPSHOT.jar_
Maven is looking to the code that GIT previously downloaded and using 'pom.xml' file build JAR package.