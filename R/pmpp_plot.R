#' Plot method for objects of class \code{pmpp}.
#'
#' @param object object of class \code{pmpp}, as returned by \code{pmpp()}
#' @param file a connection, or a character string naming the file to print to
#' @param ... not used
#'
#' @return No object is returned. Displays a \code{ggplot} of density of the estimated 
#' individual-specific effects.
#' @export
#' @importFrom ggplot2 ggplot aes geom_density xlab ylab ggtitle
#'
#' @examples
#' data(EmplUK, package = "plm")
#' EmplUK <- dplyr::filter(EmplUK, year %in% c(1978, 1979, 1980, 1981, 1982))
#' pmpp_model <- pmpp(dep_var = "emp", data = EmplUK)
#' plot(pmpp_model)
plot.pmpp <- function(object, file = "", ...) {
  if (!inherits(object, "pmpp")) {
    stop("Non-convenient object, PMPP object required.")
  }
  ggdata <- data.frame("intercept" = as.vector(object$intercept))
  ggplot(ggdata, aes(x = intercept)) +
    geom_density(aes(y = ..scaled..), fill = "deepskyblue2", alpha = 0.4) +
    xlab("Individual-specific effect (intercept)") +
    ylab("Scaled density") +
    ggtitle("Density of estimated individual-specific effects")
}
