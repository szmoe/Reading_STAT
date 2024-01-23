#install.packages("rstan")
#library(rstan)
install.packages(c("coda","mvtnorm","devtools","loo"))
install.packages("usethis")
library(usethis)
library(devtools)
#devtools::install_github("rmcelreath/rethinking") 

#install.packages(c("mvtnorm","loo","coda"), repos="https://cloud.r-project.org/",dependencies=TRUE)
#options(repos=c(getOption('repos'), rethinking='http://xcelab.net/R'))
#install.packages('rethinking',type='source')

install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install_github("rmcelreath/rethinking",ref="Experimental") # this is the newest one?


# Lecture 1: Golem of Prague ####

# Simple calculation for Bayseian posterior distribution ####

# Set up the calculation
p_grid <- seq(from = 0, to = 1, length.out = 1000)
plot(p_grid)

# Calculate prior
prob_p <- rep(1, 1000)
plot(prob_p)

# Calculate likelihood
prob_data <- dbinom(6, size = 9, prob = p_grid)
plot(prob_data)

# Generate normalized posterior distribution
posterior <- prob_data * prob_p

plot(posterior)

posterior <- posterior/ sum(posterior)

plot(posterior)


# Lecture 2: The Garden of Forking Data ####

# Probability ####
sample <- c("W", "L", "W", "W", "W", "L", "W", "L", "W")
W <- sum(sample == "W") # number of W observed
L <- sum(sample == "L") # number of L observed
p <- c(0, 0.25, 0.5, 0.75, 1) # proportions of W
ways <- sapply(p, function(q) (q * 4)^W * ((1 - q) * 4)^L)
prob <- ways/ sum(ways)
cbind(p, ways, prob)

# Plot the probability
barplot(prob, names.arg = p, col = "black", xlab = "Proportion of Water (p)",
        ylab = "Probability", main = "4-sided globe: 5 possibilities",
        ylim = c(0, max(prob) + 0.1), width = 0.5)








