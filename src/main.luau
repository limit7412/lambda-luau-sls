local net = require("@lune/net")
local serverless = require("runtime/serverless")

serverless.lambda.handler('hello', function(event)
  return {
    statusCode = 200,
    body = net.jsonEncode({
      msg = "hello luau",
    }),
  }
end)

serverless.lambda.handler('world', function(event)
  return {
    statusCode = 200,
    body = net.jsonEncode({
      msg = "hello luau",
      body = event,
    }),
  }
end)
