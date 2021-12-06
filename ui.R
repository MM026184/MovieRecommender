## ui.R
library(shiny)
library(shinydashboard)
library(recommenderlab)
library(data.table)
library(ShinyRatingInput)
library(shinyjs)

source('functions/helpers.R')

shinyUI(
    dashboardPage(
          skin = "blue",
          dashboardHeader(title = "Movie Recommender"),
          
          dashboardSidebar(
            sidebarMenu(
                # Setting id makes input$tabs give the tabName of currently-selected tab
                id = "tabs",
                menuItem("Popular Movies by Genre", tabName = "byGenre", icon = icon("hotjar")),
                menuItem("Discover Movies for You", tabName = "byCollab", icon = icon("users"))
            )
          ),
          dashboardBody(
            includeCSS("css/movies.css")
            ,tabItems(
                tabItem("byCollab",
                    fluidRow(
                        box(width = 12, title = "Step 1: Rate as many movies as possible", status = "info", solidHeader = TRUE, collapsible = TRUE,
                            div(class = "rateitems",
                                uiOutput('ratings')
                            )
                        )
                    )
                )
                ,tabItem("byGenre",
                    fluidRow(
                        box(width = 12, title = "Step 1: Select a movie genre", status = "info", solidHeader = TRUE, collapsible = TRUE,
                            selectInput("selectedGenre","Genre",
                                choices = c("Action", "Adventure", "Animation", 
                                "Children's", "Comedy", "Crime",
                                "Documentary", "Drama", "Fantasy",
                                "Film-Noir", "Horror", "Musical", 
                                "Mystery", "Romance", "Sci-Fi", 
                                "Thriller", "War", "Western")
                            )
                        )
                    )
                )
            )
            ,fluidRow(
                useShinyjs(),
                box(
                    width = 12, status = "info", solidHeader = TRUE,
                    title = "Step 2: Discover movies you might like",
                    br(),
                    withBusyIndicatorUI(
                    actionButton("btn", "Click here to get your recommendations", class = "btn-warning")
                    ),
                    br(),
                    tableOutput("results")
                )
            )
        )
    )
) 