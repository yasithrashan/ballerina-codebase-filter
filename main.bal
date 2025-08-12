import ballerinax/ai.openai;
import ballerina/io;

configurable string apiKey = ?;
configurable string userQuery = ?;

function filterRelevantSections(string astMdContent, string query) returns string|error {
    openai:ModelProvider model = check new (apiKey, openai:GPT_4O_MINI);

    string relevantSections = check model->generate(`
        You are given the AST-like markdown representation of a codebase.

        User query: "${query}".

        Task: Extract ONLY the functions, classes, methods, variables, imports, and related documentation
        that are directly relevant to the user query.
        Return them **exactly** as they appear in the markdown, no extra explanation.

        Markdown:
        ${astMdContent}
    `);

    return relevantSections;
}

public function main() returns error? {
    string astMdContent = check io:fileReadString("./bal.md");

    string relevantSections = check filterRelevantSections(astMdContent, userQuery);

    io:println("Relevant sections:\n", relevantSections);
}
