# xcd.sh
xcd.sh extends `cd` command.

## Install
### Step 1: Clone the repository
```
$ git clone https://github.com/toromoti/xcd.sh.git ~/xcd
```
### Step 2: Set `source` into shell rc-file
```
$ echo 'source ~/xcd/xcd.sh' >> ~/.bash_profile
```
__Zsh users:__ Modify your `~/.zshrc` instead of `~/.bash_profile`.
### Step 3: Load to enable now
```
$ source ~/xcd/xcd.sh
```

## Usage
```
prompt:[~]$ source ~/xcd/xcd.sh
prompt:[~]$ =
* 0 ~
prompt:[~]$ cd ..
prompt:[/home]$ cd ..
prompt:[/]$ cd /etc
prompt:[/etc]$ =
* 0 /etc
  1 /
  2 /home
  3 ~
prompt:[/etc]$ -
prompt:[/]$ -
prompt:[/home]$ =
  0 /etc
  1 /
* 2 /home
  3 ~
prompt:[/home]$ cd /var/log
prompt:[/var/log]$ =
  0 /etc
  1 /
* 2 /var/log
  3 /home
  4 ~
prompt:[/var/log]$ cd ..
prompt:[/var]$ =
  0 /etc
  1 /
* 2 /var
  3 /var/log
  4 /home
  5 ~
prompt:[/var]$ -
prompt:[/var/log]$ +
prompt:[/var]$ +
prompt:[/]$ =
  0 /etc
* 1 /
  2 /var
  3 /var/log
  4 /home
  5 ~
prompt:[/]$ = 5
prompt:[~]$ =
  0 /etc
* 1 ~
  2 /
  3 /var
  4 /var/log
  5 /home
prompt:[~]$
```
