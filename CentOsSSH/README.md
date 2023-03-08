There are created 2 containers: jenkins, remote_host.

There has been created project where jenkins server is able to establish ssh connection to remote_host using remote_user.

In order to check if ssh connection works: go into jenkins container 'docker exec -ti jenkins bash' type inside jenkins container 'ssh remote_user@remote_host'
