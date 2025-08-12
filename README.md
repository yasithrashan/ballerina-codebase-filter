# Ballerina Codebase Filter

A Ballerina application that uses OpenAI's GPT-4o-mini to intelligently filter and extract relevant sections from AST-like markdown representations of codebases based on user queries.

## Overview

This tool helps developers quickly find relevant code sections from large codebase documentation by:
- Reading AST-like markdown content from a file
- Using AI to understand the context of a user query
- Extracting only the functions, classes, methods, variables, imports, and documentation that are directly relevant to the query
- Returning the relevant sections exactly as they appear in the original markdown

## Prerequisites

- [Ballerina](https://ballerina.io/) installed on your system
- OpenAI API key
- AST markdown file of your codebase (`bal.md`)

## Installation

1. Clone or download this project
2. Ensure you have the required Ballerina dependencies:
   ```bash
   bal pull ballerinax/ai.openai
   ```

## Configuration

The application requires two configurable parameters:

### 1. API Key
Set your OpenAI API key using one of these methods:

**Option A: Command line**
```bash
bal run -- --apiKey="your-openai-api-key-here"
```

**Option B: Config.toml file**
Create a `Config.toml` file in your project root:
```toml
apiKey = "your-openai-api-key-here"
```

**Option C: Environment variable**
```bash
export API_KEY="your-openai-api-key-here"
bal run
```

### 2. User Query
Specify what you're looking for in the codebase:

**Command line:**
```bash
bal run -- --userQuery="how to handle HTTP requests"
```

**Config.toml:**
```toml
userQuery = "how to handle HTTP requests"
```

## Usage

### Basic Usage
```bash
bal run -- --apiKey="sk-your-api-key" --userQuery="authentication logic"
```

### Example Queries
- `"database connection functions"`
- `"error handling mechanisms"`
- `"HTTP client implementation"`
- `"configuration management"`
- `"logging utilities"`
- `"data validation methods"`

## Input File Format

The application expects a file named `bal.md` in the project directory containing AST-like markdown representation of your codebase. This file should include:

- Function definitions
- Class/type definitions
- Method implementations
- Variable declarations
- Import statements
- Related documentation

Example structure:
```markdown
## Imports
```ballerina
import ballerina/http;
import ballerina/log;
```

## Functions
### handleRequest
```ballerina
function handleRequest(http:Request req) returns http:Response {
    // implementation
}
```
```

## Output

The application will print the relevant sections to the console in the format:
```
Relevant sections:
[Filtered markdown content matching your query]
```

## How It Works

1. **File Reading**: Loads the AST markdown content from `bal.md`
2. **AI Processing**: Sends the content and user query to OpenAI's GPT-4o-mini model
3. **Smart Filtering**: The AI model identifies and extracts only the relevant sections
4. **Output**: Returns the filtered content exactly as it appears in the original markdown

## Error Handling

The application includes proper error handling for:
- File reading operations
- OpenAI API calls
- Configuration parameter validation

## Dependencies

- `ballerinax/ai.openai`: OpenAI integration for Ballerina
- `ballerina/io`: File I/O operations

## Contributing

Feel free to submit issues and pull requests to improve this tool.

## Notes

- Ensure your `bal.md` file is up-to-date with your codebase
- The quality of results depends on how well-structured your AST markdown is
- API usage costs will apply based on OpenAI's pricing model