#!/bin/bash
dir=$1

mkdir -p $dir/adapters
mkdir -p $dir/interfaces
mkdir -p $dir/library

wget -O $dir/composer.sh -q https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/composer.sh
wget -O $dir/rules.sh -q https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/rules.sh
wget -O $dir/run-lib.sh -q https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/run-lib.sh
wget -O $dir/ifOSThenRun.sh -q https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/ifOSThenRun.sh
wget -O $dir/_config.sh -q https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/_config.sh

wget -q -O  $dir/interfaces/_interface.sh https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/interfaces/_interface.sh
wget -q -O $dir/interfaces/_rules_interface.sh https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/interfaces/_rules_interface.sh
wget -q -O $dir/interfaces/_os_interface.sh https://raw.githubusercontent.com/alexeyp0708/bash_universal_installer/refs/heads/main/src/interfaces/_os_interface.sh
 
OS="$(cat "/etc/os-release"|grep -Po "(?<=^ID=).+$")"
if [ ! -e "$dir/adapters/_${OS}.sh" ]
then
cat <<eof > $dir/adapters/_${OS}.sh
##!/bin/bash
source "\$(dirname \$(readlink -f "\$BASH_SOURCE"))/../interfaces/_os_interface.sh"

#Implement the interface methods _os_interface.sh

#Create your own adapter script for each OS
eof
fi

if [ ! -e "$dir/library/_core.sh" ]
then
cat <<eof > $dir/library/_core.sh
#!/bin/bash

# Common set of actions for any OS
# Create your own actions
# Rule name function (action)  [command]_[app_name]  
# example install_nginx() {}; uninstall_nginx() {} 
# Arguments [$@] -  are composer options [ -y -v -q -f ]
eof
fi

if [ ! -e "$dir/library/_${OS}.sh" ]
then
cat <<eof > $dir/library/_${OS}.sh
#!/bin/bash

# Set of actions for ${OS} OS
# Create your own actions
# Rule name function (action)  [command]_[app_name]
# example install_nginx() {}; uninstall_nginx() {} 
# Arguments [$@] -  are composer options [ -y -v -q -f ]
eof
fi

<<EOF
--------------------------
"NOTE: Open the '$dir/adapters/_${OS}.sh' file 
and create adapter methods [ initOptions | install | uninstall | update | upgrade ]
--------------------------
NOTE: Open the '$dir/library/_core.sh' file and If there is a need then create common actions 
for applications - [ install_{name_app} | uninstall_{name_app} | update_{name_app} | upgrade_{name_app} ]
--------------------------
NOTE: Open the '$dir/library/_${OS}.sh' file and If there is a need then create '${OS} OS' actions 
for applications  [ install_{name_app} | uninstall_{name_app} | update_{name_app} | upgrade_{name_app} ]
--------------------------
NOTE: Run ./composer.sh [options] [command] [...apps]. Example: ./composer.sh -y install nginx nano
--------------------------
NOTE: run './composer.sh help'
--------------------------
EOF

echo Success!