install.packages("rstanarm")
install.packages("bayestestR")
library(rstanarm)
library(bayestestR)

model1 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 1e4, warmup = 100, refresh = 0)
)
effective_sample(model1)



# List of warm-up values
warmup_values <- c(1, 5, 10, 100, 500, 1000)

model2 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 1, refresh = 0)
)
effective_sample(model2)

model3 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 5, refresh = 0)
)
effective_sample(model3)

model4 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 10, refresh = 0)
)
effective_sample(model4)

model5 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 100, refresh = 0)
)
effective_sample(model5)

model6 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 500, refresh = 0)
)
effective_sample(model6)

model7 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 4000, warmup = 1000, refresh = 0)
)
effective_sample(model7)

# 8H1
model8h1 <- suppressWarnings(
  stan_glm(y ~ 1, data = data.frame(y = c(-1:1)), chains = 2, iter = 1e4, warmup = 100, refresh = 0)
)
effective_sample(model8h1)
