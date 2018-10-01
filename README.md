# wiremock-docker
A docker containing standalone WireMock stub server for GTL 

### ToDo : Helper script which will help in bringup GTL server on AWS 

Currently we Need to follow below steps to stand up a server on AWS with mocked GTL server running on it. 

Steps to follow :
```
  1) Create a AWS VM instanse with ubuntu flavor (t2.micro) and a public ip associated to it , so it can be access from MS cluster.
    a) Add a custom security group to allow Custom TCP 
        HTTP	TCP	80	0.0.0.0/0	
        HTTP	TCP	80	::/0	
  
       sudo docker run --name docker-nginx -p 80:80 -v /root/docker-nginxc/default.conf:/etc/nginx/conf.d/default.conf -v /root/docker-nginxc/.htpasswd:/etc/nginx/.htpasswd -d nginx
       sudo docker build . –t wiremock-gtl
       sudo docker run -d -p 8584:8584 wiremock-gtl
       sudo docker restart docker-nginx
      
  ```  
 
 
