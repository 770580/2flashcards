
#install postgresql and epel repo
sudo rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm
sudo yum -y install epel-release
sudo yum repolist

#install nodejs
sudo yum -y install nodejs

#install postgresql
sudo yum -y install postgresql94-server postgresql94-contrib
sudo yum -y install libpqxx-devel
sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb
sudo systemctl enable postgresql-9.4
sudo systemctl start postgresql-9.4

#add postgresql user
sudo sed -i \ "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" \/var/lib/pgsql/9.4/data/postgresql.conf
sudo sed -i \ 's/^host [^:]*$/host    all             all'\ '             all                     md5/' \/var/lib/pgsql/9.4/data/pg_hba.conf
sudo systemctl restart postgresql-9.4.service
sudo systemctl enable postgresql-9.4.service
sudo -u postgres psql -c "create user pqdev with password '123';"
sudo -u postgres psql -c "alter user pqdev with superuser;"

#go to the application folder
cd ~/sync

#install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
echo source ~/.profile >> ~/.bash_profile

#install ruby
rvm install 2.1.4

#install bundle and pg gems
echo gem: --no-ri --no-rdoc > ~/.gemrc
gem install bundler
gem install pg -- --with-pg-config=/usr/pgsql-9.4/bin/pg_config

#install bandle and create databases
bundle install
rake db:create db:migrate

#run puma as daemon
bundle exec puma -e development -p 3000 --pidfile tmp/pids/puma.pid -d