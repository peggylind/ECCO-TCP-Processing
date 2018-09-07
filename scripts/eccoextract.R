eccoextract <- function(directory) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the xml files
  files_list <- list.files(directory, full.names=TRUE) 
  
  out <- vector("list", length(files_list))
  
  #loops through the xml files
  for (i in 1:length(files_list)) {
    x <- files_list[i]
    dumFun <- function(x){
      xname <- xmlName(x)
      xattrs <- xmlAttrs(x)
      c(sapply(xmlChildren(x), xmlChildren), name = xname, xattrs, xpathorigin = files_list[i])
    }
    dum <- xmlParse(files_list[i])
    
    out[[i]] <- t(xpathSApply(dum, "//*/TEXT", dumFun))
  }
  out
}
