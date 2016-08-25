---
layout: post2
permalink: /flow_cyt_laptop_setup_2013/
title: Laptop Setup
header1: Flow Cytometry Laptop Setup 2015
header2: Workshop pages for students
image: CBW_cancerDNA_icon-16.jpg
---

# Flow Cytometry Data Analysis using R (2013): Computer set up instructions

We will be using a virtual machine – a program which emulates a Linux operating system to run R for the workshop. This will minimize technical issues; instructions will be provided at the end of the workshop to reproduce the set up on your own computers, or you can keep the virtual machine and use that for your future R analyses. <br>

<hr>

## System requirements:

1) You need a laptop with at least 4GB of RAM and at least 10GB of free storage space.<br>

2) You should have some program for reading PDFs and any browser other than Internet Explorer.<br>

3) You should also have a program which reads .csv files (spreadsheets). If you do not have one, you can download a free Office suite from http://www.openoffice.org/ which includes a document writer, spreadsheet reader, presentation maker, and more.<br>

4) If you wish, you may bring an .fcs file of your own on a USB data stick that you want to play around with at the end of Day 1. This will give you the opportunity to solidify the skills you learned during the day using data you are personally involved with. This is not required.<br>

<hr>

## Virtual machine installation instructions:

1) Download and install VirtualBox for your computer's operating system from: https://www.virtualbox.org/wiki/Downloads <br>

2) From the same web page, also download and install the extension pack (VirtualBox 4.2.12 Oracle VM VirtualBox Extension Pack, click on "All supported platforms") <br>

3) Download and unzip the file (http://bioinformatics.ca/workshop_wiki/images/bigfiles/R_and_FCM_workshop.zip R and FCM workshop.zip) to your own computer from the workshop wiki. Ensure download is complete before you attempt to open the virtual machine – it is a large file (>2.0GB), it may take a while. When you unzip it, there should be a folder called “R and FCM workshop” with 3 files and a Logs folder inside. <br>

4) To ensure the virtual machine runs as efficiently as possible, you should close the other programs running on your laptop that are not essential. The virtual machine actually uses 2GB of RAM but a good rule of thumb is that you should have another 2GB free. If you happen to have a laptop with > 4GB memory, then you can actually increase the RAM allocated to the virtual machine by running the program you installed above, Oracle VM VirtualBox, right-clicking on the “R and FCM workshop” virtual machine in the left-hand side panel, select “Settings”, click “System” and move the dial on the “Base Memory” to increase. Make sure you leave yourself at least half of the available RAM to ensure everything will run smoothly. So, if, for example, you have 6GB RAM, you can assign 3GB to the virtual machine (3GB = 3 x 1024MB = 3072MB). <br>

5) Go to the R and FCM Workshop folder and open the .vbox file. This will start up the virtual machine -- give it a minute to boot up. It is normal to see a few warning messages pop up – these are normal. If this doesn't work, you can run the new program you installed (VirtualBox) and should see in the left-side menu "R and FCM workshop", double click to run or select and click "Start". <br>

6) Log in by clicking on the "Rguru" user and typing the password "guest123" (without the quotes). Unmaximize and then maximize the window. If it looks bad/doesn't fill the screen well, in the top menu of the window click "Devices" --> "Install Guest Additions". Once it is complete, restart the machine by clicking on the gear wheel at the top right corner of the desktop --> "Shut down..." --> "Restart". Log in again and unmaximize/maximize the window to make sure it stretches properly. <br>


For any issue which arises you can look through the VirtualBox documentation:
https://www.virtualbox.org/manual/UserManual.html


<b>OR (highly recommended)</b>
simply google your exact question, chances are someone else has had the same issue and it has been answered.


<b>AND/OR</b>
Copy and paste exact error message into google if there is one.<br>


7) If all of the above works, you are ready to use R. For this workshop we will use Rstudio, you should see a big blue launcher icon with the letter "R" on it on the left side of the desktop. Click to open. The Rstudio interface contains four panels. The top-left one is the editor where you write your code – you should already see a source code file opened (hivData.R), with some code already written. Directly below that section is the Console – this is where code is executed. You can type directly in the console to execute code, for example type '4 + 5' and press enter. The top-right panel contains two tabs, Workspace and History. History saves the code that you have executed. The panel below it contains 4 tabs: Files (just a file browser), Plots (this is where we will see any plots we generate, note the grayed out back/forward arrows under the Plots tab, this allows you to look through all the plots you have generated), Packages and Help (you can search for terms like "read.FCS"). The introduction to R reading material suggested also includes  an introduction to Rstudio. (http://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf . Ignore the sections on installing R and Rstudio, as those are already installed for you in the virtual machine. Also skip Section 10.) <br>


Now in the first panel (top left), on the top menu of that panel click "Source". This will execute the whole script that is currently opened. If you accidentally closed it or it was not opened for you, click File --> Open File and navigate to Documents/Workshop/code and open 'hivData.R'. Then press Source. Wait a moment and a plot should open up asking you to gate the lymphocytes using 6 mouse clicks. Try to emulate a fairly loose gate by clicking around the lymphocytes, don't worry if your first and last clicks don't meet. Then wait a few more moments and two plots will be generated very quickly one after the other -- you can see the first one by looking at the Plots tab on the bottom-right panel and clicking the back arrow. Give it a second after each click, these plots are large. You can see the second plot again by clicking on the forward arrow. Note that there is an "Export" menu in the Plots tab, which lets you save your plots as images. <br>


The first of the plots represents the cells of interest (lymphocytes) for all samples in the data set, and the second plot is a visualization of each colour in the FCM data for just one of the samples. This is just an example of some of the things we will learn how to do.

<br>
<hr>

At this point you should read the short introduction to R and Rstudio document and follow the examples:

http://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf
