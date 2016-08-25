---
layout: post2
permalink: /microarray_laptop_setup_2013/
title: Microarray Data Analysis 2013 Student Page
header1: Microarray Data Analysis Laptop Setup 2013
header2: Workshop pages for students
image: CBW_cancerDNA_icon-16.jpg
---

1) Install the latest version of R, which can be downloaded from http://probability.ca/cran/
If you need help on installing R see bullet 8 below for assistance.

2) Install the BioConductor core packages. To do this, open R and type at the > prompt, then wait for the prompt to reappear and type second command:

``` r
 source("http://bioconductor.org/biocLite.R");
 
 biocLite();
 
 biocLite("affy");
 
 require(affy);
```

<b>NOTE:</b> The execution of this last command should not be an error, and should start with the following line of text:
 
 Loading required package: affy

3) For analysis of the microarray platform, you will need to download and install the alternative CDF file associated with the array. 

Download for HGU95Av2_Hs_ENTREZG alternative-CDF package from: http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/17.1.0/entrezg.asp

Locate the row containing HGU95Av2_Hs_ENTREZG and download the 'C' file that corresponds with your machine (PC=Win32, Source=Mac or Linux).
This will be a zipped file.



Two options for loading this into your R session:

A) Unzip the file (see below if you do not already have an unzip program). Then place this unzipped folder in your R working directory and execute the following command in R:

 install.packages("hgu95av2hsentrezgcdf_17.1.0", repos = NULL, type="source");  
You may need to modify this file name according to the name of the folder just created by unzipping the download. My folder name for example, did not have _17.1.0. For a MAC you will need the type="source" parameter, but you may not require this parameter on a PC.
 

B) Let R upload the file by executing the following command in R which will open a dialogue box allowing you to select the zip file to upload:
 install.packages(file.choose(), repos=NULL)


To test whether you have installed this package correctly, execute the following R command:

```r 
 require(hgu95av2hsentrezgcdf);
```

<b>NOTE:</b> If you have installed hgu95av2hsentrezgcdf package properly, the output from this command should not be an error and should start with the following lines of text:

``` r
 Loading required package: hgu95av2hsentrezgcdf
 Loading required package: AnnotationDbi
 Loading required package: BiocGenerics
 Loading required package: parallel
```

4) A robust text editor. For Windows/PC - notepad++ (http://notepad-plus-plus.org/). For Linux - gEdit  (http://projects.gnome.org/gedit/). For Mac – TextWrangler (http://www.barebones.com/products/textwrangler/download.html)

5) A file decompression tool. For Windows/PC – 7zip (http://www.7-zip.org/). For Linux – gzip (http://www.gzip.org). For Mac – already there.

6) A robust internet browser such as Firefox or Safari (Internet Explorer and Chrome are not recommended because of Java issues).

7) A PDF viewer (Adobe Acrobat or equivalent).
