#  iOS Test Automation

Thank you for taking the time to look at my application and technical task.

There are no external dependencies for running the tests that I have put together, if you navigate to the AutomationAssessmentUITests.swift file you should hopefully be able to run them from there.

I had a few considerations when writing these, one of which was the use of an extensions file. Since this is a simple app I opted against using one, but in a more normal app case, I would move some of the more generally "useful" functions into that so they can be called from other tests and page models. Like the "swipeUpXTimes" function I used to scroll to the bottom of some content.

I tried to approach it in a way that keeps the UI Tests file quite human readable, with the functions acting as user journey instructions. Keeping the logic contained to the page model. I have found this to be a good way to help onboard testers who have less technical experience in the past.

One issue that I did notice with my tests is in scenario 4, when navigating to the bottom of the page. The way that I implemented the function checkForEndOfPlaceholderText would find the "This is the end of the placeholder text." even if the UI tests did not scroll down. As the content text is all one element, this is obtained straight away. I could not find a better way to identify this while I was working on this assessment, so I have left it as it is and thought I should make a note of it here :)

