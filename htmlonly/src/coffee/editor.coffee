root = exports ? this

class Editor
    constructor: (@selector) ->

    #----- The basics -----#

    justifyLeft: () ->
        document.execCommand('justifyLeft', false, "")

    justifyCenter: () ->
        document.execCommand('justifyCenter', false, "")

    justifyRight: () ->
        document.execCommand('justifyRight', false, "")

    bold: () ->
        document.execCommand('bold', false, "")

    italic: () ->
        document.execCommand('italic', false, "")

    underline: () ->
        document.execCommand('underline', false, "")

    strikeThrough: () ->
        document.execCommand('strikeThrough', false, "")

    subscript: () ->
        document.execCommand('subscript', false, "")

    superscript: () ->
        document.execCommand('superscript', false, "")

    removeFormat: () ->
        document.execCommand('removeFormat', false, "")

    indent: () ->
        document.execCommand('indent', false, "")

    outdent: () ->
        document.execCommand('outdent', false, "")

    insertOrderedList: () ->
        document.execCommand('insertOrderedList', false, "")

    insertUnorderedList: () ->
        document.execCommand('insertUnorderedList', false, "")


    #---- show source ----#

    showSource: () ->
        window.alert($(@selector).html())

    toggleMarkup: () ->
        el = $(@selector)
        if(el.hasClass("showMarkup"))
            el.removeClass("showMarkup")
        else
            el.addClass("showMarkup")

    #---- Formatting ----#

    formatBlock: (blockEl) ->
        document.execCommand('formatBlock', false, blockEl)

    insertHTML: (html) ->
        document.execCommand('insertHTML', true, html)

    insertMyTemplate: (el) ->
        html = $(el).find(".template").html().toString().trim()
        console.log(html)
        #this.pasteHtmlAtCaret(html)
        v = document.execCommand('insertHTML', false, html)
        console.log(v)


    pasteHtmlAtCaret: (html) ->
        if (window.getSelection)
            # IE9 and non-IE
            sel = window.getSelection();
            if (sel.getRangeAt && sel.rangeCount)
                range = sel.getRangeAt(0);
                range.deleteContents();

                # Range.createContextualFragment() would be useful here but is
                # non-standard and not supported in all browsers (IE9, for one)
                el = document.createElement("div");
                el.innerHTML = html;
                frag = document.createDocumentFragment()
                while ( (node = el.firstChild) )
                    lastNode = frag.appendChild(node);

                range.insertNode(frag);

                #Preserve the selection
                if (lastNode)
                    range = range.cloneRange();
                    range.setStartAfter(lastNode);
                    range.collapse(true);
                    sel.removeAllRanges();
                    sel.addRange(range);
        else if (document.selection && document.selection.type != "Control")
            #IE < 9
            document.selection.createRange().pasteHTML(html);


Docstrap = 
    Editor: Editor

root.Docstrap = Docstrap


