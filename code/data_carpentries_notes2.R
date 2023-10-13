

# Data Carpentries; October 13, 2023 -----------------------------------------
# Setup ---------------------------------------------------------

#read in data (read_csv not read.csv!)
#read_csv is not a base function, so we're going to need to load tidyverse
#the underscore version reads the dataset into a tibble

library(tidyverse)
gapminder_data <- read_csv("data/gapminder_data.csv")

summarize(gapminder_data, mean(lifeExp))

#or, if you want to put life expectancy into a column:
#otherwise the column name defaults to whatever the function was

summarize(gapminder_data, averageLifeExp = mean(lifeExp))

#add a header via Cmd+Shift+R (Ctrl+Shift+R on Windows)

# R Pipe ------------------------------------------------------------------

#pipe shortcut: CMD+Shift+m (note: pipe audo-indents the next line as part of the same command)
gapminder_data %>% 
  summarize(averageLifeExp = mean(lifeExp))

#so you get the same result
#the goal of the pipe is to make it easier to read rather than having 300 sets of parentheses
#we're currently printing to the console, but not actually saving anything
#if we're saving it to an object:

gapminder_data_summarized <- gapminder_data %>% 
  summarize(averageLifeExp =mean(lifeExp))

#then you can run the object to see it
gapminder_data_summarized

#you can also do things with the object:
#(ex:multiplying it by 2)
gapminder_data_summarized * 2

gapminder_data %>% 
  summarize(recent_year = max(year))

#so, named the column recent_year
#max year = what is the most recent year in the data (it's 2007)
#so how do you find the highest life expectancy? use the variable

gapminder_data %>% 
  summarize(recent_year = max(lifeExp))

#highest life expectancy is 82.6


# Filtering --------------------------------------------------------

#creating a filter, then making a summary based on it
#filter function - limits the rows that you have; have to tell it the variable(s) you're looking at
#and what properties are important

gapminder_data %>% 
  filter(year == 2007)

# == is the equivalence symbol
#2007 not in quotes because it's a number
#if it were letters (and thus a string), you would need quotes

#so the above function shows all the rows with 2007

#average life expectancy for the year 2007 (67 - compared to the lower life expectancy of the whole dataset)

gapminder_data %>% 
  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

#because you're using the pipe function, each line is delimited by the function before it
#so, if this was written out:
summarize(filter(gapminder_data, year ==2007), average = mean(lifeExp))
#the pipe is a bit better for organization

#what if you want to temporarially disable one of the lines? ("commenting out the pipe")
gapminder_data %>% 
#  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

#it's still the same overall command, so it just runs without the filter
#good for troubleshooting

#what is the earliest year in the dataset?

gapminder_data %>% 
  summarize(recent_year = min(year))

#it's 1952
#summarize the average GDP for earliest year in the dataset

gapminder_data %>% 
  filter(year == 1952) %>% 
  summarize(average_gdp = mean(gdpPercap))

# $3,725

# Grouping ----------------------------------------------------------------
#ex: what is the mean life expectancy of each year?
#Function: group_by

gapminder_data %>% 
  group_by(year)

#running just that isn't enough; looks like nothing happened


gapminder_data %>% 
  group_by(year) %>% 
  summarize (average = mean(lifeExp))

#separates out each year
#if you want to group all the names by year


gapminder_data %>% 
  group_by(year, country) %>% 
  summarize (average = mean(lifeExp))

#that groups by year AND country
#whichever variable is listed first is grouped by first
#there's also a function called ungroup where you can decouple a group

#what is the mean life expectancy for each continent

gapminder_data %>% 
  group_by(continent) %>% 
  summarize (average = mean(lifeExp))

#what is the mean life expectancy AND mean GDP per capita for each continent?
#you can also separate out parts of the same command for organization
#just press enter (and don't forget commas!)

gapminder_data %>% 
  group_by(continent) %>% 
  summarize (
    meanLifeExp = mean(lifeExp),
    meanGDPpercap = mean(gdpPercap)
    )


# Mutate ------------------------------------------------------------------

#mutate goes across columns

#creating a new column:
gapminder_data %>% 
  mutate(double_year = year * 2)

#makes a new column, calls it double_year and populates the column with the year, multiplied by two
#not that there's a good reason to do that aside from illustration of functionality

gapminder_data %>% 
  mutate(double_year = year * 2, .before = pop)

#what is the GDP *not* per capita?
#by multiplying pop x gdpPercap

gapminder_data %>% 
  mutate(gdp = pop*gdpPercap)

#make a new column for population in millions
#use "/" for division

gapminder_data %>% 
  mutate(PopInMil = pop/1000000)

#do both in one tibble

gapminder_data %>% 
  mutate (
    gdp = pop*gdpPercap,
    PopInMil = pop/1000000
  )


## Glimpse -----------------------------------------------------------------
#function:glimpse - puts data in other direction

gapminder_data %>% 
  mutate (
    gdp = pop*gdpPercap,
    PopInMil = pop/1000000
  ) %>% 
  glimpse()

gapminder_data %>% 
  filter(continent == "Asia") %>% 
  mutate(gdp = pop * gdpPercap) %>% 
  summarize(meanGDP = mean(gdp))

#gets you the mean gdp not per capita
#no groups, so you'll only get one column (and a very big number lol)
#mean gdp not per capita, by country

gapminder_data %>% 
  group_by(country) %>% 
  filter(continent == "Asia") %>% 
  mutate(gdp = pop * gdpPercap) %>% 
  summarize(meanGDP = mean(gdp))

#if you want a table, create an object

tibble1 <- gapminder_data %>% 
  group_by(country) %>% 
  filter(continent == "Asia") %>% 
  mutate(gdp = pop * gdpPercap) %>% 
  summarize(meanGDP = mean(gdp))

#see the table in the console:
tibble1
#put that in a new tab:
view(tibble1)

#you can also use that object in future commands:
tibble1 %>% 
  mutate(meanGDPInMillions = meanGDP / 1000000)


# Select ------------------------------------------------------------------

#select chooses a subset of columns from a dataset
gapminder_data %>% 
  select(pop, year)

#shows you those two columns only
#not the most helpful in this case, but good for visualization

#you can also display sans a given column (note: does NOT delete the colulmn in the data)
gapminder_data %>% 
  select(-continent)

#Create a tibble with only country, continent, year, and life expectancy
tibble2 <- gapminder_data %>% 
  select(country, continent, year, lifeExp)

#the order in which they're written is the order they show up in the table
#double check it in the console:
tibble2

#by subtraction
gapminder_data %>% 
  select(-pop, -gdpPercap)

#if you want to know how many times something is in a category:
gapminder_data %>% 
  count(continent)

#this is a cleaned dataset so it doesn't have any NAs, but:
gapminder_data %>% 
  filter(is.na(country))

#if there were NAs, then this would show them; you could also summarize or count
gapminder_data %>% 
  count(is.na(continent))

#there are none lol

gapminder_data %>% 
  select(year, starts_with("c"))

#shows you columns starting with c
#columns ending with p:

gapminder_data %>% 
  select(year, ends_with("p"))


# Reshaping Data ----------------------------------------------------------

## Pivot Wider -------------------------------------------------------------

#making long data wide and wide data long
#pivot functions -> pivot_wider() 
#worth noting: base r and tidyverse has other functions that do these, too

gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

#columns that have numbers start with backticks (ex: '1972') 
#because R doesn't like columns to start with numbers
#so if you want to use these columns in a command, you may also need the backticks

gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, 
              values_from = lifeExp,
              names_prefix = "year")

#and then you can use year1972 as a column name rather than using '1972'

#there's also pivot_longer, which of course makes things long rather than wide
#need to decide where you want the names to go

## Joins -------------------------------------------------------------------
#combine dataframes

#"leftjoin" would be visualizing your main dataframe (left frame) 
#and anotherframe (right frame), and adding
#ex: leftjoin(dataframe1, dataframe2, by = ("country" = "countries"))
#("country" = "countries") matches data in two different frames, even if they're named differently


#the general idea is taking two dataframes and matching them on a specific parameter
#if there are extra parameters, you'll get errors
#this was done quickly to illustrate, and kind of off script
#so the data doesn't work super well with this, but:
co2_data <- read_csv("data/co2-un-data.csv", skip = 1) %>% 
  rename(country = '...2', year = Year)

left_join(gapminder_data, co2_data, by = c("country", "year"))

#use antijoin to find what is in one dataframe but not the other
#end part 1


# R Markdown --------------------------------------------------------------
# (and reports)

#reproducable research documents; Dr. Schloss; all the papers from his lab are written 
#in R Markdown so that you can see what the data attaches to
#we're not doing that today, but. it's a thing tha can be done


#title/author/date/output is the header, but you can add more things

#a code begins with three backticks ``` and then a curly brace that contains {r} (at minimum)

#```{r setup, include=FALSE}
#knitr::opts_chunk$set(echo = TRUE)
#```







