# Ansible playbook running on a remote-host container

Jenkins connects throw ssh to remote-host. On the Jenkins container ansible is installed. On the Jenkins container playbook file and inventory file are created and those file are reponsible for running ansible playbook on a remote-host container by ssh connection.
REMEMBER TO ADD remote-host SSH KEY (remote-key) from centos7 DIR TO jenkins-ansible.
## Setting Jenkins UI with Ansible:
1. Install ansible plugin
   'Manage Jenkins' -> 'plugins'
2. Create w test job
   - in section 'Build' -> 'Build step' -> 'invoke ansible playbook'
     Fulfill path for _inventory_ and _playbook file_ on a jenkins container:
     - Playbook path: '/ver/jenkin_home/ansible/play.yml
     - File or host list: '/var/jenkins_home/ansible/hosts'
   - Run the job

## Parameterize the job
ADD Parameters to the Ansible and Jenkins:
mofidy the file 'play.yml' like below:
```
 - hosts: test1
   tasks:
    - debug: msg: "{{ MSG }}"
```
### Changes in the job (jenkins UI):
1. select the box 'this project is parameterized
2. Select 'string parameter': NAME: 'ANSIBLE_MSG', Default Value: 'Hello World'
3. In the bild section -> 'Advanced' -> 'Add extra variable': Key: 'MSG', Value: '$ANSIBLE_MSG'

**conclusion: ansible is taking the value from parameter and passing it to the playbook using an extra variable.**
