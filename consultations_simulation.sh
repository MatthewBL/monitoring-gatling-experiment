#!/bin/bash

cd /media/sf_shared_folder/petclinic-gatling/src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
cd platinum/
mysql -u petclinic -ppetclinic petclinic < consultation-use-case.sql
cd ../../../..
./mvnw gatling:test -Dgatling.simulationClass=petclinic.platinum.ConsultationsConcurrentSimulation -Durl=http://localhost:8080 -Dusers=1