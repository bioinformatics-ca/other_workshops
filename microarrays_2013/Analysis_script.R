### analysis_script.R #########################################################
# This is the analysis script for the CBW bioinformatics 2013 workshop.  It will
# contain all analysis for use in this class.

### LOAD LIBRARIES ############################################################
library(affy);

### LOAD DATA #################################################################
# change to working directory
setwd('C:\\Users\\pboutros\\Desktop\\CBW_exercise\\CEL');

# load the data with multiple CDF files
raw.data.def <- ReadAffy(phenoData = 'Phenodata.txt');
raw.data.alt <- ReadAffy(
	cdfname = 'hgu95av2hsentrezgcdf',
	phenoData = 'Phenodata.txt'
	);

# verify phenodata is correctly installed
pData(raw.data.def);
pData(raw.data.alt); 

### PRE-PROCESS DATA ##########################################################
# preprocess: RMA & default CDF
eset.rma.def <- expresso(
	afbatch = raw.data.def,
	bgcorrect.method = 'rma',
	normalize.method = 'quantiles',
	pmcorrect.method = 'pmonly',
	summary.method = 'medianpolish'
	);

# preprocess: RMA & alternative CDF
eset.rma.alt <- expresso(
	afbatch = raw.data.alt,
	bgcorrect.method = 'rma',
	normalize.method = 'quantiles',
	pmcorrect.method = 'pmonly',
	summary.method = 'medianpolish'
	);

### QA/QC ASSESSMENT ################################################
# localize the preprocessed data
expr.rma.def <- exprs(eset.rma.def);
expr.rma.alt <- exprs(eset.rma.alt);

# set the working directory to the output folder
setwd('../output');

# plot the two density distributions of the raw data side-by-side
jpeg(
	filename = 'Raw_data_density.jpg',
	height = 600,
	width = 1000
	);

par(mfrow = c(1,2));

hist(raw.data.def, las = 1, main = 'Default CDF');
hist(raw.data.alt, las = 1, main = 'Alternative CDF');

dev.off();

# plot the two density distributions of the normalized data side-by-side
jpeg(
	filename = 'Normalized_data_density.jpg',
	height = 600,
	width = 1000
	);

par(mfrow = c(1,2));

plotDensity(mat = expr.rma.def);
plotDensity(mat = expr.rma.alt);

dev.off();

# create a heatmap of normalized data
correlation.matrix.rma.def <- cor(expr.rma.def);
correlation.matrix.rma.alt <- cor(expr.rma.alt);

heatmap.labels <- c( rep('Fox1', 3), rep('Myb1', 3), rep('Control', 3));

jpeg(
	filename = 'Normalized_heatmap_def.jpg',
	height = 600,
	width = 1000
	);

heatmap(
	correlation.matrix.rma.def,
	labRow = heatmap.labels,
	labCol = heatmap.labels,
	scale = "none",
	main = "Default CDF"
	);

dev.off();

jpeg(
	filename = 'Normalized_heatmap_alt.jpg',
	height = 600,
	width = 1000
	);
	
heatmap(
	correlation.matrix.rma.alt,
	labRow = heatmap.labels,
	labCol = heatmap.labels,
	scale = "none",
	main = "Alternative CDF"
	);

dev.off();

### UNIVARIATE STATISTICAL ANALYSIS #################################
control.samples <- pData(eset.rma.def)$Type == 'Control';
fox.samples <- pData(eset.rma.def)$Type == 'Fox1';
myb.samples <- pData(eset.rma.def)$Type == 'Myb1';

utest.rma.def.fox <- rep(NA, nrow(expr.rma.def));
utest.rma.def.myb <- rep(NA, nrow(expr.rma.def));

for (i in 1:nrow(expr.rma.def)) {

	# calculate fox vs. control p-value
	utest.rma.def.fox[i] <- wilcox.test(
		x = expr.rma.def[i,control.samples],
		y = expr.rma.def[i,fox.samples]
		)$p.value;

	# calculate myb vs. control p-value
	utest.rma.def.myb[i] <- wilcox.test(
		x = expr.rma.def[i,control.samples],
		y = expr.rma.def[i,myb.samples]
		)$p.value;

	}








