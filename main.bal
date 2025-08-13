import ballerina/io;
import ballerinax/ai.openai;

configurable string apiKey = ?;
configurable string userQuery = ?;

function filterRelevantSections(string astMdContent, string query) returns string|error {
    openai:ModelProvider model = check new (apiKey, openai:GPT_4O_MINI);

    string relevantSections = check model->generate(`
        You are a code analysis expert specializing in identifying relevant code sections for specific queries.
        Analyze the provided codebase AST structure and extract only the most relevant sections.

        QUERY: "${query}"

        CODEBASE STRUCTURE: The content below represents a Ballerina codebase in AST-like markdown format.

        ANALYSIS INSTRUCTIONS:
        1. Identify files and specific code sections most relevant to: "${query}"

        2. Consider:
           - Direct relevance to the query topic
           - Dependencies and related components
           - Implementation details vs interface definitions
           - Error handling and configuration related to the query
           - Type definitions that support the queried functionality
           - Import statements and external dependencies

        3. For each relevant section, include:
           - File name and location
           - Complete code construct (class, function, type definition, etc.)
           - Associated documentation/comments
           - Related dependencies and type references

        4. Prioritize by relevance:
           - PRIMARY: Direct implementations and main functionality
           - SECONDARY: Supporting types, configurations, and dependencies
           - TERTIARY: Utility functions and helper methods

        5. Output format:
           - Use clear markdown sections for each file
           - Include code blocks with proper syntax highlighting
           - Add brief explanations of relevance for each section
           - Maintain proper code structure and indentation

        6. Exclude:
           - Unrelated code sections
           - Redundant or duplicate information
           - Overly verbose documentation not directly relevant

        CODEBASE AST CONTENT:
        ${astMdContent}

        RESPONSE FORMAT:
        Return a well-structured markdown document with:
        ## Relevant Code Sections for: "${query}"

        ### Primary Relevance
        [Most directly relevant code sections]

        ### Secondary Relevance
        [Supporting types, configurations, dependencies]

        ### Implementation Context
        [Brief explanation of how sections relate to the query]
        `);
    return relevantSections;
}

public function main() returns error? {
    string astMdContent = check io:fileReadString("./bal.md");

    string relevantSections = check filterRelevantSections(astMdContent, userQuery);

    io:println("Relevant sections:\n", relevantSections);
}
