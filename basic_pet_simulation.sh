#!/bin/bash

cd /media/sf_shared_folder/petclinic-gatling/src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
cd ../../..
./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsConcurrentSimulation -Durl=http://localhost:8080 -Dtype=basic -Dusers=1