# Import data about Eredivisie Seizoen 2014/2015. Source: http://www.football-data.co.uk
# First I downloaded the Excel-file manually, but it would be better to work with code inside
# a script. Of course, it would also be nice to add a date for the download.

# Add a download date...
download_date <- date()

# Set working directory...
setwd("~/Dropbox/Sannie's Stuff/Voetbal")

# If Data directory does not exist; create it.
if (!file.exists("data")) {
        dir.create("data")
}

# Put URL pointing towards the dataset into a variable.
url_to_dataset <- "http://www.football-data.co.uk/mmz4281/1415/N1.csv"

# Download the dataset to the Data directory inside the working directory.
download.file(url_to_dataset, destfile = "./data/N1.csv")

# Put contents of .csv file into R object:
EreDivisie_2014_15 <- read.csv("./data/N1.csv")

# What have we got?
dim(EreDivisie_2014_15)
head(EreDivisie_2014_15)
names(EreDivisie_2014_15)

# There seem to be 306 rows (match results, games) and 52 variables.
# The first 10 variables are most relevant for me at this time, since
# this is data about the actual matches. The rest of the variables
# are betting odds. We'll do away with those for now to make it more
# manageble:
EreDivisie_2014_15 <- EreDivisie_2014_15[,1:10]

# What kind of variables are available exactly?
str(EreDivisie_2014_15)

# It looks like the "Date" variable isn't actually a date, but a factor
# with 92 levels. "HomeTeam" and "AwayTeam" are factors aswell. They both
# have 18 levels. So there were 18 teams in the league for that season.
# That should result in 18 * 18 = 324 minus 18 = 306 matches. This is
# consistent with the number of rows in the dataset.

# Total number of home and away matches for Ajax:
nrow(EreDivisie_2014_15[EreDivisie_2014_15$HomeTeam == "Ajax" | EreDivisie_2014_15$AwayTeam == "Ajax",])
# Result: 34 matches...
# Which equals 17 home games and 17 away games against each every other
# team in the league.

# QUESTION #1A: How often is the half-time result equal to the full-time result?
nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == EreDivisie_2014_15$FTR,]) / 306
# Result: 0.5816993. Almost 6 out of 10 times...
# In this season, at least.

# This matches the intuition: when one team is ahead with only 45 minutes
# left to play the opportunities to change the score are being reduced.

# QUESTION #1B: How often does a draw at half-time remain a draw full-time?
No_HalfTime_Ds <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "D",])
No_Ds_Remaining_FullTime <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "D" & EreDivisie_2014_15$FTR == "D",])

No_Ds_Remaining_FullTime / No_HalfTime_Ds
# Result: 0.3464567. Only about 1 in 3 half-time draws remain a draw.
# That's considerably less than the figure for the total half-time results.
# Consequently the fraction of 'won / lost' matches half-time that remain
# that way should be even higher than 6 out of 10...

# QUESTION #1C: How often does a half-time win / loss remain so full-time?
No_HalfTime_Hs <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "H",])
No_Hs_Remaining_FullTime <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "H" & EreDivisie_2014_15$FTR == "H",])

No_Hs_Remaining_FullTime / No_HalfTime_Hs
# Result: 0.7708333. Almost 8 out of 10 times the home team wins the match
# when it was ahead half-time...

No_HalfTime_As <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "A",])
No_As_Remaining_FullTime <- nrow(EreDivisie_2014_15[EreDivisie_2014_15$HTR == "A" & EreDivisie_2014_15$FTR == "A",])

No_As_Remaining_FullTime / No_HalfTime_As
# Result: 0.7228916. More than 7 out of 10 times a visiting team that is ahead
# at half-time wins the complete match (at full-time).

# So, when a difference has been made half-time it's quite likely that this
# will be reflected in the final score (a chance of 70 - 80%). Half-time draws
# usually don't remain drawn. Two out of three half-time draws become wins / losses.


# QUESTION #2: Is there a home team advantage?
nrow(EreDivisie_2014_15[EreDivisie_2014_15$FTR == "H",]) / 306
# Result: 0.4509804.
nrow(EreDivisie_2014_15[EreDivisie_2014_15$FTR == "D",]) / 306
# Result: 0.2385621.
nrow(EreDivisie_2014_15[EreDivisie_2014_15$FTR == "A",]) / 306
# Result: 0.3104575.

# Home wins seem way more likely than away wins. The ratio seems to be around
# 1,5. That strikes me as a big enough difference to conclude this is probably
# a real effect and not a statistical fluke. Home teams have a greater chance
# of winning. Or, put differently, home teams only have a 30% chance of losing.
# Winning or drawing are more likely.
#
# INTERESTING FOLLOW UP QUESTION: Has the rule change (3 points for a win
# instead of 2) had any effect? Are the percentages much different? Is it
# statistically meaningful?
#
# To get a quick impression of the half-time / full-time dynamics including
# the favorable probabilities for the home team is seems handy to create a table
# of the half-time and full-time results:
table(EreDivisie_2014_15$HTR, EreDivisie_2014_15$FTR)

# This produces a 3 x 3 table, where it is not immediately clear which axis
# represents the half-time results and which the full-time results. The following
# code provides us with a number that enables us to deduce which is wich:
nrow(EreDivisie_2014_15[(EreDivisie_2014_15$FTR == "H" & EreDivisie_2014_15$HTR == "D"),])

# This figure indicates that the half-time scores are on the Y-axis, while
# the full-time scores are on the X-axis. How to add axis-names to this table
# is unclear at the moment, we still have to find that out.

# The absolute values in the table don't communicate clearly enough what might
# be going on. Converting the numbers to percentages of the total number of games
# helps:
round(table(EreDivisie_2014_15$HTR, EreDivisie_2014_15$FTR) / nrow(EreDivisie_2014_15) * 100)

# Result:
#
#    A  D  H
# A 20  4  3
# D  9 14 18
# H  2  5 24
#
# An analyses of the matrix seems to indicate that the half-time results have
# significant predictive value. Games 'won' half-time and (actually) won full-time
# by the home team show the highest percentage (24), followed by games 'won' / won
# (half-time / full-time) by the away team (20). These results seem to be 'sticky'
# aswell, since both home and away teams lose their lead (to a draw or a loss) not
# very often. Chances are that a win half-time will be a win full-time. When a team
# loses their lead ending up with a draw is more likely than finishing a loser.
# This seems logical.
# With half-time draws the story seems to be different. Here the highest percentage
# represents games that were drawn half-time and ended up a win for the home team
# in the end. The likelyhood of this happening seems to be twice as great when compared
# to a half-time draw being converted to a win for the away team full-time.
# This seems to confirm the home team advantage.