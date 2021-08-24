library(tidyverse)
library(rvest)
library(tibble)


webpage <- read_html("https://www.eatthis.com/iconic-desserts-united-states/")

dessert_elements<- html_elements(webpage, "h2")
dessert_listing <- dessert_elements %>%
  html_text2() %>% # extracting the text associated with this type of elements of the webpage
  as_tibble() %>% # make it a data frame
  rename(dessert = value) %>% # better name for the column
  head(.,-3) %>% # 3 last ones were not desserts
  rowid_to_column("rank") %>% # adding a column using the row number as proxy for the rank
  write_csv("iconic_desserts.csv") # save it as csv




our_desserts <- tribble(~first_name, ~last_name, ~desserts,
                        "Connor", "Flynn", "Brownies",
                        "Charles", "Hendrickson", "Spring Rolls")


for(i in seq_along(our_desserts$desserts)) {
  if(our_desserts$desserts[i] %in% dessert_listing$dessert)
    print(paste("Your favorite desert is iconic"))
  else(
    print(paste("Your favorite desert is not iconic"))
  )
}


find_dessert <- function(name) {
  fav_dessert <- filter(our_desserts, name == first_name)
  return(fav_dessert$desserts)
}

find_dessert("Connor")
