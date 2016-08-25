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
ttest.rma.def.fox <- rep(NA, nrow(expr.rma.def));
ttest.rma.def.myb <- rep(NA, nrow(expr.rma.def));
foldc.rma.def.fox <- rep(NA, nrow(expr.rma.def));
foldc.rma.def.myb <- rep(NA, nrow(expr.rma.def));

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

	# calculate fox vs. control p-value
	ttest.rma.def.fox[i] <- t.test(
		x = expr.rma.def[i,control.samples],
		y = expr.rma.def[i,fox.samples]
		)$p.value;

	# calculate myb vs. control p-value
	ttest.rma.def.myb[i] <- t.test(
		x = expr.rma.def[i,control.samples],
		y = expr.rma.def[i,myb.samples]
		)$p.value;

	# calculate fold-change for fox
	foldc.rma.def.fox[i] <- mean(expr.rma.def[i,fox.samples]) - mean(expr.rma.def[i,control.samples]);
	
	foldc.rma.def.myb[i] <- mean(expr.rma.def[i,myb.samples]) - mean(expr.rma.def[i,control.samples]);
	
	}

# Now repeat using the alternative CDF
utest.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
utest.rma.alt.myb <- rep(NA, nrow(expr.rma.alt));
ttest.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
ttest.rma.alt.myb <- rep(NA, nrow(expr.rma.alt));
foldc.rma.alt.fox <- rep(NA, nrow(expr.rma.alt));
foldc.rma.alt.myb <- rep(NA, nrow(expr.rma.alt));

for (i in 1:nrow(expr.rma.alt)) {

	# calculate fox vs. control p-value
	utest.rma.alt.fox[i] <- wilcox.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,fox.samples]
		)$p.value;

	# calculate myb vs. control p-value
	utest.rma.alt.myb[i] <- wilcox.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,myb.samples]
		)$p.value;

	# test for zero variance
	variance.control <- var(expr.rma.alt[i,control.samples]);
	variance.fox <- var(expr.rma.alt[i,fox.samples]);
	variance.myb <- var(expr.rma.alt[i,myb.samples]);

	if (variance.control == 0 | variance.fox == 0 | variance.myb == 0) {
		ttest.rma.alt.fox[i] <- NA;
		ttest.rma.alt.myb[i] <- NA;
		foldc.rma.alt.fox[i] <- NA;
		foldc.rma.alt.myb[i] <- NA;
		next;
		}

	# calculate fox vs. control p-value
	ttest.rma.alt.fox[i] <- t.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,fox.samples]
		)$p.value;

	# calculate myb vs. control p-value
	ttest.rma.alt.myb[i] <- t.test(
		x = expr.rma.alt[i,control.samples],
		y = expr.rma.alt[i,myb.samples]
		)$p.value;

	# calculate fold-change for fox
	foldc.rma.alt.fox[i] <- mean(expr.rma.alt[i,fox.samples]) - mean(expr.rma.alt[i,control.samples]);
	
	foldc.rma.alt.myb[i] <- mean(expr.rma.alt[i,myb.samples]) - mean(expr.rma.alt[i,control.samples]);
	
	}

# multiple testing adjustment
fdr.utest.rma.def.fox <- p.adjust(utest.rma.def.fox, method = "fdr");
fdr.utest.rma.def.myb <- p.adjust(utest.rma.def.myb, method = "fdr");
fdr.ttest.rma.def.fox <- p.adjust(ttest.rma.def.fox, method = "fdr");
fdr.ttest.rma.def.myb <- p.adjust(ttest.rma.def.myb, method = "fdr");

fdr.utest.rma.alt.fox <- p.adjust(utest.rma.alt.fox, method = "fdr");
fdr.utest.rma.alt.myb <- p.adjust(utest.rma.alt.myb, method = "fdr");
fdr.ttest.rma.alt.fox <- p.adjust(ttest.rma.alt.fox, method = "fdr");
fdr.ttest.rma.alt.myb <- p.adjust(ttest.rma.alt.myb, method = "fdr");

# let's explore our data a little
plot(
	x = utest.rma.def.fox, 
	y = ttest.rma.def.fox
	);

# let's save the normalized data to file
write.table(
	x = expr.rma.alt,
	file = 'normalized_RMA-alt.txt',
	sep = "\t",
	col.names = NA
	);

write.table(
	x = expr.rma.def,
	file = 'normalized_RMA-def.txt',
	sep = "\t",
	col.names = NA
	);

# let's save the statistical analysis to file
write.table(
	x = cbind(
		utest.rma.def.fox,
		ttest.rma.def.fox,
		foldc.rma.def.fox,
		utest.rma.def.myb,
		ttest.rma.def.myb,
		foldc.rma.def.myb
		),
	file = 'statistical_analysis-rma-def.txt',
	sep = "\t",
	row.names = rownames(expr.rma.def),
	col.names = NA
	);
