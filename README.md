# docker-hellorails
A Ruby On Rails server dockerized

boot2docker
-----------
To run locally use [boot2docker](http://boot2docker.io/)

If you're feeling lucky run
```
  ./boot2docker.sh
```
The main command to note is:
```
  docker-compose up -d
```  
which creates the containers and daemonizes them. 

Connect to Rails on:
```
  curl http://$(boot2docker ip)
```  
AWS Elastic Container Service (ECS)
--------------------------------------
This requires the [aws-cli:](http://aws.amazon.com/cli/), and leverages ECS via CloudFormation. Run aws.sh:
```
  ./aws.sh MyAWSSshKey example.com
```
# How does it work?
Containers (heavily namespaced processes) are connected via iptables (ports) and /etc/hosts entries (links).
## docker-compose.yml
This file instructs Docker on the containers (images) to create and how to connect them (*mongo* and **dcrbsltd/hellomongo_tomcat** images in this example).
### Containers/images
The **dcrbsltd/hellorails_web_** container is a **custom image** built from a base image.
#### Building an image
`cd` into the "web" directory - the **Dockerfile** instructs Docker on how to install apps and files.
```
  docker build -t yourdockername/hellorails_web .
```
#### Upload (push) the image
Push the image to Docker hub.
```
  docker push yourdockername/hellorails_web
```
## AWS
Now the **Docker** container is in the Cloud, it is available to Amazon and can be used by its **ECS** service.

The automated configuration of Amazon is controlled by the **CloudFormation** service and **JSON template**. 

### CloudFormation
The CloudFormation template: `aws/cf/template.json` orchestrates a virtualized environment by configuring services in AWS,

## Further reading

 * **boot2docker** http://boot2docker.io/
 * **docker-compose** https://docs.docker.com/compose/
 * **Dockerfile** https://docs.docker.com/reference/builder/
 * **aws-cli** http://aws.amazon.com/cli/
 * **boto** https://boto.readthedocs.org/en/latest/index.html
 * **ECS*** http://aws.amazon.com/ecs/
 * **route53** http://aws.amazon.com/route53/
 * **AutoScaling** http://aws.amazon.com/autoscaling/
 * **CloudFormation** http://aws.amazon.com/cloudformation/
 * **Elastic Loadbalancers**, http://aws.amazon.com/elasticloadbalancing/
 * **Compute** http://aws.amazon.com/ec2/

