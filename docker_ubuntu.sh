# Docker on Ubuntu 14.04 LTS
sudo apt-get install docker.io

#
# if you prefer the command docker over docker.io 
# on Ubuntu 14.04 LTS
#

# Create /usr/bin/docker the Debian/Ubuntu way
# (avoid conflicting with docker – System tray)
sudo update-alternatives –install /usr/bin/docker docker /usr/bin/docker.io 50

# Allow bash completion for docker
sudo cp -a /etc/bash_completion.d/docker{.io,}
sudo sed -i 's/\(docker\)\.io/\1/g' /etc/bash_completion.d/docker

# Allow zsh completion for docker
sudo cp -a /usr/share/zsh/vendor-completions/_docker{.io,}
sudo sed -i 's/\(docker\)\.io/\1/g' /usr/share/zsh/vendor-completions/_docker

# the man page for docker
sudo ln -s /usr/share/man/man1/docker{.io,}.1.gz

# not really needed because docker.io is still there
sudo sed -i 's/\(docker\)\.io/\1/g' /usr/share/docker.io/contrib/*.sh

# Test Docker
sudo docker pull ubuntu
sudo docker run -i -t ubuntu /bin/bash
exit

# TODO?
# sudo dpkg -L docker.io | xargs grep -s ‘docker.io’
# /usr/share/lintian/overrides/docker.io
# /usr/share/doc/docker.io
