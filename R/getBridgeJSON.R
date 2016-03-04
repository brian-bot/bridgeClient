## FUNCTION THAT WILL CHECK ALL CALLS FOR FAILURES AND CONVERT JSON RESPONSES
#####

.getBridgeJSON <- function(url, .opts=.getBridgeCache('opts'), httpheader=.getBridgeCache("httpheader"), ...){
  
  tryGetURL <- getURL(url, .opts=.opts,
                      httpheader=httpheader, ...)
  tryGetURL <- fromJSON(tryGetURL)
  
  return(tryGetURL)
}
