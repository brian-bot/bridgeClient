## REST API CALLS
#####
## FOCUS ON GET AND POST CALLS ONLY FOR NOW
#####
uriToUrl <- function(uri, endpoint){
  uri <- sub(endpoint, "", uri, fixed=T)
  if(substr(uri, 1, 1) == "/"){
    uri <- substr(uri, 2, nchar(uri))
  }
  
  url <- paste(endpoint, uri, sep="")
  return(url)
}

## GET
bridgeRestGET <- function(uri, endpoint = .getBridgeCache("bridgeEndpoint"), .opts=.getBridgeCache("opts"), httpheader=.getBridgeCache("httpheader"), ...){
  url <- uriToUrl(uri, endpoint)
  
  .getBridgeURL(url, .opts=.opts, httpheader=httpheader, ...)
}

## POST
bridgeRestPOST<-function(uri, body, endpoint = .getBridgeCache("bridgeEndpoint"), .opts=.getBridgeCache("opts"), httpheader=.getBridgeCache("httpheader"), ...){
  url <- uriToUrl(uri, endpoint)
  
  .getBridgeURL(url, postfields=body, customrequest="POST", .opts=.opts, httpheader=httpheader, ...)
} 

