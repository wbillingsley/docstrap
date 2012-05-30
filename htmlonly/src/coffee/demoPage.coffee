
repositionEditor = () ->
    h = $(".editControls").css("height")
    $("#editor").css("margin-top", h)

theEditor = null

hookEditor = (sel) ->
    theEditor = new Docstrap.Editor(sel)
    window.theEditor = theEditor

$(window).resize(() -> repositionEditor())
$(document).ready(() -> 
	repositionEditor()
	$("#editTools").tab()
	hookEditor("#editor")
)