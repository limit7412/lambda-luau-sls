local lambda = {
  handler = function(name)
    print(name)
  end
}

return {
  lambda = lambda
}
