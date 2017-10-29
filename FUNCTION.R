# FUNCTION.R : This file contains functions that will be used while
# cleaning and / or analyzing the Voetbal data.

########################
## CLEANING FUNCTIONS ##
########################

# Function to be used for adding the various individual datasets (per
# season data) together into one big dataset.
# Found it here:
# https://amywhiteheadresearch.wordpress.com/2013/05/13/combining-dataframes-when-the-columns-dont-match/

rbind.all.columns <- function(x, y) {
        
        x.diff <- setdiff(colnames(x), colnames(y))
        y.diff <- setdiff(colnames(y), colnames(x))
        
        x[, c(as.character(y.diff))] <- NA
        
        y[, c(as.character(x.diff))] <- NA
        
        return(rbind(x, y))
}

##### Usage: rbind.all.columns(DF_1, DF_2)


# ALTERNATIVE VERSION (just the matching colums)

rbind.match.columns <- function(input1, input2) {
        n.input1 <- ncol(input1)
        n.input2 <- ncol(input2)
        
        if (n.input2 < n.input1) {
                TF.names <- which(names(input2) %in% names(input1))
                column.names <- names(input2[, TF.names])
        } else {
                TF.names <- which(names(input1) %in% names(input2))
                column.names <- names(input1[, TF.names])
        }
        
        return(rbind(input1[, column.names], input2[, column.names]))
}

##### Usage: rbind.match.columns(DF_1, DF_2)
