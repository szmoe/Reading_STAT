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

# Setting up the calculation

p_grid <- seq(from = 0, to = 1, length.out = 1000)
plot(p_grid)

# Calculating prior

prob_p <- rep(1, 1000)
plot(prob_p)

# Calculating likelihood

prob_data <- dbinom(6, size = 9, prob = p_grid)
plot(prob_data)

# Generate normalized posterior distribution

posterior <- prob_data * prob_p

plot(posterior)

posterior <- posterior/ sum(posterior)

plot(posterior)


