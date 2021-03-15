#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
ui <- navbarPage("Smart Cart",
                 tabPanel("Home",
                          
                          fluidRow(
                              column(12,
                                     img(src='./g2.png')
                              )),
                          tabsetPanel(
                          type="tabs",
                          tabPanel("Top Selling",
                            mainPanel(DTOutput('table'))),
                          tabPanel("Orders"),
                          tabPanel("Confirmation")
                          
                          )
),
                tabPanel("About Us"),
                tabPanel("Contact Us")
)
                 


# Define server logic required to draw a histogram
server <- function(input, output) {

    products<-read.csv("products.csv")
    head(products)
    top_prod<-products[1:50,1:2]
    
   # output$tbl <- renderDataTable(top_prod, options = list(
    #     pageLength = 5,
    #     initComplete = I('function(setting, json) { alert("done"); }')
    # )
    #)
    
    
    output$table <- renderDT({
        data <- data.frame(ROW = top_prod$product_name,
                           TEXT = '<input id="text" type="text" class="form-control" value=""/>',
                           SINGLE_SELECT = '<select id="single_select" style="width: 100%;">
                                          <option value="" selected></option>
                                          <option value="A">A</option>
                                          <option value="B">B</option>
                                          <option value="C">C</option>
                                        </select>',stringsAsFactors = FALSE)
        
        datatable(data = data,
                  selection = "none",
                  escape = FALSE,
                  rownames = FALSE)
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
