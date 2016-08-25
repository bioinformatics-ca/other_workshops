# Open lab assignment for CBW June 17, 2013
# Author: Radina Droumeva

###############################
# Use either your own FCS file or the one below provided by the flowQ package:
library(flowQ)
data(qData) # a data set containing 8 flowSets with 4 samples each
f <- qData[[1]][[1]] # first flowSet, first flowFrame
f

###############################
# Question 1: Using the keyword information embedded in the FCS file, can you answer any of the following (note if using your own file, your annotation may be missing some of this information)
# a) Date of file acquisition? This can be used if you want to use a control sample and must make sure it was acquired on the same day as your stained sample!
# b) What is the tube name? This can be used as a quality check.
# c) What is the unique patient identifier? This can be used as a quality check.

###############################
# Question 2: create a 2D dot plot using the scatter channels.

###############################
# Question 3: based on this plot, design and execute an algorithm to remove the debris/margin events and only retain the lymphocytes. Then, plot the original frame, and overtop of that plot (hint: see ?points, hint2: remember to use pch=".") the new "clean" frame containing only the lymphocytes in a different colour (to see names of colours you can use see ?colours). Note that if you are using your own FCS file and the lymphocytes are not the relevant population in terms of FSC-SSC 2D dot plot, then feel free to come up with something useful to do using those channels -- e.g. remove the debris by setting a threshold on low-scatter cells, removing doublets by plotting the FSC-W channel instead of side scatter, etc..

##############################
# Question 4: Note that in Question 1 you looked through the keywords and there was no compensation matrix provided. Assume the data is compensated. If using your own FCS file -- do you need to apply the compensation? If so, see ?compensate and apply it.

##############################
# Question 5: which channels need to be transformed? Pick one of the channels and create a 2 by 2 plot of:
# a) SSC-A vs Untransformed Channel of choice. Rmember -- you should now be using your 'clean' flowFrame with the lymphocytes only, not the original one. 
# b) SSC-A vs Log10 of values in Channel of choice
# c) SSC-A vs Asinh of the channel values
# d) Create a logicle transformation object, call it 'lgcl', and create a plot of SSC-A vs logicle transform of channel values
# NOTE: If possible, please pick a 'nice' channel for this excercise, e.g. a major stain such as CD3, CD4, CD8, etc. -- one for which you expect to see two nicely separated positive and negative fractions!
# Hint 1: if your points seem squished, remember you can add 'ylim = c(0, some suitable value)' inside your 'plot' statement!
# Hint 2: (if using qData) Does your logicle transform not look nearly as good as you hoped? See ?logicleTransform and see what parameter you should change and try again. If it still does not look right -- do not worry, this is actually a fault with the data. Can you think of a way to demonstrate that to convince yourself? 

##############################
# Question 6: Transform all channels which you believe should be transformed and come up with one plot (with multiple small plots if necessary) which allows you to see what the transformed data looks like.


