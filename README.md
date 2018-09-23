[![Travis-CI Build Status](https://travis-ci.org/veneficusnl/pmpp.svg?branch=master)](https://travis-ci.org/veneficusnl/pmpp)

# Posterior Mean Panel Predictor

This framework takes empirical-Bayes approach to compute forecasts with panel data. The features include what follows:

* Estimate PMPP model and use it to compute predictions;
* Choose between 10 different implementations of the model (2 methods to estimate individual effects, 5 methods to estimate common parameters);
* Compute prediction intervals with the Random-Window Block Bootstrap.

Additionally, the package exports a number of functions that can be used outside of the scope of PMPP modelling:

* `kde()` for computing a robust kernel density estimate;
* `kde2D()` for computing a robust 2-dimensional kernel density estimate;
* `create_fframe()` for adding time periods to a panel-structured data frame;
* `ssys_gmm()`, the suboptimal multi-step System-GMM estimator for AR(1) panel data model.

This package is authored and maintained by Michal Oleszak.

## How to call

The central function in the package is `pmpp()`. It estimates the model's coefficients and outputs an object of class `pmpp`. This class has 
`plot` and `summary` methods, with the former plotting the distribution of individual-specific effects and the latter additionally allowing to 
inspect model's coeffcients and in-sample error measures. To compute predictions with the PMPP model, one needs to construct the forecast frame
with `create_fframe()`. The forecast frame and the corresponding model object can be passed along to the `predict` method to obtain forecasts.
In order to obtain prediction intervals, the `pmpp_predinterval()` function can be used. This function, similarly to the `predict` method, 
takes the model object and the forecast frame as inputs. Be warned: bootstrapping of prediction interval might take time!

## Usage example

```
# Get data
data(EmplUK, package = "plm")
EmplUK <- dplyr::filter(EmplUK, year %in% c(1978, 1979, 1980, 1981, 1982))

# Run the model predicting employment
pmpp_model <- pmpp(dep_var = "emp", data = EmplUK)
summary(pmpp_model)

# Compute predictions for following three years
my_fframe <- create_fframe(EmplUK, 1983:1985)
prediction <- predict(pmpp_model, my_fframe)

# Compute prediction intervals
intervals <- pmpp_predinterval(pmpp_model, my_fframe, bootReps = 20, confidence = 0.95)
```
