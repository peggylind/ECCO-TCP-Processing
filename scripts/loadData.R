# uses counts of L and P tags to identify texts
identifyFromXML <- function(directory, threshold = 0.15) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the xml files
  files_list <- list.files(directory, full.names=TRUE) 
  
  out <- numeric(length(files_list))
  
  #loop through the xml files
 # for (i in 1:length(files_list)) {
  for (i in 1:10) {
    doc <- xmlTreeParse(files_list[i], useInternalNodes=TRUE)
    if (xpathApply(xmlRoot(doc),path="count(//SP)",xmlValue) == 0) {
      # count L and P tags
      count_L <- xpathApply(xmlRoot(doc),path="count(//L)",xmlValue)
      count_P <- xpathApply(xmlRoot(doc),path="count(//P)",xmlValue)
      cat("counts for " , basename(files_list[i]), ": ", count_L, "/", count_P, "\n")
      # todo: check for ratio and add to out
      out[i] <- files_list[i]
    }
  }
  
  return(out)
}

# uses counts of L and P for a scatterplot
create_baseDatafromXML <- function(directory) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the xml files
  files_list <- list.files(directory, full.names=TRUE) 
  
  out <- data.frame()
  
  #loop through the xml files
  for (i in 1:length(files_list)) {
    doc <- xmlTreeParse(files_list[i], useInternalNodes=TRUE)
    if (xpathApply(xmlRoot(doc),path="count(//SP)",xmlValue) == 0) {
      # count L and P tags
      count.L <- xpathApply(xmlRoot(doc),path="count(//L)",xmlValue)
      count.P <- xpathApply(xmlRoot(doc),path="count(//P)",xmlValue)
      #cat("counts for " , basename(files_list[i]), ": ", count_L, "/", count_P, "\n")
      item <- data.frame(basename(files_list[i]), count.P, count.L, count.P+count.L, count.L/count.P)
      out <- rbind(out, item)
      
    }
  }
  
  names(out) <- c("filename", "count.L", "count.P", "sum", "ratio")
  return(out)
}

createCorpus <- function(directory, ids) {
  fileNames <- sapply(ids, function(x) paste0(directory, "/", sprintf("K%06d", x), ".000.txt"))
  #read files into a character vector
  files <- lapply(fileNames, readLines, warn = FALSE)
  #create corpus from vector
  docs_ges<- Corpus(VectorSource(files))
  return(docs_ges)
}