# LOAD: This script contains steps to load football (soccer) data into R.
#
# Imports data about Eredivisie Seizoen. Source: http://www.football-data.co.uk
# At this page the data for seasons 1993/1994 - 2015/2016 are available for
# download as .CSV files. 22 Seasons! (It seems at least the full-time results
# are available in all of the files, with most also containing half-time results.)
# Let's get them all — the more data, the better.

# First add a download date...
download_date <- date()

# Set working directory...
setwd("~/Dropbox/Sannie's Stuff/Voetbal")

# If Data directory does not exist; create it.
if (!file.exists("data")) {
        dir.create("data")
}

# Put URL's pointing towards the datasets into variables:
url_to_dataset_01 <- "http://www.football-data.co.uk/mmz4281/1415/N1.csv" # 2014/2015 HT & FT results
url_to_dataset_02 <- "http://www.football-data.co.uk/mmz4281/1314/N1.csv" # 2013/2014 HT & FT results
url_to_dataset_03 <- "http://www.football-data.co.uk/mmz4281/1213/N1.csv" # 2012/2013 HT & FT results
url_to_dataset_04 <- "http://www.football-data.co.uk/mmz4281/1112/N1.csv" # 2011/2012 HT & FT results

url_to_dataset_05 <- "http://www.football-data.co.uk/mmz4281/1011/N1.csv" # 2010/2011 HT & FT results
url_to_dataset_06 <- "http://www.football-data.co.uk/mmz4281/0910/N1.csv" # 2009/2010 HT & FT results
url_to_dataset_07 <- "http://www.football-data.co.uk/mmz4281/0809/N1.csv" # 2008/2009 HT & FT results
url_to_dataset_08 <- "http://www.football-data.co.uk/mmz4281/0708/N1.csv" # 2007/2008 HT & FT results
url_to_dataset_09 <- "http://www.football-data.co.uk/mmz4281/0607/N1.csv" # 2006/2007 HT & FT results
url_to_dataset_10 <- "http://www.football-data.co.uk/mmz4281/0506/N1.csv" # 2005/2006 HT & FT results
url_to_dataset_11 <- "http://www.football-data.co.uk/mmz4281/0405/N1.csv" # 2004/2005 HT & FT results
url_to_dataset_12 <- "http://www.football-data.co.uk/mmz4281/0304/N1.csv" # 2003/2004 HT & FT results
url_to_dataset_13 <- "http://www.football-data.co.uk/mmz4281/0203/N1.csv" # 2002/2003 HT & FT results
url_to_dataset_14 <- "http://www.football-data.co.uk/mmz4281/0102/N1.csv" # 2001/2002 HT & FT results
url_to_dataset_15 <- "http://www.football-data.co.uk/mmz4281/0001/N1.csv" # 2000/2001 HT & FT results

url_to_dataset_16 <- "http://www.football-data.co.uk/mmz4281/9900/N1.csv" # 1999/2000 HT & FT results
url_to_dataset_17 <- "http://www.football-data.co.uk/mmz4281/9899/N1.csv" # 1998/1999 HT & FT results
url_to_dataset_18 <- "http://www.football-data.co.uk/mmz4281/9798/N1.csv" # 1997/1998 HT & FT results
url_to_dataset_19 <- "http://www.football-data.co.uk/mmz4281/9697/N1.csv" # 1996/1997 FT results only
url_to_dataset_20 <- "http://www.football-data.co.uk/mmz4281/9596/N1.csv" # 1995/1996 FT results only
url_to_dataset_21 <- "http://www.football-data.co.uk/mmz4281/9495/N1.csv" # 1994/1995 FT results only
url_to_dataset_22 <- "http://www.football-data.co.uk/mmz4281/9394/N1.csv" # 1993/1994 FT results only


# Download the dataset to the Data directory inside the working directory.
download.file(url_to_dataset_01, destfile = "./data/N1_2014_2015.csv")
download.file(url_to_dataset_02, destfile = "./data/N1_2013_2014.csv")
download.file(url_to_dataset_03, destfile = "./data/N1_2012_2013.csv")
download.file(url_to_dataset_04, destfile = "./data/N1_2011_2012.csv")

download.file(url_to_dataset_05, destfile = "./data/N1_2010_2011.csv")
download.file(url_to_dataset_06, destfile = "./data/N1_2009_2010.csv")
download.file(url_to_dataset_07, destfile = "./data/N1_2008_2009.csv")
download.file(url_to_dataset_08, destfile = "./data/N1_2007_2008.csv")
download.file(url_to_dataset_09, destfile = "./data/N1_2006_2007.csv")
download.file(url_to_dataset_10, destfile = "./data/N1_2005_2006.csv")
download.file(url_to_dataset_11, destfile = "./data/N1_2004_2005.csv")
download.file(url_to_dataset_12, destfile = "./data/N1_2003_2004.csv")
download.file(url_to_dataset_13, destfile = "./data/N1_2002_2003.csv")
download.file(url_to_dataset_14, destfile = "./data/N1_2001_2002.csv")
download.file(url_to_dataset_15, destfile = "./data/N1_2000_2001.csv")

download.file(url_to_dataset_16, destfile = "./data/N1_1999_2000.csv")
download.file(url_to_dataset_17, destfile = "./data/N1_1998_1999.csv")
download.file(url_to_dataset_18, destfile = "./data/N1_1997_1998.csv")
download.file(url_to_dataset_19, destfile = "./data/N1_1996_1997.csv")
download.file(url_to_dataset_20, destfile = "./data/N1_1995_1996.csv")
download.file(url_to_dataset_21, destfile = "./data/N1_1994_1995.csv")
download.file(url_to_dataset_22, destfile = "./data/N1_1993_1994.csv")


# Put contents of .csv files into R objects:
EreDivisie_2014_15 <- read.csv("./data/N1_2014_2015.csv")
EreDivisie_2013_14 <- read.csv("./data/N1_2013_2014.csv")
EreDivisie_2012_13 <- read.csv("./data/N1_2012_2013.csv")
EreDivisie_2011_12 <- read.csv("./data/N1_2011_2012.csv")

EreDivisie_2010_11 <- read.csv("./data/N1_2010_2011.csv")
EreDivisie_2009_10 <- read.csv("./data/N1_2009_2010.csv")
EreDivisie_2008_09 <- read.csv("./data/N1_2008_2009.csv")
EreDivisie_2007_08 <- read.csv("./data/N1_2007_2008.csv")
EreDivisie_2006_07 <- read.csv("./data/N1_2006_2007.csv")
EreDivisie_2005_06 <- read.csv("./data/N1_2005_2006.csv")
EreDivisie_2004_05 <- read.csv("./data/N1_2004_2005.csv")
EreDivisie_2003_04 <- read.csv("./data/N1_2003_2004.csv")
EreDivisie_2002_03 <- read.csv("./data/N1_2002_2003.csv")
EreDivisie_2001_02 <- read.csv("./data/N1_2001_2002.csv")
EreDivisie_2000_01 <- read.csv("./data/N1_2000_2001.csv")

EreDivisie_1999_00 <- read.csv("./data/N1_1999_2000.csv")
EreDivisie_1998_99 <- read.csv("./data/N1_1998_1999.csv")
EreDivisie_1997_98 <- read.csv("./data/N1_1997_1998.csv")
EreDivisie_1996_97 <- read.csv("./data/N1_1996_1997.csv")
EreDivisie_1995_96 <- read.csv("./data/N1_1995_1996.csv")
EreDivisie_1994_95 <- read.csv("./data/N1_1994_1995.csv")
EreDivisie_1993_94 <- read.csv("./data/N1_1993_1994.csv")


# The imported datasets differ somewhat and need to be cleaned up. The
# neccessary actions (commands) can be found in the file CLEAN.R.
# The way the work has been divided over several R files was guided
# by the following post on StackOverflow:
#
# http://stackoverflow.com/questions/1429907/workflow-for-statistical-analysis-and-report-writing

# How to handle the generated data files (in R)? Should these
# be saved separately? Or are the .CSV files enough?