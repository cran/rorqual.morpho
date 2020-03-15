#' Rorqual engulfment capacity
#'
#' @param species a vector of species codes
#' @param length_m a vector of lengths in meters
#'
#' @return a vector of engulfment capacities in kg of water
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_engulf("bw", 22)
#'
#' # A 7m minke
#' rorq_engulf("ba", 7)
rorq_engulf <- function(species, length_m) {
  morph_fun(species, length_m, "engulfment")
}

#' Rorqual mass
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of masses in kg
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_mass("bw", 22)
#'
#' # A 7m minke
#' rorq_mass("ba", 7)
rorq_mass <- function(species, length_m) {
  morph_fun(species, length_m, "mass")
}

#' Rorqual flipper length
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of flipper lengths in m
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_flipper("bw", 22)
#'
#' # A 7m minke
#' rorq_flipper("ba", 7)
rorq_flipper <- function(species, length_m) {
  morph_fun(species, length_m, "flipper")
}

#' Rorqual fluke length
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of fluke lengths in m
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_fluke("bw", 22)
#'
#' # A 7m minke
#' rorq_fluke("ba", 7)
rorq_fluke <- function(species, length_m) {
  morph_fun(species, length_m, "fluke")
}

#' Rorqual ventral groove blubber length
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of VGB lengths in m
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_vgb("bw", 22)
#'
#' # A 7m minke
#' rorq_vgb("ba", 7)
rorq_vgb <- function(species, length_m) {
  morph_fun(species, length_m, "vgb")
}

#' Rorqual projected mandible length
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of laterally projected mandible lengths in m
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_mandible("bw", 22)
#'
#' # A 7m minke
#' rorq_mandible("ba", 7)
rorq_mandible <- function(species, length_m) {
  morph_fun(species, length_m, "mandible")
}

#' Rorqual bizygomatic skull width
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of bizygomatic skull widths in m
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_bizygomatic("bw", 22)
#'
#' # A 7m minke
#' rorq_bizygomatic("ba", 7)
rorq_bizygomatic <- function(species, length_m) {
  morph_fun(species, length_m, "bizygomatic")
}

#' Rorqual engulfed water mass to body mass ratio
#'
#' @inheritParams rorq_engulf
#'
#' @return a vector of ratios (engulfed water mass to body mass)
#' @export
#'
#' @examples
#' # A 22m blue whale
#' rorq_massratio("bw", 22)
#'
#' # A 7m minke
#' rorq_massratio("ba", 7)
rorq_massratio <- function(species, length_m) {
  morph_fun(species, length_m, "massratio")
}

#' Generic morphology function
#'
#' @inheritParams rorq_engulf
#' @param morph name of the morphological measurement (length one character vector)
#'
#' @return vector of measurements
morph_fun <- function(species, length_m, morph) {
  # Use B. acutorostrata for B. bonaerensis
  species[species == "bb"] <- "ba"

  # Check inputs
  if (length(morph) != 1) {
    stop("morph should be length_m 1")
  }
  if (!morph %in% allometry$morphology) {
    stop(sprintf("morph %s not found", morph))
  }
  if (length(species) != length(length_m)) {
    stop(sprintf("species and length_m have different lengths"))
  }
  if (!all(species %in% allometry$species_code)) {
    invalid_sp <- setdiff(species, allometry$species_code)
    msg <- sprintf("Species %s are invalid (see allometry$species_code)",
                   paste(invalid_sp, collapse = ", "))
    stop(msg)
  }

  filter(allometry, morphology == morph) %>%
    right_join(tibble(species, length_m),
               by = c(species_code = "species")) %>%
    mutate(result = power_law(intercept, slope, length_m)) %>%
    pull(result)
}

#' Power law
#'
#' @param a intercept of the log10-log10 relationship
#' @param b slope of the log10-log10 relationship
#' @param x untransformed values for power law calculation
#'
#' @return a vector of power law results
power_law <- function(a, b, x) {
  10^a * x^b
}
