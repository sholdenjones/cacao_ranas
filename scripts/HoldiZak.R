####ZAK
# Perform rarefaction analysis with extended extrapolation
rare_results_extended <- iNEXT(abundance_list, q = 0, datatype = "abundance", endpoint = 2000)

# Plot rarefaction/extrapolation curves with extended extrapolation
ggiNEXT(rare_results_extended, type = 1) +
  ggtitle("Extended Rarefaction and Extrapolation Curves by Habitat Type") +
  xlab("Sample Size") +
  ylab("Species Richness")


# Extract the iNextEst data frame
extrapolated_richness <- rare_results_extended$iNextEst

# Check the structure
str(extrapolated_richness)

# View the data
head(extrapolated_richness)

# Extract size-based extrapolated richness values
extrapolated_summary <- extrapolated_richness$size_based %>%
  filter(Method == "Extrapolation", m == 2000) %>%
  select(Assemblage, m, qD, qD.LCL, qD.UCL)

# Print the summary
print(extrapolated_summary)
