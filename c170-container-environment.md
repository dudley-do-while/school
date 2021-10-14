## Container images for quick environment creation

This document describes the local environment that I used to develop my final project for C170 - Data Management.  I wanted a MySQL server that I could quickly destroy and recreate completely, ensuring I have a consistent starting point.  I did this by leveraging Docker containers and MySQL's official container image.  Follow along to set this up for yourself!  

The intended audience is a student early in their CS studies who have little or no experience at a terminal or with containers.  Feel free to open an issue to ask a question or PR to suggest an improvement.

### Prerequisites

Download and run the Docker Desktop application
https://www.docker.com/products/docker-desktop

Download the official MySQL image from a terminal run

```
docker pull mysql
```
this will download the image using Docker

### Starting a new container using the MySQL image

To start a Docker container named 'c170-db' from the image you pulled 'mysql' with the tag 'latest' passing in the environment variable MYSQL_ROOT_PASSWORD set to 'admin' (this sets the default mysql root user password) run

```
docker run --name c170-db -e MYSQL_ROOT_PASSWORD=admin -d mysql:latest
```

Now the container is running on your machine. Next execute the command 'bash' interactively on the container you created with

```
docker exec -it c170-db bash
```

Now you have a command prompt within the container. You can interact with the container as if it was a light weight linux vm (ls, cd, touch, etc but no top, man, etc). It has mysql running and many mysql utilities installed.

### Creating a DB and connecting to MySQL

To create a new database and connect to it from the container bash prompt.  Next use the utility 'mysqladmin' to create a new database named 'coffee' and prompt for the root mysql user's password

```
mysqladmin create coffee --password 
```

With that you have a database created and you can use the 'mysql' command line client to connect to the mysql server by running

```
mysql coffee --password
```

Now you are at a mysql server prompt, logged in as the root user, using your database and you can begin entering SQL statements and generally messing about!

### Getting back to a clean installation

The beauty of this lightweight and simple set up is that when you inevitably make a mess it is very easy to start over.  As an example you could exit mysql (exit mysql with `\q`) and the container (exit the container like a bash terminal, with `exit`) then stop or delete the container.  If you stop is make sure you a new name for your next container.

Run 

```
docker container rm c170-db
```
to delete the current container.

Now run 

```
docker run --name c170-db -e MYSQL_ROOT_PASSWORD=admin -d mysql:latest
```

again to start a new container and start over.

Alternatively, you could drop the DB you are working on if you've only made small changes.  Completely destroying the container and starting over is nice when experimenting with things like DB administration changes and breaking things you don't know how to fix.

Have fun and happy hacking!

### Further learning

Building up environments for class projects is a very useful skill as you'll find that many of the web-based environments offered by WGU are ... of questionable usability.  If you enjoyed this concept, check out Docker files and the concept of building up an image of your own.


