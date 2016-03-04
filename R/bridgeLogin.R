## AUTHOR: BRIAN M. BOT
#####


bridgeLogin <- function(email, password, study){
  stopifnot( length(study)==1L & is.character(study))
  stopifnot( length(email)==1L & is.character(email))
  stopifnot( length(password)==1L & is.character(password))
  
  ## CALL THE auth/signIn API
  resp <- bridgeRestPOST(uri="/v3/auth/signIn", body=toJSON(list(email=email, password=password, study=study)))
  
  ## HANDLE ANY MESSAGES THAT GET RETURNED ON ERROR
  if(any(names(resp) == "message")){
    stop(resp$message)
  }
  
  ## IF PASS CHECK, THEN SET IN CACHE FOR FUTURE CALLS
  .setBridgeCache('Bridge-Session', resp$sessionToken)
  cat("successfully stored sessionToken for future calls to the API")
  return(invisible(NULL))
}

