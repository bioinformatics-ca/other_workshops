# Open lab assignment ANSWER KEY for CBW June 17, 2013
# Author: Radina Droumeva

############################################
####### ANSWER TO QUESTION 1 ###############
# For the fcs file defined above, first take a look through the keywords:
f@description
# The answers then follow:
answer.to.a <- f@description$`$DATE`
answer.to.b <- f@description$`TUBE NAME`
answer.to.c <- f@description$`PATIENT ID`
############################################


########### ANSWER TO QUESTION 2 ###########
# Many ways to plot, here are 3:
# Using R's basic plotting functionality, use 'exprs' -- this contains the expression values we want to plot
plot(exprs(f)[, c("FSC-A", "SSC-A")], pch=".", main = "Plot 1")

# Using flowViz plotting, slightly simplified
library(flowViz)
plot(f, c("FSC-A", "SSC-A"), main = "Plot 2")
contour(f, c("FSC-A", "SSC-A"), nlevels=20, add=TRUE) #
# flowViz actually has a tonne of cool things you can plot, check out the documentation:
# http://www.bioconductor.org/packages/release/bioc/vignettes/flowViz/inst/doc/filters.pdf

# Using plotDens in flowDensity
plotDens(f, c("FSC-A", "SSC-A"))
############################################

######## ANSWER TO QUESTION 3 ##############
# Roughly, the FSC-A boundaries for the lymphocytes look like 250 and 600, and for SSC-A: 100 and 400.
# Verify by adding to the current plot:
abline(v = c(250, 600), lwd = 2, col = "blue") # See ?abline; 'lwd' refers to line width, 2 means twice as thick as usual, 'col' refers to the colour for the line.
abline(h = c(100, 400), lwd = 2, col = "blue")

# Now to actually extract the lymphocytes, first we find the indices in terms of the FSC-A restriction:
fsc.indices <- intersect(which(exprs(f)[, "FSC-A"] > 250), which(exprs(f)[, "FSC-A"] < 600))

# Now restrict on SSC-A and find the cells in the intersection:
ssc.indices <- intersect(which(exprs(f)[, "SSC-A"] > 100), which(exprs(f)[, "SSC-A"] < 400))
lymphocytes <- intersect(fsc.indices, ssc.indices)

# Create a new flowFrame object which only contains the lymphocyte cells of 'f':
f.clean <- f[lymphocytes]

# Now let's first plot f and overtop plot f.clean:
plot(f, c("FSC-A", "SSC-A"), smooth=FALSE) #smooth=FALSE to make the next plot better visible
points(exprs(f.clean)[, c("FSC-A", "SSC-A")], pch=".", col = "red")
############################################

######## ANSWER TO QUESTION 4 ##############
# Typically, the compensation matrix will be in one of the keywords of the FCS file:
# compensation.matrix <- f@description$`SPILL` or f@description$`SPILLOVER` or something similar.
# Then all you have to do is:
# f.compensated <- compensate(f, compensation.matrix)
############################################

######## ANSWER TO QUESTION 5 ##############
# Let's pick CD4. First, we will create all transformations and then plot them.
# I do not want to type "PE-Cy7-A" over and over, so I will create a variable:
mychan <- "PE-Cy7-A"

# Log10:
f.log <- f.clean
exprs(f.log)[, mychan] <- log10(exprs(f.clean)[, mychan])

# Asinh:
f.asinh <- f.clean
exprs(f.asinh)[, mychan] <- asinh(exprs(f.clean)[, mychan])

# Logicle:
lgcl <- logicleTransform(t = 1024) # See ?logicleTransform to find out why I set t = 1024!
f.lgcl <- f.clean
exprs(f.lgcl)[, mychan] <- lgcl(exprs(f.clean)[, mychan])

# Estimate Logicle, just to try:
estimate.lgcl <- estimateLogicle(f.clean, mychan)
f.est <- transform(f.clean, estimate.lgcl)

# Now open a new plot with 2 by 2 slots:
par(mfrow = c(3, 2)) # Actually, I did 2 by 3 to add a couple of plots extra!
plot(f.clean, c("SSC-A", mychan), main = "Untransformed", smooth=FALSE, ylim = c(0, 400))
plot(f.log, c("SSC-A", mychan), main = "Log 10", smooth=FALSE, ylim = c(0, 3))
plotDens(f.asinh, c("SSC-A", mychan), main = "Asinh")
plotDens(f.lgcl, c("SSC-A", mychan), main = "Logicle")
plotDens(f.est, c("SSC-A", mychan), main = "Estimate Logicle")
hist(exprs(f.clean)[, mychan], 30)
legend('top', paste(round(length(which(exprs(f.clean)[, mychan] == 1))/nrow(f.clean)*100,1), "% of cells have\n values equal to 1 for ", mychan, sep = ""))

# Note there appear to be a bunch of bunched up values on the axis... The truth is, those values were on the axis to begin with, so transforming them cannot turn them into anything other than a bunch of points on the axis! This is likely an ancient computer system attached to the flow cytometer which does this to the data when the operator saves the files -- we cannot reverse-engineer this. How would we catch this better? Use a Quality Assurance check! Here is one idea:
# For the purposes of flowQ, we cannot work with a single frame, so consider the flowSet it came from, qData[[1]]:
save.dir <- '/home/rguru/Documents/Workshop/assignmentQA/'
# See the help for why I added "absolute.value = 0.1". Also try running it without that and see what happens.
# Note that when we omit the 'channels' parameter, it checks the margin event count for every channel.
qa.check <- qaProcess.marginevents(set = qData[[1]], outdir = save.dir, absolute.value = 0.1)
url <- writeQAReport(qData[[1]], list(qa.check), outdir = save.dir)
browseURL(url)
############################################


######### ANSWER TO QUESTION 6 #############
# Cycle through each channel and transform (except scatter channels and Time!)
f.trans <- f.clean
for (chan in colnames(f.clean)[3:7]){
  exprs(f.trans)[, chan] <- lgcl(exprs(f.clean)[, chan])
}
# Note the last plot below will be against the 'Time' parameter -- this is useful in quality assurance!
par(mfrow = c(3, 2))
for (chan in colnames(f.trans)[3:8]){
  plotDens(f.trans, c("SSC-A", chan))
}

############################################
