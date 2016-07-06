# docker-shopware-dev

SSH (Root)  
Benutzer: root  
Passwort: nexus123  
  
SSH (Dev)  
Benutzer: nexus  
Passwort: nexus123  
  
Datanbank  
Benutzer: nexus  
Passwort: nexus123  
  
Run  
docker run --name <name> -d -p 22:22 -p 80:80 -p 3306:3306 nexusnetsoft/shopware-dev
