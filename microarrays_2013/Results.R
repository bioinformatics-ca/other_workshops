### Tutorial 1 Answers.R ######################################################
# We are analyzing the GSE17172 dataset and looking to understand univariate
# data-analysis techniques.

### PREAMBLE ##################################################################
# step one is to tell R where the data is actually stored
setwd('C:/Documents and Settings/pboutros/Desktop/GSE17172/');

# next we load the affy library from BioConductor
library(affy);

### LOAD DATA #################################################################
# I personally find it easiest to make a vector of the files to be loaded
files.to.load <- c(
	'GSM429557_ST486_Fox1.CEL',
	'GSM429558_ST486_Fox2.CEL',
	'GSM429559_ST486_Fox3.CEL',
	'GSM429560_ST486_MYB1.CEL',
	'GSM429561_ST486_MYB2.CEL',
	'GSM429562_ST486_MYB3.CEL',
	'GSM429563_ST486_NT1.CEL',
	'GSM429564_ST486_NT2.CEL',
	'GSM429565_ST486_NT3.CEL'
	);

# You can then pass this character vector to ReadAffy to load the files. This
# approach makes life much easier if you want to only load a small fraction of
# the dataset at a later time.
raw.data <- ReadAffy(
	filenames = files.to.load,
	phenoData = 'phenodata.txt'
	);
# Note that R may go and download the CDF file, which annotates CEL files with
# useful information here. Also note that I specified the phenoData argument
# to tell R which samples are controls and which are experimental.

### PRE-PROCESS DATA: RMA #####################################################
# We will use the expresso() function here, although there are actually a
# couple of alternative ways to use RMA on a dataset like this (justRMA, rma).
# expresso() is by far the most flexible technique, though.  R may need to
# download another file at this step.
preprocessed.data <- expresso(
	afbatch = raw.data,
	bgcorrect.method = 'rma',
	normalize.method = 'quantiles',
	pmcorrect.method = 'pmonly',
	summary.method = 'medianpolish',
	);

# Note that all the arguments in this function are case-sensitive. Also note the
# way we are systematically ordering our code -- consistent indenting and variable
# naming is critical to making your work easy to interpret in the future. It reduces
# the likelihood of bugs and programming errors, and makes it easier for a stranger
# to read and maintain your work.

### USING AN ALTERNATIVE CDF ##################################################
# To reprocess the data using an alternative CDF we have to reload it using that CDF
# The first step is to go to the Brainarray website, download the CDF, and install
# it into your R session. Next, you reload the raw data, specifying this new mapping:
raw.data.alt <- ReadAffy(
	filenames = files.to.load,
	phenoData = 'phenodata.txt',
	cdfname = 'hgu95av2hsentrezgcdf'
	);

# And we can re-pre-process this new dataset using expresso() again:
preprocessed.data.alt <- expresso(
	afbatch = raw.data.alt,
	bgcorrect.method = 'rma',
	normalize.method = 'quantiles',
	pmcorrect.method = 'pmonly',
	summary.method = 'medianpolish',
	);

### ASSESS DATA QUALITY #######################################################
# We can start off by making a simple histogram of the raw data
hist(raw.data);

# But in general we want to save all figures to file. This has the advantage
# of providing a permanent record of our results. It only takes a couple of
# lines of code, but it can often save re-running scripts multiple times.
jpeg(
	filename = 'GSE17172-defaultCDF-rawdata-histogram.jpg',
	height = 800,
	width = 800
	);
hist(raw.data);
dev.off();

# Similarly we can look at the normalized data
jpeg(
	filename = 'GSE17172-defaultCDF-RMAdata-density.jpg',
	height = 800,
	width = 800
	);
plotDensity(exprs(preprocessed.data));
dev.off();

# And we can do the same for data processed using the alternative CDF
jpeg(
	filename = 'GSE17172-alternativeCDF-rawdata-histogram.jpg',
	height = 800,
	width = 800
	);
hist(raw.data.alt);
dev.off();

jpeg(
	filename = 'GSE17172-alternativeCDF-RMAdata-density.jpg',
	height = 800,
	width = 800
	);
plotDensity(exprs(preprocessed.data.alt));
dev.off();

# You can also combine these two plots quite easily
jpeg(
	filename = 'GSE17172-alternativeCDF-alldata-density.jpg',
	height = 800,
	width = 1600
	);
par(mfrow = c(1,2));
hist(raw.data.alt);
plotDensity(exprs(preprocessed.data.alt));
dev.off();

# Making a heatmap can be tricky -- there are a lot of parameters and
# options that can be set. In general heatmap.2() and levelplot() do
# a slightly better job than the default heatmap function in R, but
# there are a lot of customizations possible with any of these approaches.
# The first step to creating the heatmap is to create the correlation
# matrix:
correlation.matrix <- cor(exprs(preprocessed.data), method = 'spearman');
# Note that here we used a Spearman correlation, but it is trivial to change
# to a different correlation metric.  A rank-order correlation (like Spearman)
# tends to do a better job in discriminating large vectors.
# Note also that we used the exprs() function -- this is a function that
# takes the object format produces by expresso() and extracts just the
# preprocessed data in a more user-friendly format. In particular, the format
# it generates is often called an "expression matrix".  An expression matrix
# has samples as columns and genes/features as rows.

# Next we can make a simple heatmap directly with:
heatmap(correlation.matrix);

# However there are a number of improvements we can make here:

# First we stop scaling the data so the principle diagonal is equivalent
heatmap(correlation.matrix, scale = 'none');

# Next we add a main title
heatmap(
	correlation.matrix,
	scale = 'none',
	main = 'Correlation Map - RMA + Default CDF'
	);

# Then we add easier labels to the rows
heatmap(
	correlation.matrix,
	scale = 'none',
	main = 'Correlation Map - RMA + Default CDF',
	labRow = pData(preprocessed.data)$Type
	);

# And we can remove the column labels
heatmap(
	correlation.matrix,
	scale = 'none',
	main = 'Correlation Map - RMA + Default CDF',
	labRow = pData(preprocessed.data)$Type,
	labCol = NA
	);

# Lastly save this to file
jpeg(
	filename = 'GSE17172-defaultCDF-RMAdata-heatmap.jpg',
	height = 800,
	width = 1600
	);
heatmap(
	correlation.matrix,
	scale = 'none',
	main = 'Correlation Map - RMA + Default CDF',
	labRow = pData(preprocessed.data)$Type,
	labCol = NA
	);
dev.off();

# And we can make the same for the alternative CDF
correlation.matrix.alt <- cor(exprs(preprocessed.data.alt), method = 'spearman');

jpeg(
	filename = 'GSE17172-alternativeCDF-RMAdata-heatmap.jpg',
	height = 800,
	width = 1600
	);
heatmap(
	correlation.matrix.alt,
	scale = 'none',
	main = 'Correlation Map - RMA + Default CDF',
	labRow = pData(preprocessed.data.alt)$Type,
	labCol = NA
	);
dev.off();

### UNIVARIATE STATISTICAL ANALYSIS ###########################################
# The first step in doing this analysis is to create a place to store the
# resulting set of p-values. You can do this with a vector, but first we
# "localize" the data -- that is get rid of the function-call syntax:
expression.data <- exprs(preprocessed.data);
pvalues.fox.default.rma <- rep(NA, nrow(expression.data));

# We can then do a simple loop over the data
for (i in 1:nrow(expression.data)) {
	pvalues.fox.default.rma[i] <- t.test(
		x = expression.data[i,pData(preprocessed.data)$Type == 'Fox1'],
		y = expression.data[i,pData(preprocessed.data)$Type == 'Control']
		)$p.value;
	}

# We can repeat this almost exactly for Myb:
pvalues.myb.default.rma <- rep(NA, nrow(expression.data));

for (i in 1:nrow(expression.data)) {
	pvalues.myb.default.rma[i] <- t.test(
		x = expression.data[i,pData(preprocessed.data)$Type == 'Myb1'],
		y = expression.data[i,pData(preprocessed.data)$Type == 'Control']
		)$p.value;
	}

# we repeat this for the alternative CDF, but now merging things into one loop
expression.data.alt <- exprs(preprocessed.data.alt);

pvalues.fox.alternative.rma <- rep(NA, nrow(expression.data.alt));
pvalues.myb.alternative.rma <- rep(NA, nrow(expression.data.alt));

for (i in 1:nrow(expression.data.alt)) {
	pvalues.fox.alternative.rma[i] <- t.test(
		x = expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Fox1'],
		y = expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Control']
		)$p.value;
		
	pvalues.myb.alternative.rma[i] <- t.test(
		x = expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Myb1'],
		y = expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Control']
		)$p.value;
	}

# adjusting for multiple testing is straight-forward
qvalues.fox.default.rma <- p.adjust(pvalues.fox.default.rma, method = 'fdr');
qvalues.myb.default.rma <- p.adjust(pvalues.myb.default.rma, method = 'fdr');
qvalues.fox.alternative.rma <- p.adjust(pvalues.fox.alternative.rma, method = 'fdr');
qvalues.myb.alternative.rma <- p.adjust(pvalues.myb.alternative.rma, method = 'fdr');

# plots are also relatively simple: let's put four histograms on one page
jpeg(
	filename = 'GSE17172-defaultCDF-statistics-histograms.jpg',
	height = 1600,
	width = 1600
	);
par(mfrow = c(2,2));
hist(pvalues.fox.default.rma, main = 'FoxM1 P-values', las = 1, breaks = seq(0,1,0.1));
hist(qvalues.fox.default.rma, main = 'FoxM1 Q-values', las = 1, breaks = seq(0,1,0.1));
hist(pvalues.myb.default.rma, main = 'Myb P-Values', las = 1, breaks = seq(0,1,0.1));
hist(qvalues.myb.default.rma, main = 'Myb Q-Values', las = 1, breaks = seq(0,1,0.1));
dev.off();

# and next let's compare naive to adjusted p-values
jpeg(
	filename = 'GSE17172-defaultCDF-statistics-scatterplots.jpg',
	height = 800,
	width = 1600
	);
par(mfrow = c(1,2));
plot(
	x = pvalues.fox.default.rma,
	y = qvalues.fox.default.rma,
	main = 'FoxM1',
	las = 1
	);
plot(
	x = pvalues.myb.default.rma,
	y = qvalues.myb.default.rma,
	main = 'Myb',
	las = 1
	);
dev.off();

### COMPARE EXPERIMENTAL CONDITIONS ###########################################
# To compare the data directly is similar to what we did above. We simply
# create scatterplots that compare p-values between the two conditions.
jpeg(
	filename = 'GSE17172-bothCDF-RMA-conditioncomparison.jpg',
	height = 800,
	width = 1600
	);
par(mfrow = c(1,2));
plot(
	x = pvalues.fox.default.rma,
	y = pvalues.myb.default.rma,
	main = 'Default',
	las = 1
	);
plot(
	x = pvalues.fox.alternative.rma,
	y = pvalues.myb.alternative.rma,
	main = 'Alternative',
	las = 1
	);
dev.off();

# Similarly it is straight-forward to create Venn diagrams
library(VennDiagram);
venn.diagram(
	list(
		Fox = rownames(expression.data)[pvalues.fox.default.rma < 0.05],
		Myb = rownames(expression.data)[pvalues.myb.default.rma < 0.05]
		),
	filename = 'GSE17172-defaultCDF-RMA-conditionVenn-05.tiff'
	);

venn.diagram(
	list(
		Fox = rownames(expression.data)[pvalues.fox.default.rma < 0.01],
		Myb = rownames(expression.data)[pvalues.myb.default.rma < 0.01]
		),
	filename = 'GSE17172-defaultCDF-RMA-conditionVenn-01.tiff'
	);

venn.diagram(
	list(
		Fox = rownames(expression.data)[pvalues.fox.default.rma < 0.001],
		Myb = rownames(expression.data)[pvalues.myb.default.rma < 0.001]
		),
	filename = 'GSE17172-defaultCDF-RMA-conditionVenn-001.tiff'
	);

venn.diagram(
	list(
		Fox = rownames(expression.data.alt)[pvalues.fox.alternative.rma < 0.05],
		Myb = rownames(expression.data.alt)[pvalues.myb.alternative.rma < 0.05]
		),
	filename = 'GSE17172-alternativeCDF-RMA-conditionVenn-05.tiff'
	);

venn.diagram(
	list(
		Fox = rownames(expression.data.alt)[pvalues.fox.alternative.rma < 0.01],
		Myb = rownames(expression.data.alt)[pvalues.myb.alternative.rma < 0.01]
		),
	filename = 'GSE17172-alternativeCDF-RMA-conditionVenn-01.tiff'
	);

venn.diagram(
	list(
		Fox = rownames(expression.data.alt)[pvalues.fox.alternative.rma < 0.001],
		Myb = rownames(expression.data.alt)[pvalues.myb.alternative.rma < 0.001]
		),
	filename = 'GSE17172-alternativeCDF-RMA-conditionVenn-001.tiff'
	);

### CALCULATE FOLDCHANGES PER GENE ############################################
# Again, we pre-create variables to store the data
foldchanges.fox <- rep(NA, nrow(expression.data));
foldchanges.myb <- rep(NA, nrow(expression.data));

for (i in 1:nrow(expression.data)) {
	foldchanges.fox[i] <- mean(expression.data[i,pData(preprocessed.data)$Type == 'Fox1']) -
		mean(expression.data[i,pData(preprocessed.data)$Type == 'Control']);
	foldchanges.myb[i] <- mean(expression.data[i,pData(preprocessed.data)$Type == 'Myb1']) -
		mean(expression.data[i,pData(preprocessed.data)$Type == 'Control']);
	}

# And nearly identical code for the alternative CDF
foldchanges.fox.alt <- rep(NA, nrow(expression.data.alt));
foldchanges.myb.alt <- rep(NA, nrow(expression.data.alt));

for (i in 1:nrow(expression.data.alt)) {
	foldchanges.fox.alt[i] <- mean(expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Fox1']) -
		mean(expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Control']);
	foldchanges.myb.alt[i] <- mean(expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Myb1']) -
		mean(expression.data.alt[i,pData(preprocessed.data.alt)$Type == 'Control']);
	}

# Volcano plots can be easily created now
jpeg(
	filename = 'GSE17172-defaultCDF-statistics-volcanoplots.jpg',
	height = 800,
	width = 1600
	);
par(mfrow = c(1,2));
plot(
	x = foldchanges.fox,
	y = -log10(pvalues.fox.default.rma),
	main = 'FoxM1',
	las = 1
	);
plot(
	x = foldchanges.myb,
	y = -log10(pvalues.myb.default.rma),
	main = 'Myb',
	las = 1
	);
dev.off();

# And of course very similar code for the alternative CDF
jpeg(
	filename = 'GSE17172-alternativeCDF-statistics-volcanoplots.jpg',
	height = 800,
	width = 1600
	);
par(mfrow = c(1,2));
plot(
	x = foldchanges.fox.alt,
	y = -log10(pvalues.fox.alternative.rma),
	main = 'FoxM1',
	las = 1
	);
plot(
	x = foldchanges.myb.alt,
	y = -log10(pvalues.myb.alternative.rma),
	main = 'Myb',
	las = 1
	);
dev.off();
