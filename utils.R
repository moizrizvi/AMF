require(stringr)
require(dplyr)

DATA.FOLDER <- 'data'
DK.FILE <- 'DONNEES_KANZALA.csv'
DK.DATA <- file.path(DATA.FOLDER, DK.FILE)

load.data <- function(filename){
  read.csv(filename) %.%
    mutate(date=as.Date(date))
}

varlist = function(x) {
  x = str_c('^(',paste(x, collapse='|'),')$')
  str_replace_all(x,'\\.','\\\\.')
}

