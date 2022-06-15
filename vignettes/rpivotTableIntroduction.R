## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----ideas, fig.show='hold'---------------------------------------------------
# devtools::install_github(c("ramnathv/htmlwidgets",
#                            "smartinsightsfromdata/rpivotTable"))

# for latest updates use
# devtools::install_github("fraupflaume/rpivotTable")


## ----noted, fig.show='hold'---------------------------------------------------
# install.packages('htmlwidgets', 'rpivotTable')

## ----setMeUp, fig.show='hold'-------------------------------------------------
library(rpivotTable)  # No need to explicitly load htmlwidgets; it's done for you
library(dplyr)        # for one of the examples below with the use of pipes

## ----showMe, fig.show='hold'--------------------------------------------------
data(mtcars)
rpivotTable(mtcars, rows = "gear",
            cols = c("cyl", "carb"), 
            width = "100%", height = "400px")

## ----moreIdeas, results="hold"------------------------------------------------

data(HairEyeColor)
rpivotTable(data = HairEyeColor, 
            rows = "Hair",cols = "Eye", vals = "Freq", 
            aggregatorName = "Sum", rendererName = "Table", 
            width = "100%", height = "400px")

## ----evenMore, results="hold"-------------------------------------------------

rpivotTable(data = HairEyeColor, 
            rows = "Hair", cols = "Eye", vals = "Freq", 
            aggregatorName = "Sum", rendererName = "Table", 
            width = "100%", height = "400px",
            sorters = "function(attr) {
            var sortAs = $.pivotUtilities.sortAs;
            if(attr == 'Hair'){ return sortAs(['Red', 'Brown', 'Blond', 'Black']);}
            }")


## ----subIt, fig.show='hold'---------------------------------------------------
rpivotTable(mtcars, 
            rows="gear", cols=c("cyl", "carb"), 
            subtotals = TRUE, 
            width = "100%", height = "400px")

## ----pipeIt, fig.show='hold'--------------------------------------------------

iris %>%
  as_tibble() %>%
  filter( Sepal.Width > 3 & Sepal.Length > 5 ) %>%
  rpivotTable(rows = "Sepal.Width",  rendererName = "Treemap",
              rendererOptions = list(
                d3 = list(size = list(
                  width = "400", height = "400") # can't use % here
                )))


