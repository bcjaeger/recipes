% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/roles.R
\name{roles}
\alias{roles}
\alias{add_role}
\alias{update_role}
\title{Manually Alter Roles}
\usage{
add_role(recipe, ..., new_role = "predictor", new_type = NULL)

update_role(recipe, ..., new_role = "predictor", old_role = NULL)
}
\arguments{
\item{recipe}{An existing \code{\link[=recipe]{recipe()}}.}

\item{...}{One or more selector functions to choose which variables are
being assigned a role. See \code{\link[=selections]{selections()}} for more details.}

\item{new_role}{A character string for a single role.}

\item{new_type}{A character string for specific type that the variable should
be identified as. If left as \code{NULL}, the type is automatically identified
as the \emph{first} type you see for that variable in \code{summary(recipe)}.}

\item{old_role}{A character string for the specific role to update for the
variables selected by \code{...}. If left as \code{NULL}, all roles for each selected
variable are updated to \code{new_role}. This is useful if you have a
variable with multiple roles, and you want to alter only one of them.}
}
\value{
An updated recipe object.
}
\description{
\code{add_role()} adds a \emph{new} role to an existing variable in the recipe. It
does not overwrite old roles, as a single variable can have multiple roles.

\code{update_role()} alters an existing role in the recipe.
}
\details{
With \code{add_role()}, if a variable is selected that already has the
\code{new_role}, a warning is emitted and that variable is skipped so no
duplicate roles are added.

Adding or updating roles is a useful way to group certain variables that
don't fall in the standard \code{"predictor"} bucket. You can perform a step
on all of the variables that have a custom role with the selector
\code{\link[=has_role]{has_role()}}.
}
\examples{
data(biomass)

# Create the recipe manually
rec <- recipe(x = biomass)
rec
summary(rec)

rec <- rec \%>\%
  update_role(carbon, contains("gen"), sulfur, new_role = "predictor") \%>\%
  update_role(sample, new_role = "id variable") \%>\%
  update_role(dataset, new_role = "splitting variable") \%>\%
  update_role(HHV, new_role = "outcome")

rec
summary(rec)

# Add a secondary role for carbon
rec <- rec \%>\%
  add_role(carbon, new_role = "carbon predictor")

summary(rec)

# Now update only the "predictor" role of carbon to instead
# be an additional outcome
rec \%>\%
  update_role(carbon, new_role = "outcome", old_role = "predictor") \%>\%
  summary()

}
\concept{preprocessing model_specification}
\keyword{datagen}
