library(shiny)
library(ggplot2)

dataset <- read.csv("data.csv", header=TRUE, sep=";")
names(dataset) <- c("Team", "Season", "Wins", "Win_Percentage", "Playoffs", "Points", "Field_Goal_Made", "Field_Goal_Attempted",
                    "Field_Goal_Percentage", "Two_Point_Made", "Two_Point_Attempted",
                    "Two_Point_Percentage", "Three_Point_Made", "Three_Point_Attempted",
                    "Three_point_Percentage", "Free_Throw_Made", "Free_Throw_Attempted",
                    "Free_Throw_Percentage", "Offensive_Rebounds", "Defensive_Rebounds",
                    "Total_Rebounds", "Assists", "Steals", "Blocks", "Turnovers", "Personal_Fouls")
dataset$Wins <- as.numeric(dataset$Wins)
dataset$Win_Percentage <- as.numeric(gsub(",", ".", gsub("\\.", "", dataset$Win_Percentage)))

fluidPage(
  titlePanel("NBA REGULAR SEASON STATS (2009-2014)"),

  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1, nrow(dataset)), step=1, round=0),
    
    selectInput('x', 'X axis', names(dataset)),
    selectInput('y', 'Y axis', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),

    checkboxInput('smooth_linear', 'Linear Regression Line'),
    checkboxInput('smooth_curved', 'Curved Regression Line')
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Documentation", verbatimTextOutput("help")),
      tabPanel("Plot", plotOutput("plot"))
    ))
  
  #mainPanel(
   # plotOutput('plot')
  #)
)