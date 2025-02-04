# Universal Installer

Simple but powerful installer for adaptation to different OS.

The goal of the project is to unify the installation of packages for different operating systems.

The script also aims to personalize application installations.

## Syntax rules:

- The prefix "_" in the script name (`_my_script.sh`) means that the script is not executable. the first line of such scripts is `##!/bin/bash` 
and is intended only for extending current scripts (`source _myscript.sh;`);
-  The prefix "_" in the function name (`_my_function`) means that the functions are private and can be modified in the future.
It is not recommended to use them in your scripts.;

##Definitions
- installation management scripts -   Installation management scripts for each operating system
## Description

The script is designed in such a way that for a specific operational system you can write
a separate file with commands for installing and removing programs (installation management script).
By default, such files are located in the directory path `./src/distr`
But you can specify your own path to the operating system installer file and set your own calling rules.


### Use Composer for default installation management scripts

Detect OS : "/etc/os-release: {ID}"
Example of a default software builder for OS = debian

./composer.sh
```shell
#!/bin/bash
# ./composer.sh

# Let's assume that the OS installer is located in "Installer" directory.
source "$(dirname $(readlink -f "$BASH_SOURCE"))/Installer/src/_composer.sh"

# rule name function  [command]_[app_name] 
# argumens it is options script

install_nginx(){
  local options="$@"
  echo 'hello';
  # see composer help
  # composer - (function composer) internal command 
  # composer [ options ] [ command ] [...apps]
  composer $options install nginx;
}

execute "$@"
```
Run
```shell
# Running `./composer.sh => install_nginx -y"
./composer.sh -y install nginx
#Running 
# Running  `./distr/_debian.sh => initOptions -y` and `./distr/_debian.sh => install nano`
./composer.sh -y install nano
```

## Use  composer for  custom installation management scripts

./my_distr/_other.sh
```shell
##!/bin/bash
#It is mandatory to implement the interface ./interfaces/_interfaces.sh
source "$(dirname $(readlink -f "$BASH_SOURCE"))/../Installer/src/interfaces/_interface.sh"

#initOptions is required 
#Format `initOptions -y`
local opt_str
initOptions(){
  opt_str="$@"
  #You can process options in a special way
}

# Any command you define that are used in your code.
add(){
  sudo apt-get $opt_str install $@
}

```

```shell
#!/bin/bash
# ./composer.sh

# Let's assume that the OS installer is located in "Installer" directory.
source "$(dirname $(readlink -f "$BASH_SOURCE"))/Installer/src/_composer.sh"

# Redefine 'distr_file' variable to use your installation management scripts
distr_file="${$my_composer_script_path}/my_distr/_other.sh"

# rule name function  [command]_[app_name] 
# arguments it is options script

add_nginx(){
  local options="$@"
  echo 'hello';
  # see composer help
  # composer - (function composer) internal command 
  # composer [ options ] [ command ] [...apps]
  composer $options add nginx;
}

execute "$@"
```

Run
```shell
# Running `./composer.sh => add_nginx -y"
./composer.sh -y add nginx
#Running 
# Running  `./distr/_other.sh => initOptions -y` and `./distr/_other.sh => add nano`
./composer.sh -y add nano
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

Detect OS : "/etc/os-release: {ID}"


## Create of your project 

For your project you will need to download the following files:
- `./_composer.sh`
- `./_iOSThenRun.sh`
- `./iOSThenRun.sh` (optional)
- `./{distr}/required.sh`
- `./interfaces/_interface.sh`
- `./interfaces/_required_interface.sh`

You must create the following custom files:
- `./composer.sh` extends `./_composer.sh` 
- `./iOSThenRun.sh` extends `./_iOSThenRun.sh` (optional)
- `./{distr}/required.sh` implement `./interfaces/_required_interface.sh` (optional)
- `./interfaces/{_your_command_interface}.sh` extends  `./interfaces/_interface.sh` (optional)
- `./{distr}/{_your_installer_distributive_script}.sh` implement `./interfaces/{_your_command_interface}.sh` (optional)

### {distr}
`{distr}` - This is the path directory to distribution installers scripts
It can be changed by changing the `$distr_file` variable in `./composr.sh`  and `./iOSThenRun.sh` files.
`$distr_file` - path file to distribution installers script.
default directory path - `./distr`

### ./{distr}/required.sh

Depending on the project rules, these methods in file `./{distr}/required.sh` can be adjusted, 
and `./_composer.sh` depends on them.
You can create your own file `./distr/required.sh` implementing the interface `./interfaces/_required_interface.sh`
The directory will correspond to the path specified in the `$distr_file` variable in `./composer.sh`.

Next you need to create a `./composer.sh` file

### ./composer.sh

```shell
#!/bin/bash

source ./_composer.sh

##Change if necessary
#os="$(cat "/etc/os-release"|grep -Po "(?<=^ID=).+$")"
#distr_file="./distr/_${os}.sh"



## add methods on format name - [command]_[app] [$@=...options]  if necessary

execute "$@"
```

### `./iOSThenRun.sh`

/iOSThenRun.sh is a standalone script
`/iOSThenRun.sh` may optionally depend on the `execute` method of the distribution installers script (see `./interfaces/_interface.sh`), 
if there is a special approach to handling command execution.

if you change the default directory `{distr}`, then in order for the execute method to run,
you need to specify the location of the distribution's installation scripts for `/iOSThenRun.sh`.
To do this, you need to create your own `./iOSThenRun.sh`.

./iOSThenRun.sh
```shell
#!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/_ifOSThenRun.sh"
#os='your_name'
distr_file="$(dirname $(readlink -f "$BASH_SOURCE"))/new_distr/_${os}.sh"
#Your manipulation code
run "$@"
```


### ./{distr}/{_your_installer_distributive_script}.sh`

This {_your_installer_distributive_script} file name depends on how the path in the `$distr_file` variable will be formed.
Default is OS name (`/etc/os-release {ID}`)
`{_your_installer_distributive_script}.sh` must be implement  `./interfaces/_interface.sh` interface

./distr/_ubuntu.sh

```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/interfaces/_interface.sh"

initOptions(){
  # yor code
}
## your any methods as commands
```
If there are many distribution installer scripts, it is recommended to create your own interface

./interfaces/_my_interface.sh
```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/interfaces/_interface.sh"

add (){
  _fail
}
## your any methods as commands
```
./distr/_ubuntu.sh
```shell
##!/bin/bash
source "$(dirname $(readlink -f "$BASH_SOURCE"))/interfaces/my_interface.sh"

initOptions(){
  # yor code
}

add(){
  # yor code
}
## your any methods as commands
```
This approach helps to declare the necessary commands in the necessary scripts.

