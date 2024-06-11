local serverless = require("runtime/serverless")

serverless.lambda.handler('hello', function(event)
  return {
    statusCode = 200,
    msg = "hello luau",
  }
end)

serverless.lambda.handler('world', function(event)
  return {
    statusCode = 200,
    msg = "hello luau",
    body = event,
  }
end)
