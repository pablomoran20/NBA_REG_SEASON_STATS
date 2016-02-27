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
    
  }, height=600)
  
  output$help <- renderPrint({
    cat(c("This application lets you compare a series of statistical data stored in the NBA stats database, between the 2009-10 and the 2013-14 season.\n\nThe results are all given in per game basis, apart from total wins (per season) and the percentage variables. The variables that can be specified in the X and Y axes and in the color differentiation are the following:\n- Team\n- Season\n- Wins: total per season, win %\n- Achieved playoffs?\n- Points scored\n- Field goal: made, attempted, FG %\n- 2-point: made, attempted, 2pt %\n- 3-point: made, attempted, 3pt %\n- Free throw: made, attempted, FT %\n- Rebounds: offensive, defensive, total\n- Assists\n- Steals\n- Blocks\n- Turnovers\n- Personal fouls\n\nIf the color input is set to None, the regression line for the X-Y relationship (lineal and/or curved) can be graphically observed."))
  })
  

  
}