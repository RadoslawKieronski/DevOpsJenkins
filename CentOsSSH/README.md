There are created 2 containers: jenkins, remote-host.

There has been created project where jenkins server is able to establish ssh connection to remote-host using remote_user.

In order to check if ssh connection works: go into jenkins container 'docker exec -ti jenkins bash' type inside jenkins container 'ssh remote_user@remote_host'

You can set ssh connection in jenkins UI.
Add 'remote_user' with ssh key to credentials section (choose type - SSH Username with private key).
In job section 'Execute shell script on remote host usig ssh' select the added credentials.
