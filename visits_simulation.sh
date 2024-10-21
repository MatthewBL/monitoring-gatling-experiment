#!/bin/bash

cd /media/sf_shared_folder/petclinic-gatling/src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
cd common/
mysql -u petclinic -ppetclinic petclinic < visits-use-case.sql
cd ../../../..
./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.VisitsConcurrentSimulation -Durl=http://localhost:8080 -Dusers=10