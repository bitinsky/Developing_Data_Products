library(shiny)
library(readr)
library(dplyr)

# Data read and pre-processing ----
df <- read_csv("data/openpowerlifting.csv", 
               col_types = cols_only(
                 Sex = col_factor(levels = c("F","M","Mx"), ordered = FALSE),
                 Best3SquatKg = col_double(),
                 Best3BenchKg = col_double(),
                 Best3DeadliftKg = col_double(),
                 TotalKg = col_double()
               ))

server <- function(input, output) {
  df_subset <- reactive({
    df %>% 
      filter(Sex == input$gender,
             !is.na(input$event),
             input$event > 0) %>% 
          select(input$event)
  })
  
  output$plot <- renderPlot({
    boxplot(df_subset(),
            main=input$event,
            ylab="kilograms of weight lifted (kg)",
            col="orange",
            border="brown")
  })
  
  output$summary <- renderText({summary(df_subset())})
  
  output$dt <- renderDataTable({
    df_subset() 
  })
  
  output$text1 <- renderUI({
    HTML(paste("This is a presentation of powerlifting statistics for lifters competing within the <a href='https://www.powerlifting.sport/'>International Powerlfiting Federation.</a>",
    "Powerlifting consists of three events, which are <a href='https://en.wikipedia.org/wiki/Powerlifting#Squat'>Squat</a>, <a href='https://en.wikipedia.org/wiki/Powerlifting#Bench_press'>Bench Press</a>, <a href='https://en.wikipedia.org/wiki/Powerlifting#Deadlift'>Deadlift</a>, plus the cumulative <b>Total</b> of those three.", 
    "","This presentation is only for 'raw,' 'classic', or <a href='https://en.wikipedia.org/wiki/Powerlifting#Equipped_powerlifting'>'un-equipped'</a> lifting.",
    "Future versions of this will allow for further breakdown into age and weight classes, and possibly all the various powerlifting federations. For now it consists of all lifters data separated only into gender and event.",
    "","You can select <b style='color:Orange;'>Gender</b> from the <i style='color:Violet;'>radio buttons</i>, and the the <b style='color:Orange;'>Event</b> from the <i style='color:Violet;'>drop-down list</i>",
    "After selecting the parameters that you are interested in, you can see a <b style='color:Orange;'>box plot</b> by clicking on the <i style='color:Violet;'><b>Plot</b> tab</i>, and the associated <b style='color:Orange;'>data table</b> from the <i style='color:Violet;'><b>Data</b> tab</i>",
    "","All data is courtesy of <a href = 'https://www.openpowerlifting.org/'>Open Powerlifting</a>",
    sep="<br/>"))
  })
  
  
   
}