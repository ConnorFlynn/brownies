library(tidyverse)
library(rvest)


webpage <- read_html("https://www.eatthis.com/iconic-desserts-united-states/")

dessert_elements<- html_elements(webpage, "h2")
dessert_listing <- dessert_elements %>%
  html_text2() %>% # extracting the text associated with this type of elements of the webpage
  as_tibble() %>% # make it a data frame
  rename(dessert = value) %>% # better name for the column
  head(.,-3) %>% # 3 last ones were not desserts
  rowid_to_column("rank") %>% # adding a column using the row number as proxy for the rank
  write_csv("iconic_desserts.csv") # save it as csv


our_favorite_desserts <- favorite_desserts

for(i in seq_along(our_favorite_desserts$Favorite_dessert)) {
  if(our_favorite_desserts$Favorite_dessert %in% dessert_listing$dessert)
    print(paste("Your favorite desert is iconic"))
  else(
    print(paste("Your faorite desert is not iconic")))
}






