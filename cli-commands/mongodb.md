# MongoDB CLI Commands

## MongoDB Shell (mongosh)
```bash
# Connect to MongoDB
mongosh                           # Connect to local instance
mongosh "mongodb://localhost:27017"
mongosh "mongodb://user:pass@host:port/database"
mongosh --host localhost --port 27017

# Connect to specific database
mongosh myDatabase
mongosh "mongodb://localhost:27017/myDatabase"
```

## Database Operations
```javascript
// Show databases
show dbs
show databases

// Switch to database
use myDatabase

// Show current database
db

// Create database (implicitly created when first document is inserted)
use newDatabase
db.collection.insertOne({name: "test"})

// Drop database
db.dropDatabase()

// Database stats
db.stats()
```

## Collection Operations
```javascript
// Show collections
show collections
show tables

// Create collection
db.createCollection("users")
db.createCollection("users", {capped: true, size: 100000})

// Drop collection
db.users.drop()

// Collection stats
db.users.stats()

// Rename collection
db.users.renameCollection("customers")
```

## Document Operations (CRUD)

### Insert Documents
```javascript
// Insert one document
db.users.insertOne({name: "John", age: 30, email: "john@example.com"})

// Insert multiple documents
db.users.insertMany([
  {name: "Alice", age: 25, email: "alice@example.com"},
  {name: "Bob", age: 35, email: "bob@example.com"}
])

// Insert with custom _id
db.users.insertOne({_id: 1, name: "Custom ID User"})
```

### Find Documents
```javascript
// Find all documents
db.users.find()
db.users.find().pretty()

// Find specific documents
db.users.findOne({name: "John"})
db.users.find({age: {$gt: 25}})
db.users.find({age: {$gte: 25, $lt: 40}})

// Find with projection
db.users.find({}, {name: 1, email: 1})
db.users.find({}, {age: 0})  // Exclude age

// Find with limit and sort
db.users.find().limit(5)
db.users.find().sort({age: 1})    // Ascending
db.users.find().sort({age: -1})   // Descending
db.users.find().skip(10).limit(5)
```

### Update Documents
```javascript
// Update one document
db.users.updateOne(
  {name: "John"},
  {$set: {age: 31}}
)

// Update multiple documents
db.users.updateMany(
  {age: {$lt: 30}},
  {$set: {status: "young"}}
)

// Replace document
db.users.replaceOne(
  {name: "John"},
  {name: "John Doe", age: 32, email: "johndoe@example.com"}
)

// Update with upsert
db.users.updateOne(
  {name: "Jane"},
  {$set: {name: "Jane", age: 28}},
  {upsert: true}
)

// Update operators
db.users.updateOne({name: "John"}, {$inc: {age: 1}})      // Increment
db.users.updateOne({name: "John"}, {$unset: {status: ""}}) // Remove field
db.users.updateOne({name: "John"}, {$push: {hobbies: "reading"}}) // Add to array
```

### Delete Documents
```javascript
// Delete one document
db.users.deleteOne({name: "John"})

// Delete multiple documents
db.users.deleteMany({age: {$lt: 25}})

// Delete all documents
db.users.deleteMany({})
```

## Indexing
```javascript
// Create indexes
db.users.createIndex({email: 1})           // Single field
db.users.createIndex({name: 1, age: -1})   // Compound index
db.users.createIndex({email: 1}, {unique: true})  // Unique index
db.users.createIndex({description: "text"}) // Text index

// List indexes
db.users.getIndexes()

// Drop indexes
db.users.dropIndex({email: 1})
db.users.dropIndex("email_1")
db.users.dropIndexes()  // Drop all except _id
```

## Aggregation Pipeline
```javascript
// Basic aggregation
db.users.aggregate([
  {$match: {age: {$gte: 25}}},
  {$group: {_id: "$department", avgAge: {$avg: "$age"}}},
  {$sort: {avgAge: -1}}
])

// Common aggregation stages
db.users.aggregate([
  {$match: {status: "active"}},           // Filter documents
  {$project: {name: 1, age: 1}},         // Select fields
  {$sort: {age: -1}},                    // Sort
  {$limit: 10},                          // Limit results
  {$skip: 5},                            // Skip documents
  {$group: {_id: "$department", count: {$sum: 1}}}, // Group and count
  {$lookup: {                            // Join collections
    from: "departments",
    localField: "deptId",
    foreignField: "_id",
    as: "department"
  }}
])
```

## MongoDB with Docker
```bash
# Run MongoDB container
docker run -d --name mongodb -p 27017:27017 mongo:latest

# Run with authentication
docker run -d --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  -p 27017:27017 \
  mongo:latest

# Connect to containerized MongoDB
docker exec -it mongodb mongosh

# Run with volume for data persistence
docker run -d --name mongodb \
  -v mongodb_data:/data/db \
  -p 27017:27017 \
  mongo:latest
```

## Backup and Restore
```bash
# Backup database
mongodump --db myDatabase --out /backup/

# Backup specific collection
mongodump --db myDatabase --collection users --out /backup/

# Backup with authentication
mongodump --host localhost:27017 --username admin --password password --authenticationDatabase admin --db myDatabase --out /backup/

# Restore database
mongorestore --db myDatabase /backup/myDatabase/

# Restore with drop existing
mongorestore --db myDatabase --drop /backup/myDatabase/

# Export to JSON
mongoexport --db myDatabase --collection users --out users.json

# Import from JSON
mongoimport --db myDatabase --collection users --file users.json
```

## Performance and Monitoring
```javascript
// Show current operations
db.currentOp()

// Kill operation
db.killOp(opId)

// Profiler
db.setProfilingLevel(2)  // Profile all operations
db.setProfilingLevel(1, {slowms: 100})  // Profile slow operations
db.system.profile.find().limit(5).sort({ts: -1}).pretty()

// Explain query
db.users.find({age: {$gt: 25}}).explain("executionStats")

// Index usage
db.users.find().hint({email: 1})  // Force index usage
```

## Replica Set Operations
```bash
# Initialize replica set
mongosh --eval "rs.initiate()"

# Check replica set status
mongosh --eval "rs.status()"

# Add member to replica set
mongosh --eval "rs.add('mongodb2:27017')"

# Remove member
mongosh --eval "rs.remove('mongodb2:27017')"
```

## Useful MongoDB Commands
```javascript
// Database administration
db.adminCommand("listCollections")
db.adminCommand("serverStatus")
db.adminCommand("dbStats")

// Connection info
db.runCommand({connectionStatus: 1})

// Validate collection
db.users.validate()

// Compact collection
db.runCommand({compact: "users"})

// Get collection size
db.users.totalSize()
db.users.dataSize()
```

## MongoDB Configuration
```yaml
# mongod.conf example
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true

systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

net:
  port: 27017
  bindIp: 127.0.0.1

security:
  authorization: enabled
```

## Useful Aliases and Functions
```bash
# Add to .zshrc or .bashrc
alias mongo='mongosh'
alias mongolocal='mongosh "mongodb://localhost:27017"'

# Function to quickly connect to different environments
mongo-dev() {
    mongosh "mongodb://localhost:27017/dev-db"
}

mongo-prod() {
    mongosh "mongodb://user:pass@prod-host:27017/prod-db"
}
```