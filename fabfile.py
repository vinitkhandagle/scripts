from fabric.api import *
import os
import shutil
import stat

env.hosts.extend(['x.p.w1', 'x.p.w2'])

def type_host():
	run('hostname')

def type_apache():
	sudo('/etc/init.d/httpd status')


@hosts()
def backup_site():
	sudo('cp -ar /home/vinit/newdir /home/vinit/new_fabric_site_`date +%F`')
	


def deploy():
	if os.path.exists('code_dirs'):
		local('rm -rf code_dirs')
	local('mkdir code_dirs')
	local('cp -ar /var/www/site/app code_dirs')
	local('cp -ar /var/www/site/skin code_dirs')
	local('cp -ar /var/www/site/js code_dirs')
	
	if os.path.exists('code_dirs.tar.gz'):
		local('rm -rf code_dirs.tar.gz')
	local('tar -czf code_dirs.tar.gz code_dirs > /dev/null')
	put('code_dirs.tar.gz', '/home/vinit/code_dirs.tar.gz')
	run('tar -zxf code_dirs.tar.gz')
	run('rsync -avzr code_dirs/* code_sync')
    
	sudo('chown -R vinit:nobody code_sync')
	backup_site()
