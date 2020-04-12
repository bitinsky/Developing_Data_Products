library(shiny)
library(shinythemes)
# Define UI for app that draws a histogram ----
ui <- fluidPage(theme = shinytheme("superhero"),
  
  # App title ----
  titlePanel("INTERNATIONAL POWERLIFTING FEDERATION (IPF) STATISTICS"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      selectInput(inputId = "event", label = "Event:",
                  choices = c("Squat" = "Best3SquatKg",
                              "Bench Press" = "Best3BenchKg",
                              "Deadlift" = "Best3DeadliftKg",
                              "Total" = "TotalKg"),
                  selected = "Squat"),

      radioButtons(inputId = "gender", label = "Gender:",
                         choices = c("Male" = "M",
                                     "Female" = "F"),
                                    # "Other" = "Mx"), # Mx not used in this Federation
                         selected = "M"),
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Box and Whisker plot ----
      tabsetPanel(
        tabPanel("Summary", htmlOutput("text1")),
        tabPanel("Plot", plotOutput("plot"),textOutput("summary")),
        tabPanel("Table",dataTableOutput("dt")) 
      )
    )
  )
)