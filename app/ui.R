library(shiny)

shinyUI(fluidPage(
    titlePanel("E-Mail Spam Filter Test"),
    fluidRow(
        column(6,
               wellPanel(
                   checkboxGroupInput("emailProperties", label = h3("E-Mail Properties"),
                                      choices = as.list(modelVariableNames), selected = NULL),
                   tags$small(helpText(paste(
                       "Select which properties the evaluated e-mail should have.",
                       "Each property can either lower or raise the probability of the e-mail",
                       "to be classified as spam."
                    )))
               )
        ),
        column(6,
               wellPanel(
                   sliderInput("threshold", label = h3("Threshold"), min = 0, max = 1, value = 0.5),
                   tags$small(helpText(paste(
                       "Select the threshold - minimum probability for spam.",
                       "E-mail messages with predicted spam probability at or above this value",
                       "will be classified as spam.",
                       "Note that setting this value too low will result in too many good e-mails",
                       "classified as spam (false positives). Setting it too high will result in",
                       "too many spam messages not classified as spam (false negatives)."
                   )))
               )
        )
    ),
    fluidRow(
        column(6,
               wellPanel(
                   h3("Model Evaluation"),
                   p(
                       "Under the threshold",
                       strong(textOutput("thresholdEvaluation", inline = TRUE)),
                       "the prediction model correctly classified",
                       strong(textOutput("correctOverall", inline = TRUE)),
                       "out of ",
                       strong(textOutput("testMessagesCount", inline = TRUE)),
                       "test messages.",
                       strong(textOutput("correctSpam", inline = TRUE)),
                       "messages were correcly classified as spam and",
                       strong(textOutput("correctHam", inline = TRUE)),
                       "messages were correcly classified as ham.",
                       "The prediction accuracy is",
                       strong(textOutput("accuracy", inline = TRUE)),
                       "and test error rate is",
                       strong(textOutput("errorRate", inline = TRUE))
                    ),
                   tableOutput("confusionMatrix")
               )
        ),
        column(6,
               wellPanel(
                   h3("Result"),
                   p("An e-mail with the following properties:"),
                   htmlOutput("properties", container = tags$ul),
                   p(
                       "has predicted spam probability",
                       strong(textOutput("probability", inline = TRUE)),
                       "and is classified under the threshold",
                       strong(textOutput("thresholdResult", inline = TRUE)),
                       "as",
                       strong(textOutput("result", inline = TRUE))
                   )
               )
        )
    )
))
