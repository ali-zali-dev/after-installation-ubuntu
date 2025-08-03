# Go CLI Commands

## Installation and Setup
```bash
# Download and install Go
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz

# Add to PATH (.zshrc or .bashrc)
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Verify installation
go version
go env
```

## Project Management
```bash
# Initialize module
go mod init <module-name>
go mod init github.com/username/project

# Download dependencies
go mod download
go mod tidy              # Clean up dependencies

# Add dependency
go get <package>
go get github.com/gin-gonic/gin
go get github.com/gin-gonic/gin@v1.7.0  # Specific version

# Remove dependency
go mod edit -droprequire=<package>

# Update dependencies
go get -u               # Update all
go get -u <package>     # Update specific package
```

## Building and Running
```bash
# Run Go program
go run main.go
go run .                # Run package in current directory
go run *.go             # Run all Go files

# Build executable
go build                # Build current package
go build main.go        # Build specific file
go build -o myapp       # Build with custom name

# Install binary to GOPATH/bin
go install
go install <package>

# Cross-compilation
GOOS=linux GOARCH=amd64 go build
GOOS=windows GOARCH=amd64 go build
GOOS=darwin GOARCH=amd64 go build
```

## Testing
```bash
# Run tests
go test                 # Test current package
go test ./...           # Test all packages recursively
go test -v              # Verbose output
go test -cover          # Show coverage
go test -race           # Race condition detection

# Benchmark tests
go test -bench=.        # Run all benchmarks
go test -bench=BenchmarkFunction
go test -benchmem       # Memory allocation stats

# Test specific functions
go test -run TestFunction
go test -run "TestUser.*"  # Pattern matching
```

## Code Quality and Analysis
```bash
# Format code
go fmt                  # Format current package
go fmt ./...            # Format all packages
gofmt -w .              # Format and write changes

# Vet code (find potential issues)
go vet
go vet ./...

# Generate documentation
go doc <package>
go doc fmt.Println
godoc -http=:6060       # Start doc server

# Static analysis
go install honnef.co/go/tools/cmd/staticcheck@latest
staticcheck ./...
```

## Package Management
```bash
# List modules
go list -m all          # All dependencies
go list -m -versions <package>  # Available versions

# Show module info
go mod graph            # Dependency graph
go mod why <package>    # Why package is needed
go mod vendor           # Create vendor directory

# Clean module cache
go clean -modcache
```

## Workspace Commands
```bash
# List packages
go list                 # Current package
go list ./...           # All local packages
go list std             # Standard library packages

# Show build info
go version -m <binary>

# Environment info
go env                  # All environment variables
go env GOPATH
go env GOROOT
```

## Common Tools
```bash
# Install useful tools
go install golang.org/x/tools/cmd/goimports@latest  # Auto-import organizer
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest  # Linter
go install github.com/air-verse/air@latest  # Live reload

# Use goimports (better than gofmt)
goimports -w .

# Use golangci-lint
golangci-lint run

# Use air for live reload
air init                # Initialize .air.toml
air                     # Start development with live reload
```

## Debugging
```bash
# Install delve debugger
go install github.com/go-delve/delve/cmd/dlv@latest

# Debug commands
dlv debug               # Debug current package
dlv debug main.go
dlv test                # Debug tests
dlv attach <pid>        # Attach to running process

# Build with debug info
go build -gcflags="all=-N -l" main.go
```

## Performance and Profiling
```bash
# Build race detector enabled
go build -race main.go

# CPU profiling
go tool pprof cpu.prof

# Memory profiling
go tool pprof mem.prof

# Trace execution
go tool trace trace.out

# Benchmark with profiling
go test -bench=. -cpuprofile=cpu.prof
go test -bench=. -memprofile=mem.prof
```

## Go Modules Example
```go
// go.mod file
module github.com/username/myproject

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/stretchr/testify v1.8.4
)
```

## Common Project Structure
```
myproject/
├── go.mod
├── go.sum
├── main.go
├── cmd/
│   └── server/
│       └── main.go
├── pkg/
│   └── handlers/
│       └── user.go
├── internal/
│   └── config/
│       └── config.go
└── test/
    └── integration/
        └── api_test.go
```

## Useful Go Commands
```bash
# Clean build cache
go clean -cache

# Download source for packages
go mod download -json

# Verify dependencies
go mod verify

# Edit go.mod
go mod edit -require=example.com/m@v1.1.0
go mod edit -droprequire=example.com/m

# Replace module (for local development)
go mod edit -replace=github.com/old/repo=../local/path
```

## Environment Variables
```bash
# Common Go environment variables
export GOOS=linux        # Target OS
export GOARCH=amd64      # Target architecture
export CGO_ENABLED=0     # Disable CGO
export GOPROXY=direct    # Module proxy setting
export GOSUMDB=off       # Disable checksum database
```

## Useful Aliases
```bash
# Add to .zshrc or .bashrc
alias gor='go run'
alias gob='go build'
alias got='go test'
alias gotv='go test -v'
alias gotc='go test -cover'
alias gom='go mod'
alias gomt='go mod tidy'
alias gof='go fmt ./...'
alias gov='go vet ./...'
alias gol='go list ./...'
```

## Common Makefile for Go Projects
```makefile
.PHONY: build run test clean fmt vet

build:
	go build -o bin/app ./cmd/server

run:
	go run ./cmd/server

test:
	go test -v ./...

test-cover:
	go test -cover ./...

clean:
	go clean
	rm -rf bin/

fmt:
	go fmt ./...

vet:
	go vet ./...

lint:
	golangci-lint run

deps:
	go mod tidy
	go mod download

install-tools:
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```