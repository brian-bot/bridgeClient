## Startup functions and global constants
###############################################################################

kCertBundle <- "certificateBundle/cacert.pem"

.onLoad <- function(libname, pkgname){
  
  ## SET ESPN CACHE AND START OPTIONS
  .setBridgeCache("opts", list())
  .setBridgeCache("httpheader", character())
  .setBridgeCache("bridgeEndpoint", "https://webservices.sagebridge.org/")
  .setBridgeCache("Accept", "application/json")
  .setBridgeCache("User-Agent", "R")
  .setBridgeCache("Content-Type", "text/json")
  .setBridgeCache("low.speed.time", 60)
  .setBridgeCache("low.speed.limit", 1)
  .setBridgeCache("connecttimeout", 300)
  .setBridgeCache("followlocation", TRUE)
  .setBridgeCache("ssl.verifypeer", TRUE)
  .setBridgeCache("verbose", FALSE)
  .setBridgeCache("cainfo", file.path(libname, pkgname, kCertBundle))
}

