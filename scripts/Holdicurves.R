
library(iNEXT)
library(ggplot2)
library(dplyr)

#load matrix
attach(MATFROGH)
data <- MATFROGH


# Check the structure of your matrix
str(MATFROGH)

# Ensure Type is a factor
MATFROGH$Type <- as.factor(MATFROGH$Type)


# Summarize abundances for each Type and split into a list
abundance_list <- MATFROGH %>%
  group_by(Type) %>%
  summarise(across(where(is.numeric), sum)) %>%  # Summarize numeric columns
  split(.$Type)  # Split the summarized data by Type

# Remove the Type column within each list element
abundance_list <- lapply(abundance_list, function(x) x[, -1])  # Drop 'Type' column


# Summarize abundances for each Type and split into numeric vectors
abundance_list <- MATFROGH %>%
  group_by(Type) %>%
  summarise(across(where(is.numeric), sum)) %>%
  split(.$Type)  # Split by Type

# Convert each element of the list to a numeric vector
abundance_list <- lapply(abundance_list, function(x) as.numeric(x[, -1]))  # Drop the 'Type' column

# Check the structure of abundance_list
str(abundance_list)


###RARE
rare_results <- iNEXT(abundance_list, q = 0, datatype = "abundance")

rare_results
# Plot the rarefaction curves

ggiNEXT(rare_results, type = 1) +
  ggtitle("Rarefaction Curves by Habitat Type") +
  xlab("Sample Size") +
  ylab("Species Richness")




