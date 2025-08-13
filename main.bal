import ballerina/io;
import ballerinax/openai.chat as chat;

configurable string apiKey = ?;
configurable string userQuery = ?;

chat:ChatCompletionTool fileReaderTool = {
    'type: "function",
    'function: {
        name: "read_file",
        description: "Read and analyze code file content",
        parameters: {
            "type": "object",
            "properties": {
                "filename": {
                    "type": "string",
                    "description": "The file path to read"
                }
            },
            "required": ["filename"]
        }
    }
};

function analyzeCodeWithTools() returns string|error {
    chat:Client openAIChat = check new ({auth: {token: apiKey}});

    chat:ChatCompletionRequestMessage[] messages = [
        {
            "role": "user",
            "content": string `Analyze this codebase for: ${userQuery}.
            First, read the bal.md file to understand the code structure and identify which specific files contain relevant code sections.
            Then read those relevant files to extract the most important code snippets.`
        }
    ];

    chat:CreateChatCompletionRequest request = {
        model: "gpt-4o-mini",
        messages: messages,
        tools: [fileReaderTool]
    };

    chat:CreateChatCompletionResponse response = check openAIChat->/chat/completions.post(request);

    if response.choices[0].message?.tool_calls is chat:ChatCompletionMessageToolCall[] {
        chat:ChatCompletionMessageToolCall[] toolCalls = <chat:ChatCompletionMessageToolCall[]>response.choices[0].message?.tool_calls;

 
        chat:ChatCompletionRequestMessage assistantMsg = {
            role: response.choices[0].message.role,
            content: response.choices[0].message.content,
            tool_calls: toolCalls
        };
        messages.push(assistantMsg);

        // Process each tool call
        foreach chat:ChatCompletionMessageToolCall toolCall in toolCalls {
            if toolCall.'function.name == "read_file" {
                // Parse the function arguments to get the filename
                json functionArgs = check toolCall.'function.arguments.fromJsonString();
                string filename = check functionArgs.filename;

                string fileContent;
                do {
                    fileContent = check io:fileReadString(filename);
                } on fail error e {
                    fileContent = string `Error reading file ${filename}: ${e.message()}`;
                }

                // Add tool response message
                messages.push({
                    "role": "tool",
                    "content": fileContent,
                    "tool_call_id": toolCall.id
                });
            }
        }

        // Make another request to get the final analysis
        chat:CreateChatCompletionRequest finalRequest = {
            model: "gpt-4o-mini",
            messages: messages
        };

        chat:CreateChatCompletionResponse finalResponse = check openAIChat->/chat/completions.post(finalRequest);

        // Check if there are more tool calls in the response
        if finalResponse.choices[0].message?.tool_calls is chat:ChatCompletionMessageToolCall[] {
            chat:ChatCompletionMessageToolCall[] moreCalls = <chat:ChatCompletionMessageToolCall[]>finalResponse.choices[0].message?.tool_calls;

            // Add the assistant message
            messages.push({
                role: finalResponse.choices[0].message.role,
                content: finalResponse.choices[0].message.content,
                tool_calls: moreCalls
            });

            // Process additional tool calls
            foreach chat:ChatCompletionMessageToolCall toolCall in moreCalls {
                if toolCall.'function.name == "read_file" {
                    json functionArgs = check toolCall.'function.arguments.fromJsonString();
                    string filename = check functionArgs.filename;

                    string fileContent;
                    do {
                        fileContent = check io:fileReadString(filename);
                    } on fail error e {
                        fileContent = string `Error reading file ${filename}: ${e.message()}`;
                    }

                    messages.push({
                        "role": "tool",
                        "content": fileContent,
                        "tool_call_id": toolCall.id
                    });
                }
            }

            // Make final request for analysis
            messages.push({
                "role": "user",
                "content": string `Based on all the files you've read, extract and format only the most relevant code sections for: ${userQuery}.

                Format as:
                ## Relevant Code Sections

                ### Primary Relevance
                [Most relevant code with explanations]

                ### Secondary Relevance
                [Supporting code and dependencies]`
            });

            chat:CreateChatCompletionRequest lastRequest = {
                model: "gpt-4o-mini",
                messages: messages
            };

            chat:CreateChatCompletionResponse lastResponse = check openAIChat->/chat/completions.post(lastRequest);
            return lastResponse.choices[0].message.content ?: "No response generated";
        }

        return finalResponse.choices[0].message.content ?: "No response generated";
    }

    return response.choices[0].message.content ?: "No response generated";
}

public function main() returns error? {
    string result = check analyzeCodeWithTools();
    io:println("Analysis Result:\n", result);
}