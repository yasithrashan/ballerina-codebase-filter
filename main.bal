import ballerina/io;
import ballerinax/ai.openai;

configurable string apiKey = ?;
configurable string userQuery = ?;

function filterRelevantSections(string astMdContent, string query) returns string|error {
    openai:ModelProvider model = check new (apiKey, openai:GPT_4O_MINI);

    string relevantSections = check model->generate(`
        You are an expert developer assistant analyzing a codebase represented in AST-like markdown format.

        User query: "${query}"

        Your task:
        - Identify and extract ONLY the code elements directly relevant to the user's query.
        - Relevant elements include functions, classes, methods, variables, imports, and their associated documentation comments.
        - For each extracted element, specify clearly the file(s) and their context if applicable.
        - Exclude unrelated code or documentation.
        - Return the extracted content formatted as markdown, suitable for developers to quickly understand the relevant parts.

        Here is the AST-like markdown representation of the codebase:

        ${astMdContent}
        `);
    return relevantSections;
}

public function main() returns error? {
    string astMdContent = check io:fileReadString("./bal.md");

    string relevantSections = check filterRelevantSections(astMdContent, userQuery);

    io:println("Relevant sections:\n", relevantSections);
}
