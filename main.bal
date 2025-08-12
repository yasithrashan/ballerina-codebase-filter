import ballerinax/ai.openai;
import ballerina/io;

configurable string apiKey = ?;
configurable string userQuery = ?;

type Review record {|
    string summary;
    string[] suggestions;
|};

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

function reviewCodebase(string relevantCode) returns Review|error {
    openai:ModelProvider model = check new (apiKey, openai:GPT_4O_MINI);

    Review review = check model->generate(`
        You are an expert code reviewer.

        Below is the **filtered relevant code** from a codebase:
        ${relevantCode}

        Task:
        1. Summarize what this code does in a few sentences.
        2. Suggest improvements (as an array of strings).

        Return the result in JSON format matching:
        {
          "summary": "...",
          "suggestions": ["...", "..."]
        }
    `);

    return review;
}

public function main() returns error? {
    string astMdContent = check io:fileReadString("./bal.md");

    string relevantSections = check filterRelevantSections(astMdContent, userQuery);
    Review review = check reviewCodebase(relevantSections);

    io:println("Summary: ", review.summary);
    io:println("Suggestions: ", review.suggestions);
}
