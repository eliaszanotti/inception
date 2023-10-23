# Inception
*42 project by Elias ZANOTTI. (README.md by Leon PUPIER)*

## Description
The Inception project serves as an introduction to the world of system and network administration. The primary objective is to create a Docker-based virtual machine capable of deploying various web services, including an Nginx web server, a WordPress server, and a MySQL database.

## Prerequisites
Before getting started, ensure that you have the following installed on your system:
- Docker: [Download Docker](https://www.docker.com/get-started)
- Docker Compose: [Download Docker Compose](https://docs.docker.com/compose/install/)

## Installation
1. Clone this repository to your local machine:
   ```
   git clone https://github.com/ezanotti/Inception.git
   ```
2. Navigate to the project directory:
   ```
   cd Inception
   ```
3. Start the Docker containers using Docker Compose by the Makefile:
   ```
   make
   ```

> [!NOTE] 
> You will need root privileges to execute this command
>
> If you encounter permission issues, you may need to run the following command as the root user:
> ```
> sudo make
> ```

## Usage
Once the containers are up and running, These services are implemented:
- Nginx Server
- WordPress: [http://ezanotti.42.fr](http://ezanotti.42.fr)
- MySQL