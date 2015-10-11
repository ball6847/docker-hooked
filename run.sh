#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <repository name>"
  exit 1
fi

name="$1"

cd /

if [[ ! -f /conf.d/$name ]]; then
    echo "No hook for $name"
    exit 1
fi

. /conf.d/$name

export GIT_SSH="/git_ssh.sh"
export PKEY=""

if [[ -f /conf.d/${name}.pem ]]; then
    export PKEY="/conf.d/${name}.pem"
    chmod 644 $PKEY
fi

# ===========================

if [[ -z "$path" ]]; then
    exit 1
fi

if [[ -z "$repository" ]]; then
    exit 1
fi

# ===========================

if [[ ! -d "$path" ]]; then
    echo "Working directory not exists"
    exit 1
fi

# get uid from path
uid="$(stat -c %u $path)"
username="$(getent passwd "$uid" | cut -d: -f1)"

if [ $uid -gt 999 -a "$username" == "" ]; then
    username="a${uid}"
    adduser -D -u $uid -s /bin/sh $username
fi

# now deploy using clone or pull command
if [[ ! -d "$path/.git" ]]; then
    su $username -p -c "git clone $repository $path"
else
    su $username -p -c "git -C $path pull origin master"
fi

