local lambda = {
  handler = function(name: string, callback: (string) -> (string))
    callback(name)
  end
}

return {
  lambda = lambda
}
