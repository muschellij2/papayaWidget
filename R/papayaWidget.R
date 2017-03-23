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
papayaWidget <- function(img, width = NULL, height = NULL, elementId = NULL) {

  #################################
  # making into filenames
  img = neurobase::checkimg(img)
  # encoding - sapply allows for multiple
  img_str = sapply(img, base64enc::base64encode)

  # forward options using x
  # x = list(
  #   img_str = img_str)
  # making x empty because hack
  x = list(img_str = "")

  ################################
  # Making names for JS vars
  ################################
  n_images = length(img_str)
  img_names = names(img_str) = paste0("sample_image", seq(n_images))

  ################################
  # pasting together
  ################################
  eimages = paste0("'", img_names, "'")
  ################################
  # if multiple - then [['sample1'], ['sample2']]
  # otherwise ['sample']
  ################################
  if (n_images > 1) {
    eimages = paste0("[", eimages, "]")
    eimages = paste(eimages, collapse = ", ")
  }
  ################################
  # setting params
  ################################
  fake_js = paste0("var params = {encodedImages: [", eimages, "]};")

  ################################
  # make a fake dependency
  # give the javascript and a name for the lib
  ################################
  make_fake_dep = function(input_js, jsname = "fake-js") {
    tdir = tempfile(fileext = ".js")
    dir.create(tdir, showWarnings = FALSE)
    tfile = file.path(tdir, paste0(jsname, ".js"))
    writeLines(input_js, tfile)
    fake_dep = htmltools::htmlDependency(name = jsname,
                                         version = "1.0",
                                         src = dirname(tfile),
                                         script = basename(tfile))
  }

  ################################
  # fake dep for params
  ################################
  fake_dep = make_fake_dep(fake_js, jsname = "fake-js")

  ################################
  # make a file with all the data
  ################################
  fake_data_js = mapply(function(data, name) {
    paste0('var ', name, '="', data, '";')
  }, img_str, names(img_str))
  fake_data_dep = make_fake_dep(fake_data_js, jsname = "fake-data-js")




  # add dependencies for jquery
  deps <- list(
    rmarkdown::html_dependency_jquery()
  )
  ########################################
  # add the hack for params and data
  ########################################
  if (!is.null(fake_dep)) {
    deps = c(deps, list(fake_dep))
  }
  if (!is.null(fake_data_dep)) {
    deps = c(deps, list(fake_data_dep))
  }



  # create widget
  htmlwidgets::createWidget(
    name = 'papayaWidget',
    x,
    width = width,
    height = height,
    package = 'papayaWidget',
    elementId = elementId,
    dependencies = deps
  )
}

papayaWidget_html <- function(id, style, class, ...){
  tags$div(id = id,
           class = paste('papaya', class),
           `data-params` = "params")
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
