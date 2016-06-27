## AUTHOR: BRIAN M. BOT
#####

bridgeLogin <- function(email="", password="", study=""){
  ## IF NOTHING PROVIDED, CHECK THE ~/.bridgeConfig FILE
  if( email=="" & password=="" & study=="" ){
    config <- try(ConfigParser())
    if( class(config) != "try-error" ){
      if( all(Config.hasOption(config, "authentication", "email")) ){
        email <- Config.getOption(config, "authentication", "email")
      }
      if (all(Config.hasOption(config, "authentication", "password"))) {
        password <- Config.getOption(config, "authentication", "password")
      }
      if (all(Config.hasOption(config, "authentication", "study"))) {
        study <- Config.getOption(config, "authentication", "study")
      }
    }
  }
  
  stopifnot( length(study)==1L & is.character(study) & nchar(study)>0L)
  stopifnot( length(email)==1L & is.character(email) & nchar(email)>0L)
  stopifnot( length(password)==1L & is.character(password) & nchar(password)>0L)
  
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

ConfigParser <- function(path) {
  config <- new("Config")
  configFile <- .checkAndReadFile(path)
  section = NULL
  for (line in configFile) {
    # Sections
    matches <- regexec("\\[(.+)\\]", line)
    matches <- unlist(regmatches(line, matches))
    if (length(matches) > 1) {
      section <- matches[2]
      # Keep all items if there are repeated sections
      if (!(section %in% names(config@data))) {
        config@data[[section]] <- list()
      }
      next
    }
    
    # Options and values
    matches <- regexec("\\s*([^:=]+)\\s*[:=]\\s*(\\S.*)\\s*", line)
    matches <- unlist(regmatches(line, matches))
    if (length(matches) > 2) {
      matches <- sapply(matches, function(vec){ gsub("(^ +)|( +$)", "", vec) })
      config@data[[section]][[matches[[2]]]] <- matches[[3]]
    }
  }
  
  return(config)
}

.checkAndReadFile <- function(path) {
  if (missing(path)) {
    path <- "~/.bridgeConfig"
  }
  if (!file.exists(path)) {
    stop(sprintf("Configuration file '%s' cannot be found.", path))
  }
  return(readLines(path))
}

Config.hasSection <- function(config, section) {
  return(section %in% names(config@data))
}

Config.hasOption <- function(config, section, option) {
  return(option %in% names(config@data[[section]]))
}

Config.getOption <- function(config, section, option) {
  return(config@data[[section]][[option]])
}
