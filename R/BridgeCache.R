## CREATE AND MANAGE A GLOBAL CACHE FOR THE CLIENT TO ACCESS
#####
## AUTHOR: BRIAN M. BOT
#####

.setBridgeCache <- function(key, value){
  cache <- new("BridgeCache")
  cache@env[[key]] <- value
  
  ## IF ONE OF THESE PARAMS THEN ADD TO opts
  validOpts <- c("low.speed.time", "low.speed.limit", "connecttimeout", "followlocation", "verbose", "cainfo", "ssl.verifypeer")
  if(key %in% validOpts){
    opts <- .getBridgeCache("opts")
    opts[[key]] <- value
    .setBridgeCache("opts", opts)
  }
  
  ## IF ONE OF THESE PARAMS THEN ADD TO httpheader
  validHeaders <- c("Bridge-Session", "User-Agent", "Accept", "Content-Type")
  if(key %in% validHeaders){
    httpheader <- .getBridgeCache("httpheader")
    httpheader[[key]] <- value
    .setBridgeCache("httpheader", httpheader)
  }
  
  return(NULL)
}

.inBridgeCache <- function(key){
  cache <- new("BridgeCache")
  return(key %in% ls(cache@env))
}

.getBridgeCache <- function(key){
  if( !.inBridgeCache(key) ){
    return(NULL)
  } else{
    cache <- new("BridgeCache")
    return(cache@env[[key]])
  }
}

