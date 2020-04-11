### 
# Pre-process some data from https://www.openpowerlifting.org/
# Could and should do this all in the actual app, but
# doing this to speed up the shinyApp, for this assignment.

library(readr)

df <- read.csv("openpowerlifting-2020-02-15.csv")
df <- df[,c(2:5,10,15,20,25,26,34)]
df <- df[df$Event == "SBD" & df$Equipment == "Raw" & df$Federation == "IPF",]
df <- df %>% mutate_each(funs(replace(., .<0, NA)))

write_csv(df, "openpowerlifting.csv", append = FALSE, col_names = TRUE)

