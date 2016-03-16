## FUNCTION THAT WILL CHECK ALL CALLS FOR FAILURES AND CONVERT JSON RESPONSES
#####

.getBridgeURL <- function(url, .opts=.getBridgeCache('opts'), httpheader=.getBridgeCache("httpheader"), ...){
  
  h <- basicHeaderGatherer()
  tryGetURL <- getURL(url, .opts=.opts,
                      httpheader=httpheader, headerfunction = h$update, ...)
  
  st <- h$value()["status"]
  if(st != "201"){
    tryGetURL <- fromJSON(tryGetURL)
  }
  
  return(tryGetURL)
}
