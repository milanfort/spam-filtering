library(shiny)
set.seed(99)
options(digits=2)

#url <- "email.txt"
loadData <- function (url) {
    emails <- read.table(url, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
    selectedVariables <- c(
        "spam", "to_multiple", "cc", "attach", "dollar", "winner",
        "inherit", "password", "format", "re_subj", "exclaim_subj"
    )
    emails <- emails[selectedVariables]

    convertToIndicator <- function(value) {
        factor(ifelse(value > 0, "yes", "no"), levels = c("yes", "no"), ordered = TRUE)
    }

    # Turn winner temporarily into number in order for the next conversion to work properly
    emails["winner"] <- ifelse(emails["winner"] == "yes", 1, 0)
    emails <- as.data.frame(apply(emails, 2, convertToIndicator))
    emails
}

# emailProperties <- c("attach", "winner", "format")
predictProbabilityForEmail <- function (emailProperties) {
    testEmail <- rep(factor("no", levels=c("yes", "no"), ordered=TRUE), ncol(emails))
    names(testEmail) <- names(emails)
    testEmail[emailProperties] <- "yes"
    testEmail <- as.data.frame(t(as.matrix(testEmail)))
    predict(fit, newdata = testEmail, type = "response")
}

emails <- loadData("email.txt")
train <- sample(c(TRUE, FALSE), size = nrow(emails), replace = TRUE, prob = c(0.6, 0.4))
fit <- glm(spam~to_multiple+attach+winner+format+re_subj, data = emails, family = binomial, subset = train)
testData <- emails[!train, ]
testPrediction <- predict(fit, newdata = testData, type="response")

shinyServer(
    function(input, output) {
        output$testMessagesCount <- renderText(nrow(testData))

        threshold <- reactive({input$threshold})
        output$thresholdEvaluation <- renderText({threshold()})
        output$thresholdResult <- renderText({threshold()})

        prediction <- reactive({ifelse(testPrediction > threshold(), "yes", "no")})
        confusionMatrix <- reactive({table(prediction(), as.character(testData[, "spam"]))})

        output$correctOverall <- renderText({
            ifelse(nrow(confusionMatrix()) == 2,
                   confusionMatrix()[1, 1] + confusionMatrix()[2, 2],
                   ifelse(threshold() > 0.5, confusionMatrix()[1, 1], confusionMatrix()[1, 2]))
        })

        output$correctSpam <- renderText({
            ifelse(nrow(confusionMatrix()) == 2,
                   confusionMatrix()[2, 2],
                   ifelse(threshold() > 0.5, 0, confusionMatrix()[1, 2]))
        })

        output$correctHam <- renderText({
            ifelse(nrow(confusionMatrix()) == 2 || threshold() > 0.5, confusionMatrix()[1, 1], 0)
        })

        output$confusionMatrix <- renderTable({confusionMatrix()})

        accuracy <- reactive({mean(prediction() == as.character(testData[, "spam"]))})
        output$accuracy <- renderText({accuracy()})
        output$errorRate <- renderText({1 - accuracy()})

        output$properties <- renderUI({
            prefix <- ifelse(length(input$emailProperties) > 0, "<li>", "[NONE SELECTED]")
            properties <- modelVariableDescriptions[input$emailProperties]
            HTML(paste0(prefix, paste0(properties, collapse = "<li>")))
        })

        probability <- reactive({predictProbabilityForEmail(input$emailProperties)})
        output$probability <- renderText({probability()})
        output$result <- renderText({ifelse(probability() >= threshold(), "SPAM", "HAM")})
    }
)
