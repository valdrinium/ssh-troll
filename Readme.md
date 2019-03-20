# Motivation

The motivation for this mechanism was to find a way to connect to all the 
PCs in a laboratory through `ssh`, knowing the credentials for the student 
account, and running a set of predefined commands through the command line 
of each of them, simultaneously.

Basically, all I wanted to do was filp my coleagues' screens upside down 
and draw some cows on them xD.

# Introduction

1. Firstly, the `run.sh` script reads the network ip and the username and 
password for the common account, then looks for a previously comted list of 
ip addresses. If none exists, it will discover them by running `nmap` on 
the network. It will only keep the addresses that allow the `ssh` connection 
and then run `run.exp` for each of them simultaneously.
0. Secondly, the `run.exp` expect script will read all the command from the 
`commands.txt` file, connect through `ssh` with the given credentials to the 
given address and run all the commands in the file. It automatically detects 
when it need to input the password for the accound and other `y/n` prompts.
0. Thridly, edit the `commands.txt` in order to run some commands of your liking.

# Requirements

- `Bash 4` with the following packages:
    - `nmap`
    - `sshpass`
    - `expect`

# TODO
[] Make the `run.exp` script aware of more prompt types.
[] Use alternative methods when `nmap -sn` fails.
[] Implement a `--force` options that ignores the `.ips` file.

# Happy spamming! xD
