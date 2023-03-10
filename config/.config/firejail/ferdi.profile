# Firejail profile for ferdi
# This file is overwritten after every install/update
# Persistent local customizations
include ferdi.local
# Persistent global definitions
include globals.local

ignore noexec /tmp

noblacklist ${HOME}/.cache/Ferdi
noblacklist ${HOME}/.config/Ferdi
noblacklist ${HOME}/.pki
noblacklist ${HOME}/.local/share/pki
noblacklist ${HOME}/Public/

include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-programs.inc

mkdir ${HOME}/.cache/Ferdi
mkdir ${HOME}/.config/Ferdi
mkdir ${HOME}/.pki
mkdir ${HOME}/.local/share/pki
whitelist ${HOME}/Images
whitelist ${HOME}/.cache/Ferdi
whitelist ${HOME}/.config/Ferdi
whitelist ${HOME}/.pki
whitelist ${HOME}/.local/share/pki
whitelist ${HOME}/Public/
include whitelist-common.inc

apparmor
caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
nou2f
protocol unix,inet,inet6,netlink
seccomp !chroot
shell none

disable-mnt
private-dev
private-tmp
