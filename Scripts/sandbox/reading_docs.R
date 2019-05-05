
### open the correct library
library(antiword)
library(tidyverse)

#readtext("pancakes.doc")


pancakes <- antiword("Pancakes.doc")

pancakes



#############
##What happens if I use docx?  Is it easier?

library(xml2)

#amy <- xml2::read_xml("Pancakes.doc")
