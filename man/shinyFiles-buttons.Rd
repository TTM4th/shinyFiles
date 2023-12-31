% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filechoose.R, R/dirchoose.R, R/filesave.R
\name{shinyFiles-buttons}
\alias{shinyFiles-buttons}
\alias{shinyFilesButton}
\alias{shinyFilesLink}
\alias{shinyDirButton}
\alias{shinyDirLink}
\alias{shinySaveButton}
\alias{shinySaveLink}
\title{Create a button to summon a shinyFiles dialog}
\usage{
shinyFilesButton(
  id,
  label,
  title,
  multiple,
  buttonType = "default",
  class = NULL,
  icon = NULL,
  style = NULL,
  viewtype = "detail",
  ...
)

shinyFilesLink(
  id,
  label,
  title,
  multiple,
  class = NULL,
  icon = NULL,
  style = NULL,
  viewtype = "detail",
  ...
)

shinyDirButton(
  id,
  label,
  title,
  buttonType = "default",
  class = NULL,
  icon = NULL,
  style = NULL,
  ...
)

shinyDirLink(id, label, title, class = NULL, icon = NULL, style = NULL, ...)

shinySaveButton(
  id,
  label,
  title,
  filename = "",
  filetype,
  buttonType = "default",
  class = NULL,
  icon = NULL,
  style = NULL,
  viewtype = "detail",
  ...
)

shinySaveLink(
  id,
  label,
  title,
  filename = "",
  filetype,
  class = NULL,
  icon = NULL,
  style = NULL,
  viewtype = "detail",
  ...
)
}
\arguments{
\item{id}{The id matching the \code{\link[=shinyFileChoose]{shinyFileChoose()}}}

\item{label}{The text that should appear on the button}

\item{title}{The heading of the dialog box that appears when the button is
pressed}

\item{multiple}{A logical indicating whether or not it should be possible to
select multiple files}

\item{buttonType}{The Bootstrap button markup used to colour the button.
Defaults to 'default' for a neutral appearance but can be changed for another
look. The value will be pasted with 'btn-' and added as class.}

\item{class}{Additional classes added to the button}

\item{icon}{An optional \href{https://shiny.rstudio.com/reference/shiny/latest/icon.html}{icon} to appear on the button.}

\item{style}{Additional styling added to the button (e.g., "margin-top: 25px;")}

\item{viewtype}{View type to use in the file browser. One of "detail" (default), "list", or "icon"}

\item{...}{Named attributes to be applied to the button or link (e.g., 'onclick')}

\item{filename}{A predefined filename to be filed in. Can be modified by the
user during saving.}

\item{filetype}{A named list of file extensions. The name of each element
gives the name of the filetype and the content of the element the possible
extensions e.g. \code{list(picture=c('jpg', 'jpeg'))}. The first extension
will be used as default if it is not supplied by the user.}
}
\value{
This function is called for its side effects
}
\description{
This function adds the required html markup for the client to access the file
system. The end result will be the appearance of a button on the webpage that
summons one of the shinyFiles dialog boxes. The last position in the file
system is automatically remembered between instances, but not shared between
several shinyFiles buttons. For a button to have any functionality it must
have a matching observer on the server side. shinyFilesButton() is matched
with shinyFileChoose() and shinyDirButton with shinyDirChoose(). The id
argument of two matching calls must be the same. See
\code{\link[=shinyFiles-observers]{shinyFiles-observers()}} on how to handle client input on the
server side.
}
\details{
\strong{Selecting files}

When a user selects one or several files the corresponding input variable is
set to a list containing a character vector for each file. The character
vectors gives the traversal route from the root to the selected file(s). The
reason it does not give a path as a string is that the client has no
knowledge of the file system on the server and can therefore not ensure
proper formatting. The \code{\link[=parseFilePaths]{parseFilePaths()}} function can be used on
the server to format the input variable into a format similar to that
returned by \code{\link[shiny:fileInput]{shiny::fileInput()}}.

\strong{Selecting folders}

When a folder is selected it will also be available in its respective input
variable as a list giving the traversal route to the selected folder. To
properly format it, feed it into \code{\link[=parseDirPath]{parseDirPath()}} and a string with
the full folder path will be returned.

\strong{Creating files (saving)}

When a new filename is created it will become available in the respective
input variable and can be formatted with \code{\link[=parseSavePath]{parseSavePath()}} into a
data.frame reminiscent that returned by fileInput. There is no size column
and the type is only present if the filetype argument is used in
\code{shinySaveButton}. In that case it will be the name of the chosen type
(not the extension).

\strong{Manual markup}

For users wanting to design their html markup manually it is very easy to add
a shinyFiles button. The only markup required is:

\emph{shinyFilesButton}

\verb{<button id="inputId" type="button" class="shinyFiles btn btn-default" data-title="title" data-selecttype="single"|"multiple">label</button>}

\emph{shinyDirButton}

\verb{<button id="inputId" type="button" class="shinyDirectories btn-default" data-title="title">label</button>}

\emph{shinySaveButton}

\code{<button id="inputId" type="button" class="shinySave btn-default" data-title="title" data-filetype="[{name: 'type1', ext: ['txt']}, {name: 'type2', ext: ['exe', 'bat']}]">label</button>}

where the id tag matches the inputId parameter, the data-title tag matches
the title parameter, the data-selecttype is either "single" or "multiple"
(the non-logical form of the multiple parameter) and the internal textnode
matches the label parameter. The data-filetype tag is a bit more involved as
it is a json formatted array of objects with the properties 'name' and 'ext'.
'name' gives the name of the filetype as a string and 'ext' the allowed
extensions as an array of strings. The non-exported
\code{\link[=formatFiletype]{formatFiletype()}} function can help convert from a named R list
into the string representation. In the example above "btn-default" is used as
button styling, but this can be changed to any other Bootstrap style.

Apart from this the html document should link to a script with the
following path 'sF/shinyFiles.js' and a stylesheet with the following path
'sF/styles.css'.

The markup is bootstrap compliant so if the bootstrap css is used in the page
the look will fit right in. There is nothing that hinders the developer from
ignoring bootstrap altogether and designing the visuals themselves. The only
caveat being that the glyphs used in the menu buttons are bundled with
bootstrap. Use the css ::after pseudoclasses to add alternative content to
these buttons. Additional filetype specific icons can be added with css using
the following style:

\preformatted{
.sF-file .sF-file-icon .yourFileExtension{
    content: url(path/to/16x16/pixel/png);
}
.sF-fileList.sF-icons .sF-file .sF-file-icon .yourFileExtension{
  content: url(path/to/32x32/pixel/png);
}
}

If no large version is specified the small version gets upscaled.

\strong{Client side events}

If the shiny app uses custom Javascript it is possible to react to selections
directly from the javascript. Once a selection has been made, the button will
fire the event 'selection' and pass the selection data along with the event.
To listen for this event you simple add:

\preformatted{
$(button).on('selection', function(event, path) {
  // Do something with the paths here
})
}

In the same way, when a file is saved, the save button will fire the event
'save' and pass the file path along with the event. To listen for this event
you can use:

\preformatted{
$(button).on('save', function(event, path) {
  // Do something with the path here
})
}

Moreover, a 'cancel' event is fired when a user dismisses a ShinyFiles dialog
box. In that case, no path is passed on.

Outside events the current selection is available as an object bound to the
button and can be accessed at any time:

\preformatted{
// For a shinyFilesButton
$(button).data('files')

// For a shinyDirButton
$(button).data('directory')

// For a shinySaveButton
$(button).data('file')
}
}
\references{
The file icons used in the file system navigator is taken from
FatCows Farm-Fresh Web Icons (\url{https://www.fatcow.com/free-icons})
}
\seealso{
Other shinyFiles: 
\code{\link{shinyFiles-observers}},
\code{\link{shinyFiles-parsers}},
\code{\link{shinyFilesExample}()}
}
\concept{shinyFiles}
