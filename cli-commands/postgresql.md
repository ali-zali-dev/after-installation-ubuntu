# PostgreSQL CLI Commands

## psql (PostgreSQL Interactive Terminal)
```bash
# Connect to PostgreSQL
psql                              # Connect as current user to default DB
psql -U username                  # Connect as specific user
psql -U username -d database      # Connect to specific database
psql -h hostname -p 5432 -U username -d database

# Connect with password prompt
psql -U username -W

# Connect using connection string
psql "postgresql://username:password@host:port/database"
psql "postgres://user:pass@localhost/mydb"
```

## Database Operations
```sql
-- List databases
\l
\list

-- Connect to database
\c database_name
\connect database_name

-- Show current database
SELECT current_database();

-- Create database
CREATE DATABASE myapp;
CREATE DATABASE myapp OWNER username;

-- Drop database
DROP DATABASE myapp;

-- Database size
SELECT pg_size_pretty(pg_database_size('database_name'));
```

## Schema and Table Operations
```sql
-- List schemas
\dn

-- Set search path
SET search_path TO schema_name;

-- List tables
\dt
\dt schema_name.*

-- Describe table
\d table_name
\d+ table_name  -- More details

-- List all relations
\d

-- Create table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drop table
DROP TABLE table_name;
DROP TABLE IF EXISTS table_name;

-- Alter table
ALTER TABLE users ADD COLUMN age INTEGER;
ALTER TABLE users DROP COLUMN age;
ALTER TABLE users RENAME COLUMN username TO user_name;
```

## User and Permission Management
```sql
-- List users/roles
\du

-- Create user
CREATE USER username WITH PASSWORD 'password';
CREATE ROLE rolename LOGIN PASSWORD 'password';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE dbname TO username;
GRANT SELECT, INSERT, UPDATE ON table_name TO username;
GRANT ALL ON ALL TABLES IN SCHEMA public TO username;

-- Revoke privileges
REVOKE ALL PRIVILEGES ON DATABASE dbname FROM username;

-- Change password
ALTER USER username WITH PASSWORD 'newpassword';

-- Drop user
DROP USER username;
```

## Data Operations (CRUD)

### Insert Data
```sql
-- Insert single row
INSERT INTO users (username, email) VALUES ('john', 'john@example.com');

-- Insert multiple rows
INSERT INTO users (username, email) VALUES 
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com');

-- Insert and return
INSERT INTO users (username, email) VALUES ('jane', 'jane@example.com') RETURNING id;
```

### Query Data
```sql
-- Basic select
SELECT * FROM users;
SELECT username, email FROM users;

-- With conditions
SELECT * FROM users WHERE age > 25;
SELECT * FROM users WHERE username LIKE 'j%';
SELECT * FROM users WHERE created_at > '2023-01-01';

-- Ordering and limiting
SELECT * FROM users ORDER BY created_at DESC LIMIT 10;
SELECT * FROM users ORDER BY username ASC OFFSET 5 LIMIT 10;

-- Aggregation
SELECT COUNT(*) FROM users;
SELECT AVG(age) FROM users;
SELECT department, COUNT(*) FROM users GROUP BY department;
```

### Update Data
```sql
-- Update records
UPDATE users SET age = 30 WHERE username = 'john';
UPDATE users SET age = age + 1 WHERE age < 30;

-- Update and return
UPDATE users SET age = 31 WHERE username = 'john' RETURNING *;
```

### Delete Data
```sql
-- Delete records
DELETE FROM users WHERE age < 18;
DELETE FROM users WHERE username = 'john';

-- Delete all (truncate is faster)
DELETE FROM users;
TRUNCATE TABLE users;
```

## Indexes
```sql
-- Create indexes
CREATE INDEX idx_users_email ON users(email);
CREATE UNIQUE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_name_age ON users(username, age);

-- List indexes
\di

-- Drop index
DROP INDEX idx_users_email;

-- Analyze index usage
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM users WHERE email = 'john@example.com';
```

## Backup and Restore
```bash
# Backup database
pg_dump -U username -h hostname database_name > backup.sql
pg_dump -U username -h hostname -Fc database_name > backup.dump  # Custom format

# Backup specific tables
pg_dump -U username -h hostname -t table_name database_name > table_backup.sql

# Backup with compression
pg_dump -U username -h hostname database_name | gzip > backup.sql.gz

# Restore database
psql -U username -h hostname database_name < backup.sql
pg_restore -U username -h hostname -d database_name backup.dump

# Restore from compressed backup
gunzip -c backup.sql.gz | psql -U username -h hostname database_name
```

## PostgreSQL with Docker
```bash
# Run PostgreSQL container
docker run -d --name postgres \
  -e POSTGRES_DB=myapp \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypass \
  -p 5432:5432 \
  postgres:15

# Connect to containerized PostgreSQL
docker exec -it postgres psql -U myuser -d myapp

# Run with volume for data persistence
docker run -d --name postgres \
  -e POSTGRES_DB=myapp \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypass \
  -v postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:15

# Using docker-compose
version: '3.8'
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypass
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
volumes:
  postgres_data:
```

## Performance and Monitoring
```sql
-- Show running queries
SELECT pid, now() - pg_stat_activity.query_start AS duration, query 
FROM pg_stat_activity 
WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes';

-- Kill query
SELECT pg_cancel_backend(pid);
SELECT pg_terminate_backend(pid);

-- Database statistics
SELECT * FROM pg_stat_database WHERE datname = 'myapp';

-- Table statistics
SELECT * FROM pg_stat_user_tables;

-- Index usage
SELECT * FROM pg_stat_user_indexes;

-- Table sizes
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Analyze query performance
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'john@example.com';
```

## PostgreSQL Configuration
```bash
# Find config files
SHOW config_file;
SHOW hba_file;
SHOW data_directory;

# View settings
SHOW all;
SHOW max_connections;
SHOW shared_buffers;

# Reload configuration
SELECT pg_reload_conf();
```

## psql Meta-commands
```sql
-- Help
\?              -- List all meta-commands
\h              -- SQL command help
\h CREATE TABLE -- Help for specific command

-- Connection info
\conninfo       -- Current connection info
\du             -- List users
\l              -- List databases
\dn             -- List schemas

-- Table info
\dt             -- List tables
\di             -- List indexes
\dv             -- List views
\df             -- List functions
\dp             -- List table privileges

-- Output formatting
\x              -- Toggle expanded output
\pset           -- Set output options
\timing         -- Toggle timing

-- File operations
\i filename     -- Execute commands from file
\o filename     -- Send output to file
\o              -- Send output to stdout

-- Variables
\set var value  -- Set variable
\echo :var      -- Display variable

-- Quit
\q              -- Quit psql
```

## Useful PostgreSQL Functions
```sql
-- Date/time functions
SELECT NOW();
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT EXTRACT(YEAR FROM NOW());

-- String functions
SELECT UPPER('hello');
SELECT LOWER('HELLO');
SELECT LENGTH('hello');
SELECT SUBSTRING('hello' FROM 2 FOR 3);

-- Math functions
SELECT ROUND(3.14159, 2);
SELECT CEIL(3.2);
SELECT FLOOR(3.8);

-- System functions
SELECT version();
SELECT current_user;
SELECT current_database();
```

## Environment Variables
```bash
# PostgreSQL environment variables
export PGHOST=localhost
export PGPORT=5432
export PGUSER=myuser
export PGPASSWORD=mypass
export PGDATABASE=myapp

# Connection with environment variables
psql  # Uses environment variables
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias pglocal='psql -h localhost -U postgres'
alias pgdev='psql -h dev-server -U myuser -d myapp'
alias pgprod='psql -h prod-server -U myuser -d myapp'

# Functions for common operations
pg-backup() {
    pg_dump -h localhost -U postgres $1 > "${1}_$(date +%Y%m%d).sql"
}

pg-restore() {
    psql -h localhost -U postgres $1 < $2
}

pg-size() {
    psql -h localhost -U postgres -c "SELECT pg_size_pretty(pg_database_size('$1'));"
}
```

## Common SQL Patterns
```sql
-- Create table with common constraints
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    category_id INTEGER REFERENCES categories(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Update timestamp trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_products_updated_at BEFORE UPDATE
ON products FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Pagination
SELECT * FROM users ORDER BY id LIMIT 20 OFFSET 40;

-- Window functions
SELECT 
    name, 
    salary,
    RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;
```