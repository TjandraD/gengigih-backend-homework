# Steps for Deploying Our MVC App With Vagrant

1. Bundle our project `tar --exclude='./.git' -zcvf build.tgz .`
2. Initialize vagrant `vagrant init ubuntu/focal64`
3. Start our vagrant machine `vagrant up`
4. Copy the program into our VM `scp -i .vagrant/machines/default/virtualbox/private_key ./build.tgz vagrant@192.168.20.21:/home/vagrant/app`
5. ssh into vagrant `vagrant ssh` or `ssh vagrant@192.168.20.21 -i .vagrant/machines/default/virtualbox/private_key`
6. Install all the required dependencies (check each library documentation)
7. Unzip the build.tgz file inside our VM `tar -xvzf build.tgz`