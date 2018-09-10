eccoextract <- function(directory) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the xml files
  files_list <- list.files(directory, full.names=TRUE) 
  
  out <- vector("list", length(files_list))
  
  #loops through the xml files
  for (i in 1:length(files_list)) {
    #read xml file
    dum <- xmlParse(files_list[i])
    #extract TEXT node
    out[i] <- unlist(xpathApply(dum, '//*/TEXT', xmlValue))
  }
  return(out)
}