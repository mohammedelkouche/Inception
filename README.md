<div align="center">

# Inception

</div>

## About the project
This project from 42 school aims to broaden your knowledge of system administration by using Docker. IIn this tutorial You will virtualize several Docker images, creating them in your new personal virtual machine. In this read.me you will have an inception tutorial to know how the project works.

## The topics we will discuss in this README are:
- [What is Docker?](#what-is-docker)
- [Important commands to use docker](#Important-commands-to-use-docker)
- [How Does Docker Work?](#how-does-docker-work)
- [Docker Engine?](#Docker-Engine?)
- [What is a Dockerfile?](#what-is-a-dockerfile)
- [What is a Docker Compose?](#what-is-a-docker-compose)
- [How Does Docker Compose Work?](#how-does-docker-compose-work)
- [Docker Compose Commands](#Docker-Compose-Commands)
- [What is a Container?](#what-is-a-container)
- [What is The Difference Between a Container and a VM?](#what-is-the-difference-between-a-container-and-a-vm)
- [What is PID 1?](#What-is-PID-1)


## What is Docker? <a name="what-is-docker"></a>

Docker is a tool designed to allow you to build, deploy and run applications in an isolated and consistent manner across different machines and operating systems. This process is done using <strong>CONTAINERS</strong>. which are lightweight virtualized environments that package all the dependencies and code an application needs to run into a single text file, which can run the same way on any machine.  
While Docker is primarily used to package and run applications in containers, it is not limited to that use case. Docker can also be used to create and run other types of containers, such as ones for testing, development, or experimentation.
  
## Important commands to use docker <a name="Important-commands-to-use-docker"></a>

### General docker commands

```
- docker ps or docker ps -a //show the names of all the containers you have + the id you need and the port associated.
- docker pull "NameOfTheImage" // pull an image from dockerhub
- docker "Three first letter of your docker" // show the logs of your last run of dockers
- docker rm $(docker ps -a -q) //allow to delete all the opened images
- docker exec -it "Three first letter of your docker" sh // to execute the program with the shell****
```
### Docker run

```
- docker run "name of the docker image" //to run the docker image
- docker run -d, // run container in background
- docker run -p,// publish a container's port to the host
- docker run -P, // publish all exposed port to random ports
- docker run -it "imageName", //le programme continuera de fonctionner et on pourra interagir avec le container
- docker run -name sl mysql, //give a name for the container instead an ID
- docker run -d -p 7000:80 test:latest
```
### Docker image

Docker Image is a lightweight executable package that includes everything the application needs to run, including the code, runtime environment, system tools, libraries, and dependencies.

Although it cannot guarantee error-free performance, as the behavior of an application ultimately depends on many factors beyond the image itself, using Docker can reduce the likelihood of unexpected errors.

Docker Image is built from a DOCKERFILE, which is a simple text file that contains a set of instructions for building the image, with each instruction creating a new layer in the image.



```
- docker image rm -f "image name/id", //delete the image, if the image is running you need to kill it first.
- docker image kill "name", //stop a running image,
```

## How Does Docker Work? <a name="how-does-docker-work"></a>

Docker uses a client-server architecture, where Docker client talks to Docker daemon, which is responsible for building, running, and distributing all Docker containers. The Docker client and Docker daemon communicate using a REST API, over a UNIX socket or a network interface.

## Docker Engine? <a name="Docker-Engine?"></a>

- Docker Engine is a tool that allows for seamless management of resources and control of all containers running.
- The engine consists of a **Daemon** that manages containers and their running state in the background, **Command-Line Interface (CLI)** a user can interact with to pass commands/directives/inspect/remove containers/volumes/networks and finally an **API** that allows for communication between the **CLI** and the **Daemon**
- Docker Engine controls every aspect of a container from volumes and networks to the innard of a container, this allows for ease of building and deployment of containers without major issues setting in.
![Docker Engine](https://www.docker.com/wp-content/uploads/2021/10/Docker-Website-2018-Diagrams-071918-V5_a-Docker-Engine-page-first-panel.png)

## what is a dockerfile <a name="what-is-a-dockerfile"></a>

Dockerfile is that SIMPLE TEXT FILE that I mentioned earlier, which contains a set of instructions for building a Docker Image. It specifies the base image to use and then includes a series of commands that automate the process for configuring and building the image, such as installing packages, copying files, and setting environment variables. Each command in the Dockerfile creates a new layer in the image.

Here's an example of a Dockerfile to make things a little bit clear:


```
# This Specifies the base images for the container (in this case, it's the 3.14 version of Alpine)
FROM alpine:3.14

# This Run commands in the container shell and installs the specified packages
# (it will install nginx & OpenSSL, and will create the directory "/run/nginx" as well)
RUN apk update && \
    apk add nginx openssl && \
    mkdir -p /run/nginx

# This Copies the contents of "./conf/nginx.conf" on the host machine to the "/etc/nginx/http.d/"
# directory inside the container
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# This Specifies the command that will run when the container gets started
CMD ["nginx", "-g", "daemon off;"]
```

## What is a Docker Compose? <a name="what-is-a-docker-compose"></a>



Docker Compose is a powerful tool that simplifies the deployment and management of multi-container Docker applications. It provides several benefits, including simplifying the process of defining related services, volumes for data persistence, and networks for connecting containers. With Docker Compose, you can easily configure each service's settings, including the image to use, the ports to expose, and the environment variables to set...

Overall, Docker Compose streamlines the development process, making it easier for you to build and deliver your applications with greater efficiency and ease.

A Docker Compose has 3 important parts, which are:

Services: A service is a unit of work in Docker Compose, it has a name, and it defines container images, a set of environment variables, and a set of ports that are exposed to the host machine. When you run docker-compose up, Docker will create a new container for each service in your Compose file.

Networks: A network is a way for containers to communicate with each other. When you create a network in your Compose file, Docker will create a new network that all the other containers in your Compose file will be connected to. This allows containers to communicate with each other without even knowing the IP of each other, just by the name.

Volumes: A volume is a way to store data that is shared between containers. When you create a volume in your Compose file, Docker will create a new volume (a folder in another way) that all the containers have access to. This allows you to share data between the containers without having to copy-paste each and every time you want that data.

Here's an example of a Docker Compose to make things a little bit clear:

```
version: '3'

# All the services that you will work with should be declared under the SERVICES section!
services:

  # Name of the first service (for example nginx)
  nginx:
  
    # The hostname of the service (will be the same as the service name!)
    hostname: nginx
    
    # Where the service exists (path) so you can build it
    build:
      context: ./requirements/nginx
      dockerfile: Dockerfile
      
    # Restart to always keep the service restarting in case of any unexpected errors causing it to go down
    restart: always
    
    # This line explains itself!!!
    depends_on:
      - wordpress
      
    # The ports that will be exposed and you will work with
    ports:
      - 443:443
      
    # The volumes that you will be mounted when the container gets built
    volumes:
      - wordpress:/var/www/html
      
    # The networks that the container will connect and communicate with the other containers
    networks:
      - web
```

## how does docker compose work <a name="how-does-docker-compose-work"></a>

Docker Compose uses a YAML file to configure all the services, networks, and volumes that your application needs to. You can then with just a single command create and start all the services from your configuration. That's it. As simple as that.



## Docker Compose Commands <a name="Docker-Compose-Commands"></a>


```
- docker-compose up -d --build, //Create and build all the containers and they still run in the background
- docker-compose ps, //Check the status for all the containers
- docker-compose logs -f --tail 5, //see the first 5 lines of the logs of your containers
- docker-compose stop , //stop a stack of your docker compose
- Docker-compose down, //destroy all your ressources
- docker-compose config, //check the syntax of you docker-compose file
```

## What is a Container?   <a name="what-is-a-container"></a>

- Containerization, a Special functionallity of Docker and many other containerization programs, it **builds** and **packs**  and holds the software and it's dependencies in a single package called **image**. 
-  When this image is executed it turns into a **Container** and runs above an engine that controls the flow of data/resources (similar to a hypervisor but not quite) in this case it'll be the **Docker Engine**.


## What is The Difference Between a Container and a VM?  <a name="what-is-the-difference-between-a-container-and-a-vm"></a>

Containers and Virtual machines have similar resource isolation and allocation benefits but function differently because containers virtualize the operating system instead of the hardware. Containers are more portable and efficient.

* <ins><strong>Containers</strong></ins> are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (talks about tens of MBs in size), can handle more applications, and require fewer VMs and Operating Systems.

  <p align="center" width="100%">
    <img width="598" src="https://user-images.githubusercontent.com/63506492/233226746-6594ac04-341d-474e-b918-3df1d95c7b95.png">
  </p>
  
* <ins><strong>Virtual Machines (VMs)</strong></ins> are an abstraction of physical hardware turning one server into many servers. The hypervisor allows multiple VMs to run on a single machine. Each machine includes a full copy of an operating system, the application, necessary binaries, and libraries. VMs take more space compared to containers (talking about tens of GBs in size), and they can be slow to boot.
  
  <p align="center" width="100%">
    <img width="539" src="https://user-images.githubusercontent.com/63506492/233227532-82371157-98c5-469e-82b4-c7606ee17831.png">
  </p>

## What is PID 1?  <a name="What-is-PID-1"></a>

If we want what is PID 1 in docker, we must first know what is PID 1 itself and what its relation with Linux.

In a Unix-like operating system, Process ID 1, often referred to as PID 1, is a special process known as the init process. The init process is the first process started by the kernel during the system boot process, and it has a PID of 1.

The init process has a crucial role in the system. It is responsible for initializing the system and starting other processes. In modern Linux systems, init has been replaced by more advanced init systems such as systemd.

after we have covered what's PID in Linux we can say the same idea goes over here in our dockerfile, In Docker, the PID 1 inside a container is typically the main process that is specified in the container's entry point or command. Docker containers are designed to run a single main process, and when that process exits, the container is considered to have completed its task and will be stopped.

In the example of the MariaDB container, the mysqld becomes the main process, and Docker will run it as PID 1 inside the containe


























