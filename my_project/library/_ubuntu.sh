##!/bin/bash

# Set of actions for ubuntu OS
# Create your own actions
# Rule name function (action)  [command]_[app_name]
# example install_nginx() {}; uninstall_nginx() {} 
# Arguments [my_project] -  are composer options [ -y -v -q -f ]
install_nano(){
    composer -q $@ install nano 
}