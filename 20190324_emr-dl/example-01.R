# Packages -----------------------------------------------------------------

library(keras)
library(Metrics)
library(ggplot2)

# Generating data -----------------------------------------------------------

n_row <- 1000
n_col <- 10

X <- rnorm(n_row*n_col) %>% matrix(nrow = n_row)
y <- apply(X, 1, sum) + rnorm(n_row)


# Some visualizations ---------------------------------------------------

qplot(X[,1], y) + geom_smooth(method = "lm")

# Defining the model ------------------------------------------------------

input <- layer_input(n_col)
output <- layer_dense(input, units = 1)

model <- keras_model(input, output)
summary(model)


# Generating predictions --------------------------------------------------

y_hat <- predict(model, X)
dim(y_hat)


# Calculating the error ----------------------------------------------------

rmse(y, y_hat)

# Compiling the model -----------------------------------------------------

# We have to train the model
# Before that, we need to define our loss (likelihood function) and
# optimization method

model %>% 
  compile(
    loss = "mse",
    optimizer = "sgd"
  )


# Adjusting models ----------------------------------------------------

model %>% 
  fit(X , y, validation_split = 0.2)

# Recalculating error ---------------------------------------------

y_hat <- predict(model, X)
rmse(y, y_hat)

