---
layout: post2
permalink: /microarrays_2013/
title: Microarray Data Analysis 2013 Student Page
header1: Microarray Data Analysis 2013
header2: Workshop pages for students
image: CBW_cancerDNA_icon-16.jpg
---

Laptop Setup Instructions
-------------------------

Instructions for setting up your laptop can be found here: [Laptop Setup Instructions\_Microarrays](Laptop_Setup_Instructions_Microarrays "wikilink")

Pre-Workshop Tutorials
----------------------

1) **R Preparation tutorials**: You are expected to have completed the following tutorials in **R** beforehand. The tutorial should be very accessible even if you have never used **R** before.

* The [R Tutorial](http://www.cyclismo.org/tutorial/R/) up to and including 5. Basic Plots
* The [R command cheat sheet](../../resources/R_Short-refcard.pdf)

2) **UNIX Preparation tutorials**: 

* Tutorials #1-3 on [UNIX Tutorial for Beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/)
* [Unix Cheat sheet](http://www.rain.org/~mkummel/unix.html) 


<hr>
[R teaching material for Sunday June 23](https://bioinformatics.ca/statistics2013module1-ppt)

Pre-Workshop Readings
---------------------

[The MicroArray Quality Control (MAQC) project shows inter- and intraplatform reproducibility of gene expression measurements](http://www.ncbi.nlm.nih.gov/pubmed/16964229)
[Microarray data analysis: from disarray to consolidation and consensus](http://www.ncbi.nlm.nih.gov/pubmed/16369572)

<hr>
R Review Session
----------------

[R review Module](../../resources/RReview_slides.pdf)  
[R review Scripts](https://github.com/bioinformatics-ca/bioinformatics-ca.github.io/blob/master/resources/R_Review_Session_Code.ipynb)  

<hr>

Data Sets:
----------

-   [GSM429557\_ST486\_Fox1.CEL](Media:GSM429557_ST486_Fox1.CEL "wikilink")
-   [GSM429558\_ST486\_Fox2.CEL](Media:GSM429558_ST486_Fox2.CEL "wikilink")
-   [GSM429559\_ST486\_Fox3.CEL](Media:GSM429559_ST486_Fox3.CEL "wikilink")
-   [GSM429560\_ST486\_MYB1.CEL](Media:GSM429560_ST486_MYB1.CEL "wikilink")
-   [GSM429561\_ST486\_MYB2.CEL](Media:GSM429561_ST486_MYB2.CEL "wikilink")
-   [GSM429562\_ST486\_MYB3.CEL](Media:GSM429562_ST486_MYB3.CEL "wikilink")
-   [GSM429563\_ST486\_NT1.CEL](Media:GSM429563_ST486_NT1.CEL "wikilink")
-   [GSM429564\_ST486\_NT2.CEL](Media:GSM429564_ST486_NT2.CEL "wikilink")
-   [GSM429565\_ST486\_NT3.CEL](Media:GSM429565_ST486_NT3.CEL "wikilink")
-   [Phenodata.txt](Media:Phenodata.txt "wikilink")

<hr>
Day 1
-----

<hr>
### Welcome

<font color="green">*Faculty: Michelle Brazas*</font>

<hr>
### Module 1: Introduction to Microarrays and R

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** [Module 1](Media:Microarray_2013_Module1.pdf "wikilink")

**Lab Practical:**
[Modules 1-3 Lab questions](Media:Microarray_2013_Practical-Questions.pdf "wikilink")

<hr>
### Module 2: Quality Control of Microarrays

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** [Module 2‎](Media:Microarray_2013_Module2.pdf "wikilink")

**Lab Practical:**
[Modules 1-3 Lab questions](Media:Microarray_2013_Practical-Questions.pdf "wikilink")
[Day 1 analysis script](Media:analysis_script.R "wikilink")

<hr>
### Integrated Assignment

<font color="green">*Faculty: Nicholas Harding*</font>

-   [Evening session R script](Media:Results.R "wikilink")
-   [Integrated Assignment Qs](Media:Integrated_assignment2013.pdf "wikilink")

Note: You will have to create your own phenotype data .txt file, using the sample annotations in the links.

**phenotypedata.txt** Many people had issues with creating the phenotype data file. The phenotype data must be: - TAB delimited - Must contain a header, the header has one fewer column than the other rows. The header also contains a preceding tab. This is because the first column, i.e. the file names are read in as rownames. For differences between the rownames of a data frame and a column, check the dataframe documentation. - Beware of spaces- as the file is tab delimited, any trailing/leading spaces will be incorporated into the cells. Be careful, as 'Control ' is not the same as 'Control'. Hint: some text editors have options that displays whitespace characters.

remember you can check your file has been read in correctly using the:

`   pData() `

function, which returns your phenotype annotation as a dataframe.

For further help see

`   ?ReadAffy`

This points you to another function that loads the dataframe, and tells you exactly what it is expecting.

`   ?read.AnnotatedDataFrame`

You can troubleshoot any problems with your phenotype data using this function directly.

### Integrated Assignment Data

For annotations:
Rat: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE10770>
Mouse: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE10769>
Note: The 11 samples above are the same as in the link below. Only this time they are part of a larger set. Use the link below to prepare PhenoData file: Mouse: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?targ=gse&acc=GSM254871>

For CDF file: Download for alternative-CDF package from: <http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/17.1.0/entrezg.asp>

#### Rat

-   [GSM273072.CEL](Media:GSM273072.CEL "wikilink")
-   [GSM273073.CEL](Media:GSM273073.CEL "wikilink")
-   [GSM273074.CEL](Media:GSM273074.CEL "wikilink")
-   [GSM273075.CEL](Media:GSM273075.CEL "wikilink")
-   [GSM273076.CEL](Media:GSM273076.CEL "wikilink")
-   [GSM273077.CEL](Media:GSM273077.CEL "wikilink")
-   [GSM273078.CEL](Media:GSM273078.CEL "wikilink")
-   [GSM273079.CEL](Media:GSM273079.CEL "wikilink")

#### Mouse

-   [GSM254871.CEL](Media:GSM254871.CEL "wikilink")
-   [GSM254872.CEL](Media:GSM254872.CEL "wikilink")
-   [GSM254873.CEL](Media:GSM254873.CEL "wikilink")
-   [GSM254877.CEL](Media:GSM254877.CEL "wikilink")
-   [GSM254878.CEL](Media:GSM254878.CEL "wikilink")
-   [GSM254879.CEL](Media:GSM254879.CEL "wikilink")
-   [GSM254880.CEL](Media:GSM254880.CEL "wikilink")
-   [GSM254881.CEL](Media:GSM254881.CEL "wikilink")
-   [GSM254882.CEL](Media:GSM254882.CEL "wikilink")
-   [GSM254883.CEL](Media:GSM254883.CEL "wikilink")
-   [GSM254885.CEL](Media:GSM254885.CEL "wikilink")

<hr>
Day 2
-----

<hr>
### Module 3: Statistical Analysis

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:**
[Module 3‎](Media:Microarray_2013_Module3.pdf "wikilink")
[Clustering Slides‎](Media:Microarrays_2012_Clustering_Slides.pdf "wikilink")

**Lab Practical:**
[Modules 1-3 Lab questions](Media:Microarray_2013_Practical-Questions.pdf "wikilink")
[Status of R script at 11:55am](Media:Analysis_scripts_day2am.R "wikilink")
[Status of R script at 12:33pm](Media:Analysis_scripts_day2noon.R "wikilink")
[Status of R script at 4:24pm](Media:Analysis_scripts_day2pm.R "wikilink")
[R script with MAS5](Media:Analysis_scripts_mas5.R "wikilink")

<hr>
### Module 4: Beyond the Microarray Experiment

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** [Module 4](Media:Microarray_2013_Module4.pdf "wikilink")

<hr>
Other (more advanced) resources
-------------------------------

*Manuals:*

More detailed introduction to R. Not a basic tutorial, this is for people who really want to know more about R.

<http://cran.r-project.org/doc/manuals/R-intro.html>

*Books:*

1) "Introductory Statistics with R" by Peter Dalgaard. It is not required for this workshop but if you are interested in buying a good book and/or want to know more, you might want to consider getting a copy.

Section 1-5 give a very good (perhaps very detailed) idea of what I plan to discuss during the workshop.

2) Statistics for Biology and Health by Robert Gentleman, Vincent Carey, Wolfgang Huber, Rafael Irizarry and Sandrine Dudoit

3) Building Bioinformatics Solutions with Perl, R and MySQL by Conrad Bessant, Ian Shadforth and Darren Oakley

<hr>
