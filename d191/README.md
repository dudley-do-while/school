## Container image for quick environment creation

This document describes the local environment that I used to develop my final project for D191 - Advanced Data Management.  The provided Windows-based VM is awkward at best.  I noticed the dataset used is the public "dvdrental" database so I thought I'd make a quick Docker-based environment.  This has the added benefit that resetting your environment takes seconds instead of many minutes.  This one was a bit more involved that building the environment for C170 so I added the needed files here.  Follow along to set this up for yourself!  

The intended audience is a student early in their CS studies who have little experience at a terminal or with containers.  Feel free to open an issue to ask a question or PR to suggest an improvement.

### Prerequisites

Download and run the Docker Desktop application
https://www.docker.com/products/docker-desktop

Clone in to my repo 'school'
```
git clone https://github.com/dudley-do-while/school.git
```

### Setting up the environment

From a terminal navigate to the `/school/d191` folder.  Run `docker build` to build an image based on the included Dockerfile.  We'll give the image a tag of 'd191'.  

```
docker build -t d191 ./
```

Not sure about the contents of the Dockerfile?  See 'Exploring the Dockerfile' below.

Next we'll start a docker container based on our new image and call it 'dvdrental'.

```
docker run --name dvdrental -d d191
```

Now that the container is running we can connect to it and open a bash shell.

```
docker exec -it dvdrental bash
```

From the bash shell we can get a postgres shell with the 'dvdrental' database selected using the `psql` tool.

```
psql --username postgres --dbname dvdrental
```

From here we can input SQL and start figuring out the practical assessment.  

### Resetting the environment

One of the perks of this setup is how fast and easy it is to reset the environment.  The image we created from our Dockerfile has postgres installed and the 'dvdrental' database created.  Whenever we want to start over we can simply stop and destroy the current container and build a new one.

Destroy the current container.  

```
docker container kill dvdrental
```

And create a new one!

```
docker run --name dvdrental -d d191
```

### Exploring the Dockerfile

When we build our image using `docker build` docker uses the instructions in our Dockerfile (the last argument is `./` which tells `docker` to look for a Dockerfile in the directory we are in).  The first line of the Dockerfile 

```
FROM postgres:latest
```

tells docker to use the offical postgres image which is a light-weight linux installation with the latest version of postgres and some postgres tools installed.  The rest of the Dockerfile extends on this base image.  Next, we set the default password for postgres.  

```
ENV POSTGRES_PASSWORD admin
```

Finally, we copy a few files from our local directory to directories on the container.

```
COPY  --chown=postgres data/* /tmp/
COPY  --chown=postgres restore.sql /docker-entrypoint-initdb.d/
```

`--chown=postgres` sets the owner of the file to the user called postgres.  We copy everything in the `data/` directory, which is where I've stored all the data from the 'dvdrentals' dataset.  Then we copy the script `restore.sql` to the location `/docker-entrypoint-initdb.d/` which will be automatically run by the postgres user when the container starts.  In effect, we copy the data we need and tell the container to restore that data when it starts, thus giving us a clean, new installation with postgres installed and the database we need to use!  Happy hacking!