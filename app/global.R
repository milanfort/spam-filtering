
modelVariableNames = c("to_multiple", "attach", "winner", "format", "re_subj")

modelVariableDescriptions = c(
    "has multiple recipients in the To field",
    "has an attachment",
    "contains the word 'winner'",
    "is in HTML format",
    "has 'Re:' at the beginning of its subject"
)

names(modelVariableDescriptions) <- modelVariableNames

names(modelVariableNames) <- modelVariableDescriptions
