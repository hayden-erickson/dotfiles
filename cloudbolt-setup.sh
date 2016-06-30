sudo apt-get update
sudo apt-get -y install wget curl vim screen 

# vim pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install node
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs


mkdir -p ~/.ssh
mv .bash* ~/
mv .vimrc ~/
mv github_rsa.pub ~/.ssh
mv authorized_keys ~/.ssh


