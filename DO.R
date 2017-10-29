# This file contains the steps / commands used for analysing the dataset
# and production of graphs and / or a report.

# So, this is what we've got:

str(EreDivisie_Complete) # [CLEAN AND TIDY DATASET]

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


# We can count the number of AWAY (wins), HOME (wins), and DRAWS for the half.time.result and
# the full.time.result variables.
# The easiest way to do this seems to be by using the table() command:
table(EreDivisie_Complete$half.time.result)
# This produces absolute numbers. To get percentages, we should use this:
round(table(EreDivisie_Complete$half.time.result) / 
              nrow(EreDivisie_Complete[!is.na(EreDivisie_Complete$half.time.result), ]) * 100)
# Result:
#
# AWAY DRAW HOME 
# 24   38   38 

# And for the complete match results:
round(table(EreDivisie_Complete$full.time.result) / 
              nrow(EreDivisie_Complete[!is.na(EreDivisie_Complete$full.time.result), ]) * 100)
# Result:
#
# AWAY DRAW HOME 
# 28   24   48

# What does this mean?
#
#       Well, it seems clear that (over the last 22 seasons) teams playing at home won their
# matches quite a lot more frequently than teams playing away (48% vs 28%) [1].
#       When draws are taken into account the chance of a visiting team winning the match is
# only 28%. 72% of the matches are either won by the teams playing at home or end in a draw. Put
# differently: teams playing at home don't lose very often (on average, of course) [2].
#       Half-time results show about the same number of 'wins' for away playing teams (24%),
# but there are significantly fewer 'wins' for the home teams (38%). It seems the remainder of
# the wins for the home teams are still 'hidden' in the draws. The number of half-time draws is
# a lot greater than the number of full-time draws (38% vs 24%) [3].
#       In most matches won by the visiting team the difference has already been made in the
# first half. The percentage of half-time 'wins' by teams playing away is 24, while 28% of the
# full-time matches are being won by visiting teams [4].

# Additional questions:
#
#       How much variation is there within the dataset when one calculates the percentage of
# aways, homes, and draws for each season? Do the figures fluctuate wildly or do we get broadly
# comparable results per season?

# We'll have to use dplyr::group_by() and dplyr::summarise() for this, but that turns out to be
# difficult. How do we get the figures / percentages of HOMEs, DRAWs, and AWAYs calculated per
# season?
#
# This is a start:
EreDivisie_by_Season <- group_by(EreDivisie_Complete, season, full.time.result)
FullTimeResult_by_Season <- summarise(EreDivisie_by_Season, number = n(), percentage = round(n() / 306 * 100))
# The above shows only the first 10 rows of the dataset. If you need to see more
# you should use:
FullTimeResult_by_Season %>% View()
# This opens the dataset in the spreadsheet viewer (in RStudio).
# Alternatively, one can use subsetting to view other parts of the dataset:
FullTimeResult_by_Season[60:66,]
# The maximal viewing area is still fixed at a limited number of rows, mind you. So,
FullTimeResult_by_Season[40:66,]
# still get's cut off!

# There are NA values in the half.time.result variable. These should be filtered out first:
EreDivisie_Complete_WithoutNA <- subset(EreDivisie_Complete, !is.na(EreDivisie_Complete$half.time.result))
# For the half-time results we have to do this again (with a variation):
EreDivisie_by_Season_HalfTime <- group_by(EreDivisie_Complete_WithoutNA, season, half.time.result)
HalfTimeResult_by_Season <- summarise(EreDivisie_by_Season_HalfTime, number = n(), percentage = round(n() / 306 * 100))


# Maybe we can use the indexing / subsetting to create a new object where we've got the
# seasons as observation with three variables: AWAY%, DRAW%, and HOME%. (I seem to remember
# there was a function that could do this —- it came up with regards to melt...)

# INDEED, DCAST (RESHAPE2) seems to provide the functionality we want in one handy command. Let's see if
# that produces the same result:
dcast(FullTimeResult_by_Season, season ~ full.time.result, value.var = "percentage")
# Yup, this works too —— and much simpler.
# The function produces this output:
# 
#       season  AWAY DRAW HOME
# 1  1993/1994   26   24   50
# 2  1994/1995   28   26   46
# 3  1995/1996   27   28   45
# 4  1996/1997   28   26   46
# 5  1997/1998   28   20   53
# 6  1998/1999   27   27   46
# 7  1999/2000   30   21   49
# 8  2000/2001   28   25   47
# 9  2001/2002   22   25   53
# 10 2002/2003   27   24   49
# 11 2003/2004   29   24   47
# 12 2004/2005   35   19   46
# 13 2005/2006   31   20   49
# 14 2006/2007   27   23   50
# 15 2007/2008   30   23   47
# 16 2008/2009   27   25   48
# 17 2009/2010   30   20   50
# 18 2010/2011   25   23   52
# 19 2011/2012   29   21   51
# 20 2012/2013   30   25   45
# 21 2013/2014   25   27   47
# 22 2014/2015   31   24   45


# We can use the seq() command to create a list of indexes that correspond to only the
# AWAYs, DRAWs, or HOMEs:
Seq22_Away <- seq(1, 66, by = 3)
Seq22_Draw <- seq(2, 66, by = 3)
Seq22_Home <- seq(3, 66, by = 3)
# Yup, this works. It creates sequences of every third item. Filtering out only the AWAYs,
# DRAWs, and HOMEs.

# This produces a listing of only the number and percentages of AWAY's (wins by a visiting
# team) per season:
FullTimeResult_by_Season[Seq22_Away,]
# This isolates only the percentages of wins by away teams per season. And could be used as
# input for a aggregate dataframe:
FullTimeResult_by_Season[Seq22_Away, 4]


# This also works and produces summary results for only the AWAYs (could only be only DRAWs,
# or HOMEs).
summary(FullTimeResult_by_Season[Seq22_Away,])
summary(FullTimeResult_by_Season[Seq22_Draw,])
summary(FullTimeResult_by_Season[Seq22_Home,])
# The results match those of the summary() command when applied to EreDivisie_Complete. So
# the integrity of the data has remained in tact.

# For the half-time results we have to make a slight alteration. There is missing data for the
# first 4 seasons (and 4 observations in the 1997/1998 season). So we have to use different
# sequencing variables:
Seq18_Away <- seq(1, 54, by = 3)
Seq18_Draw <- seq(2, 54, by = 3)
Seq18_Home <- seq(3, 54, by = 3)

# Testing...
HalfTimeResult_by_Season[Seq18_Away, 4]
summary(HalfTimeResult_by_Season[Seq18_Away,])
# That seems in order...

# In order to be able to produce a nice graph showing the average number (percentages) of away
# wins, draws, and home wins full-time and half-time AND the per season figures we would need a
# new dataframe. It would have to look something like this:
EreDivisie_Aggregate_Results <- data.frame(season = character(length = 22),
                        perc.full.time.home.win = double(length = 22), perc.full.time.draw = double(length = 22),
                        perc.full.time.away.win = double(length = 22),
                        perc.half.time.home.ahead = double(length = 22), perc.half.time.draw = double(length = 22),
                        perc.half.time.away.ahead = double(length = 22))

# Let's check the blueprint:
str(EreDivisie_Aggregate_Results)
# Shows the following:
#
# 'data.frame':	0 obs. of  7 variables:
# $ season                   : Factor w/ 0 levels: 
# $ perc.full.time.home.win  : num 
# $ perc.full.time.draw      : num 
# $ perc.full.time.away.win  : num 
# $ perc.half.time.home.ahead: num 
# $ perc.half.time.draw      : num 
# $ perc.half.time.away.ahead: num

# Looks OK, let's try and load the new dataframe with some data:
EreDivisie_Aggregate_Results$season <- FullTimeResult_by_Season$season[Seq22_Home]
EreDivisie_Aggregate_Results$perc.full.time.home.win <- as.data.frame(FullTimeResult_by_Season)[Seq22_Home, 4]
EreDivisie_Aggregate_Results$perc.full.time.draw <- as.data.frame(FullTimeResult_by_Season)[Seq22_Draw, 4]
EreDivisie_Aggregate_Results$perc.full.time.away.win <- as.data.frame(FullTimeResult_by_Season)[Seq22_Away, 4]
# The above statements import the data, but also changes the column names without the
# as.data.frame() function, so we have to use that as a wrapper. Guess this
# is something specific when using dplyr functions.

# For the half-time results, we've got to create that dataframe first -- see above.
EreDivisie_Aggregate_Results$perc.half.time.home.ahead[5:22] <- as.data.frame(HalfTimeResult_by_Season)[Seq18_Home, 4]
EreDivisie_Aggregate_Results$perc.half.time.draw[5:22] <- as.data.frame(HalfTimeResult_by_Season)[Seq18_Draw, 4]
EreDivisie_Aggregate_Results$perc.half.time.away.ahead[5:22] <- as.data.frame(HalfTimeResult_by_Season)[Seq18_Away, 4]
# Looks good, but something strange is going on in season 1997/1998. There are NA values included
# in the results (besides HOMEs, DRAWs, and AWAYs) and that messes things up...

# We have adjusted for the missing values, now set the first 4 seasons half-time results to NA:
EreDivisie_Aggregate_Results$perc.half.time.home.ahead[1:4] <- NA
EreDivisie_Aggregate_Results$perc.half.time.draw[1:4] <- NA
EreDivisie_Aggregate_Results$perc.half.time.away.ahead[1:4] <- NA

# OK, now we have a nice dataframe with aggregates for the 22 seasons:
EreDivisie_Aggregate_Results

# Let's clean up some of the intermediate objects / values:
rm(Seq18_Home, Seq18_Draw, Seq18_Away, Seq22_Home, Seq22_Draw, Seq22_Away)
rm(EreDivisie_Complete_WithoutNA)

# Now, let's try our hand at some graphs:



#       Is there a trend? Are more / less games being won by the home team in later years when
# compared to earlier years? If there is no trend, does the variation around the mean increase /
# decrease through the years? Are there any outliers?



# We can produce a table with the full-time scores by using:
table(EreDivisie_Complete$full.time.home.goals, EreDivisie_Complete$full.time.away.goals)
# This produces an overview of the number of times a certain score (goals scored by the home
# team on the Y-axis, goals scored by the visitors on the X-axis) occured in the dataset.

# Result:
#
#      0   1   2   3   4   5   6   7   8
# 0  405 342 292 168  71  29   8   0   0
# 1  554 716 388 206  87  27   7   3   2
# 2  510 480 389 131  65  21  10   1   0
# 3  336 359 184  72  24  11   2   0   0
# 4  165 191  94  28   7   2   0   0   0
# 5   80  86  35   9   2   0   0   0   0
# 6   33  38  15   2   2   0   0   0   0
# 7   19  11   3   0   0   0   0   0   0
# 8    4   1   1   0   0   0   0   0   0
# 9    2   0   0   0   0   0   0   0   0
# 10   2   0   0   0   0   0   0   0   0

# What does it mean?
#
#       This table directly shows that football (soccer) is a game of low scores, with a 1 - 1
# draw as most common result [1].
#       Teams playing at home are more productive than teams playing away. Home teams score more
# goals. Especially extreme scores (say more than 5 goals) seem to be the privilege of the home
# teams. (Home teams scored 5 or more goals 133 times, while visitors scored 5 or more goals only
# 33 times. This difference increases as the number of goals increases.) [2a]
nrow(EreDivisie_Complete[EreDivisie_Complete$full.time.home.goals > 5,]) # 133
nrow(EreDivisie_Complete[EreDivisie_Complete$full.time.away.goals > 5,]) #  33

summary(EreDivisie_Complete)
# Confirms what we saw in the table above. These colums seem to be most telling:
summary(EreDivisie_Complete[, 5:6])
summary(EreDivisie_Complete[, 8:9])

# Result:
#
# half.time.home.goals half.time.away.goals
# Min.   :0.00         Min.   :0.0000      
# 1st Qu.:0.00         1st Qu.:0.0000      
# Median :1.00         Median :0.0000      
# Mean   :0.78         Mean   :0.5472      
# 3rd Qu.:1.00         3rd Qu.:1.0000      
# Max.   :6.00         Max.   :5.0000      
# NA's   :1228         NA's   :1228 
#
# full.time.home.goals full.time.away.goals
# Min.   : 0.000       Min.   :0.000       
# 1st Qu.: 1.000       1st Qu.:0.000       
# Median : 2.000       Median :1.000       
# Mean   : 1.787       Mean   :1.272       
# 3rd Qu.: 3.000       3rd Qu.:2.000       
# Max.   :10.000       Max.   :8.000

#       On average a home playing team scores 1.8 goals, while visiting teams only
# score 1.3 goals. This difference explains the home team advantage. The median values
# are consistent aswell. Home teams most often score 2 goals, while visitors most
# often come away with 1 goal. At half-time the medians are 1 (home team) versus 0
# (away team) [2b].
#       During the second half both home and away teams seem to be more productive.
# the average number of goals scored in the first half represents close to 43% of the
# final number of goals scored. This ratio is about the same for both home and away
# teams [3].


