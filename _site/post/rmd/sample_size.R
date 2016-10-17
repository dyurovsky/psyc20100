# Coins are either heads or tails
data <- c("H", "T")

# Take in how many coins to flip, and then flip them
sample_func <- function(n) {
  mean(sample(data, n, replace = TRUE) == "H")
}

# Find the upper nth percentile of a set of samples
upper_percentile <- function(samples) {
  sort(samples)[length(samples) - (percentile * length(samples))]
}

# Find the lower nth percentile of a set of samples
lower_percentile <- function(samples) {
  sort(samples)[percentile * length(samples)]
}

# Set up parameters for sampling
percentile <- .025 #criterion for significance
n <- 4 #sample size
true_prob <- .75 #my true guessing ability

# Generate samples
samples <- replicate(10000, sample_func(n))

top <- upper_percentile(samples)
bottom <- lower_percentile(samples)

# make the plot
samples %>%
  qplot() + 
  geom_vline(xintercept = top, color = "lightgray", size = 2) +
  geom_vline(xintercept = bottom, color = "lightgray", size = 2) +
  geom_vline(xintercept = true_prob, color = "darkred", size = 2) +
  theme_bw()
