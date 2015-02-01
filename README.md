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
[prompt: ~] source ~/xcd/xcd.sh
[prompt: ~] =
* 0 ~
[prompt: ~] cd ..
[prompt: /home] cd ..
[prompt: /] =
* 0 /
  1 /home
  2 ~
[prompt: /] = 2
[prompt: ~] =
* 0 ~
  1 /
  2 /home
[prompt: ~] -
[prompt: /] =
  0 ~
* 1 /
  2 /home
[prompt: /] -
[prompt: /home] =
  0 ~
  1 /
* 2 /home
[prompt: /home] cd
[prompt: ~] =
  0 /
* 1 ~
  2 /home
[prompt: ~] cd github/xcd.sh
[prompt: ~/github/xcd.sh] =
  0 /
* 1 ~/github/xcd.sh
  2 ~
  3 /home
[prompt: ~/github/xcd.sh] cd ..
[prompt: ~/github] =
  0 /
* 1 ~/github
  2 ~/github/xcd.sh
  3 ~
  4 /home
[prompt: ~/github] -
[prompt: ~/github/xcd.sh] -
[prompt: ~] =
  0 /
  1 ~/github
  2 ~/github/xcd.sh
* 3 ~
  4 /home
[prompt: ~]
```
