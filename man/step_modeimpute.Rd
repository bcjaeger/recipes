% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modeimpute.R
\name{step_modeimpute}
\alias{step_modeimpute}
\alias{tidy.step_modeimpute}
\title{Impute Nominal Data Using the Most Common Value}
\usage{
step_modeimpute(recipe, ..., role = NA, trained = FALSE,
  modes = NULL, skip = FALSE, id = rand_id("modeimpute"))

\method{tidy}{step_modeimpute}(x, ...)
}
\arguments{
\item{recipe}{A recipe object. The step will be added to the
sequence of operations for this recipe.}

\item{...}{One or more selector functions to choose which
variables are affected by the step. See \code{\link[=selections]{selections()}}
for more details. For the \code{tidy} method, these are not
currently used.}

\item{role}{Not used by this step since no new variables are
created.}

\item{trained}{A logical to indicate if the quantities for
preprocessing have been estimated.}

\item{modes}{A named character vector of modes. This is
\code{NULL} until computed by \code{\link[=prep.recipe]{prep.recipe()}}.}

\item{skip}{A logical. Should the step be skipped when the
recipe is baked by \code{\link[=bake.recipe]{bake.recipe()}}? While all operations are baked
when \code{\link[=prep.recipe]{prep.recipe()}} is run, some operations may not be able to be
conducted on new data (e.g. processing the outcome variable(s)).
Care should be taken when using \code{skip = TRUE} as it may affect
the computations for subsequent operations}

\item{id}{A character string that is unique to this step to identify it.}

\item{x}{A \code{step_modeimpute} object.}
}
\value{
An updated version of \code{recipe} with the new step
added to the sequence of existing steps (if any). For the
\code{tidy} method, a tibble with columns \code{terms} (the
selectors or variables selected) and \code{model} (the mode
value).
}
\description{
\code{step_modeimpute} creates a \emph{specification} of a
recipe step that will substitute missing values of nominal
variables by the training set mode of those variables.
}
\details{
\code{step_modeimpute} estimates the variable modes
from the data used in the \code{training} argument of
\code{prep.recipe}. \code{bake.recipe} then applies the new
values to new data sets using these values. If the training set
data has more than one mode, one is selected at random.
}
\examples{
data("credit_data")

## missing data per column
vapply(credit_data, function(x) mean(is.na(x)), c(num = 0))

set.seed(342)
in_training <- sample(1:nrow(credit_data), 2000)

credit_tr <- credit_data[ in_training, ]
credit_te <- credit_data[-in_training, ]
missing_examples <- c(14, 394, 565)

rec <- recipe(Price ~ ., data = credit_tr)

impute_rec <- rec \%>\%
  step_modeimpute(Status, Home, Marital)

imp_models <- prep(impute_rec, training = credit_tr)

imputed_te <- bake(imp_models, new_data = credit_te, everything())

table(credit_te$Home, imputed_te$Home, useNA = "always")

tidy(impute_rec, number = 1)
tidy(imp_models, number = 1)
}
\concept{preprocessing imputation}
\keyword{datagen}
