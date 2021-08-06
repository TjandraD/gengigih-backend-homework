# Steps for Deploying Our MVC App With Vagrant

## Manual Deployment
1. Bundle our project `tar --exclude='./.git' -zcvf build.tgz .`
2. Initialize vagrant `vagrant init ubuntu/focal64`
3. Start our vagrant machine `vagrant up`
4. Copy the program into our VM `scp -i .vagrant/machines/default/virtualbox/private_key ./build.tgz vagrant@192.168.20.21:/home/vagrant/app`
5. ssh into vagrant `vagrant ssh` or `ssh vagrant@192.168.20.21 -i .vagrant/machines/default/virtualbox/private_key`
6. Install all the required dependencies (check each library documentation)
7. Unzip the build.tgz file inside our VM `tar -xvzf build.tgz`

## Using systemd for our app service
1. Create a new file called sinatra.service inside /etc/systemd/system.
    ```
    cd /etc/systemd/system
    sudo nano sinatra.service
    ```
2. Paste the following code
    ```
    [Unit]
    Description=Sinatra application

    [Service]
    User=root
    WorkingDirectory=/home/vagrant/app
    ExecStart=/usr/bin/ruby web.rb -o 192.168.20.21
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```
3. Run these commands to start the systemd service and print the status
    ```
    sudo systemctl daemon-reload
    sudo systemctl start sinatra.service
    sudo systemctl status sinatral.service
    ```

## Automating the process using Ansible
1. Create the playbook file called playbook.yml (in this case I used palybook.demo.yml for the tutorial process)
2. Paste the following code into the playbook.yml file
    ```
    - hosts: all
      tasks:
        - name: Download node setup script
          get_url:
            url: https://deb.nodesource.com/setup_12.x
            dest: /tmp/node_setup.sh
            mode: '0755'
        - name: Execute node setup script
          become: yes
          command: bash /tmp/node_setup.sh

    ```
3. Create inventory.yml file to specify our server location and paste the following code
    ```
    all:
      hosts:
        server01:
          ansible_host: 192.168.20.21
    ```
4. Additional steps: Create Makefile to make your command typing process way easier
    ```
    ansible-demo:
        ansible-playbook --inventory inventory.yml --user vagrant --private-key
        .vagrant/machines/default/virtualbox/private_key playbook.yml
    ```