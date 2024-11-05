#!/bin/bash

# Change to the react-petclinic directory and run the Spring Boot application in the background
cd /media/sf_shared_folder/petclinic-gatling/src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
cd /media/sf_shared_folder/react-petclinic/
mvn spring-boot:run &