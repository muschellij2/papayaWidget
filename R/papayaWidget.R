#' @param img Vector of character file names or list of \code{nifti} images
#' @param elementId ID for the element in the DOM
#' @param width Width of the widget
#' @param height height of the widget
#' @param options to pass to papaya widget.  Should be a list with
#' the same number of elements as images passed in.  Options can
#' be generated using \code{\link{papayaOptions}}
#' @param sync_view should the view be synced to other Papaya viewers?
#' @param hide_toolbar Hide the toolbar for this viewer?
#' @param hide_controls Hide the controls (increment) for this viewer?
#' @param orthogonal Should an orthogonal view be displayed (\code{TRUE})
#' versus just a slice (\code{FALSE}).
#' @param interpolation Should smoothing/interpolation be done in the viewer?
#' This can be overridden if individual image options set \code{interpolation}
#' as well
#' @param title the title for the overlay itself
#' @title Creating a Papaya widget
#'
#' @description Wraps a widget for the Papaya JavaScript library
#'
#' @import htmlwidgets
#'
#' @export
#' @importFrom neurobase checkimg
#' @importFrom base64enc base64encode
#' @importFrom jsonlite toJSON
#' @examples
#' papaya(interpolation = TRUE)
#' papaya(interpolation = FALSE)
#'
#' img = kirby21.t1::get_t1_filenames()[1]
#'
#' papaya(img, options = papayaOptions(min = 0, max = 8e5))
#' papaya(c(img, img),
#' options = list(papayaOptions(alpha = 0.5),
#' papayaOptions(alpha = 0.5, lut = "Red Overlay"))
#' )
#'
#' \dontrun{
#' papaya(img, options = papayaOptions(min = 0, max = 8e5))
#' papaya(c(img, img),
#' options = list(papayaOptions(alpha = 0.5),
#' papayaOptions(alpha = 0.5, lut = "Red Overlay"))
#' )
#' nii = neurobase::readnii(img)
#' nii = nii < 3e5 & nii > 1e5
#' papaya(list(img, nii), options = list(list(), papayaOptions(interpolation = FALSE)))
#' }
#'
papaya <- function(
  img = NULL,
  elementId = NULL,
  width = NULL, height = NULL,
  options = NULL,
  sync_view = FALSE,
  hide_toolbar = FALSE,
  hide_controls = FALSE,
  orthogonal = TRUE,
  interpolation = TRUE,
  title = NULL
  # options = papayaOptions()) {
){
  #
  image_names = title
  if (!is.null(img)) {
    img = checkimg(img, allow_array = TRUE)
    image_names = sapply(img, function(x) {
      basename(tempfile(pattern = "img_"))
    })
    image_names = unname(image_names)
    if (!is.null(title) && is.character(title)) {
      title = unname(paste(title, collapse = " "))
      image_names[[length(image_names)]] = title
    }
    fileData = sapply(img, base64enc::base64encode)
    fileData <- jsonlite::toJSON(fileData)
  } else {
    fileData = NULL
    if (!is.null(title)) {
      warning("title doesn't work if no images were given")
    }
  }
  if (is.null(elementId)) {
    elementId = basename(tempfile())
  }
  if (!is.null(options)) {
    n_options = length(options)
    n_imgs = length(img)
    if (n_imgs > 1) {
      assert_that(n_options == n_imgs)
    } else {
      options = list(options)
    }
    # options = fileData <- jsonlite::toJSON(fileData)
  }

  x <- list(
    index = 0,
    id = elementId,
    images = fileData,
    options = options,
    ignore_sync = !sync_view,
    hide_toolbar = hide_toolbar,
    show_controls = !hide_controls,
    orthogonal = orthogonal,
    interpolation = interpolation
  )
  x$image_names = image_names


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
#' @examples
#' file = system.file("examples", "kirby21.R", package = "papayaWidget")
#' if (requireNamespace("shiny", quietly = TRUE) &&
#'     file.exists(file)) {
#'    app = source(file)
#' }
#' papayaOutput("random_id")
papayaOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, "papayaWidget", width,
                                 height, package = "papayaWidget")
}

#' @rdname papayaWidget-shiny
#' @export
#' @examples
#' renderPapaya({papaya()})
renderPapaya <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, papayaOutput, env, quoted = TRUE)
}
