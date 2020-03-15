#' Allometric equations for rorqual morphology
#'
#' A dataset including the intercepts and slopes of the ordinary least squares
#' allometric regression (in log10 space) of various morphometric parameters
#' against body length. Use the formula 10^intercept * length^slope to predict
#' morphology.
#'
#' @format A data frame with 5 columns:
#' \describe{
#'   \item{species_code}{two
#'   letter codes: bw, bp, mn, ba, be, and bs}
#'   \item{binomial}{scientific
#'   binomials}
#'   \item{morphology}{morphological parameter e.g. flipper length,
#'   body mass}
#'   \item{slope}{slope of the allometric relationship}
#'   \item{intercept}{intercept of the allometric relationship}
#' }
#'
#' @source \doi{10.1002/jmor.20846}
"allometry"
