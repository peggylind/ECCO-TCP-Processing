# this script controls running a collection of scripts related to ECCO TCP processing
library(here)
library(XML)
library(readr)
library(dplyr)
library(tibble)
library(stringr)
library(zoo)
library(tm)

options(stringsAsFactors = FALSE)

# Part 1: Prepare metadata and text
source(here("scripts","loadData.R")) 
xmldataDirectory <- "xml"
# parse the xml data and create list
verseDataList <- identifyFromXML(xmldataDirectory)
# create corpus from text files
eccotcpCorpus <- createCorpus(verseDataList)

source(here("scripts","eccoextract.R")) 
eccotcpTextExtracted <- eccoextract(directory)
# we could write those texts to file (but maybe need some cleaning)
# for example
write_lines(eccotcpTextExtracted[[1]], path = "test.txt")

# Part 2: Create topicmodel