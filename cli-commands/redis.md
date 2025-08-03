# Redis CLI Commands

## Connection and Basic Operations
```bash
# Connect to Redis
redis-cli                        # Connect to localhost:6379
redis-cli -h hostname -p 6380    # Connect to specific host/port
redis-cli -a password            # Connect with password
redis-cli --raw                  # Raw output format

# Test connection
ping
echo "Hello Redis"

# Authentication
AUTH password

# Select database (0-15 by default)
SELECT 0
SELECT 1
```

## String Operations
```bash
# Set/Get values
SET key "value"
GET key
SET name "John Doe"
GET name

# Set with expiration
SET key "value" EX 60        # Expires in 60 seconds
SET key "value" PX 60000     # Expires in 60000 milliseconds
SETEX key 60 "value"         # Set with 60 second expiration

# Set only if not exists
SETNX key "value"

# Multiple set/get
MSET key1 "value1" key2 "value2"
MGET key1 key2

# Increment/Decrement
INCR counter
DECR counter
INCRBY counter 5
DECRBY counter 3

# String manipulation
APPEND key " additional text"
STRLEN key
GETRANGE key 0 4  # Get substring
```

## Hash Operations
```bash
# Set/Get hash fields
HSET user:1 name "John" email "john@example.com" age 30
HGET user:1 name
HMGET user:1 name email

# Get all hash fields
HGETALL user:1

# Check if field exists
HEXISTS user:1 name

# Delete field
HDEL user:1 age

# Get all fields or values
HKEYS user:1
HVALS user:1

# Increment hash field
HINCRBY user:1 age 1
```

## List Operations
```bash
# Push to list
LPUSH mylist "item1"          # Push to left
RPUSH mylist "item2"          # Push to right
LPUSH queue "task1" "task2"   # Push multiple

# Pop from list
LPOP mylist                   # Pop from left
RPOP mylist                   # Pop from right
BLPOP mylist 10              # Blocking pop (wait 10 seconds)

# Get list elements
LRANGE mylist 0 -1           # Get all elements
LRANGE mylist 0 2            # Get first 3 elements
LLEN mylist                  # List length
LINDEX mylist 0              # Get element at index

# Set element at index
LSET mylist 0 "new value"

# Trim list
LTRIM mylist 0 9             # Keep only first 10 elements
```

## Set Operations
```bash
# Add/Remove members
SADD myset "member1" "member2"
SREM myset "member1"

# Check membership
SISMEMBER myset "member1"

# Get all members
SMEMBERS myset

# Set operations
SINTER set1 set2             # Intersection
SUNION set1 set2             # Union
SDIFF set1 set2              # Difference

# Random members
SRANDMEMBER myset            # Get random member
SPOP myset                   # Pop random member

# Set size
SCARD myset
```

## Sorted Set Operations
```bash
# Add members with scores
ZADD leaderboard 100 "player1" 200 "player2" 150 "player3"

# Get members by rank
ZRANGE leaderboard 0 -1                    # All members (low to high score)
ZRANGE leaderboard 0 -1 WITHSCORES         # With scores
ZREVRANGE leaderboard 0 2                  # Top 3 (high to low score)

# Get members by score
ZRANGEBYSCORE leaderboard 100 200
ZREVRANGEBYSCORE leaderboard 200 100

# Get rank and score
ZRANK leaderboard "player1"                # Rank (0-based)
ZREVRANK leaderboard "player1"             # Reverse rank
ZSCORE leaderboard "player1"               # Score

# Remove members
ZREM leaderboard "player1"
ZREMRANGEBYRANK leaderboard 0 2            # Remove by rank
ZREMRANGEBYSCORE leaderboard 0 100         # Remove by score

# Increment score
ZINCRBY leaderboard 10 "player1"

# Count and size
ZCARD leaderboard                          # Number of members
ZCOUNT leaderboard 100 200                 # Count in score range
```

## Key Management
```bash
# List keys
KEYS *                       # All keys (dangerous on large datasets)
KEYS user:*                  # Keys matching pattern
SCAN 0 MATCH user:* COUNT 10 # Safe way to iterate keys

# Key information
EXISTS key
TYPE key
TTL key                      # Time to live in seconds
PTTL key                     # Time to live in milliseconds

# Set expiration
EXPIRE key 60                # Expire in 60 seconds
EXPIREAT key 1640995200      # Expire at timestamp
PERSIST key                  # Remove expiration

# Delete keys
DEL key
DEL key1 key2 key3
UNLINK key                   # Async delete (non-blocking)

# Rename keys
RENAME oldkey newkey
RENAMENX oldkey newkey       # Rename only if newkey doesn't exist
```

## Database Operations
```bash
# Database info
DBSIZE                       # Number of keys in current database
INFO                         # Server information
INFO memory                  # Memory usage info
INFO replication            # Replication info

# Clear database
FLUSHDB                      # Clear current database
FLUSHALL                     # Clear all databases

# Save database
SAVE                         # Synchronous save
BGSAVE                       # Background save
LASTSAVE                     # Last save timestamp
```

## Pub/Sub Operations
```bash
# Publisher
PUBLISH channel "message"
PUBLISH news "Breaking news!"

# Subscriber (in separate connection)
SUBSCRIBE channel
SUBSCRIBE news sports
UNSUBSCRIBE channel

# Pattern subscription
PSUBSCRIBE news:*
PUNSUBSCRIBE news:*

# Check subscriptions
PUBSUB CHANNELS             # List active channels
PUBSUB NUMSUB channel       # Number of subscribers
```

## Transactions
```bash
# Transaction block
MULTI
SET key1 "value1"
INCR counter
EXEC                        # Execute all commands

# Discard transaction
MULTI
SET key1 "value1"
DISCARD                     # Cancel transaction

# Watch keys (optimistic locking)
WATCH key1
MULTI
SET key1 "new value"
EXEC                        # Fails if key1 was modified
```

## Redis with Docker
```bash
# Run Redis container
docker run -d --name redis -p 6379:6379 redis:latest

# Run with password
docker run -d --name redis \
  -p 6379:6379 \
  redis:latest redis-server --requirepass mypassword

# Connect to containerized Redis
docker exec -it redis redis-cli

# Run with persistence
docker run -d --name redis \
  -v redis_data:/data \
  -p 6379:6379 \
  redis:latest redis-server --appendonly yes

# Using docker-compose
version: '3.8'
services:
  redis:
    image: redis:latest
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes
volumes:
  redis_data:
```

## Configuration
```bash
# Get configuration
CONFIG GET "*"
CONFIG GET "maxmemory"
CONFIG GET "save"

# Set configuration
CONFIG SET maxmemory 100mb
CONFIG SET save "900 1 300 10"

# Reset configuration
CONFIG RESETSTAT            # Reset statistics
```

## Performance and Monitoring
```bash
# Monitor commands
MONITOR                      # Show all commands in real-time

# Performance testing
redis-benchmark              # Basic benchmark
redis-benchmark -c 50 -n 10000  # 50 clients, 10k requests

# Memory analysis
MEMORY USAGE key
MEMORY STATS
MEMORY DOCTOR

# Slow log
SLOWLOG GET 10              # Get last 10 slow commands
SLOWLOG LEN                 # Number of slow commands
SLOWLOG RESET               # Clear slow log

# Client connections
CLIENT LIST                 # List connected clients
CLIENT KILL ip:port         # Kill specific client
CLIENT SETNAME "myapp"      # Set client name
```

## Backup and Restore
```bash
# Create backup (RDB)
BGSAVE                      # Background save
# Copy dump.rdb file from Redis data directory

# Create backup (AOF)
BGREWRITEAOF               # Rewrite AOF file

# Point-in-time backup script
redis-cli --rdb backup.rdb

# Restore from backup
# 1. Stop Redis
# 2. Replace dump.rdb with backup
# 3. Start Redis
```

## Redis Modules and Extensions
```bash
# Load module
MODULE LOAD /path/to/module.so

# List loaded modules
MODULE LIST

# RedisJSON (if installed)
JSON.SET user:1 $ '{"name":"John","age":30}'
JSON.GET user:1

# RedisGraph (if installed)
GRAPH.QUERY social "CREATE (p:Person {name: 'John', age: 30})"

# RedisSearch (if installed)
FT.CREATE idx ON HASH PREFIX 1 user: SCHEMA name TEXT age NUMERIC
```

## Useful Aliases and Functions
```bash
# Add to .zshrc or .bashrc
alias rediscli='redis-cli'
alias redislocal='redis-cli -h localhost -p 6379'
alias redismon='redis-cli monitor'

# Functions
redis-info() {
    redis-cli info | grep -E "(used_memory_human|connected_clients|total_commands_processed)"
}

redis-keys-count() {
    redis-cli eval "return #redis.call('keys', ARGV[1])" 0 "${1:-*}"
}

redis-flush-pattern() {
    redis-cli --scan --pattern "$1" | xargs -r redis-cli del
}
```

## Common Patterns and Use Cases
```bash
# Session storage
SET session:abc123 "user_data" EX 3600

# Rate limiting
INCR rate_limit:user:123
EXPIRE rate_limit:user:123 60

# Caching with TTL
SET cache:user:123 "user_data" EX 300

# Distributed locking
SET lock:resource "token" EX 10 NX

# Queue implementation
LPUSH queue:tasks "task_data"
BRPOP queue:tasks 0

# Real-time analytics
ZINCRBY page_views:daily 1 "homepage"
ZREVRANGE page_views:daily 0 9 WITHSCORES
```