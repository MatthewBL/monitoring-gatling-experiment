#!/bin/bash

cd /media/sf_shared_folder/petclinic-gatling/src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
cd ../../..
./mvnw gatling:test -Dgatling.simulationClass=petclinic.gold.CalendarFeatureSimulation -Durl=http://localhost:8080 -Dtype=platinum -Did=1