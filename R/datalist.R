#'@name datalist
#'@title datalist
#'@description Creates an autocomplete input
#'@param inputId Input id
#'@param datalistId Datalist id
#'@param label Input label
#'@param options Vector of autocomplete options
#'@export
datalist <- function(inputId, datalistId, label, options = c()) {
  addResourcePath(prefix = "lib", directoryPath = system.file("lib", package = "rdatalist"))
  tagList(
    singleton(tags$head(
      tags$script(src="lib/datalist-binding.js")
    )),
    div(id=inputId, class="form-group datalist",
        tags$label(label),
        tags$input(class="form-control", type="text", list=datalistId),
        tags$datalist(id=datalistId,
          lapply(options, function(option) {
            tags$option(value=option)
          }))
        )
  )
}
