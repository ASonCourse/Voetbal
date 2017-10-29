# This file contains steps (commands) taken to CLEAN the downloaded
# datasets about the Ere Divisie football league. Additionally the separate
# files will be transformed and combined into one single object.

# Set working directory...
setwd("~/Dropbox/Sannie's Stuff/Voetbal")

# If Data directory does not exist; create it.
if (!file.exists("data")) {
        dir.create("data")
}

# Use of this script depends on the R datasets being present in the
# data directory.

# Analysing the 22 datasets it has become clear that most of them
# contain 306 rows of data (representing matches). This correponds
# to a league consisting of 18 teams. The teams play each other twice.
# Once at home, the other match is an away game. With 18 teams, there
# should in fact be (18 * 18 - 18) 306 matches (rows).
# In view of this datasets with more than 306 rows must be treated
# with suspicion. Unless there are more than 18 teams in the league
# the number of rows / matches should also be 306. Excessive rows
# must be removed from the dataset.

############################################################################
## NOTE: Via Wikipedia data about more seasons (further back in history)  ##
## might be obtained (by scraping the website). This could be interesting ##
## with a view to the historical evolution. Especially the effect of the  ##
## rule change with regards to the number of points awarded for a win     ##
## might become clearer when an average can be calculated using more      ##
## data (matches / seasons).                                              ##
############################################################################

## Source:https://nl.wikipedia.org/wiki/Eredivisie_1956/57
## There apear to be webpages for every season.


unique(EreDivisie_1993_94$HomeTeam)
# Shows 19 teams, so that would mean (19 * 19 - 19) 342 matches to
# be played in that season.
# Removing excessive rows:
EreDivisie_1993_94[300:350, 1:10]
# Strange, the unique() command showed 19 levels (presumable teams).
# Let's see what's going on:
levels(EreDivisie_1993_94$HomeTeam)
# Yes, 19 levels, but 18 teams. One level is empty (""). So there
# should actually be 306 matches / rows. The dataset must be cut off
# at 306 rows:
EreDivisie_1993_94 <- EreDivisie_1993_94[1:306,]
tail(EreDivisie_1993_94[,1:10])
nrow(EreDivisie_1993_94)


unique(EreDivisie_1994_95$HomeTeam)
# Also 19 teams, so there should be 342 rows (matches) in the dataset.
# Removing excessive rows:
EreDivisie_1994_95[300:350, 1:10]
# Unique() command showed 19 levels, but there are only 306 matches.
# Something must be wrong; let's check:
levels(EreDivisie_1994_95$HomeTeam)
# 19 levels, but only 18 teams. There's one empty ("") level. So we can
# cut the file off at 306 rows:
EreDivisie_1994_95 <- EreDivisie_1994_95[1:306,]
tail(EreDivisie_1994_95[,1:10])
nrow(EreDivisie_1994_95)
# Result: 306.


###########################################################################
## NOTE: Starting the 1995/1996 season a win delivered 3 points, while a ##
## draw was worth 1 point. A loss had no value (0 points). Before a win  ##
## was worth only 2 points.                                              ##
###########################################################################

## Source:https://nl.wikipedia.org/wiki/Eredivisie_(mannenvoetbal)#Meeste_punten_in_1_seizoen
## "Tot het seizoen 1995/1996 leverde een overwinning twee punten op,
##  tegenover drie vanaf dit seizoen. In de volgende tabel zijn de punten
##  berekend volgens de huidige regel."


unique(EreDivisie_1995_96$HomeTeam)
# 19 teams, 342 matches / rows.
# Removing excessive rows:
EreDivisie_1995_96[300:350, 1:10]
# Hmm, the unique() command indicated 19 levels (teams). Let's check
# that out:
levels(EreDivisie_1995_96$HomeTeam)
# Yup, 19 levels, but only 18 teams. One level is empty (""). So we can
# cut the file off at 306 rows:
EreDivisie_1995_96 <- EreDivisie_1995_96[1:306,]
tail(EreDivisie_1995_96[,1:10])
nrow(EreDivisie_1995_96)
# Result: 306.


unique(EreDivisie_1996_97$HomeTeam)
# 19 teams, 342 matches / rows.
# Removing excessive rows:
EreDivisie_1996_97[300:310, 1:10]
# Hmm, this is weird. It seems there are only 306 matches... Still,
# with 19 teams??? How can that be?
# https://nl.wikipedia.org/wiki/Eredivisie_1996/97 makes clear there
# were actually 18 teams in the league that season. So how can the
# unique() command come up with 19?!
levels(EreDivisie_1996_97$HomeTeam)
# Results in 19 levels, including one that is "". There are actually 18
# teams in the league. So we may cut the file at 306 rows; rows 307:552
# may be removed:
EreDivisie_1996_97 <- EreDivisie_1996_97[1:306,]
tail(EreDivisie_1996_97[,1:10])
nrow(EreDivisie_1996_97)
# Result: 306.


unique(EreDivisie_1997_98$HomeTeam)
# 18 teams, 306 matches / rows. Apparently something has changed this
# season. UPDATE: no, nothing has changed. There have always been 18
# teams in the league. The figure 19 was introduced by an empty level.
# This made it seem there were more teams / matches. In effect there
# were still 18 teams and hence 306 matches. Rows beyond 306 may be
# removed.
# Removing excessive rows:
EreDivisie_1997_98[300:310, 1:10]
EreDivisie_1997_98 <- EreDivisie_1997_98[1:306,]
tail(EreDivisie_1997_98[,1:10])
nrow(EreDivisie_1997_98)
# Result: 306.


unique(EreDivisie_1998_99$HomeTeam)
# Based on information from Wikipedia there should be 18 teams in the
# league, but there seem to be 19 levels. Let's check:
levels(EreDivisie_1998_99$HomeTeam)
# There is one empty level ("").
# Removing excessive rows:
EreDivisie_1998_99[300:350, 1:10]
EreDivisie_1998_99 <- EreDivisie_1998_99[1:306,]
tail(EreDivisie_1998_99[,1:10])
nrow(EreDivisie_1998_99)
# Result: 306.


unique(EreDivisie_1999_00$HomeTeam)
# 19 Levels...
levels(EreDivisie_1999_00$HomeTeam)
# 18 teams, 19 levels (including one empty level).
# There should be 306 matches / rows:
EreDivisie_1999_00[300:350, 1:10]
# Indeed, 306 rows / matches.
# Removing excessive rows:
EreDivisie_1999_00 <- EreDivisie_1999_00[1:306,]
nrow(EreDivisie_1999_00)
# Result: 306.


EreDivisie_2000_01[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2001_02[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2002_03[300:320, 1:10]
# Hm, this dataset seems to have empty rows inbetween the actual
# data. This needs cleaning up.
nrow(EreDivisie_2002_03[EreDivisie_2002_03$Div == "N1", 1:10])
# This results in 306 rows.
# Remove irrelevant rows:
EreDivisie_2002_03 <- EreDivisie_2002_03[EreDivisie_2002_03$Div == "N1",]
EreDivisie_2002_03[300:310, 1:10]
# The rownumbers (indices) run higher than 306. How does one
# reset those?
# This should do it:
rownames(EreDivisie_2002_03) <- seq(1, nrow(EreDivisie_2002_03))
# Done!
EreDivisie_2002_03[300:310, 1:10]
# Now we have 306 matches / rows.


EreDivisie_2003_04[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2004_05[300:310, 1:10]
# There seem to be more than 306 rows. Possibly there are empty
# rows inbetween. Let's find out.
nrow(EreDivisie_2004_05[EreDivisie_2004_05$Div == "", 1:10])
# The count of empty lines is 16. Exactly what we expected, since
# the number of rows for this dataset originally was 322.
# When we filter out the empty rows, we get the desired number
# of 306 rows:
nrow(EreDivisie_2004_05[EreDivisie_2004_05$Div == "N1", 1:10])
EreDivisie_2004_05 <- EreDivisie_2004_05[EreDivisie_2004_05$Div == "N1",]
# The rownames will probably be messed up:
tail(EreDivisie_2004_05)
# Indeed. Let's fix that:
rownames(EreDivisie_2004_05) <- seq(1, nrow(EreDivisie_2004_05))
# Fixed:
EreDivisie_2004_05[300:310, 1:10]
# Now we have 306 rows / matches.


EreDivisie_2005_06[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2006_07[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2007_08[300:310, 1:10]
# There must be empty rows again...
nrow(EreDivisie_2007_08[EreDivisie_2007_08$Div == "N1", 1:10])
# Yup. Let's remove the empty rows:
EreDivisie_2007_08 <- EreDivisie_2007_08[EreDivisie_2007_08$Div == "N1",]
# Fix rownames:
rownames(EreDivisie_2007_08) <- seq(1, nrow(EreDivisie_2007_08))
# Fixed:
EreDivisie_2007_08[300:310, 1:10]
# Now we have 306 rows / matches.


EreDivisie_2008_09[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2009_10[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2010_11[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2011_12[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2012_13[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2013_14[300:310, 1:10]
# This seems in order, 306 matches / rows.


EreDivisie_2014_15[300:310, 1:10]
# This seems in order, 306 matches / rows.


# Adding a column with the season is necessary when we want to create
# one big dataset (without it will be difficult to distinguish seasons).
# Per dataset a column with the name 'Season' should be added (at the
# front of the original dataset). This should contain the same value
# for each match (row) in the form "2014/2015" ("yyyy/yyyy").

# Create a dataframe called 'Season', and fill that with the appropriate
# value (repeated 306 times):
Season <- data.frame(Season = rep("1993/1994", 306))
tail(Season)
# Use this dataframe to add a column to the dataset:
EreDivisie_1993_94 <- cbind(Season, EreDivisie_1993_94)
tail(EreDivisie_1993_94[,1:10])


# Recycle the Season dataframe:
Season <- data.frame(Season = rep("1994/1995", 306))
tail(Season)
# Use to expand dataset for 1994/1995:
EreDivisie_1994_95 <- cbind(Season, EreDivisie_1994_95)
tail(EreDivisie_1994_95[,1:10])


# Recyle:
Season <- data.frame(Season = rep("1995/1996", 306))
# Expand:
EreDivisie_1995_96 <- cbind(Season, EreDivisie_1995_96)
tail(EreDivisie_1995_96[,1:10])


# Recyle:
Season <- data.frame(Season = rep("1996/1997", 306))
# Expand:
EreDivisie_1996_97 <- cbind(Season, EreDivisie_1996_97)
tail(EreDivisie_1996_97[,1:10])


# Recyle:
Season <- data.frame(Season = rep("1997/1998", 306))
# Expand:
EreDivisie_1997_98 <- cbind(Season, EreDivisie_1997_98)
tail(EreDivisie_1997_98[,1:10])


# Recyle:
Season <- data.frame(Season = rep("1998/1999", 306))
# Expand:
EreDivisie_1998_99 <- cbind(Season, EreDivisie_1998_99)
tail(EreDivisie_1998_99[,1:10])


# Recyle:
Season <- data.frame(Season = rep("1999/2000", 306))
# Expand:
EreDivisie_1999_00 <- cbind(Season, EreDivisie_1999_00)
tail(EreDivisie_1999_00[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2000/2001", 306))
# Expand:
EreDivisie_2000_01 <- cbind(Season, EreDivisie_2000_01)
tail(EreDivisie_2000_01[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2001/2002", 306))
# Expand:
EreDivisie_2001_02 <- cbind(Season, EreDivisie_2001_02)
tail(EreDivisie_2001_02[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2002/2003", 306))
# Expand:
EreDivisie_2002_03 <- cbind(Season, EreDivisie_2002_03)
tail(EreDivisie_2002_03[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2003/2004", 306))
# Expand:
EreDivisie_2003_04 <- cbind(Season, EreDivisie_2003_04)
tail(EreDivisie_2003_04[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2004/2005", 306))
# Expand:
EreDivisie_2004_05 <- cbind(Season, EreDivisie_2004_05)
tail(EreDivisie_2004_05[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2005/2006", 306))
# Expand:
EreDivisie_2005_06 <- cbind(Season, EreDivisie_2005_06)
tail(EreDivisie_2005_06[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2006/2007", 306))
# Expand:
EreDivisie_2006_07 <- cbind(Season, EreDivisie_2006_07)
tail(EreDivisie_2006_07[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2007/2008", 306))
# Expand:
EreDivisie_2007_08 <- cbind(Season, EreDivisie_2007_08)
tail(EreDivisie_2007_08[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2008/2009", 306))
# Expand:
EreDivisie_2008_09 <- cbind(Season, EreDivisie_2008_09)
tail(EreDivisie_2008_09[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2009/2010", 306))
# Expand:
EreDivisie_2009_10 <- cbind(Season, EreDivisie_2009_10)
tail(EreDivisie_2009_10[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2010/2011", 306))
# Expand:
EreDivisie_2010_11 <- cbind(Season, EreDivisie_2010_11)
tail(EreDivisie_2010_11[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2011/2012", 306))
# Expand:
EreDivisie_2011_12 <- cbind(Season, EreDivisie_2011_12)
tail(EreDivisie_2011_12[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2012/2013", 306))
# Expand:
EreDivisie_2012_13 <- cbind(Season, EreDivisie_2012_13)
tail(EreDivisie_2012_13[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2013/2014", 306))
# Expand:
EreDivisie_2013_14 <- cbind(Season, EreDivisie_2013_14)
tail(EreDivisie_2013_14[,1:10])


# Recyle:
Season <- data.frame(Season = rep("2014/2015", 306))
# Expand:
EreDivisie_2014_15 <- cbind(Season, EreDivisie_2014_15)
tail(EreDivisie_2014_15[,1:10])


# Now it's time to stitch the individual (per season) datasets together. Let's call
# it EreDivisie_Complete. Some datasets are (a lot) wider than others, but we'll fix
# that later. It seems there are 11 relevant colums / variables at this point —
# the betting odds serve no purpose at this point.


# Rename the first individual dataset for the 1993/1994 season:
EreDivisie_Complete <- EreDivisie_1993_94
nrow(EreDivisie_Complete)
dim(EreDivisie_Complete)


# Add the next season (1994/1995) to the base dataset:
# Checking dimensions...
dim(EreDivisie_1994_95)
# Seems to be the same...
# Add dataset to base...
EreDivisie_Complete <- rbind(EreDivisie_Complete, EreDivisie_1994_95)
# Check result...
nrow(EreDivisie_Complete)
dim(EreDivisie_Complete)
EreDivisie_Complete[300:310,1:10]
# Seems to be in order... Next:


# Add season 1995/1996 to base:
EreDivisie_Complete <- rbind(EreDivisie_Complete, EreDivisie_1995_96)
# Check result...
nrow(EreDivisie_Complete)
EreDivisie_Complete[610:616, 1:10]
# Seems to be in order... Next:


# Add season 1996/1997 to base:
EreDivisie_Complete <- rbind(EreDivisie_Complete, EreDivisie_1996_97)
# Check result...
nrow(EreDivisie_Complete)
EreDivisie_Complete[916:926, 1:10]
# Seems to be in order... Next:


# Add season 1997/1998 to base:
EreDivisie_Complete <- rbind(EreDivisie_Complete, EreDivisie_1997_98)
# !!! This produces an error:
#       Error in rbind(deparse.level, ...) : 
#       numbers of columns of arguments do not match
# Guess the season 1997/1998 dataset has a different dimension...
dim(EreDivisie_1997_98)
# Yup: 22 variables / columns instead of 29...
# Can rbind() handle this situation???
# Hmm, seems difficult. The rownames should match, otherwise the function
# does not work.
# Found a homebrewn function that can deal with this situation. Seems
# useful so I will include it in the FUNCTION.R file. This file should be
# sourced before the function can be used:
source("./FUNCTION.R")


# Tested the function rbind.all.colums() and found it worked nicely. So:


# Add season 1997/1998 to base:
EreDivisie_Complete <- rbind.all.columns(EreDivisie_Complete, EreDivisie_1997_98)
# Worked, now we've got a dataset with 1530 rows (matches)...


# Add season 1998/1999 to base:
EreDivisie_Complete <- rbind.all.columns(EreDivisie_Complete, EreDivisie_1998_99)
# Seems to be in order... Next:


# Add season 1999/2000 to base:
EreDivisie_Complete <- rbind.all.columns(EreDivisie_Complete, EreDivisie_1999_00)
# Seems to be in order... Next:


# How many were done now?
nrow(EreDivisie_Complete) / 306
# Result: 7, so seven seasons out of 22 were combined so far. This is tedious;
# can it be automated?
# Guess so. Via ls() one can obtain a list of objects loaded into R. The seasonal
# datasets should be present in this list that the command produces. Using grep()
# one can select only (the indexes of) the relevant dataframes:
List_Of_Objects <- ls()
Selected_Indices <- grep("EreDivisie_20", ls())
# This selects only the (indexes of the) dataframes in the 2000's
# (so 2000/2001 - 2014/2015)...
# To get actual object names this command should be used:
Selected_Objects <- List_Of_Objects[Selected_Indices]


# We should be able to loop through this list automatically... How can we do this?
for (i in mget(Selected_Objects)) {
        EreDivisie_Complete <- rbind.all.columns(EreDivisie_Complete, i)
}
# Tested the above and it seems to work. mget() function is necessary because
# we need the object names (multiples) that are 'behind' the character strings.


# YES! THIS WORKED!
# There should be (22 * 306) 6732 rows / matches in EreDivisie_Complete now, and
# there are:
dim(EreDivisie_Complete)
nrow(EreDivisie_Complete)
# The number of variables is now 100. That seems to be a lot, but at least nothing
# was lost. Most of the added colums are betting odds, which we don't really need
# anyway:
names(EreDivisie_Complete)
# The columns / variables we actually need are:
#
# Season, Div, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR, HTHG, HTAG, HTR. Maybe
# Div can also be removed, since it's implicit that the data covers the EreDivisie.
# We'll have to check the presentation by Hadley Wickham on Tidy Data, because
# he mentioned a handy tool in it that made it easy to subset columns by name...
# Did some Googling and found it: it's the dplyr package and the select() function
# in particular that seem helpful here:
install.packages("dplyr")
library(dplyr)
# For documentation see: https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html


# Now, use the command to subset the required columns / variables:
EreDivisie_Complete <- select(EreDivisie_Complete, Season:FTR, HTHG:HTR)


# Now we have to figure out the variables (factors, integers, dates, etc.)


# Remove 'Div' column, since it doesn't add anything. If one would want to include
# a variable indicating which competition the match belongs to, it would be named
# "League", or something anyway.
EreDivisie_Complete <- select(EreDivisie_Complete, -Div)


# Values for variable FTR (Full Time Result):
unique(EreDivisie_Complete$FTR)
# Shows A, H, and D -- for Away, Home, Draw, indicating a win for the Away team,
# the Home team or a draw.
# Tidy Data requires the values to be descriptive and the column names shouldn't
# be abbreviated either. Let's fix that first (using the rename() function from
# the dplyr package:
EreDivisie_Complete <- rename(EreDivisie_Complete, full.time.result = FTR)
names(EreDivisie_Complete)
# That worked nicely, so let's rename the other column / variable names aswell:
EreDivisie_Complete <- rename(EreDivisie_Complete, season = Season, date = Date,
                              home.team = HomeTeam, away.team = AwayTeam,
                              full.time.home.goals = FTHG, full.time.away.goals = FTAG,
                              half.time.home.goals = HTHG, half.time.away.goals = HTAG,
                              half.time.result = HTR)
names(EreDivisie_Complete)
# OK, the column names have been fixed. Looks better allready!
# Now, lets fix the A's, H's, and D's. Replace them with AWAY, HOME, and DRAW.
# The gsub() function can be used here:
gsub("^A$", "AWAY", EreDivisie_Complete$FTR)
# Hmmm... this doesn't do anything. Possibly because there is no column named
# FTR anymore...
gsub("^A$", "AWAY", EreDivisie_Complete$full.time.result)
gsub("^H$", "HOME", EreDivisie_Complete$full.time.result)
gsub("^D$", "DRAW", EreDivisie_Complete$full.time.result)
# The above seems to work, but the object hasn't changed. Guess we'll have to use:
EreDivisie_Complete$full.time.result <- gsub("^A$", "AWAY", EreDivisie_Complete$full.time.result)
EreDivisie_Complete$full.time.result <- gsub("^H$", "HOME", EreDivisie_Complete$full.time.result)
EreDivisie_Complete$full.time.result <- gsub("^D$", "DRAW", EreDivisie_Complete$full.time.result)
# Has this worked? Yup:
unique(EreDivisie_Complete$full.time.result)
# Now returns: "AWAY" "HOME" "DRAW".
# That's better (tidier).
# Let's do the same for the HTR / half.time.result values:
EreDivisie_Complete$half.time.result <- gsub("^A$", "AWAY", EreDivisie_Complete$half.time.result)
EreDivisie_Complete$half.time.result <- gsub("^H$", "HOME", EreDivisie_Complete$half.time.result)
EreDivisie_Complete$half.time.result <- gsub("^D$", "DRAW", EreDivisie_Complete$half.time.result)
# Nice, looks better!
unique(EreDivisie_Complete$half.time.result)
# There seem to be a few observations of the variable half.time.result that are
# empty (""). These should be "NA", of course. Let's fix that:
# Found this resource on the subject:
# http://stackoverflow.com/questions/12763890/exclude-blank-and-na-in-r
# In there was a piece of code that seems to work, but it requires an object
# (not a subset of an object):
# foo[foo==""] <- NA
# Eventually ended up with this:
EreDivisie_Complete[EreDivisie_Complete==""] <- NA
# Now unique() returns no more empty strings ("").
# summary() also reports 4 more NA's when compared to before. 
str(EreDivisie_Complete)
# This shows the following:
# 'data.frame':	6732 obs. of  10 variables:
# $ season              : Factor w/ 22 levels "1993/1994","1994/1995",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ date                : Factor w/ 2218 levels "","01/03/94",..: 49 49 49 49 51 51 51 51 51 69 ...
# $ home.team           : Factor w/ 40 levels "","Ajax","Cambuur",..: 5 7 9 19 2 4 6 13 16 3 ...
# $ away.team           : Factor w/ 31 levels "","Ajax","Cambuur",..: 15 12 11 8 18 3 10 17 14 9 ...
# $ full.time.home.goals: int  1 1 2 1 3 1 1 3 2 1 ...
# $ full.time.away.goals: int  4 0 3 0 0 0 2 0 2 3 ...
# $ full.time.result    : chr  "AWAY" "HOME" "AWAY" "HOME" ...
# $ half.time.home.goals: int  NA NA NA NA NA NA NA NA NA NA ...
# $ half.time.away.goals: int  NA NA NA NA NA NA NA NA NA NA ...
# $ half.time.result    : chr  NA NA NA NA ...
# ############################################

# season seems OK, as a factor with 22 levels. There are 22 seasons in the dataset.
# date is now a factor with 2218 levels, but this should be converted to a date class...
# First convert the date values to character values:
EreDivisie_Complete$date <- as.character(EreDivisie_Complete$date)
# Then convert to date values with the as.Date() function:
EreDivisie_Complete$date <- as.Date(EreDivisie_Complete$date, format = "%d/%m/%y")
# Check if it worked:
EreDivisie_Complete$date[1:10]
# Yes, that looks right. Now we can robustly make calculations involving dates.

# home.team is now a factor with 40 levels, but that includes an empty one. The number of
# levels is not consistent with the levels for away.team. Guess we should reset the levels
# of the factor. But converting to a character class seems like a first step...
EreDivisie_Complete$home.team <- as.character(EreDivisie_Complete$home.team)
EreDivisie_Complete$away.team <- as.character(EreDivisie_Complete$away.team)
# Now, it shall become clear why we've got a difference in levels:
unique(EreDivisie_Complete$home.team)
unique(EreDivisie_Complete$away.team)
# It seems there are some doubles as a result of extra spaces following the names of
# certain clubs (Heracles, Roda, Ajax, Feyenoord, Graafschap, Groningen, Utrecht,
# Vitess, and Willem II). How to remove the extra space behind the names of the doubles?
# gsub() will come in handy again:
# But, please use a loop construct — otherwise things become tedious again...
NamesWithExtraSpaces <- unique(EreDivisie_Complete$home.team)
NamesWithExtraSpaces <- NamesWithExtraSpaces[31:39]
NamesWithoutSpaces <- unique(EreDivisie_Complete$home.team)
NamesWithoutSpaces <- NamesWithoutSpaces[31:39]
NamesWithoutSpaces <- gsub(" $", "", NamesWithoutSpaces)
for (i in NamesWithExtraSpaces) {
        for (j in NamesWithoutSpaces) {
                EreDivisie_Complete$home.team <- gsub(i, j, EreDivisie_Complete$home.team)
        }
}
# Seems to have worked, because unique() doesn't show any more doubles:
unique(EreDivisie_Complete$home.team)

# UPDATE:
# There seems to be some funny stuff going on with the clubnames...
# In EreDivisie_Complete$home.team there is "HeraclesJC" and "Heracles". Not OK,
# and should be fixed. No idea where this comes from. Was it introduced by the
# cleaning process? Possibly.
# In EreDivisie_Complete_BUP$home.team we find "Go Ahead EaglesJC" and "Go Ahead Eagles".
# In both datasets there is "Roda" instead of "Roda JC".
# We ought to check if the match data is still the same...
# Logically that should be the case, since only the values for home.team in the observations
# was changed, right?
# Let's fix this issue:
EreDivisie_Complete$home.team <- gsub("HeraclesJC", "Heracles", EreDivisie_Complete$home.team)
EreDivisie_Complete$home.team <- gsub("Roda", "Roda JC", EreDivisie_Complete$home.team)
EreDivisie_Complete$away.team <- gsub("Roda", "Roda JC", EreDivisie_Complete$away.team)
EreDivisie_Complete$away.team <- gsub("Roda JC JC", "Roda JC", EreDivisie_Complete$away.team)
# Seems fixed now. Was messy...

# full.time.home.goals and full.time.away.goals seem to contain no NA's:
sum(is.na(EreDivisie_Complete$full.time.home.goals))
sum(is.na(EreDivisie_Complete$full.time.away.goals))
# Result: 0
# full.time.result also seems to be complete:
sum(is.na(EreDivisie_Complete$full.time.result))
# Result: 0

# half.time.home.goals, half.time.away.goals, and half.time.result do contain NA's:
sum(is.na(EreDivisie_Complete$half.time.home.goals))
sum(is.na(EreDivisie_Complete$half.time.away.goals))
sum(is.na(EreDivisie_Complete$half.time.result))
# Result: 1228
# So there are missing values. The number does not divide nicely by 306 (the number
# of matches per season) however. Strange, because one may assume that the half-time
# data is complete for all seasons since it showed up in the datasets.
is.na(EreDivisie_Complete$half.time.result)
# Visual inspection of the TRUEs and FALSEs has proven that there are two blocks:
# one where is.na() returns TRUE, and another where it returns FALSE.
# But... there are also a few TRUEs inbetween the block of FALSEs. We have to hunt
# those down and collect the missing data from another source.
# Which matches should have the half-time data, but don't?
# Visually we've been able to determine that the block of FALSEs starts at #1225,
# so we should be able to isolate the offending rows:
# Via:
EreDiv_FALSE <- EreDivisie_Complete[1225:6732,]
EreDiv_FALSE[is.na(EreDiv_FALSE$half.time.result),]
# We end up with this:
#      season      date     home.team    away.team      full.time.home.goals   full.time.away.goals
# 1293 1997/1998 28/09/97    Sparta        Roda JC                    3                    1             
# 1354 1997/1998 16/11/97    Sparta MVV Maastricht                    4                    0             
# 1489 1997/1998 12/04/98    Sparta  PSV Eindhoven                    3                    1             
# 1517 1997/1998 03/05/98    Sparta         Twente                    1                    1 
# Seem to be the same 4 rows / matches that contained empty strings for half.time.result
# earlier. No surprise, really.
# Let's see if we can find the missing data points...
# Source: https://nl.wikipedia.org/wiki/Eredivisie_1997/98
# Unfortunately only full-time results...
# Source: http://www.eredivisiestats.nl
# Unfortunately the query engine doesn't seem to work (anymore)...
# Google doesn't produce the missing data either, so we've fired off an email
# to Sparta Rotterdam requesting the missing datapoints (half-time results
# for 4 matches played in the 1997/1998 season).
# Webadress: http://www.sparta-rotterdam.nl/32/2018/algemene-gegevens/
# Hopefully, the missing data can be produced via this route, otherwise we'll
# have to accept that the dataset is incomplete. 4 NA's out of 5000-plus seems
# like a minor issue, though.

str(EreDivisie_Complete)
# Now shows the following:
#
# 'data.frame':	6732 obs. of  10 variables:
# $ season              : Factor w/ 22 levels "1993/1994","1994/1995",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ date                : Date, format: "1993-08-14" "1993-08-14" "1993-08-14" "1993-08-14" ...
# $ home.team           : chr  "Go Ahead Eagles" "Heerenveen" "NAC Breda" "Willem II" ...
# $ away.team           : chr  "Vitesse" "Sparta" "Roda JC" "MVV Maastricht" ...
# $ full.time.home.goals: int  1 1 2 1 3 1 1 3 2 1 ...
# $ full.time.away.goals: int  4 0 3 0 0 0 2 0 2 3 ...
# $ full.time.result    : chr  "AWAY" "HOME" "AWAY" "HOME" ...
# $ half.time.home.goals: int  NA NA NA NA NA NA NA NA NA NA ...
# $ half.time.away.goals: int  NA NA NA NA NA NA NA NA NA NA ...
# $ half.time.result    : chr  NA NA NA NA ...
# ############################################
# Looks like the dataset is now CLEAN and TIDY!
# Time to analyse the data and produce some graphs and / or a report.
# Commands involving this process can be found in the DO.R file.


####################################################################################
## The website Eredivisiestats.NL is an valuable source of data. One of the       ##
## things missing in my data is the position (rank) at all match dates. This site ##
## contains a tool that can generate this position:                               ##
## http://www.eredivisiestats.nl/standen.php                                      ##
####################################################################################