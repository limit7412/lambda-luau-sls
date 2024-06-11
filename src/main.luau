local serverless = require("runtime/serverless")

serverless.lambda.handler('hello', function(event)
  print(event)
end)
