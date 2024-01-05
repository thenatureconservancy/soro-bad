

## try to make a nice chord screenshot for MDW/NE Prescribed Fire Council Poster

## using instructions from https://r-graph-gallery.com/159-save-interactive-streamgraph-to-static-image-png.html

# load packages

library(chorddiag)
library(htmlwidgets)
library(igraph)
library(readr)
library(tidygraph)
library(tidyverse)
library(webshot)



# read in data
chord_df<- read_csv("data/bps2evt_chord.csv")
#view(histFireGVchord)

#convert to matrix
matrix_df <-as.matrix(as_adjacency_matrix(as_tbl_graph(chord_df),attr = "ACRES"))

#clean up matrix (could be cleaner!)
matrix_df = subset(matrix_df, select = -c(1:6))

matrix_df <- matrix_df[-c(7:15),]

#make a custom color pallet #eb4034 (redish) #b0af9e(grey)

# ORIGINAL
groupColors <-c( "#1d4220", # conifer 
                 "#fc9d03", # grassland
                 "#56bf5f", # hardwood
                 "#397d3f", # hardwood-conifer 
                 "#7db7c7", # riparian 
                 "#6e4f1e", # shrubland
                 "#f5e942", # cur ag
                 "#1d4220", # cur conifer
                 "#397d3f", # cur hdw-con
                 "#b0af9e", # developed
                 "#eb4034", # exotics
                 "#fc9d03", # grassland
                 "#56bf5f", # hardwood
                 "#7db7c7",
                 "#6e4f1e"# shrubland
                 
                 
)



#make chord diagram
chord<-chorddiag(data = matrix_df,
                 type = "bipartite",
                 groupColors = groupColors,
                 groupnamePadding = 10,
                 groupPadding = 3,
                 groupnameFontsize = 12 ,
                 showTicks = FALSE,
                 margin=130,
                 tooltipGroupConnector = "    &#x25B6;    ",
                 chordedgeColor = "#363533"
)
chord 


## try static save

#install phantom:
webshot::install_phantomjs(force = TRUE)


# Make a webshot in pdf : high quality but can not choose printed zone
webshot("chord.html" , "output.pdf", delay = 0.2)







#save then print to have white background
htmlwidgets::saveWidget(chord,
                        "chord.html",
                        background = "white",
                        selfcontained = TRUE
)



