#!/bin/bash

for i in $(seq 1 100)
do
  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsConcurrentSimulation -Durl=http://localhost:8080 -Dtype=basic -Dusers=10

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsConcurrentSimulation -Durl=http://localhost:8080 -Dtype=gold -Dusers=10

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsConcurrentSimulation -Durl=http://localhost:8080 -Dtype=platinum -Dusers=10

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsRampSimulation -Durl=http://localhost:8080 -Dtype=basic -Dusers=10 -Dduration=60

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsRampSimulation -Durl=http://localhost:8080 -Dtype=gold -Dusers=10 -Dduration=60

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.PetsRampSimulation -Durl=http://localhost:8080 -Dtype=platinum -Dusers=10 -Dduration=60

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd common/
  mysql -u petclinic -ppetclinic petclinic < visits-use-case.sql
  cd ../../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.VisitsConcurrentSimulation -Durl=http://localhost:8080 -Dusers=10

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd common/
  mysql -u petclinic -ppetclinic petclinic < visits-use-case.sql
  cd ../../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.common.VisitsRampSimulation -Durl=http://localhost:8080 -Dusers=10 -Dduration=60

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.gold.CalendarFeatureSimulation -Durl=http://localhost:8080 -Dtype=gold -Did=1

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd ../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.gold.CalendarFeatureSimulation -Durl=http://localhost:8080 -Dtype=platinum -Did=1

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd platinum/
  mysql -u petclinic -ppetclinic petclinic < consultation-use-case.sql
  cd ../../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.platinum.ConsultationsConcurrentSimulation -Durl=http://localhost:8080 -Dusers=10

  cd src/test/resources/
  mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql
  cd platinum/
  mysql -u petclinic -ppetclinic petclinic < consultation-use-case.sql
  cd ../../../..
  ./mvnw gatling:test -Dgatling.simulationClass=petclinic.platinum.ConsultationsRampSimulation -Durl=http://localhost:8080 -Dusers=10 -Dduration=60
done
