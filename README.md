Remote Agent Install Steps:
------------------------------

On WorkStation/Control machine:
------------------------------
1. yum -y install git, sshpass
2. ssh-keygen -f git-key
3. copy git-key to Git Repo deploy keys. Repo --> Settings --> Deploy Keys --> Add Deploy Key --> Copy git-key.pub content here.

4. Create script to loop through all servers and install agent
File - 01.Install-Agents-Wrapper.sh

	#!/bin/sh
	SERVER_LIST=dilip6823c.mylabserver.com,dilip6823c.mylabserver.com
	admin_user=cloud_user
	admin_password=Gana@123
	git_repo_url=git@github.com:dilip682/pipelines.git
	git_repo_name=pipelines

	  for i in $(echo $SERVER_LIST| sed "s/,/ /g")
	  do
	    sshpass -p "${admin_password}" ssh ${admin_user}@${i} "echo 'Logged in to Server - `hostname`'"
		# sshpass -p "${admin_password}" ssh -t ${admin_user}@${i} "sudo yum -y install git"
		sshpass -p "${admin_password}" scp -o StrictHostKeyChecking=no ~/git-key ${admin_user}@${i}:/home/${admin_user}/
		sshpass -p "${admin_password}" ssh ${admin_user}@${i} "ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts"
		sshpass -p "${admin_password}" ssh ${admin_user}@${i} "ssh-agent bash -c 'ssh-add /home/${admin_user}/git-key; rm -Rf pipelines; git clone ${git_repo_url}'"
		sshpass -p "${admin_password}" ssh ${admin_user}@${i} "sh ~/${git_repo_name}/agent-install.sh"
	  done

Below are commands used:
------------------------------

	sudo yum -y install git 
	sshpass -p "**password**" ssh -t linux_admin_user@remote-host.abc.com "sudo yum -y install git"
	sshpass -p "**password**" ssh linux_admin_user@remote-host.abc.com "echo `hostname`"
	sshpass -p "**password**" scp -o StrictHostKeyChecking=no /home/dilip/git-key linux_admin_user@remote-host.abc.com:/home/linux_admin_user/
	sshpass -p "**password**" ssh linux_admin_user@remote-host.abc.com "ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts"
	sshpass -p "**password**" ssh linux_admin_user@remote-host.abc.com "ssh-agent bash -c 'ssh-add /home/linux_admin_user/git-key; rm -Rf pipelines; git clone git@github.com:dilip682/pipelines.git'"
	sshpass -p "**password**" ssh linux_admin_user@remote-host.abc.com "sh ~/pipelines/agent-install.sh"
