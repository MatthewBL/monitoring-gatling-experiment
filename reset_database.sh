#!/bin/bash

cd src/test/resources/
mysql -u petclinic -ppetclinic petclinic < petclinic-schema.sql