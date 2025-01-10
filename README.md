# mini-proj-file-rouge

I. web-app
1/Copie du fichier app

![alt text](images/image.png)

2/Creation du container

 docker build -t mortalla/ic-webapp:v1.0 .

![alt text](images/image-1.png)

 docker run -d --name=test-ic-webapp mortalla/ic-webapp:v1.0

 ![alt text](images/image-2.png)

 3/Push to the DockerHub

 docker push mortalla/ic-webapp:v1.0

 ![alt text](images/image-3.png)

 ![alt text](images/image-4.png)

 II. Ansible Role

 III. Jenkinsfile Pipeline