#!/bin/bash
set -e

mongosh <<EOF
db = db.getSiblingDB('admin');
// move to the admin db - always created in Mongo

db.auth(process.env.MONGO_INITDB_ROOT_USERNAME, process.env.MONGO_INITDB_ROOT_PASSWORD);

// create users in the admin database
db.createUser({
  'user': process.env.MONGO_USER,
  'pwd': process.env.MONGO_PASS,
  'roles': [
    { 'role': 'dbOwner', 'db': process.env.MONGO_INITDB_DATABASE },
    { 'role': 'dbOwner', 'db': process.env.MONGO_INITDB_DATABASETWO }]});
EOF
