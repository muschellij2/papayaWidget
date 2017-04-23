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
#' @importFrom jsonlite toJSON
papayaWidget <- function(
  img,
  passingMethod = c("embed", "file"), elementId = NULL,
  width = NULL, height = NULL) {

  img = checkimg(img)
  passingMethod = match.arg(passingMethod)
  if (passingMethod == "embed") {
    fileData = sapply(img, base64enc::base64encode)
    fileData <- jsonlite::toJSON(fileData)
    embed_params_def <- paste0("window.data",elementId,0:(length(img)-1)," = x.data[",0:(length(img)-1),"]; ",collapse="")
    embed_encoded_img_string <- paste0("\"data",elementId,0:(length(img)-1),"\",",collapse="")
    embed_encoded_img_string <- substr(embed_encoded_img_string,1,nchar(embed_encoded_img_string)-1)
  } else {
      fileData = ""
      embed_params_def = ""
      embed_encoded_img_string = ""
  }
  if (is.null(elementId)) {
    elementId = basename(tempfile())
  }

  # deps = list(
  #   jquery = rmarkdown::html_dependency_jquery()
  # )
  x <- list(
    data = fileData,
    params = embed_params_def,
    enc_img_str = embed_encoded_img_string,
    names = img,
    passingMethod = passingMethod
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'papayaWidget',
    x = x,
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
  htmlwidgets::shinyWidgetOutput(outputId, "papayaWidget", width,
                                 height, package = "papayaWidget")
}

#' @rdname papayaWidget-shiny
#' @export
renderPapayaWidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, papayaWidgetOutput, env, quoted = TRUE)
}
