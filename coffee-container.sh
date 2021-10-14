# Download and run Docker Desktop
# https://www.docker.com/products/docker-desktop

# Download the official MySQL image
# from a terminal run
docker pull mysql
# to download the image using Docker

# to start a docker container named 'c170-db' 
# from the image you pulled 'mysql' with the tag 'latest'
# passing in the environment variable MYSQL_ROOT_PASSWORD set to 'admin' (this sets the default mysql root user password)
# run
docker run --name c170-db -e MYSQL_ROOT_PASSWORD=admin -d mysql:latest

# now the container is running on your machine
# next execute the command 'bash' (bash shell) interactively on the container you created with
docker exec -it c170-db bash

# now you have a command prompt within the container
# you can interact with the container as if it was a light weight linux vm (ls, cd, touch, etc but no top, man, etc)
# it has mysql running and many mysql utilities installed

# now to create a new database and connect to it
# from the container bash prompt
# next use the utility 'mysqladmin' to create a new database named 'coffee' and prompt for the root mysql user's password
mysqladmin create coffee --password 
# enter the root mysql user's password
# now that you have a database created you can use the 'mysql' command line client to connect to the mysql server by running
mysql coffee --password
# now you are at a mysql server prompt, logged in as the root user, using your database
# you can begin entering SQL statements and generally messing about!

# the beauty of this lightweight and simple set up is that when you inevitably make a mess 
# it is very easy to start over
# simply exit mysql (exit mysql with '\q') and the container (exit the container like a bash terminal, with 'exit')
# then DELETE the container (not STOP, but DELETE)
docker container rm c170-db

# now start back at 
docker run --name c170-db -e MYSQL_ROOT_PASSWORD=admin -d mysql:latest
# to start a new container and start over

# alternatively, you could drop the DB you are working on if you've only made small changes.  
# completely destroying the container and starting over is nice when experimenting with DB administration changes.

#  have fun and happy hacking!
