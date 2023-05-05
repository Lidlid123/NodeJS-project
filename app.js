const express = require('express');
const app = express();
const MongoClient = require('mongodb').MongoClient;
const url = 'mongodb://172.31.81.230:27017';
const dbName = 'mydb';

let db;

MongoClient.connect(url, { useUnifiedTopology: true },function(err, client) {
  if (err) throw err;
  console.log("Connected successfully to server");
  db = client.db(dbName);
});

app.get('/', (req, res) => {
  db.collection('fruits').find({name: 'apples'}).toArray((err, result) => {
    if (err) throw err;
    res.send(`Hello World! from lidor (: We have ${result[0].qty} apples.`);
  });
});

app.listen(3000, () => {
  console.log('Example app listening on port 3000!');
});
