# Package Management Adapter (or PMA Composer)

Simple but powerful adapter of package managers of different OS.
The goal of the project is to quickly write server scripts for installing programs and configuring them on various operating systems.

## Syntax rules:

- The prefix "_" in the script name (`_my_script.sh`) means that the script is not executable. The first line of such scripts is `##!/bin/bash`.   Is intended only for extending current scripts (`source _myscript.sh;`);
-  The prefix "_" in the function name (`_my_function`) means that the functions are private and can be modified in the future.
It is not recommended to use them in your scripts.;

## Definitions

Methods - script functions  
Interfaces - non-executable scripts with declaration of methods that need to be implemented in the executable script.  
Adapters - scripts adapted for the OS package manager.  
Actions - scripts designed for various actions with the application and designed for specific behavior (example nstallation or configuration)  

## Project creation

To deploy your own project:
- download `./create-project.sh`
- run the command `./create-project.sh {your_directory}`

The script will download the necessary scripts and create templates for writing your own scripts.

>WARNING: To speed up the script, the adapter (`./adapters/_{OS}.sh`), application actions(`./library/_core.sh` and `./library/_{OS}.sh`)
and composer (./composer.sh) are included in one file. This means they have the same scope.  
Be careful with declaring variables in such files. They may overlap and override each other.


### Creating an adapter for the package manager.

./{your_directory}/adapters/_{yor_OS}.sh

Detect OS : "/etc/os-release: {ID}"

```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_interface.sh"

#Implement the interface methods _os_interface.sh

#Create your own provider script for each OS

#example
local opt_str=
initOptions(){
  # You have to build your own combinations of options depending on the package manager.
  opt_str="$@"
}
install(){
  sudo apt-get $opt_str install $@
}
uninstall(){
  sudo apt-get $opt_str remove $@
}
#....
#You must implement all methods that are declared in ./interfaces/_os_interface.sh
```
run
`./composer.sh -y install nginx`


### Creating actions for applications.

>Note: To speed up the script, the adapter, application actions, and composer are included in one file. 
Therefore, application actions can be declared in the adapter script.

Create 
`./{your_directory}/library/_core.sh`
or/and
`./{your_directory}/library/_{OS}.sh`

```shell
#!/bin/bash

_formatOptions(){
  ## Adapting options to the package manager
  echo $@
}
install_nginx(){
  local $opt= $(_formatOptions $@) 
  sudo apt-get $opt install  nginx=1.27.3
  # or
  composer $opt install  nginx=1.27.3
}

settings_nginx(){
  # change /etc/nginx/nginx.conf
  nginx -t && nginx -s reload 
}

```
run
`./composer.sh -y install nginx`
`./composer.sh -y settings nginx`


## Behavior expansion

You can set your own option validation rules and implement your own commands for adapters.

### Adapter commands

The composer itself is not tied to commands and can run any commands that are declared in the adapter.
But if several adapters are to be implemented (for example, for different OS), it is recommended to unify such a process.
For this, it is recommended to create your own interface. It is not necessary to declare it in the adapters,
but when writing a new adapter, it will tell you which methods are needed.

./interfaces/_os_my_interface.sh
```shell
##!/bin/bash
# it is mandatory to implement the methods of the interface `/interfaces/_adapter_interface.sh"`
source "$(dirname $(readlink -f "$BASH_SOURCE"))/_adapter_interface.sh"
add(){
  _fail
}
del(){
  _fail
}
```
./adapters/_ubuntu.sh
```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_my_interface.sh"

# implement methods

```

### Actions commands

If you need scripts with application actions for each OS, it is also recommended to unify such a process.
For this, it is recommended to create your own action interface. It is not necessary to declare it in adapters,
but when writing a new adapter, it will tell you which methods are needed.

./interfaces/_os_actions_interface.sh
```shell
##!/bin/bash
_fail(){
  printf '%s\n' "There is no implementation of the method [${OS}] [${FUNCNAME[1]}] [$(readlink -f "$0")]" >&2
  exit 1
}
install_nginx(){
  _fail
}
settings_nginx(){
    _fail
}
```
./library/_ubuntu.sh
```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_os_actions_interface.sh"

# implement methods
```

## Fine-tuning - Changing options and command descriptions
To change the description of commands when calling `./composer.sh help`, change  the `help` method of  `./rules.sh` script 
or you can create your own rules script.
To change the format of options, change the `validateOptions` method of `./rules.sh` script
or you can create your own rules script.

### Creating your own script with rules

./_my-rules.sh
```shell
##!/bin/bash
_rules(){
  source "$(dirname $(readlink -f "$BASH_SOURCE"))/../interfaces/_rules_interface.sh"
  # implement the methods of the interface _rules_interface.sh
  help(){
    #....
  }
  validateRules(){
    #....
  }
}




```

./_config.sh
```shell
##!/bin/bash
#....
# set the RULES_SCRIPT variable
RULES_SCRIPT="$(dirname $(readlink -f "$BASH_SOURCE"))/_my-rules.sh"
#....
```


## Additionally

You can use the command ./ifOSThenRun.sh
```shell
#Runing command if OS is Ubuntu
./ifOSThenRun.sh ubuntu apt-get -y install nginx
#Runing command if OS is alpine
./ifOSThenRun.sh alpine apk -y add nginx
#or
./ifOSThenRun.sh ubuntu apt-get -y install nginx || ./ifOSThenRun.sh alpine apk -y add nginx || exit 1
```

