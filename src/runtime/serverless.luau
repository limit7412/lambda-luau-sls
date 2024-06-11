local process = require("@lune/process")
local net = require("@lune/net")

local _HANDLER: string = process.env._HANDLER
local AWS_LAMBDA_RUNTIME_API: string = process.env.AWS_LAMBDA_RUNTIME_API

local lambda = {
  handler = function(name: string, callback: (any) -> (any))
    if (name ~= _HANDLER) then
      return
    end

    while true do
      local response = net.request("http://"..AWS_LAMBDA_RUNTIME_API.."/2018-06-01/runtime/invocation/next")
      local event = net.jsonDecode(response.body)
      local requestId: string = response.headers["lambda-runtime-aws-request-id"]

      local url = "http://"..AWS_LAMBDA_RUNTIME_API.."/2018-06-01/runtime/invocation/"..requestId.."/response"
      local ok, body = pcall(callback, event.body)
      if not ok then
        url = "http://"..AWS_LAMBDA_RUNTIME_API.."/2018-06-01/runtime/invocation/"..requestId.."/error"
        body = {
          statusCode = 500,
          body = net.jsonEncode({
            msg = "Internal Lambda Error",
          }),
        }
      end

      net.request({
        url = url,
        method = "POST",
        body = net.jsonEncode(body)
      })
    end
  end
}

return {
  lambda = lambda
}
