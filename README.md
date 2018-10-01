# wiremock-docker
A docker containing standalone WireMock stub server for GTL 

### ToDo : Helper script which will help in bringup GTL server on AWS 

Currently we Need to follow below steps to stand up a server on AWS with mocked GTL server running on it. 

Steps to follow :
```
  1) Create a AWS VM instanse with ubuntu flavor and a public ip associated to it , so it can be access from MS cluster.
    a) Add a custom security group to allow Custom TCP 
        HTTP	TCP	80	0.0.0.0/0	
        HTTP	TCP	80	::/0	
        
  2) configure ngnix with basic auth configured
    To install ngnix.
      sudo apt-get update
      sudo apt install -y ngnix
      
    a) configure ngnix basic auth by 
    
       copy .htpasswd /etc/nginx/.htpasswd
                       or
            modify /etc/nginx/.htpasswd
            username:user/ Password: pass               
            using htpasswd generator creates passwords that are hashed  
        
    b) copy nginx-gtl-mock.conf to /etc/nginx/sites-enabled/wiremock
    
    c) delete the default file /etc/nginx/sites-enabled/default
    
    d) restart the ngnix server
    
  3) Docker build the mocked GTL server with below command.
  
        sudo docker build . -t wiremock-gtl
  
  4) Run the docker 
  
        sudo docker run -d -p 8584:8584 wiremock-gtl 8584
   
  5) Finally public ip should be accessable from outside
     it can be accessed using  
             
             http://public-ip-of-aws-vm/check?email=qe_comon@hpe.com
             
  This confirm that GTL is working
```  

### Patch for ncs/deployment 

### https://review.zing.ncsre.hpcloud.net/#/c/15942/

## How to revert the changes to Production GTL server

  https://review.zing.ncsre.hpcloud.net/#/c/15942/22/bin/deploy.sh

  ```
  # TODO: need a better way to figure this out when to skip or go for mocked GTL
  # Skipping only for Zing re DU's
  if [[ $DOMAIN_SUFFIX == "test.hpedevops.net" && $SHORTNAME =~ ncsre.* ]] ; then
    mispipe "$SCRIPT_DIR/secrets-creator-globaltrade-mock.sh 2>&1" 'ts "[global trade mock secrets] " '
    mispipe "echo Finished" 'ts "[global trade mock secrets] "'
  else
    mispipe "$SCRIPT_DIR/secrets-creator-globaltrade.sh 2>&1" 'ts "[global trade secrets] " '
    mispipe "echo Finished" 'ts "[global trade secrets] "'
  fi
  ```
  
  change to 
  
  ```
    mispipe "$SCRIPT_DIR/secrets-creator-globaltrade.sh 2>&1" 'ts "[global trade secrets] " '
    mispipe "echo Finished" 'ts "[global trade secrets] "'  
  ```
 
 ### AWS image back up is created (ami-09670543ff229d58c) which can be used to standup the Mocked GTL server.
  ```
  Create a AWS instance with above image.
  
    a) Add a custom security group to allow Custom TCP 
        HTTP	TCP	80	0.0.0.0/0	
        HTTP	TCP	80	::/0	
        
  sudo docker run -d -p 8584:8584 wiremock-gtl 8584
  ```  
 
 
