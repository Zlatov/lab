$(document).ready(function() {
    $("#toc").append('<p id="toc_">Оглавление</p><ul></ul>')

    // for (var h = 2; h <= 6; i++) {
    //     var header_selectror = 'h' + h
    //     $(header_selectror).each
    // }

    $("h2").each(function(i) {
        var current = $(this);
        current.attr("id", "h2" + i);
        $("#toc").children("ul").append("<li><a id='linkh2" + i + "' href='#h2" +
            i + "' title='" + (current.attr("title")||'') + "'>" +
            current.html() + '</a><ul></ul></li>');
    });
    $("h3").each(function(i) {
        var current = $(this);
        current.attr("id", "h3" + i);
        var prevh2 = current.prevAll("h2").first();
        var j = prevh2.attr("id").substring(2);
        $("#linkh2" + j).next("ul").append("<li><a id='linkh3" + i + "' href='#h3" +
            i + "' title='" + (current.attr("title")||'') + "'>" +
            current.html() + '</a><ul></ul></li>');
    });
    $("h4").each(function(i) {
        var current = $(this);
        current.attr("id", "h4" + i);
        var prevh3 = current.prevAll("h3").first();
        var j = prevh3.attr("id").substring(2);
        $("#linkh3" + j).next("ul").append("<li><a id='linkh4" + i + "' href='#h4" +
            i + "' title='" + (current.attr("title")||'') + "'>" +
            current.html() + '</a><ul></ul></li>');
    });
    $("h5").each(function(i) {
        var current = $(this);
        current.attr("id", "h5" + i);
        var prevh4 = current.prevAll("h4").first();
        var j = prevh4.attr("id").substring(2);
        $("#linkh4" + j).next("ul").append("<li><a id='linkh5" + i + "' href='#h5" +
            i + "' title='" + (current.attr("title")||'') + "'>" +
            current.html() + '</a><ul></ul></li>');
    });
    $("h6").each(function(i) {
        var current = $(this);
        current.attr("id", "h6" + i);
        var prevh5 = current.prevAll("h5").first();
        var j = prevh5.attr("id").substring(2);
        $("#linkh5" + j).next("ul").append("<li><a id='linkh6" + i + "' href='#h6" +
            i + "' title='" + (current.attr("title")||'') + "'>" +
            current.html() + '</a><ul></ul></li>');
    });
});


// $(function() {
//     var $affixElement = $('div[data-spy="affix"]');
//     $affixElement.width($affixElement.parent().width());
// });