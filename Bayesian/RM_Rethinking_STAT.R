#install.packages("rstan")
#library(rstan)
install.packages(c("coda","mvtnorm","devtools","loo"))
install.packages("usethis")
library(devtools)
#devtools::install_github("rmcelreath/rethinking") 

#install.packages(c("mvtnorm","loo","coda"), repos="https://cloud.r-project.org/",dependencies=TRUE)
#options(repos=c(getOption('repos'), rethinking='http://xcelab.net/R'))
#install.packages('rethinking',type='source')

install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install_github("rmcelreath/rethinking",ref="Experimental") # this is the newest one?
