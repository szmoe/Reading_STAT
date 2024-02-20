library(rethinking)
data("WaffleDivorce")
d <- WaffleDivorce

# standardize predictor
d$MedianAgeMarriage.s <- (d$MedianAgeMarriage-mean(d$MedianAgeMarriage))/
  sd(d$MedianAgeMarriage)
d$Marriage.s <- (d$Marriage - mean(d$Marriage))/sd(d$Marriage)

m5.3 <- map(
  alist(
    Divorce ~ dnorm( mu , sigma ) ,
    mu <- a + bR*Marriage.s + bA*MedianAgeMarriage.s ,
    a ~ dnorm( 10 , 10 ) ,
    bR ~ dnorm( 0 , 1 ) ,
    bA ~ dnorm( 0 , 1 ) ,
    sigma ~ dunif( 0 , 10 )
  ),
  data = d )

precis( m5.3 )


# call link without specifying new data
# so it uses original data
mu <- link( m5.3 )

# summarize samples across cases
mu.mean <- apply( mu , 2 , mean )
mu.PI <- apply( mu , 2 , PI )


# compute residuals
divorce.resid <- d$Divorce - mu.mean


# Calculate waffle houses per capita
d$Wafflehouse_per_capita <- d$WaffleHouses/d$Population
Wafflehouse_per_capita

# Fit the map model 
m5.6c <- map(
  alist(
    divorce.resid ~ dnorm(mu, sigma),
    mu <- a + b*d$Wafflehouse_per_capita,
    a ~ dnorm(0, 10),
    b ~ dnorm(0, 1),
    sigma ~ dunif(0, 10)
  ), 
  data = d
)

m5.6c

# Plot divorce residue against waffle house per capita
plot(divorce.resid ~ Wafflehouse_per_capita, data = d, col = rangi2,
     xlab = "Waffles per capita", ylab = "Divorce error", ylim = c(-5, 4))

# Add the regression line
abline(coef(m5.6c)[1], coef(m5.6c)[2])

# Define the indices of the points to label
indices <- c(20, 4, 1, 25, 11, 40, 13)  

# Add text labels to specific points
text(x = d$Wafflehouse_per_capita[indices], y = divorce.resid[indices], 
     labels = d$Loc[indices], cex = 0.8, pos = 3)

  W.seq <- seq( from=0 , to=50 , length.out=50 )
  pred.data <- data.frame(Wafflehouse_per_capita=W.seq)
                        
 pred.data   
 
# Shade PI
mu <- link( m5.6c , data=pred.data ) 
mu.PI <- apply( mu , 2 , PI )
mu.PI  
shade(mu.PI, W.seq)
W.sim <- sim(m5.6c, data = pred.data, n = 1e4)
W.PI <- apply(W.sim, 2, PI)
shade(W.PI, W.seq)

## Try using lm function
# fit the model 
fit <- lm(divorce.resid ~ Wafflehouse_per_capita, data = d)
plot(divorce.resid ~ Wafflehouse_per_capita, data = d, col = col.alpha(rangi2, 0.8),
     xlab = "Waffles per capita", ylab = "Divorce error", ylim = c(-5, 4))
abline(fit)

# Define the indices of the points to label
indices <- c(20, 4, 1, 25, 11, 40, 13)  

# Add text labels to specific points
text(x = d$Wafflehouse_per_capita[indices], y = divorce.resid[indices], 
     labels = d$Loc[indices], cex = 0.8, pos = 3)

# find CI
fit.ci <- predict(fit, interval = "confidence")
polygon(c(d$Wafflehouse_per_capita, rev(d$Wafflehouse_per_capita)), 
        c(fit.ci[, "lwr"], rev(fit.ci[, "upr"])),
        col = col.alpha("gray", 0.3), border = NA)

## Try using ggplot
library(ggplot2)
ggplot(d, aes(x = Wafflehouse_per_capita, y = divorce.resid)) +
  geom_point(color = col.alpha(rangi2, 0.8), size = 2) +
  geom_smooth(method = "lm", fullrange = T,
              color  = "black", size = 1/2, 
              fill   = "gray", alpha = 1/3) +
  labs(x = "Waffles per capita", y = "Divorce error") +
  theme_minimal() 


# try adding label
indices <- c(20, 4, 1, 25, 11, 40, 13) 
ggplot(d, aes(x = Wafflehouse_per_capita, y = divorce.resid)) +
  geom_point(color = col.alpha(rangi2, 0.8), size = 2) +
  geom_smooth(method = "lm", fullrange = T,
              color  = "black", size = 1/2, 
              fill   = "gray", alpha = 1/3) +
 
  geom_text(aes(label=ifelse(divorce.resid > 2.33022867,as.character(Loc),'')), hjust = 0, vjust = -0.5) +
  
  geom_text(aes(label = ifelse(divorce.resid > 1.73858361 & divorce.resid <= 1.8, as.character(Loc), "")),
            hjust = 1, vjust = 1.2) +
  
  geom_text(aes(label = ifelse(divorce.resid > 1 & divorce.resid <= 1.15377608, as.character(Loc), "")),
            hjust = 1, vjust = -0.5) +
  
  geom_text(aes(label = ifelse(divorce.resid > -1.34199783 & divorce.resid <= -1.3, as.character(Loc), "")),
            hjust = 1, vjust = -0.5) +
  
  
  geom_text(aes(label=ifelse(divorce.resid < -4.38753672,as.character(Loc),'')), hjust = 0, vjust = -0.5) +
  labs(x = "Waffles per capita", y = "Divorce error") +
  theme_minimal() 

divorce.resid

# Create initial ggplot
DW.plot <- ggplot(d, aes(x = Wafflehouse_per_capita, y = divorce.resid)) +
  geom_point(color = col.alpha(rangi2, 0.8), size = 2)

# Select states
state <- c("ME", "AR", "MS", "AL", "GA", "SC", "ID")

# Filter dataset
state.ft <- subset(d, Loc %in% state)

DW.plot +
  geom_label_repel(data = state.ft,
                   aes(label = Loc, y = ),
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'grey50') +
  
  geom_smooth(method = "lm", fullrange = T,
              color  = "black", size = 1/2, 
              fill   = "gray", alpha = 1/3) +
  labs(x = "Waffles per capita", y = "Divorce error") +
  theme_minimal() 

View(WaffleDivorce)
View(divorce.resid)



  
