local lambda = {
  handler = function(name: string, callback)
    print(name)
    callback()
  end
}

return {
  lambda = lambda
}
