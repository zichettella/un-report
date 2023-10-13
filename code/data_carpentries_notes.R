

# Data Carpentries October 12, 2023 ---------------------------------------

#testing
2+2

# Running Code ------------------------------------------------------------

## 1. click run button
## 2. hit "command" + "return"
## 3. you can highlight specific parts of a line/multiple lines
## 4. Code menu & click "run selected lines"
## 5. Hit "source" and it'll run every single line
#### 5A source("~/Documents/UMichData/data-carpentries/un-report/gdp_population.R")
## 5.1 Source + Echo prints all the annotation and code as well as the results
#### 5.1A source("~/Documents/UMichData/data-carpentries/un-report/gdp_population.R", echo=TRUE)


# Adding Packages ----------------------------------------------------------------

#adding libraries and packages
#we're using tidyverse for this

library(tidyverse)

#library is a function, tidyverse is an argument within the function

#currently a conflict with "dplyr" with a function called filter that will conflict with the filter function in the package "stats"
#"stats" is part of base r
#you just need to specify which function you're using from 
# "::" functions as an operator. ex:

#"filter ()" will default to dyplr, so use:
#"stats::filter()" in order to use the stats version

#if you go to the help menu and click cheat sheets, it'll send you to a webpage or download something
#in this case, it'll give you all the funtions of the dyplr package


# Opening a Dataset -------------------------------------------------------

#in file menu, import dataset
#two options: base and read r
#read r is a package uploaded as part of tidyverse
#we're using read r here

#Csv -> comma separated values; that’s what the current file is, so delimiter should be listed as “comma.” There are other delimiter options, but check your dataset for what it’s using
#R also gives you a data preview, so check that to make sure everything looks right
#we've opened up the data panel, but we also have a new item in the environment tap, representing the data we've loaded

#you can also read-in data via syntax
gapminder_1997 <- 
read_csv("data/gapminder_1997.csv")
#^has been edited via unix, double check


# Data Analysis Basics ----------------------------------------------------

#if you highlight just the "gapminder_1997" part of that, it'll show you a summary (a tibble!)

#you can also do this:
show(gapminder_1997)

# "<-" is an assignment operator
# it saves the read_csv function to the "gapminder_1997" object

result <- 2+2
#saves the answer to 2+2 to the result object
result
#command enter that, and it'll run it. it's a 4

#R can also handle strings; you can save strings to objects
#strings of letters need to be in quotations

name <- "Brianna"
name 

#anything you save as an object will be listed in the environment pane

#EXERCISE: assign something else to name, then see what's stored

name <- "Flumpert"
name

#when you reassign something, it erases the old value
#in this case, the new value is the instructor's cat's name and it's excellent


# Data Hygiene: Names -----------------------------------------------------

#starting an object with a number isn't great
#ex: "1number <- 3"
#you get an error if you run that
#better:
number1 <- 3
#you can have numbers, they just can't be the first thing in the object name

#also can't have spaces in the name
#ex: "favorite number <- 7"
#R is like. why are you like this and you get an error
#one way to get around it is to add an underscore, or to capitalize subsequent words
favorite_number <- 7
favoriteNumber <- 8
#the main thing is to be consistent throughout your code


# Arguments ---------------------------------------------------------------

read_csv()
#you can't just run that because you're trying to run a function with no argument*
read_csv("data/gapminder_1997.csv")
#much better

#but if you ever need help, then "?[function]" will give you more information
?read_csv()
#which pulls up the requisite info in the help pane
#the base argument for this one is file (meaning you just put in the file name), but there are other arguments
#what's shown in the help pane will be the default settings for each argument
#if you want to change the default behavior, use one of those in the function
#when you use a given function, that's called a "call"
#R automatically assumes that arguments are the order in which they're listed in the help file
#if you want them in a different order, specify the file argument

gapminder_1997 <- read_csv(file = "data/gapminder_1997.csv")
#passing an argument

#*though not all functions require arguments
#ex: 
Sys.Date()
#gives you the date your computer system is set to
#ex:
getwd()
#tells you the working directory
#when it gives you the dropdown, you can down arrow to what you're looking for (if it's there) and press tab to finiish the line with that

sum(5,6)
#arguments are separated by commas; so 5 is the first argument and 6 is the second


# Help Directory ----------------------------------------------------------

#look up the round function and predict what "round (3.1415,3)" would do
?round
round (3.1415,3)
#so that would round pi to three decimal points 

#Which of these lines gives you an output of 3.14?

#a
round(x = 3.1415)
#b
round(x = 3.1415, digits = 2)
#c 
round(digits = 2, x = 3.1415)
#d 
round(2, 3.1415)

#so check the help directory for what "digits" does
#clearly not a or d
#for b & c, the order doesn't matter if you're labeling everything correctly
##ANSWER: both b and c will give you 3.14 because they're labeled correctly


# Plotting ----------------------------------------------------------------

#we're going to be using ggplot2
ggplot(data=gapminder_1997)
#but that's not specific enough. you told it what to plot, but not *how*
#you need to add "aesthetic mappings" [or: aes()] - what's on the x axis, the y axis, what are we doing with colors etc
#we're going to be adding LAYERS to this command
#adding a plus at the end and pressing enter indents the code to make it easier to write out; because it's all part of the same command, running the last line will run the whole thing
#note: R doesn't care about spaces, it's up to personal preference

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap)

#you've added an x-axis, but you still need more
#like adding labels [or: labs()]

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita")

#try adding a y-axis

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp)

#tell it what graph to draw (plus labeling the y axis)
#this is called "specifying a gemoetry" 

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point()

#add a title

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?")

#what if the continent they're on also plays a role?
#new layer

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent)

#gives you a legend with which color means what
#but you can also change up the color palette

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1")

##Exercise: change the palette to something else
?scale_color_brewer

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Reds")

#just for playing around, but you can also mess with the size

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop)

#so now the size of the dot corresponds to whatever value you set it to; in this case, set to our pouplation size column
#adding a legend to help better understand dot size:

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop/1000000) +
  labs(size = "Population (in millions)")

#Exercise: encode eacch continent as different shapes instead of colors

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point(shape=18) +
  labs(title = "Do people in wealthy countries live longer?")

    
#okay that just changed the shape of all dots

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(shape = continent)

#looks terrible but gets the job done lol
#you can compress the calls though

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  labs(x = "GDP Per Capita") +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent)

#Exercise: consolidate the above code

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent) +
  labs(x = "GDP Per Capita", y = "Life Expectancy", title = "Do people in wealthy countries live longer?") +
  geom_point()+
  scale_color_brewer(palette="Set2")

#the line is kinda long. but you can add a new line between arguments by pressing enter

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap, 
      y = lifeExp, 
      color = continent) +
  labs(x = "GDP Per Capita", 
       y = "Life Expectancy", 
       title = "Do people in wealthy countries live longer?") +
  geom_point()+
  scale_color_brewer(palette="Set2")


#on the plots pane, use the export button to get an image or pdf for publication

#see the lesson materials for other information on how to plot


# Github ------------------------------------------------------------------

#CONFIGURE GITHUB

#you can also run terminal in rstudio
#tools --> terminal --> new terminal
#enter "PS1='$ '" to shorten the command line
#git config --global user.name "zichettella"
#git config --global email "zichette@umich.edu"

#git config --global core.autocrlf input
#if on windows, "true" rather than "input"

#tell git what text editor to use
#git config --global core.editor "nano -w"

#set default branch name
#git config --global init.defaultBrancch main

#stores the user id and password for interacting with github
#git config --global credential.helper store

#there are other things you can do to customize your configuration
#to check what your configuration is: git config --list


###########################
###########################
####                   ####
####  VERSION CONTROL  ####
####   (and github)    ####
####                   ####
###########################
###########################

#never delete .git because you'll lose everything
#some technical difficulties later, there is now a git pane
#(git was saved in a strange area)
#when adding something to the repository, MAKE SURE YOU ACTUALLY WANT TO ADD IT
#probably no huge files, because they cause issues
#NO PASSWORDS OR PROTECTED INFORMATION

#can add things to the .gitignore file (files pane) and that means that the repository will ignore them
#good for passwords and protected info, so it doesn't go into the repository
#terminology: things are "committed" to the repository

#from github, post making new repository, copy paste into terminal:
#git remote add origin https://github.com/zichettella/un-report.git
#git branch -M main
#git push -u origin main

#it'll ask for your username and password - NOT ACTUALLY THE PASSWORD, github wants a token
# go to the github webpage --> account settings, developer settings, token (classic) 
# set an expiration date, check repo and user, then generate token
# copy it, then paste it into the password command
# IT WILL NOT BE VISIBLE/only enter it once


#the respositiory on github will have an address that you can put on your paper so that people can see your analyses
#or you can put it on a cv to prove that you know how to code lol
#repositories can be either public or private; make sure you pick the right one for the project
#Recommendation: uploading data isn't a great idea because it's big enough to break it (use .gitignore to hide big files)
#code should be fine tho

#add a readme to the file
# file -> new file -> markdown file

#on git pane, clock symbol shows history [changes]
#can click on past versions of file; link to view them on right (the random code is called a "sha")

#green arrow pushes changes up to github

#commit when you've done an amount of work you want to save (i.e. writing a paragraph, not just minor changes)
#general advice is to push at the end of the day

#markdown notes forthcoming tomorrow (## means make this a heading)

#the issues tab: can create an issue & submit it
#if your colleagues are on github, you can @ them and they'll be notified

#you can also create files on github
#can add licenses via the insights tab

#get things from github to your local computer via "pull"


###EXERCISE###

ggplot(data=gapminder_1997) +
  aes(x = gdpPercap, 
      y = lifeExp, 
      color = continent) +
  labs(x = "GDP Per Capita", 
       y = "Life Expectancy", 
       title = "Do people in wealthy countries live longer?") +
  geom_point()+
  scale_color_brewer(palette="Set2")
  
ggsave("figures/gdpPercap_lifeExp.png")

#want to embed a figure in the readme? "![]"

#![](figures/gdpPercap_lifeEx.png)
#not currently working; revisit (pschloss on github)

#apparently they used to run this whole workshop from the command line
#GUIs have gotten better, but the command line is still more powerful
#if collaborating, it's always an option to pull from git first so that you're working on the most recent version


