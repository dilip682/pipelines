#!/bin/sh
SERVER_LIST=dilip6823c.mylabserver.com,dilip6823c.mylabserver.com
admin_user=cloud_user
admin_password=***********
git_repo_url=git@github.com:dilip682/pipelines.git
git_repo_name=pipelines

  for i in $(echo $SERVER_LIST| sed "s/,/ /g")
  do
    sshpass -p "${admin_password}" ssh ${admin_user}@${i} "echo 'Logged in to Server - `hostname`'"
	# sshpass -p "${admin_password}" ssh -t ${admin_user}@${i} "sudo yum -y install git"
	sshpass -p "${admin_password}" scp -o StrictHostKeyChecking=no ~/git-key ${admin_user}@${i}:/home/${admin_user}/
	sshpass -p "${admin_password}" ssh ${admin_user}@${i} "ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts"
	sshpass -p "${admin_password}" ssh ${admin_user}@${i} "ssh-agent bash -c 'ssh-add /home/${admin_user}/git-key; rm -Rf ${git_repo_name}; git clone ${git_repo_url}'"
	sshpass -p "${admin_password}" ssh ${admin_user}@${i} "sh ~/${git_repo_name}/agent-install.sh"
  done
