To build the image, just cd to working directory and run this

```sh
docker build -t ball6847/hooked .
```

Then run container using the following command, by default hooked run at port 8888 (map your own port if needed)

```sh
docker run -d \
    --name hooked \
    -v $PWD/config/:/conf.d \
    -v $PWD/data/:/data \
    ball6847/hooked
```

Then you can go to http://localhost:8888/ to see if it working.
To run a hook on specific repo just call http://localhost:8888/hooks/repo-name/master

You need to put the repo config to /conf.d using the exact same name as the repo name shown on url (http://localhost:8888/hooks/<repo>/<branch> will looking for /conf.d/<repo>)

### Example

```sh
#!/bin/sh
repository="git@github.com:ball6847/slim-starter.git"
path="/data/slim-starter"
```

From the above example /data/slim-starter has to be mounted to the container to make it work.

## SSH Indentity File

To make it work with ssh git repository you need to put `<repo>.pem` at the same directory of the config file (using the same name but with .pem append) git will use the file as identiry file for your connection
