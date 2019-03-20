# Motivation

The motivation for this mechanism was to find a way to connect to all the 
PCs in a laboratory through `ssh`, knowing the credentials for the student 
account, and running a set of predefined commands through the command line 
for each of them, simultaneously.

Basically, all I wanted to do was filp my coleagues' screens upside down 
and draw some cows on them xD.

# Introduction

1. Firstly, the `run.sh` script asks for the network ip, the `ssh` username and 
password for the student account, then looks for a previously computed list of 
ip addresses. If none exists, it will discover them by running `nmap` on 
the network. It will only keep the addresses that allow `ssh` connections 
and then run `run.exp` for each of them simultaneously.
0. Secondly, the `run.exp` `expect script` will read all the lines from the 
`commands.txt` file, connect through `ssh` with the given credentials to the 
given address and run all the commands in the file. It automatically detects 
when it needs to input the password for a given action (eg. `sudo apt-get update`) 
and for other `y/n` prompts.
0. Thridly, you can edit the `commands.txt` in order to run the commands of 
your liking.

# Requirements

- `Bash 4` with the following `Linux` packages:
    - `sshpass`
    - `expect`
    - `nmap`

# TODO
- [ ] Make the `run.exp` script aware of more prompt types.
- [ ] Use alternative methods when `nmap -sn` fails.
- [ ] Implement a `--force` options that ignores the `.ips` file.
