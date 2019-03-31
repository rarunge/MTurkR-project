## More MTurk data for revise and resubmit 

# these lines connect to our MTurk account:
Sys.setenv(AWS_ACCESS_KEY_ID = "") #removed for GitHub; it's best security practice to keep these in a separate ".env" file.
Sys.setenv(AWS_SECRET_ACCESS_KEY = "") #removed for GitHub; it's best security practice to keep these in a separate ".env" file.

# dependencies
library(MTurkR)
library(MTurkRGUI) #another option...also couldn't get this to work AND it doesn't allow copy + paste for the XML code, so it may frustrate you quickly
library(XML)

# test connection to live server
AccountBalance(sandbox=F)  #this should be $31.43
# test connection to sandbox server
AccountBalance(sandbox = TRUE) #this should be $10,000

# load the GUI (but the GUI kind of sucks)
wizard(style = "tcltk", sandbox = getOption('MTurkR.sandbox'))

# try it the non-GUI way:
test <- CreateQualificationType('Mental Health', 
                                'Answer a brief question about mental health', 
                                status = "Inactive", 
                                retry.delay = NULL, test = NULL, answerkey = NULL, 
                                test.duration = NULL,
                                validate.test = FALSE, validate.answerkey = FALSE,
                                auto = NULL, auto.value = NULL,
                                verbose = getOption('MTurkR.verbose', TRUE)) #, ...)
DisposeQualificationType(test$QualificationTypeId)

## Here's sample code for what I'm trying to do: 

# QualificationType with test and answer key
qf <- paste0(readLines(system.file("templates/qualificationtest1.xml", package = "MTurkR")), collapse="")
qa <- paste0(readLines(system.file("templates/answerkey1.xml", package = "MTurkR")), collapse="")
qual1 <- CreateQualificationType(name = "Qualification with Test",
                                 description = "This qualification is a demo",
                                 test = qf,
                                 answerkey = qa, # optionally, use AnswerKey
                                 status = "Active",
                                 keywords = "test, autogranted",
                                 test.duration = 30)
DisposeQualificationType(qual1$QualificationTypeId)


## revised solution

# QualificationType with test and answer key
qf.test <- paste0(readLines(paste0(getwd(),"/qualificationtest-revised.xml")), collapse="")
qa.test <- paste0(readLines(paste0(getwd(),"/answerkey-revised.xml")), collapse="")
qual.Test <- CreateQualificationType(name = "Mental Health Questions - Revised",
                                     description = "Answer a brief question about mental health",
                                     test = qf.test,
                                     answerkey = qa.test,
                                     status = "Inactive",
                                     keywords = "",
                                     test.duration = 30)
DisposeQualificationType(qual.Test$QualificationTypeId)


## search qualification types

SearchQualificationTypes(only.mine = TRUE, return.all = TRUE)

## parse XML for comparison

#compare qualificationtest XML code from R package author with revised XML
xmlParse(qf)
xmlParse(qf.test)

#compare answerkey XML code from R package author with revised XML
xmlParse(qa)
xmlParse(qa.test)


