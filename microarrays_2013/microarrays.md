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

Instructions for setting up your laptop can be found here: [Laptop Setup Instructions](http://bioinformatics-ca.github.io/microarray_laptop_setup_2013/)

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

* [.zip CEL files](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Microarray_data.zip) containing:   

-   GSM429557_ST486_Fox1.CEL
-   GSM429558_ST486_Fox2.CEL
-   GSM429559_ST486_Fox3.CEL
-   GSM429560_ST486_MYB1.CEL
-   GSM429561_ST486_MYB2.CEL
-   GSM429562_ST486_MYB3.CEL
-   GSM429563_ST486_NT1.CEL
-   GSM429564_ST486_NT2.CEL
-   GSM429565_ST486_NT3.CEL

* [Phenodata.txt](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Phenodata.txt)

<hr>
Day 1
-----

<hr>
### Welcome

<font color="green">*Faculty: Michelle Brazas*</font>

<hr>
### Module 1: Introduction to Microarrays and R

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** 

[Module 1 pdf](https://bioinformatics.ca/microarrays2013module1-pdf)  
[Module 1 ppt](https://bioinformatics.ca/microarrays2013module1-ppt)  
[Module 1 mp4](https://bioinformatics.ca/microarrays2013module1-mp4)  

**Lab Practical:**

[Modules 1-3 Lab questions](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Microarray_2013_Practical-Questions.pdf)

<hr>
### Module 2: Quality Control of Microarrays

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** 

[Module 2 pdf‎](https://bioinformatics.ca/microarrays2013module2-pdf)  
[Module 2‎ ppt](https://bioinformatics.ca/microarrays2013module2-ppt)  
[Module 2‎ mp4](https://bioinformatics.ca/microarrays2013module2-mp4)  

**Lab Practical:**

[Modules 1-3 Lab questions](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Microarray_2013_Practical-Questions.pdf)  
[Day 1 analysis script](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Analysis_script.R)  

<hr>
### Integrated Assignment

<font color="green">*Faculty: Nicholas Harding*</font>

-   [Evening session R script](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Results.R)  
-   [Integrated Assignment Qs](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Integrated_assignment2013.pdf)  

Note: You will have to create your own phenotype data .txt file, using the sample annotations in the links.

**phenotypedata.txt** Many people had issues with creating the phenotype data file. The phenotype data must be: - TAB delimited - Must contain a header, the header has one fewer column than the other rows. The header also contains a preceding tab. This is because the first column, i.e. the file names are read in as rownames. For differences between the rownames of a data frame and a column, check the dataframe documentation. - Beware of spaces- as the file is tab delimited, any trailing/leading spaces will be incorporated into the cells. Be careful, as 'Control ' is not the same as 'Control'. Hint: some text editors have options that displays whitespace characters.

remember you can check your file has been read in correctly using the:

``` r
   pData() 
```

function, which returns your phenotype annotation as a dataframe.

For further help see

``` r
   ?ReadAffy
```

This points you to another function that loads the dataframe, and tells you exactly what it is expecting.

``` r
   ?read.AnnotatedDataFrame
```

You can troubleshoot any problems with your phenotype data using this function directly.

### Integrated Assignment Data

For annotations:

* Rat: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE10770>
* Mouse: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE10769>

Note: The 11 samples above are the same as in the link below. Only this time they are part of a larger set. Use the link below to prepare PhenoData file: 

* Mouse: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?targ=gse&acc=GSM254871>

For CDF file: Download for alternative-CDF package from: <http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/17.1.0/entrezg.asp>

#### Rat

* [.zip file of rat CEL files](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Rat_data.zip) containing: 

-   GSM273072.CEL
-   GSM273073.CEL
-   GSM273074.CEL
-   GSM273075.CEL
-   GSM273076.CEL
-   GSM273077.CEL
-   GSM273078.CEL
-   GSM273079.CEL

#### Mouse

* [.zip file of mouse CEL files](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Mouse_data.zip) containing:

-   GSM254871.CEL
-   GSM254872.CEL
-   GSM254873.CEL
-   GSM254877.CEL
-   GSM254878.CEL
-   GSM254879.CEL
-   GSM254880.CEL
-   GSM254881.CEL
-   GSM254882.CEL
-   GSM254883.CEL
-   GSM254885.CEL

<hr>
Day 2
-----

<hr>
### Module 3: Statistical Analysis

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:**

[Module 3‎ pdf](https://bioinformatics.ca/microarrays2013module3-pdf)  
[Module 3‎ ppt](https://bioinformatics.ca/microarrays2013module3-ppt)  
[Module 3‎ mp4](https://bioinformatics.ca/microarrays2013module3-mp4)  


[Clustering Slides‎](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Microarrays_2012_Clustering_Slides.pdf)

**Lab Practical:**
[Modules 1-3 Lab questions](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Microarray_2013_Practical-Questions.pdf)  
[Status of R script at 11:55am](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Analysis_scripts_day2am.R)  
[Status of R script at 12:33pm](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Analysis_scripts_day2noon.R)  
[Status of R script at 4:24pm](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Analysis_scripts_day2pm.R)  
[R script with MAS5](https://github.com/bioinformatics-ca/other_workshops/raw/master/microarrays_2013/Analysis_scripts_mas5.R)  

<hr>
### Module 4: Beyond the Microarray Experiment

<font color="green">*Faculty: Paul Boutros*</font>

**Lecture:** 

[Module 4 pdf](https://bioinformatics.ca/microarrays2013module4-pdf)  
[Module 4 ppt](https://bioinformatics.ca/microarrays2013module4-ppt)  
[Module 4 mp4](https://bioinformatics.ca/microarrays2013module4-mp4)  

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
