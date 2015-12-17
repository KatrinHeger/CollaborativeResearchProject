# The result of this command is an n by k matrix, where n is the number of
# data points being predicted and k is the number of options.
# Therefore to make a choice, we need to calculate the cumulative probabilities
# associated with each option. We can then draw a random value between 0 to 1;
# the option with the greatest cumulative probability below our draw value is our choice.
# This can be written into a function for easier use.
# Source: http://bit.ly/1UBXJGk

# Function to predict multinomial logit choice model outcomes
predictMNL <- function(model, newdata) {
  
  # Only works for neural network models
  if (is.element("nnet",class(model))) {
    # Calculate the individual and cumulative probabilities
    probs <- predict(model,newdata,"probs")
    cum.probs <- t(apply(probs,1,cumsum))
    
    # Draw random values
    vals <- runif(nrow(newdata))
    
    # Join cumulative probabilities and random draws
    tmp <- cbind(cum.probs,vals)
    
    # For each row, get choice index.
    k <- ncol(probs)
    ids <- 1 + apply(tmp,1,function(x) length(which(x[1:k] < x[k+1])))
    
    # Return the values
    return(ids)
  }
}

# Using the function created above to predict the outcome for our dataset
y2 <- predictMNL(mlogit3_reb_3, dat.3)
df2 <- cbind(dat.3,y=y2)
stargazer(df2, type = "text", digits = 2)