#/bin/bash

set -e

cd

# force update if any cmd line param exists
if [[ ( -z "$1") && (-e $HOME/.toolboxrc ) ]]; then
  exit 0
fi

cat > $HOME/.toolboxrc <<-EOF
	TOOLBOX_DOCKER_IMAGE=v6net/coreos-ansible-toolbox
	TOOLBOX_USER=root
	TOOLBOX_DOCKER_TAG=edge
EOF

sudo mkdir --parents '/opt/bin'

sudo tee '/opt/bin/python' > /dev/null <<-EOL
	#!/bin/bash
	toolbox --quiet --bind=/home:/home --bind=/var/run/docker.sock:/var/run/docker.sock python "\$@"
EOL

sudo chmod +x '/opt/bin/python'

sudo tee '/opt/bin/pip' > /dev/null <<-EOL
	#!/bin/bash
	toolbox --quiet --bind=/home:/home --bind=/var/run/docker.sock:/var/run/docker.sock pip "\$@"
EOL

sudo chmod +x '/opt/bin/pip'

toolbox mkdir -p /opt/bin

toolbox ln -sf /usr/bin/python /opt/bin
