#!/bin/bash

test=123
mongo mongodb://master:27017 --eval="rs.initiate(); rs.add('slave');"
sleep 5;
mongo mongodb://master:27017/test --eval="db.test.insertOne({status: $test})"
sleep 3;
mongo mongodb://slave:27017/test --eval="rs.slaveOk(); db.test.find();" | grep $test;
