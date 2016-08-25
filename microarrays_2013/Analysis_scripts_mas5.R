### analysis_script.R #########################################################
# This is the analysis script for the CBW bioinformatics 2013 workshop.  It will
# contain all analysis for use in this class.

### LOAD LIBRARIES ############################################################
library(affy);

### LOAD DATA #################################################################
# change to working directory
setwd('C:\\Users\\pboutros\\Desktop\\CBW_exercise\\CEL');

# load the data with multiple CDF files
raw.data.alt <- ReadAffy(
	cdfname = 'hgu95av2hsentrezgcdf',
	phenoData = 'Phenodata.txt'
	);

# verify phenodata is correctly installed
pData(raw.data.alt); 

### PRE-PROCESS DATA ##########################################################
# preprocess: RMA & alternative CDF
eset.rma.alt <- expresso(
	afbatch = raw.data.alt,
	bgcorrect.method = 'rma',
	normalize.method = 'quantiles',
	pmcorrect.method = 'pmonly',
	summary.method = 'medianpolish'
	);

# preprocess: MAS5 & alternative CDF
eset.mas.alt <- expresso(
	afbatch = raw.data.alt,
	bgcorrect.method = 'mas',
	normalize.method = 'invariantset',
	pmcorrect.method = 'mas',
	summary.method = 'mas'
	);

### QA/QC ASSESSMENT ################################################
# localize the preprocessed data
expr.rma.alt <- exprs(eset.rma.alt);
expr.mas.alt <- exprs(eset.mas.alt);

# set the working directory to the output folder
setwd('../output');

### UNIVARIATE STATISTICAL ANALYSIS #################################
control.samples <- pData(eset.rma.alt)$Type == 'Control';
fox.samples <- pData(eset.rma.alt)$Type == 'Fox1';
myb.samples <- pData(eset.rma.alt)$Type == 'Myb1';

utest.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
utest.mas.alt.fox <- rep(NA, nrow(expr.rma.alt));

ttest.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
ttest.mas.alt.fox <- rep(NA, nrow(expr.rma.alt));

foldc.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
foldc.mas.alt.fox <- rep(NA, nrow(expr.rma.alt));

for (i in 1:nrow(expr.rma.alt)) {

	# calculate fox vs. control p-value - RMA
	utest.rma.alt.fox[i] <- wilcox.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,fox.samples]
		)$p.value;

	# calculate fox vs. control p-value - MAS
	utest.mas.alt.fox[i] <- wilcox.test(
		x = expr.mas.alt[i,control.samples],
		y = expr.mas.alt[i,fox.samples]
		)$p.value;
		
	# test for zero variance
	variance.rma.control <- var(expr.rma.alt[i,control.samples]);
	variance.mas.control <- var(expr.mas.alt[i,control.samples]);
	variance.rma.fox <- var(expr.rma.alt[i,fox.samples]);
	variance.mas.fox <- var(expr.mas.alt[i,fox.samples]);

	if (variance.rma.control == 0 | variance.rma.fox == 0 | variance.mas.control == 0 | variance.mas.fox == 0) {
		ttest.rma.alt.fox[i] <- NA;
		ttest.mas.alt.fox[i] <- NA;
		foldc.rma.alt.fox[i] <- NA;
		foldc.mas.alt.fox[i] <- NA;
		next;
		}

	# calculate fox vs. control p-value - RMA
	ttest.rma.alt.fox[i] <- t.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,fox.samples]
		)$p.value;

	# calculate fox vs. control p-value - MAS
	ttest.mas.alt.fox[i] <- t.test(
		x = expr.mas.alt[i,control.samples],
		y = expr.mas.alt[i,fox.samples]
		)$p.value;

	# calculate fold-change for fox - RMA
	foldc.rma.alt.fox[i] <- mean(expr.rma.alt[i,fox.samples]) - mean(expr.rma.alt[i,control.samples]);
	
	# calculate fold-change for fox - MAS
	foldc.rma.alt.fox[i] <- mean(expr.rma.alt[i,fox.samples]) / mean(expr.rma.alt[i,control.samples]);
	
	}

# multiple testing adjustment
fdr.utest.rma.alt.fox <- p.adjust(utest.rma.alt.fox, method = "fdr");
fdr.ttest.mas.alt.fox <- p.adjust(ttest.mas.alt.fox, method = "fdr");

fdr.utest.rma.alt.fox <- p.adjust(utest.rma.alt.fox, method = "fdr");
fdr.ttest.mas.alt.fox <- p.adjust(ttest.mas.alt.fox, method = "fdr");

# let's explore our data a little
plot(
	x = utest.rma.alt.fox, 
	y = ttest.rma.alt.fox
	);

# let's save the normalized data to file
write.table(
	x = expr.rma.alt,
	file = 'normalized_RMA-alt.txt',
	sep = "\t",
	col.names = NA
	);

write.table(
	x = expr.mas.alt,
	file = 'normalized_MAS-alt.txt',
	sep = "\t",
	col.names = NA
	);

# let's save the statistical analysis to file
write.table(
	x = cbind(
		utest.rma.alt.fox,
		ttest.rma.alt.fox,
		foldc.rma.alt.fox,
		utest.mas.alt.fox,
		ttest.mas.alt.fox,
		foldc.mas.alt.fox
		),
	file = 'statistical_analysis-rma-alt.txt',
	sep = "\t",
	row.names = rownames(expr.rma.alt),
	col.names = NA
	);
