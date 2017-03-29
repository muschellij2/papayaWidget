#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
#' @importFrom htmltools tags htmlDependency
#' @importFrom neurobase checkimg
#' @importFrom base64enc base64encode
papayaWidget <- function(img, elementId, width = NULL, height = NULL) {

  x <- list (files = img)
  
  # create widget
  htmlwidgets::createWidget(
    name = 'papayaWidget',
    x,
    width = width,
    height = height,
    package = 'papayaWidget',
    elementId = elementId
  )
}

#' Shiny bindings for papayaWidget
#'
#' Output and render functions for using papayaWidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a papayaWidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name papayaWidget-shiny
#'
#' @export
papayaWidgetOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'papayaWidget', width, height, package = 'papayaWidget')
}

#' @rdname papayaWidget-shiny
#' @export
renderPapayaWidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, papayaWidgetOutput, env, quoted = TRUE)
}
