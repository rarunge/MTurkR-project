## More MTurk data for revise and resubmit 

library(MTurkR)
library(MTurkRGUI) #another option...also couldn't get this to work AND it doesn't allow copy + paste for the XML code, so it may frustrate you quickly
library(XML)

# these lines connect to our MTurk account:
Sys.setenv(AWS_ACCESS_KEY_ID = "")
Sys.setenv(AWS_SECRET_ACCESS_KEY = "")

# test connection to live server
AccountBalance(sandbox=F)  #this should be $31.43
# test connection to sandbox server
AccountBalance(sandbox = TRUE) #this should be $10,000

# load the GUI (but the GUI kind of sucks)
wizard(style = "tcltk", sandbox = getOption('MTurkR.sandbox'))

# try it the non-GUI way:
CreateQualificationType('Mental Health', 'Answer a brief question about mental health', Inactive, 
                        retry.delay = NULL, test = NULL, answerkey = NULL, 
                        test.duration = NULL,
                        validate.test = FALSE, validate.answerkey = FALSE,
                        auto = NULL, auto.value = NULL,
                        verbose = getOption('MTurkR.verbose', TRUE), ...)

## Here's sample code for what I'm trying to do: 
# QualificationType with test and answer key
qf <- paste0(readLines(system.file("qualificationtest.xml", package = "MTurkR")), collapse="")
qa <- paste0(readLines(system.file("answerkey.xml", package = "MTurkR")), collapse="")
qual1 <- CreateQualificationType(name = "Qualification with Test",
                                 description = "This qualification is a demo",
                                 test = qf,
                                 answerkey = qa, # optionally, use AnswerKey
                                 status = "Active",
                                 keywords = "test, autogranted")
DisposeQualificationType(qual1$QualificationTypeId)




