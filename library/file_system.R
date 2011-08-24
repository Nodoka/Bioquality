FILE <- (function() { 
  attr(body(sys.function()), "srcfile")
})()$filename 
