{
  "ballerina_project": {
    "files": [
      {
        "filename": "types.bal",
        "type": "module_file",
        "imports": [
          {
            "type": "import_declaration",
            "module": "ballerina/data.jsondata"
          },
          {
            "type": "import_declaration",
            "module": "ballerina/http"
          }
        ],
        "top_level_constructs": [
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ErrorPayloadInternalServerError",
            "definition": {
              "type": "record_type",
              "fields": [
                {
                  "type": "inclusion",
                  "included_type": "http:InternalServerError"
                },
                {
                  "name": "body",
                  "type": "ErrorPayload"
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ContentFilterIdResult",
            "definition": {
              "type": "record_type",
              "fields": [
                {
                  "type": "inclusion",
                  "included_type": "ContentFilterResultBase"
                },
                {
                  "name": "id",
                  "type": "string"
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ChatCompletionRequestMessage",
            "definition": {
              "type": "record_type",
              "fields": [
                {
                  "name": "role",
                  "type": "ChatCompletionRequestMessageRole",
                  "documentation": "The role of the messages author"
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ContentFilterDetectedResult",
            "definition": {
              "type": "record_type",
              "fields": [
                {
                  "type": "inclusion",
                  "included_type": "ContentFilterResultBase"
                },
                {
                  "name": "detected",
                  "type": "boolean"
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ContentFilterResultsBase",
            "definition": {
              "type": "record_type",
              "documentation": "Information about the content filtering results",
              "fields": [
                {
                  "name": "selfHarm",
                  "type": "ContentFilterSeverityResult",
                  "optional": true,
                  "annotations": [
                    {
                      "type": "annotation",
                      "name": "jsondata:Name",
                      "value": "self_harm"
                    }
                  ]
                },
                {
                  "name": "customBlocklists",
                  "type": "ContentFilterIdResult[]",
                  "optional": true,
                  "annotations": [
                    {
                      "type": "annotation",
                      "name": "jsondata:Name",
                      "value": "custom_blocklists"
                    }
                  ]
                },
                {
                  "name": "hate",
                  "type": "ContentFilterSeverityResult",
                  "optional": true
                },
                {
                  "name": "profanity",
                  "type": "ContentFilterDetectedResult",
                  "optional": true
                },
                {
                  "name": "error",
                  "type": "ErrorBase",
                  "optional": true,
                  "quoted_identifier": true
                },
                {
                  "name": "sexual",
                  "type": "ContentFilterSeverityResult",
                  "optional": true
                },
                {
                  "name": "violence",
                  "type": "ContentFilterSeverityResult",
                  "optional": true
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ChatCompletionMessageToolCall_function",
            "definition": {
              "type": "record_type",
              "documentation": "The function that the model called",
              "fields": [
                {
                  "name": "name",
                  "type": "string",
                  "documentation": "The name of the function to call."
                },
                {
                  "name": "arguments",
                  "type": "string",
                  "documentation": "The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function."
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ChatCompletionToolChoiceOption",
            "definition": {
              "type": "union_type",
              "documentation": "Controls which (if any) function is called by the model. `none` means the model will not call a function and instead generates a message. `auto` means the model can pick between generating a message or calling a function. Specifying a particular function via `{\"type\": \"function\", \"function\": {\"name\": \"my_function\"}}` forces the model to call that function",
              "members": [
                {
                  "type": "string_literal",
                  "value": "none"
                },
                {
                  "type": "string_literal",
                  "value": "auto"
                },
                {
                  "type": "type_reference",
                  "name": "ChatCompletionNamedToolChoice"
                }
              ]
            }
          },
          {
            "type": "type_definition",
            "visibility": "public",
            "name": "ConnectionConfig",
            "definition": {
              "type": "record_type",
              "annotations": [
                {
                  "type": "annotation",
                  "name": "display",
                  "fields": {
                    "label": "Connection Config"
                  }
                }
              ],
              "documentation": "Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.",
              "fields": [
                {
                  "name": "auth",
                  "type": "http:BearerTokenConfig|ApiKeysConfig",
                  "documentation": "Provides Auth configurations needed when communicating with a remote HTTP endpoint."
                },
                {
                  "name": "httpVersion",
                  "type": "http:HttpVersion",
                  "default_value": "http:HTTP_2_0",
                  "documentation": "The HTTP version understood by the client"
                },
                {
                  "name": "http1Settings",
                  "type": "http:ClientHttp1Settings",
                  "default_value": "{}",
                  "documentation": "Configurations related to HTTP/1.x protocol"
                },
                {
                  "name": "http2Settings",
                  "type": "http:ClientHttp2Settings",
                  "default_value": "{}",
                  "documentation": "Configurations related to HTTP/2 protocol"
                },
                {
                  "name": "timeout",
                  "type": "decimal",
                  "default_value": "30",
                  "documentation": "The maximum time to wait (in seconds) for a response before closing the connection"
                },
                {
                  "name": "forwarded",
                  "type": "string",
                  "default_value": "\"disable\"",
                  "documentation": "The choice of setting `forwarded`/`x-forwarded` header"
                },
                {
                  "name": "followRedirects",
                  "type": "http:FollowRedirects",
                  "optional": true,
                  "documentation": "Configurations associated with Redirection"
                },
                {
                  "name": "poolConfig",
                  "type": "http:PoolConfiguration",
                  "optional": true,
                  "documentation": "Configurations associated with request pooling"
                },
                {
                  "name": "cache",
                  "type": "http:CacheConfig",
                  "default_value": "{}",
                  "documentation": "HTTP caching related configurations"
                },
                {
                  "name": "compression",
                  "type": "http:Compression",
                  "default_value": "http:COMPRESSION_AUTO",
                  "documentation": "Specifies the way of handling compression (`accept-encoding`) header"
                },
                {
                  "name": "circuitBreaker",
                  "type": "http:CircuitBreakerConfig",
                  "optional": true,
                  "documentation": "Configurations associated with the behaviour of the Circuit Breaker"
                },
                {
                  "name": "retryConfig",
                  "type": "http:RetryConfig",
                  "optional": true,
                  "documentation": "Configurations associated with retrying"
                },
                {
                  "name": "cookieConfig",
                  "type": "http:CookieConfig",
                  "optional": true,
                  "documentation": "Configurations associated with cookies"
                },
                {
                  "name": "responseLimits",
                  "type": "http:ResponseLimitConfigs",
                  "default_value": "{}",
                  "documentation": "Configurations associated with inbound response size limits"
                },
                {
                  "name": "secureSocket",
                  "type": "http:ClientSecureSocket",
                  "optional": true,
                  "documentation": "SSL/TLS-related options"
                },
                {
                  "name": "proxy",
                  "type": "http:ProxyConfig",
                  "optional": true,
                  "documentation": "Proxy server related options"
                },
                {
                  "name": "socketConfig",
                  "type": "http:ClientSocketConfig",
                  "default_value": "{}",
                  "documentation": "Provides settings related to client socket configuration"
                },
                {
                  "name": "validation",
                  "type": "boolean",
                  "default_value": "true",
                  "documentation": "Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default"
                },
                {
                  "name": "laxDataBinding",
                  "type": "boolean",
                  "default_value": "true",
                  "documentation": "Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, and absent fields are handled as `nilable` types. Enabled by default."
                }
              ]
            }
          }
        ]
      },
      {
        "filename": "client.bal",
        "type": "module_file",
        "imports": [
          {
            "type": "import_declaration",
            "module": "ballerina/data.jsondata"
          },
          {
            "type": "import_declaration",
            "module": "ballerina/http"
          }
        ],
        "top_level_constructs": [
          {
            "type": "class_definition",
            "visibility": "public",
            "qualifiers": ["isolated"],
            "name": "Client",
            "fields": [
              {
                "name": "clientEp",
                "type": "http:Client",
                "qualifiers": ["final"]
              },
              {
                "name": "apiKeyConfig",
                "type": "readonly & ApiKeysConfig",
                "optional": true,
                "qualifiers": ["final"]
              }
            ],
            "methods": [
              {
                "type": "method_definition",
                "visibility": "public",
                "qualifiers": ["isolated"],
                "name": "init",
                "documentation": "Gets invoked to initialize the `connector`.",
                "parameters": [
                  {
                    "name": "config",
                    "type": "ConnectionConfig",
                    "documentation": "The configurations to be used when initializing the `connector`"
                  },
                  {
                    "name": "serviceUrl",
                    "type": "string",
                    "default_value": "\"http://localhost:9094/ai/chat\"",
                    "documentation": "URL of the target service"
                  }
                ],
                "return_type": "error?",
                "documentation": "An error if connector initialization failed",
                "body": {
                  "type": "block_statement",
                  "statements": [
                    {
                      "type": "variable_declaration",
                      "name": "httpClientConfig",
                      "type": "http:ClientConfiguration",
                      "initializer": {
                        "type": "record_constructor",
                        "fields": [
                          {
                            "name": "httpVersion",
                            "value": "config.httpVersion"
                          },
                          {
                            "name": "http1Settings",
                            "value": "config.http1Settings"
                          },
                          {
                            "name": "http2Settings",
                            "value": "config.http2Settings"
                          },
                          {
                            "name": "timeout",
                            "value": "config.timeout"
                          },
                          {
                            "name": "forwarded",
                            "value": "config.forwarded"
                          },
                          {
                            "name": "followRedirects",
                            "value": "config.followRedirects"
                          },
                          {
                            "name": "poolConfig",
                            "value": "config.poolConfig"
                          },
                          {
                            "name": "cache",
                            "value": "config.cache"
                          },
                          {
                            "name": "compression",
                            "value": "config.compression"
                          },
                          {
                            "name": "circuitBreaker",
                            "value": "config.circuitBreaker"
                          },
                          {
                            "name": "retryConfig",
                            "value": "config.retryConfig"
                          },
                          {
                            "name": "cookieConfig",
                            "value": "config.cookieConfig"
                          },
                          {
                            "name": "responseLimits",
                            "value": "config.responseLimits"
                          },
                          {
                            "name": "secureSocket",
                            "value": "config.secureSocket"
                          },
                          {
                            "name": "proxy",
                            "value": "config.proxy"
                          },
                          {
                            "name": "socketConfig",
                            "value": "config.socketConfig"
                          },
                          {
                            "name": "validation",
                            "value": "config.validation"
                          },
                          {
                            "name": "laxDataBinding",
                            "value": "config.laxDataBinding"
                          }
                        ]
                      }
                    },
                    {
                      "type": "if_statement",
                      "condition": {
                        "type": "type_test_expression",
                        "expression": "config.auth",
                        "test_type": "ApiKeysConfig"
                      },
                      "then_body": {
                        "type": "block_statement",
                        "statements": [
                          {
                            "type": "assignment_statement",
                            "lhs": "self.apiKeyConfig",
                            "rhs": {
                              "type": "method_call",
                              "expression": {
                                "type": "type_cast_expression",
                                "expression": "config.auth",
                                "target_type": "ApiKeysConfig"
                              },
                              "method": "cloneReadOnly"
                            }
                          }
                        ]
                      },
                      "else_body": {
                        "type": "block_statement",
                        "statements": [
                          {
                            "type": "assignment_statement",
                            "lhs": "httpClientConfig.auth",
                            "rhs": {
                              "type": "type_cast_expression",
                              "expression": "config.auth",
                              "target_type": "http:BearerTokenConfig"
                            }
                          },
                          {
                            "type": "assignment_statement",
                            "lhs": "self.apiKeyConfig",
                            "rhs": {
                              "type": "nil_literal"
                            }
                          }
                        ]
                      }
                    },
                    {
                      "type": "assignment_statement",
                      "lhs": "self.clientEp",
                      "rhs": {
                        "type": "checked_expression",
                        "expression": {
                          "type": "new_expression",
                          "arguments": [
                            "serviceUrl",
                            "httpClientConfig"
                          ]
                        }
                      }
                    }
                  ]
                }
              },
              {
                "type": "resource_method_definition",
                "visibility": "public",
                "qualifiers": ["isolated"],
                "accessor": "post",
                "resource_path": ["embeddings"],
                "name": "embeddings",
                "documentation": "Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.",
                "annotations": [
                  {
                    "type": "annotation",
                    "name": "display",
                    "fields": {
                      "label": "Generate Embeddings"
                    }
                  }
                ],
                "parameters": [
                  {
                    "name": "payload",
                    "type": "EmbeddingRequest"
                  },
                  {
                    "name": "headers",
                    "type": "EmbeddingsCreateHeaders",
                    "default_value": "{}",
                    "documentation": "Headers to be sent with the request"
                  }
                ],
                "return_type": "EmbeddingResponse|error",
                "documentation": "OK",
                "body": {
                  "type": "block_statement",
                  "statements": [
                    {
                      "type": "variable_declaration",
                      "name": "resourcePath",
                      "type": "string",
                      "initializer": {
                        "type": "template_expression",
                        "value": "/embeddings"
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "httpHeaders",
                      "type": "map<string|string[]>",
                      "initializer": {
                        "type": "function_call",
                        "function": "http:getHeaderMap",
                        "arguments": ["headers"]
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "request",
                      "type": "http:Request",
                      "initializer": {
                        "type": "new_expression"
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "jsonBody",
                      "type": "json",
                      "initializer": {
                        "type": "function_call",
                        "function": "jsondata:toJson",
                        "arguments": ["payload"]
                      }
                    },
                    {
                      "type": "expression_statement",
                      "expression": {
                        "type": "method_call",
                        "expression": "request",
                        "method": "setPayload",
                        "arguments": [
                          "jsonBody",
                          "\"application/json\""
                        ]
                      }
                    },
                    {
                      "type": "return_statement",
                      "expression": {
                        "type": "method_call",
                        "expression": "self.clientEp",
                        "method": "post",
                        "arguments": [
                          "resourcePath",
                          "request",
                          "httpHeaders"
                        ]
                      }
                    }
                  ]
                }
              },
              {
                "type": "resource_method_definition",
                "qualifiers": ["isolated"],
                "accessor": "post",
                "resource_path": ["chat", "completions"],
                "name": "completions",
                "parameters": [
                  {
                    "name": "payload",
                    "type": "CreateChatCompletionRequest"
                  },
                  {
                    "name": "headers",
                    "type": "ChatCompletionsHeaders",
                    "default_value": "{}",
                    "documentation": "Headers to be sent with the request"
                  }
                ],
                "return_type": "CreateChatCompletionResponse|error",
                "documentation": "OK",
                "body": {
                  "type": "block_statement",
                  "statements": [
                    {
                      "type": "variable_declaration",
                      "name": "resourcePath",
                      "type": "string",
                      "initializer": {
                        "type": "template_expression",
                        "value": "/chat/completions"
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "httpHeaders",
                      "type": "map<string|string[]>",
                      "initializer": {
                        "type": "function_call",
                        "function": "http:getHeaderMap",
                        "arguments": ["headers"]
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "request",
                      "type": "http:Request",
                      "initializer": {
                        "type": "new_expression"
                      }
                    },
                    {
                      "type": "variable_declaration",
                      "name": "jsonBody",
                      "type": "json",
                      "initializer": {
                        "type": "function_call",
                        "function": "jsondata:toJson",
                        "arguments": ["payload"]
                      }
                    },
                    {
                      "type": "expression_statement",
                      "expression": {
                        "type": "method_call",
                        "expression": "request",
                        "method": "setPayload",
                        "arguments": [
                          "jsonBody",
                          "\"application/json\""
                        ]
                      }
                    },
                    {
                      "type": "return_statement",
                      "expression": {
                        "type": "method_call",
                        "expression": "self.clientEp",
                        "method": "post",
                        "arguments": [
                          "resourcePath",
                          "request",
                          "httpHeaders"
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          }
        ]
      },
      {
        "filename": "utils.bal",
        "type": "module_file",
        "imports": [
          {
            "type": "import_declaration",
            "module": "ballerina/url"
          }
        ],
        "top_level_constructs": [
          {
            "type": "function_definition",
            "visibility": "isolated",
            "name": "getEncodedUri",
            "documentation": "Get Encoded URI for a given value.",
            "parameters": [
              {
                "name": "value",
                "type": "anydata",
                "documentation": "Value to be encoded"
              }
            ],
            "return_type": "string",
            "documentation": "Encoded string",
            "body": {
              "type": "block_statement",
              "statements": [
                {
                  "type": "variable_declaration",
                  "name": "encoded",
                  "type": "string|error",
                  "initializer": {
                    "type": "function_call",
                    "function": "url:encode",
                    "arguments": [
                      {
                        "type": "method_call",
                        "expression": "value",
                        "method": "toString"
                      },
                      "\"UTF8\""
                    ]
                  }
                },
                {
                  "type": "if_statement",
                  "condition": {
                    "type": "type_test_expression",
                    "expression": "encoded",
                    "test_type": "string"
                  },
                  "then_body": {
                    "type": "block_statement",
                    "statements": [
                      {
                        "type": "return_statement",
                        "expression": "encoded"
                      }
                    ]
                  },
                  "else_body": {
                    "type": "block_statement",
                    "statements": [
                      {
                        "type": "return_statement",
                        "expression": {
                          "type": "method_call",
                          "expression": "value",
                          "method": "toString"
                        }
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    ]
  }
}