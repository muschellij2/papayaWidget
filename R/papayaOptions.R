#' Options for Papaya Image
#'
#' @param alpha The overlay image alpha level (0 to 1).
#' @param icon Image url to use as the toolbar icon (rescaled to 18x18).
#' @param interpolation If true, image will have a smooth display
#' (default true).
#' @param lut The color table name (built-in or custom).
#' @param negative_lut The color table name (built-in or custom)
#' used by the negative side of the parametric pair.
#' @param max The display range maximum.
#' @param maxPercent The display range maximum as a percentage of
#' image max.
#' @param min The display range minimum.
#' @param minPercent The display range minimum as a percentage of
#' image max.
#' @param rotation An array of rotation degrees about each of the
#' three axes (e.g., [0,0,45] = 45 degree rotation about Z axis)
#' @param rotationPoint The point of rotation. Options are "center"
#' (default), "origin", or "crosshairs".
#' @param parametric If true, loads two views of the same image,
#' one in the positive and one in the negative range. (Also see
#' combineParametric.)
#' @param symmetric If true, sets the negative range of a parametric
#'  pair to the same size as the positive range.
#' @param ... additional arguments (not used)

#' @importFrom assertthat assert_that is.number is.flag is.string
#' @export
#' @examples
#' papayaOptions(alpha = 0.5)
#' papayaOptions()
#' papayaOptions(rotation = c(0, 0, 45),
#' parametric = TRUE, rotationPoint = "center")
papayaOptions = function(
  alpha = NULL,
  icon = NULL,
  interpolation = NULL,
  lut = NULL,
  negative_lut = NULL,
  max = NULL,
  maxPercent = NULL,
  min = NULL,
  minPercent = NULL,
  rotation = NULL,
  rotationPoint = NULL,
  parametric = NULL,
  symmetric = NULL) {

  L = list(
    alpha = alpha,
    icon = icon,
    interpolation = interpolation,
    lut = lut,
    negative_lut = negative_lut,
    max = max,
    maxPercent = maxPercent,
    min = min,
    minPercent = minPercent,
    rotation = rotation,
    rotationPoint = rotationPoint,
    parametric = parametric,
    symmetric = symmetric
  )
  L = validateOptions(L)
  return(L)
}

#' @rdname papayaOptions
#' @export
validateOptions = function(...) {
  L = as.list(...)
  L = nonull(L)
  if (length(L) == 0) {
    return(NULL)
  }

  nums = c("alpha",
           "max",
           "min")
  chars = c("icon",
            "lut",
            "negative_lut")
  logs = c("interpolation",
           "maxPercent",
           "minPercent",
           "parametric",
           "symmetric")

  rotation_opts = c("center", "origin", "crosshairs")
  if (!is.null(L$rotationPoint)) {
    L$rotationPoint = match.arg(
      L$rotationPoint, choices = rotation_opts)
  }


  l = L[names(L) %in% nums]
  for (i in seq_along(l)) {
    assert_that(is.number(l[[i]]))
  }

  if (!is.null(L$rotation)) {
    L$rotation = as.numeric(L$rotation)
    assert_that(length(L$rotation) == 3)
  }


  l = L[names(L) %in% chars]
  for (i in seq_along(l)) {
    assert_that(is.string(l[[i]]))
  }

  l = L[names(L) %in% logs]
  for (i in seq_along(l)) {
    assert_that(is.flag(l[[i]]))
    # JS {x: "true"} is not same as {x: true}
    # l[[i]] = tolower(as.character(l[[i]]))
  }
  L[names(L) %in% logs] = l
  return(L)
}
