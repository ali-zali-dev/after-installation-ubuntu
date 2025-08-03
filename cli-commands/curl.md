# Curl CLI Commands

## Basic HTTP Requests
```bash
# GET request
curl <url>
curl https://api.example.com/users

# POST request with data
curl -X POST -d "key=value" <url>
curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' <url>

# PUT request
curl -X PUT -d "data" <url>

# DELETE request
curl -X DELETE <url>
```

## Headers and Authentication
```bash
# Add custom headers
curl -H "Authorization: Bearer token" <url>
curl -H "Content-Type: application/json" <url>
curl -H "User-Agent: MyApp/1.0" <url>

# Multiple headers
curl -H "Header1: value1" -H "Header2: value2" <url>

# Basic authentication
curl -u username:password <url>
curl -u username <url>  # Will prompt for password
```

## Data and File Operations
```bash
# Send data from file
curl -X POST -d @data.json <url>
curl -X POST --data-binary @file.txt <url>

# Upload file
curl -F "file=@/path/to/file" <url>
curl -F "field=value" -F "file=@image.jpg" <url>

# Download file
curl -O <url>  # Save with remote filename
curl -o filename <url>  # Save with custom filename
```

## Response Handling
```bash
# Include response headers
curl -i <url>

# Only show headers
curl -I <url>
curl --head <url>

# Follow redirects
curl -L <url>

# Silent mode (no progress bar)
curl -s <url>

# Show only HTTP status code
curl -s -o /dev/null -w "%{http_code}" <url>
```

## Advanced Options
```bash
# Set timeout
curl --connect-timeout 10 <url>
curl --max-time 30 <url>

# Retry on failure
curl --retry 3 <url>

# Use proxy
curl --proxy proxy:port <url>
curl --proxy user:pass@proxy:port <url>

# Ignore SSL certificate errors
curl -k <url>
curl --insecure <url>

# Verbose output
curl -v <url>
curl --verbose <url>
```

## Cookie Handling
```bash
# Save cookies
curl -c cookies.txt <url>

# Send cookies
curl -b cookies.txt <url>
curl -b "name=value" <url>

# Both save and send cookies
curl -b cookies.txt -c cookies.txt <url>
```

## HTTP/2 and Modern Features
```bash
# Force HTTP/2
curl --http2 <url>

# Show timing information
curl -w "@curl-format.txt" <url>

# Custom curl format file content:
# time_namelookup:  %{time_namelookup}s
# time_connect:     %{time_connect}s
# time_appconnect:  %{time_appconnect}s
# time_pretransfer: %{time_pretransfer}s
# time_redirect:    %{time_redirect}s
# time_starttransfer: %{time_starttransfer}s
# time_total:       %{time_total}s
```

## Testing APIs
```bash
# Test JSON API
curl -X GET -H "Accept: application/json" <api-url>
curl -X POST -H "Content-Type: application/json" -d '{"name":"test"}' <api-url>

# Test with query parameters
curl "https://api.example.com/search?q=term&limit=10"

# Test different HTTP methods
curl -X GET <url>
curl -X POST <url>
curl -X PUT <url>
curl -X PATCH <url>
curl -X DELETE <url>
curl -X HEAD <url>
curl -X OPTIONS <url>
```

## Useful Aliases and Functions
```bash
# Add to .zshrc or .bashrc
alias curltime='curl -w "@curl-format.txt" -o /dev/null -s'
alias curljson='curl -H "Accept: application/json" -H "Content-Type: application/json"'

# Function to prettify JSON response
curlj() {
    curl -s "$1" | jq .
}
```