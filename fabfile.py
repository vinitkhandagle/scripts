from fabric.api import *

@hosts('localhost', 'redhatbox')
def mytask():
	run('hostname')

@hosts('redhatbox')
def pkg_install(name):
	sudo('yum -y install %s' % name)


@hosts('vinit@redhatbox')
def hg_clone():
	clone_dir = '/home/vinit/clone_dir'
	with cd(clone_dir):
		run("hg clone https://hg.dev.xcite.com/trunk/pci")

