library(shiny)
library(ggplot2)

nba <- read.csv("data.csv", header=TRUE, sep=";")
names(nba) <- c("Team", "Season", "Wins", "Win_Percentage", "Playoffs", "Points", "Field_Goal_Made", "Field_Goal_Attempted",
                "Field_Goal_Percentage", "Two_Point_Made", "Two_Point_Attempted",
                "Two_Point_Percentage", "Three_Point_Made", "Three_Point_Attempted",
                "Three_point_Percentage", "Free_Throw_Made", "Free_Throw_Attempted",
                "Free_Throw_Percentage", "Offensive_Rebounds", "Defensive_Rebounds",
                "Total_Rebounds", "Assists", "Steals", "Blocks", "Turnovers", "Personal_Fouls")
nba$Wins <- as.numeric(nba$Wins)
nba$Win_Percentage <- as.numeric(gsub(",", ".", gsub("\\.", "", nba$Win_Percentage)))

function(input, output) {

  dataset <- reactive({
    nba[sample(nrow(nba), input$sampleSize),]
  })

  output$plot <- renderPlot({

    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)

    if (input$smooth_linear)
      p <- p + geom_smooth(method=lm)
    if (input$smooth_curved)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
  
}