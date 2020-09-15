#'@name datalistInput
#'@title datalistInput
#'@description Creates an autocomplete input
#'@param inputId Input id
#'@param datalistId Datalist id
#'@param label Input label
#'@param options Vector of autocomplete options
#'@export
datalistInput <- function(inputId, datalistId, label, options = c()) {
  addResourcePath(prefix = "lib", directoryPath = system.file("lib", package = "rdatalist"))
  tagList(
    singleton(tags$head(
      tags$script(src="lib/datalist-binding.js")
    )),
    div(id=inputId,
        class="form-group datalist",
        `data-options`=jsonlite::toJSON(options),
        tags$label(label),
        tags$input(class="form-control", type="text", list=datalistId),
        tags$datalist(id=datalistId)
    )
  )
}

#' @name updateDatalistInput
#' @title updateDatalistInput
#' @description Update datalist input options
#' @export
updateDatalistInput <- function(session, inputId, options=c()) {
  message <- list(options=options)
  session$sendInputMessage(inputId, message)
}
