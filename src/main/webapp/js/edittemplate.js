
/**********  common - begin   *************/

function GetCheckItems() {
    _CheckItems = new Array();
    var checkItems = $(".check_item");
    if (checkItems.length > 0) {
        checkItems.each(function () {
            var o = new Object();
            o.ctrl = this;
            _CheckItems.push(o);
        });
    }
    else {
        if (_ActiveItem != null) {
            var o = new Object();
            o.ctrl = _ActiveItem;
            _CheckItems.push(o);
        }
    }
}

function ShowNotice() {
    _ShowFloatFrame("notice.aspx", "400px", "300px");
}

/**********  top - begin   *************/

var colText = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

function MarkRule(headRow, colCount) {
    var cells = headRow.children();

    for (var i = 0; i < colCount; i++) {

        if (i == 0) {

            $(cells[i]).text("1-A").css("text-align", "center");
        }
        else if (i >= 26 * 26) {
            return;
        }
        else {
            var mIndex = parseInt(i / 26);
            var cIndex = parseInt(i % 26);

            var c = colText.substr(cIndex, 1);
            if (mIndex > 0) {
                c = colText.substr(mIndex - 1, 1) + c;
            }
            $(cells[i]).text(c + ' ').addClass("l_h");
        }
    }
}

var _PrintRange = new Object();
_PrintRange.width = 1;
_PrintRange.height = 1;

function PrintRange(page_width, page_height) {
    _PrintRange.width = page_width;
    _PrintRange.height = page_height;

    var page = $(".page");
    var bgColor = $(".bg_color");

    page.outerWidth(page_width + 'cm');
    page.outerHeight(page_height + 'cm');

    bgColor.outerWidth(page_width + 'cm');
    bgColor.outerHeight(page_height + 'cm');

    $(".header_page,.footer_page").css("width", page_width + "cm");
    $(".footer_page").css("top", page_height - $("#footer_page_height").val() + "cm");

    SetPageLine();
}

function CreateLineRow(lineTable, colCount) {
    var row = $("<tr></tr>").appendTo(lineTable);
    for (var i = 0; i < colCount; i++) {
        $("<td class='line_cell'></td>").appendTo(row);
    }

    return row;
}

function ParseCtrlBarcodeType(ctrl) {
    var setCtrl = GetSetCtrl(ctrl);
    var btype = $(setCtrl).attr("btype");
    $("#btype").val(btype);
}

function ParseCtrlSize(ctrl) {
    var setCtrl = GetSetCtrl(ctrl);
    var width = $(setCtrl).css("width");
    var height = $(setCtrl).css("height");
    $("#item_width").val(parseFloat(width));
    $("#item_height").val(parseFloat(height));
}

function ParseCtrl(ctrl) {
    for (var i = 0; i < _CtrlItems.length; i++) {
        var item = _CtrlItems[i];

        if (item.ctrl == ctrl) {
            $("#ctrlitems").val(item.val);
        }
    }
}

function ParseCtrlOpacity(ctrl) {
    var setCtrl = GetSetCtrl(ctrl);
    var opacity = $(setCtrl).css("opacity");
    $("#opacity").val(opacity);
}

function ParseCtrlFont(ctrl) {
    var setCtrl = GetSetCtrl(ctrl);
    var font = $(setCtrl).css("font-family");
    if (font.replace('"', '').replace('"', '') == "Fifty Trial") {
        font = "Fifty Trial";
    }
    $("#font").val(font);
    $("#font_size").val($(setCtrl).css("font-size"));

}

function ParseCtrlCss(ctrl) {
    var setCtrl = GetSetCtrl(ctrl);
    var of = $(setCtrl).css("overflow");
    var wordbreak = $(setCtrl).css("word-break");
    if (wordbreak != "break-all" && of == "visible") {
        of = "";
    }
    $("#overflow_type").val(of);

    var z = $(setCtrl).css("zoom");

    if (z) {
        $("#zoom").val(z);
    }
    else {
        $("#zoom").val("1");
    }
}

/***  multiple  ***/

function SetFont() {
    GetCheckItems();
    var font = $("#font").val();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        $(setCtrl).css("font-family", font);
    }
}

function SetFontSize() {
    GetCheckItems();
    var fontSize = $("#font_size").val();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        $(setCtrl).css("font-size", fontSize);
    }
}

function SetAntiColor() {
    GetCheckItems();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        $(setCtrl).css({
            "color": "#ffffff",
            "background-color": "#000000"
        });
    }
}


function SetAlign(align) {
    GetCheckItems();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        $(setCtrl).css("text-align", align);
    }
}

function SetDocAlign(align) {
    GetCheckItems();
    var hasItemList = false;
    NeedItems = new Array();
    for (var i = 0; i < _CheckItems.length; i++) {
        var itemCtrl = _CheckItems[i].ctrl;
        if ($(itemCtrl).tagname() == "TD") {
            if (hasItemList) {
                continue;
            }
            else {
                hasItemList = true;
                itemCtrl = $(".item_list");
            }
        }
        var o = new Object();
        o.ctrl = itemCtrl;
        o.top = parseInt($(itemCtrl).css("top"));
        o.left = parseInt($(itemCtrl).css("left"));
        o.width = $(itemCtrl).outerWidth();
        o.height = $(itemCtrl).outerHeight();
        o.right = o.left + o.width;
        o.bottom = o.top + o.height;
        NeedItems.push(o);

    }
    if (NeedItems.length == 0) {
        return;
    }

    switch (align) {
        case "left":
            DocLeftAlign(NeedItems);
            break;
        case "vertical":
            DocVerticalAlign(NeedItems);
            break;
        case "right":
            DocRightAlign(NeedItems);
            break;
        case "top":
            DocTopAlign(NeedItems);
            break;
        case "center":
            DocCenterAlign(NeedItems);
            break;
        case "bottom":
            DocBottomAlign(NeedItems);
            break;
    }
}

function DocLeftAlign(needItems) {
    var minleft = 0;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];

        if (i == 0) {
            minleft = item.left;
        }
        if (minleft > item.left) {
            minleft = item.left;
        }
    }
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        $(item.ctrl).css("left", minleft);
    }
}

function DocVerticalAlign(needItems) {
    var minleft = 0;
    var maxright = 0

    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];

        if (i == 0) {
            minleft = item.left;
            maxright = item.right;
        }
        if (minleft > item.left) {
            minleft = item.left;
        }
        if (maxright < item.right) {
            maxright = item.right;
        }
    }
    var vertical = minleft + (maxright - minleft) / 2;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        var left = vertical - (item.width / 2);
        $(item.ctrl).css("left", left);
    }
}

function DocRightAlign(needItems) {
    var maxright = 0;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];

        if (i == 0) {
            maxright = item.right;
        }
        if (maxright < item.right) {
            maxright = item.right;
        }
    }

    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        var left = maxright - item.width;
        $(item.ctrl).css("left", left);
    }
}

function DocTopAlign(needItems) {
    var mintop = 0;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        if (i == 0) {
            mintop = item.top;
        }
        if (mintop > item.top) {
            mintop = item.top;
        }
    }
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        $(item.ctrl).css("top", mintop);
    }
}

function DocCenterAlign(needItems) {
    var mintop = 0;
    var maxbottom = 0;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];

        if (i == 0) {
            mintop = item.top;
            maxbottom = item.bottom;
        }
        if (mintop > item.top) {
            mintop = item.top;
        }
        if (maxbottom < item.bottom) {
            maxbottom = item.bottom;
        }
    }

    var center = mintop + (maxbottom - mintop) / 2;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        var top = center - (item.height / 2);
        $(item.ctrl).css("top", top);
    }

}

function DocBottomAlign(needItems) {
    var maxbottom = 0;
    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];

        if (i == 0) {
            maxbottom = item.bottom;
        }
        if (maxbottom < item.bottom) {
            maxbottom = item.bottom;
        }
    }

    for (var i = 0; i < needItems.length; i++) {
        var item = needItems[i];
        var top = maxbottom - item.height;
        $(item.ctrl).css("top", top);
    }
}

function SetOverflow() {
    GetCheckItems();
    var of = $("#overflow_type").val();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        if (of == "hidden") {
            $(setCtrl).css("overflow", "hidden").width($(setCtrl).width()).height($(setCtrl).height()).css("word-break", "normal");
            if ($(setCtrl).hasClass("_fitem_pattern")) {
                $(setCtrl).css("white-space", "nowrap");
            }
        }
        else if (of == "visible") {
            $(setCtrl).css("overflow", "visible").css("word-break", "break-all");
        }
        else {
            $(setCtrl).css("overflow", "").css("word-break", "normal");
            if ($(setCtrl).hasClass("_fitem_pattern")) {
                $(setCtrl).css("white-space", "nowrap");
            }
        }
    }
}

function SetItemWidth() {
    GetCheckItems();
    var width = parseFloat($("#item_width").val());
    for (var i = 0; i < _CheckItems.length; i++) {
        var itemCtrl = _CheckItems[i].ctrl;
        //var setCtrl = GetSetCtrl(itemCtrl);
        if ($(itemCtrl).tagname() == "TD") {
            var cellIndex = $(itemCtrl).prevAll().length;
            var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
            if (childrentagName != "img") {
                $(".item_head_tr").children().eq(cellIndex).outerWidth(width);
                $(".item_body_tr").children().eq(cellIndex).outerWidth(width);
                $(".item_body_tr").children().eq(cellIndex).children().outerWidth(width);
            }
        }
        else {
            $(itemCtrl).css("width", width);
        }
    }
}

function SetItemHeight() {
    GetCheckItems();
    var height = parseFloat($("#item_height").val());
    for (var i = 0; i < _CheckItems.length; i++) {
        var itemCtrl = _CheckItems[i].ctrl;
        //var setCtrl = GetSetCtrl(itemCtrl);
        if ($(itemCtrl).tagname() == "TD") {
            var cellIndex = $(itemCtrl).prevAll().length;
            var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
            if (childrentagName != "img") {
                $(itemCtrl).parent().outerHeight(height);
                $(itemCtrl).parent().find("div").outerHeight(height);
            }
        }
        else {
            $(itemCtrl).css("height", height);
        }
    }
}

var _CtrlItems = new Array();

function InitCtrlItems() {
    $("#dateitems").empty();
    var html = "<option value='-1'>标签选择</option>";
    $(".dataitem,.item_head,.item_body").each(function (index) {
        if ($(this).hasClass("header_page") || $(this).hasClass("footer_page")) {
            return;
        }
        _CtrlItems.push(
            {
                val: index,
                ctrl: this
            });
        var text = $(this).text() || "无命名标签";
        var item = "<option value='" + index + "'>" + text + "</option>";
        html += item;
    });

    $("#ctrlitems").html(html);
}

function InitEditItems(init) {

    var header_footer = $.parseJSON($("#header_footer").html());

    if (init && header_footer != null) {
        $(".page").append(header_footer.header);
        $(".page").append(header_footer.footer);
    }

    var items = "<option value='body'>正文</option>";

    if ($(".dataitem").hasClass("header_page")) {
        items += "<option value='header_page'>页眉</option>";
    }

    if ($(".dataitem").hasClass("footer_page")) {
        items += "<option value='footer_page'>页脚</option>";
    }

    $("#editctrls").html(items);
}

function SelectCtrl() {
    var val = $("#ctrlitems option:selected").val();
    if (val == -1) {
        $(".active").removeClass("active").removeClass("check_item");
        return;
    }
    for (var i = 0; i < _CtrlItems.length; i++) {
        if (val == _CtrlItems[i].val) {
            $(_CtrlItems[i].ctrl).trigger("click");
        }
    }
}

var CurrentPage = "page";

function SelectEditCtrl() {
    var val = $("#editctrls option:selected").val();
    $(".active").removeClass("active").removeClass("check_item");
    //$(".active_header,.active_footer").removeClass("active_header").removeClass("active_footer").removeClass("check_item");
    if (val == "header_page") {
        $(".header_page").addClass("active check_item");
        CurrentPage = "header_page";
    }
    else if (val == "footer_page") {
        $(".footer_page").addClass("active check_item");
        CurrentPage = "footer_page";
    }
    else {
        CurrentPage = "page";
    }
}

/***  single  ***/

function SetStraight() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);
        var s = $(setCtrl).attr("_c");
        if (typeof (s) != "undefined") {
            $(setCtrl).removeAttr("_c");
            $(setCtrl).css("white-space", "");
            $(setCtrl).css("overflow", "");
            $(setCtrl).css("text-overflow", "");
            $(setCtrl).css("display", "");
            $.msg("已取消不换行!")
        }
        else {
            $(setCtrl).attr("_c", "s");
            $(setCtrl).css("white-space", "nowrap");
            $(setCtrl).css("overflow", "hidden");
            $(setCtrl).css("text-overflow", "ellipsis");
            $(setCtrl).css("display", "block");
            $.msg("已添加不换行!")
        }
    }
}

function SetB() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(setCtrl).css("font-weight") == "bold" || $(setCtrl).css("font-weight") == "700") {
            $(setCtrl).css("font-weight", "");
        }
        else {
            $(setCtrl).css("font-weight", "700");
        }
    }
}

function SetI() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(setCtrl).css("font-style") != "normal") {
            $(setCtrl).css("font-style", "");
        }
        else {
            $(setCtrl).css("font-style", "oblique");

        }
    }
}

function SetU() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(setCtrl).css("text-decoration").indexOf("underline") != -1) {
            $(setCtrl).css("text-decoration", "");
        }
        else {
            $(setCtrl).css("text-decoration", "underline");
        }
    }
}

function SetText() {

    if (_ActiveItem != null) {
        var text = GetCtrlText(_ActiveItem);
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(setCtrl).tagname() == "IMG") {

            var item = $("<div></div>").text(text).attr("class", $(setCtrl).attr("class")).removeClass("barcode").removeClass("withtext").removeClass("qrcoder").removeClass("img").addClass("text").attr("style", $(setCtrl).attr("style")).mousemove(function (e) {
                ItemMove(e, this);
            }).mousedown(function (e) {
                return ItemDown(e, this);
            }).click(function (e) {
                ItemClick(this, e);
            });
            $(setCtrl).parent().append(item);

            setCtrl.remove();
            ActiveCtrl(item);
        }
        else if ($(_ActiveItem).attr("class").indexOf("barcode") != -1) {
            $(setCtrl).removeClass("barcode withtext");
            $(setCtrl).text(text);
        }
    }
    //SetUnDragImg();
}

function SetPic() {

    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(_ActiveItem).tagname() != "IMG") {
            var text = GetCtrlText(_ActiveItem);
            //$("<img />").attr("src", text.replace("*", "×"))
            var item = $("<img />").attr("src", "css/timg.jpg").attr("class", $(setCtrl).attr("class")).removeClass("barcode").removeClass("withtext").removeClass("qrcoder").removeClass("text").addClass("img").attr("style", $(setCtrl).attr("style")).mousemove(function (e) {
                ItemMove(e, this);
            }).mousedown(function (e) {
                return ItemDown(e, this);
            }).click(function (e) {
                ItemClick(this, e);
            });
            $(setCtrl).parent().append(item);

            setCtrl.remove();
            ActiveCtrl(item);
        }
        else {
            var text = GetCtrlText(_ActiveItem);
            $(setCtrl).attr("src", text).removeClass("barcode").removeClass("withtext").removeClass("qrcoder").removeClass("text").addClass("img").width("").height("");
        }
    }
    //SetUnDragImg();


}






function SetQRCode() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);

        if ($(setCtrl).tagname() != "IMG") {
            var text = GetCtrlText(_ActiveItem);

            var item = $("<img />").attr("src", "css/qrcode.png").attr("title", text).attr("class", $(setCtrl).attr("class")).removeClass("barcode").removeClass("withtext").removeClass("img").removeClass("text").addClass("qrcoder").attr("style", $(setCtrl).attr("style")).width("").height("").mousemove(function (e) {
                ItemMove(e, this);
            }).mousedown(function (e) {
                return ItemDown(e, this);
            }).click(function (e) {
                ItemClick(this, e);
            });
            $(setCtrl).parent().append(item);

            $(setCtrl).remove();
            ActiveCtrl(item);
        }
        else {
            var text = GetCtrlText(_ActiveItem);
            $(setCtrl).attr("src", "css/qrcode.png").removeClass("barcode").removeClass("withtext").removeClass("img").removeClass("text").addClass("qrcoder").width("").height("");
        }
    }
    ////SetUnDragImg();
}

function SetBarCode(type) {
	
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);
        $(setCtrl).css("font-family", "");
        var text = GetCtrlText(setCtrl);
        //if (text.indexOf("*") == -1)
        //{
        //    text = "*" + text + "*";
        //}

        if ($(setCtrl).tagname() == "IMG") {

            var item = $("<div></div>").text(text).attr("class", $(_ActiveItem).attr("class")).removeClass("text").removeClass("qrcoder").removeClass("withtext").removeClass("img").addClass("barcode").attr("style", $(_ActiveItem).attr("style")).mousemove(function (e) {
                ItemMove(e, this);
            }).mousedown(function (e) {
                return ItemDown(e, this);
            }).click(function (e) {
                ItemClick(this, e);

            });
            $(setCtrl).parent().append(item);

            setCtrl.remove();

            ActiveCtrl(item);
        }
        else {
            $(setCtrl).css("font-family", "").removeClass("text").removeClass("qrcoder").removeClass("img").removeClass("barcode").removeClass("withtext").addClass("barcode");
            if (type == "withtext") {
                $(setCtrl).addClass("withtext");
            }
            if (!$(setCtrl).attr("btype")) {
                $(setCtrl).attr("btype", "code128");
            }
        }
    }
}

function SetBorder(bool) {
    if (bool) {
        $(".item_list").attr("border", 1);
    }
    else {
        $(".item_list").attr("border", 0);
    }
}

function SetRotate() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);
        var _self = $(setCtrl);
        if (_self.hasClass("rotate90")) {
            _self.removeClass("rotate90");
            _self.addClass("rotate180");
            return;
        }
        if (_self.hasClass("rotate180")) {
            _self.removeClass("rotate180");
            _self.addClass("rotate270");
            return;
        }
        if (_self.hasClass("rotate270")) {
            _self.removeClass("rotate270");
            return;
        }
        _self.addClass("rotate90");
    }
}

function SetBarcodeRotate() {
    if (_ActiveItem != null) {
        var setCtrl = $(GetSetCtrl(_ActiveItem));
        var style = setCtrl.attr("class");
        if (style.indexOf("img") > -1 || style.indexOf("qrcoder") > -1 || style.indexOf("line") > -1) {
            $.msg("必须先设定条码对象或者文本对象");
            return;

        }
        else {
            SetRotate();
        }
    }
    else {
        $.msg("必须先设定条码对象或者文本对象");
    }
}

function SetBarcodeType() {
    if (_ActiveItem != null) {
        var setCtrl = $(GetSetCtrl(_ActiveItem));
        if (setCtrl.attr("class").indexOf("barcode") > -1 || setCtrl.attr("class").indexOf("withtext") > -1) {
            var val = $("#btype").val();
            setCtrl.attr("btype", val);
            if (val == "ean13") {
                $.msg("选择右侧【EAN-13码】打印项并且值也是13位EAN-13码才能正常使用哦");
            }
        }
        else {
            $.msg("必须先设定条码对象");
            return;
        }
    }
    else {
        $.msg("必须先设定条码对象");
    }
}

function SetOpacity() {
    if (_ActiveItem != null) {
        var setCtrl = $(GetSetCtrl(_ActiveItem));
        if (setCtrl.hasClass("barcode") || $(setCtrl).tagname() == "IMG") {
            $.msg("必须先设定文本对象");
            return;
        }
        var val = $("#opacity").val();
        setCtrl.css("opacity", val);
    }
    else {
        $.msg("必须先设定文本对象");
    }
}

function SetPageLine() {
    var pageLine = $("#page_line");

    if (!$("#print_line").prop("checked")) {
        pageLine.hide();
        return;
    }
    pageLine.show();

    pageLine.css("width", _PrintRange.width + 'cm');
    pageLine.css("height", _PrintRange.height + 'cm');

    var lineTable = $("#line_table");
    var colCount = parseInt(_PrintRange.width + 1);
    var rowCount = parseInt(_PrintRange.height + 1);

    lineTable.css("width", colCount + "cm");
    lineTable.css("height", rowCount + "cm");

    lineTable.empty();

    var headRow = CreateLineRow(lineTable, colCount);
    MarkRule(headRow, colCount);
    for (var i = 1; i < rowCount; i++) {
        var bodyRow = CreateLineRow(lineTable, colCount);
        $(bodyRow.children()[0]).text(i + 1).addClass("l_b");
    }
}

function SetShowBg() {
    var pageLine = $("#show_bg");
    var bg = $(".bg");
    if (!$("#show_bg").prop("checked")) {
        bg.hide();
    }
    else {
        bg.show();
    }
}

var isSelectAll = false;

function SelectAll() {
    var ctrl = $("#selectall");
    if ($(ctrl).prop("checked")) {
        isSelectAll = true;
        $(".dataitem, .item_head, .item_body").addClass("check_item");
    }
    else {
        isSelectAll = false;
        $(".check_item, .active").removeClass("check_item").removeClass("active");
    }
}

function SetSelectAll(all) {
    if (all) {
        isSelectAll = true;
        $("#selectall").prop("checked", true);
        $(".dataitem, .item_head, .item_body").addClass("check_item");
    }
    else {
        isSelectAll = false;
        $("#selectall").prop("checked", false);
        $(".check_item").removeClass("check_item");
    }
}

function CheckSelectAll() {
    var items = $(".dataitem, .item_head, .item_body");
    var selectAll = true;
    for (var i = 0; i < items.length; i++) {
        if (!$(items[i]).hasClass("check_item")) {
            selectAll = false;
            break;
        }
    }
    if (selectAll) {
        $("#selectall").prop("checked", true);
    }
    isSelectAll = selectAll;
}

function SetZoom() {
    if (_ActiveItem != null) {
        var setCtrl = GetSetCtrl(_ActiveItem);
        var of = $("#zoom").val();
        $(setCtrl).css("zoom", of);
    }
    else {
        $.msg("请先选定需要缩放的对象", 2000);
    }
}

var zoom = 100;
var zoombase = 10;
function Enlarge() {
    if (zoom < 200) {
        zoom = parseInt(zoom + zoombase);
        setZoom(zoom);
    }
}

function Narrow() {
    if (zoom > 20) {
        zoom = parseInt(zoom - zoombase);
        setZoom(zoom);
    }
}

function setZoom(zoom) {
    $("#zoomsize").text(zoom + "%");
    var docZoom = zoom / 100;
    $("#page_set").css("zoom", docZoom);
    //$("#drag_over").css("zoom", docZoom);
    //$("#print_range").css("zoom", docZoom);
    $("#page_line").css("zoom", docZoom);
    $(".bg_color").css("zoom", docZoom);
    $(".bg").css("zoom", docZoom);
}

/**********  top - end   *************/

/**********  template - begin   *************/

function ShowList(id) {
    $("#" + id).show();
}

function HideList(id) {
    $("#" + id).hide();
}

function HidePtList() {
    $("#pt_list,#pt_opacity").hide();
}

function ShowPtList() {
    LoadPts();
    $("#pt_list,#pt_opacity").show();

}



function ResetDefault() {
    $.cfm("请确认是否重置为默认模板,当前自定义的设置信息将丢失", function (isOk) {
        if (isOk) {
            var rv = _CallPage("ResetDefault");
        }
    });
}

function SetDefault(ptId, pt) {
    var rv = _CallPage("SetDefault", ptId);
    if (rv) {
        $(".d").text("设为默认").removeClass("default_true").addClass("default_false");
        $("#pt" + ptId).find(".d").text("默认").removeClass("default_false").addClass("default_true");
        if (pt) {
            for (var i = 0; i < _pts.length; i++) {
                _pts[i].is_default = false;
            }
            pt.is_default = true;
            LoadPts();
        }
    }

}

function SetUserDefault(ptId, pt) {
    var rv = _CallPage("SetUserDefault", ptId);
    if (rv) {
        $(".d").text("设为我的默认").removeClass("default_true").addClass("default_false");
        $("#pt" + ptId).find(".d").text("我的默认").removeClass("default_false").addClass("default_true");
        if (pt) {
            for (var i = 0; i < _pts.length; i++) {
                _pts[i].is_user_default = false;
            }
            pt.is_user_default = true;
            LoadPts();
        }
    }
}

function Del(ptId, isDefault, pt) {
    var msg = "";
    if (!EnableDel) {
        $.msg("您没有删除权限");
        return;
    }
    if (isDefault) {
        msg += "正要删除的模板为默认模板,请删除后重新设置默认模板,如果不设定打印时将随机寻找模板``";
    }
    msg += "请确认真的需要删除该模板";
    $.cfm(msg, function (isOk) {
        if (isOk) {
            var rv = _CallPage("Del", ptId);
            if (rv) {
                $("#pt" + ptId).remove();
                if (pt != undefined) {
                    pt['delete'] = true;
                    LoadPts();
                }
            }
        }
    });
}

function PtSaved(ptId) {
    $("#pt_id").val(ptId);
}

function gotoPage(_type, pt_id) {
    var types = _type.split('_');
    if (types.length == 2 && types[0] === types[1] && types[0] === "order") {
        _type = "order";
    }
    var _href = window.location.toString();
    var _regex1 = /(\?|&)type=(order_)?[^&]*/gi;
    var _regex2 = /(\?|&)pt_id=[0-9]*/gi;
    if (_regex1.test(_href)) {
        _href = _href.replace(_regex1, "$1type=$2" + _type);
    }
    if (_regex2.test(_href)) {
        _href = _href.replace(_regex2, "$1pt_id=" + pt_id);
    } else {
        _href += "&pt_id=" + pt_id;
    }
    window.location = _href;
}

function Modify(ptId, _type) {
    $.cfm("请确认当前编辑的模板已经保存,如果需要保存请点击取消再保存后继续操作``请确认不保存需要继续 ?!", function (isOk) {
        if (isOk) {
            $("#pt_id").val(ptId);
            gotoPage(_type, ptId);
        }
    });
}

var _pre_pt;

function LoadPts() {

    var ptctrl = $("#pts").empty();

    for (var i = 0; i < _pts.length; i++) {
        var pt = _pts[i];
        if (i > 0 && pt.co_id == 1 && _pre_pt.co_id > 1) {
            var ptiCtrl = $("<div class='pti_spt'></div>").appendTo(ptctrl);

        }
        _pre_pt = pt;
        RenderPtItem(ptctrl, pt);
    }
}

function RenderPtItem(ptctrl, pt) {
    if (pt['delete'] === true) {
        return;
    }

    var ptiCtrl = $("<div class='pti'></div>").appendTo(ptctrl);
    pt.ctrl = ptiCtrl;

    if (IsAdminEdit) {
        if (pt.co_id == _co_id) {
            $("<span class='pti_btn'>删除</span>").appendTo(ptiCtrl).click(function () {
                Del(pt.pt_id, pt.is_default, pt);
            });
        }
        else {
            $("<span class='pti_btn' title='复制后请保存才会生效'>复制</span>").appendTo(ptiCtrl).click(function () {
                Modify(pt.pt_id, pt.type, pt);
            });
        }
    }

    var name = pt.name;
    if (name.length > 12) {
        name = name.substr(0, 11) + "...";
    }

    var nameCtrl = $("<span class='name' title='" + pt.name + "'></span>").text(name).appendTo(ptiCtrl);

    if (pt.co_id == 1) {
        $("<span class='sys'>系统</span>").appendTo(ptiCtrl);
    }
    if (pt.type == "cnp") {
        $("<span class='cnp'>菜鸟</span>").appendTo(ptiCtrl);
    }
    if (pt.type == "pdd") {
        $("<span class='pdd'>拼多多</span>").appendTo(ptiCtrl);
    }

    pt.current_ctrl = $("<span class='current'>当前模板</span>").appendTo(ptiCtrl).hide();
    if (pt.pt_id == _current_pt_id) {
        pt.current_ctrl.show();
    }

    else if (pt.co_id == _co_id) {
        $("<span class='pti_btn'>编辑</span>").appendTo(ptiCtrl).click(function () {
            Modify(pt.pt_id, pt.type, pt);
        });
    }
    pt.default_ctrl = $("<span class='default'>默认</span>").appendTo(ptiCtrl).hide();
    pt.set_default_btn = $("<span class='pti_btn'>设为默认</span>").appendTo(ptiCtrl).click(function () {
        SetDefault(pt.pt_id, pt);
    }).hide();

    pt.user_default_ctrl = $("<span class='default'>我的默认</span>").appendTo(ptiCtrl).hide();
    pt.set_user_default_btn = $("<span class='pti_btn'>设为我的默认</span>").appendTo(ptiCtrl).click(function () {
        SetUserDefault(pt.pt_id, pt);
    }).hide();


    if ((pt.is_default || pt.is_user_default) && pt.co_id == _co_id) {
        if (pt.is_default && pt.co_id == _co_id) {
            pt.default_ctrl.show();
        }
        if (pt.is_user_default && pt.co_id == _co_id) {
            pt.user_default_ctrl.show();
        }

        if (!pt.is_default) { pt.set_default_btn.show(); }
        if (!pt.is_user_default) { pt.set_user_default_btn.show(); }
    }
    else if (pt.co_id == _co_id) {
        pt.set_default_btn.show();
        pt.set_user_default_btn.show();
    }
}

function GetSetterHTML() {

    $(".foot").removeClass(".foot");

    while ($("#drag_over").length >= 1) {
        $("#drag_over").remove();
    }

    var dataitems = $(".dataitem");
    for (var i = 0; i < dataitems.length; i++) {
        var ctrl = dataitems[i];
        if ($(ctrl).tagname().toLowerCase() == "div") {
            var style = $(ctrl).prop("style");
            if (style.width.length == 0 && style.height.length == 0) {
                $(ctrl).css({
                    "width": $(ctrl).outerWidth(),
                    "height": $(ctrl).outerHeight()
                })
            }
        }
    }

    var itemList = $(".item_list");
    var itemHeight1 = $(itemList).outerHeight(true);

    if (itemList.length > 0) {
        var divs = $(".page").children("div,img");
        var top = parseInt($(itemList).css("top"));
        var left = parseInt($(itemList).css("left"));
        var right = left + $(itemList).width();

        divs.each(function () {
            var footTop = parseInt($(this).css("top"));
            var footLeft = parseInt($(this).css("left"));
            var footRight = parseInt($(this).css("left")) + $(this).width();
            if (footTop > top && footLeft < right && footRight > left) {
                $(this).addClass("foot");
                $(this).attr({
                    "top": footTop - (top + itemHeight1),
                    "left": footLeft - left
                });
            }
        });

        var tds = $(".page").find("td");
        tds.each(function () {
            var height = $(this).outerHeight(true);
            var width = $(this).outerWidth(true);

            $(this).attr({
                "f_height": height,
                "f_width": width,
            })

        })
    }

    var tmphtml = {
        "header": "",
        "page": "",
        "footer": ""
    }

    if (!__isSelf) {
        tmphtml.page = $("#printer").val();
        return JSON.stringify(tmphtml);
    }

    var headerPage = $(".page").find(".header_page").prop("outerHTML");
    var footerPage = $(".page").find(".footer_page").prop("outerHTML");
    if (headerPage) {
        $(".page").remove(".header_page");
        tmphtml.header = headerPage;
    }
    if (footerPage) {
        $(".page").remove(".footer_page");
        tmphtml.footer = footerPage;
    }
    if (headerPage || footerPage) {
        var temPageSet = $("#page_set").clone();
        $(temPageSet).find(".header_page").remove();
        $(temPageSet).find(".footer_page").remove();
        tmphtml.page = $(temPageSet).html();
    }
    else {
        tmphtml.page = $("#page_set").html();
    }

    return JSON.stringify(tmphtml);
}

function Save() {
    var content ="<!DOCTYPE html>"+ document.documentElement.outerHTML;
    console.log(content);
     //var content = GetSetterHTML();
     var company = "鼎业机械";
     $.post({
         url: "http://localhost:8080/printpage/save",
         data: {'content':content,'company':company},
         success:function(data){
             alert(data);
             //console.log(data);
         }
     });

}

/**********  template - end   *************/

/**********  right - begin   *************/

//function SetPageWidth() {
//    var w = $("#page_width").val();
//    w = parseFloat(w);
//    $(".page,.bg_color,.header_page,.footer_page").css("width", w + "cm");
//}

//function SetPageHeight() {
//    var h = $("#page_height").val();
//    h = parseFloat(h);
//    $(".page,.bg_color").css("height", h + "cm");
//}

function SetHeaderPageHeight() {
    var h = $("#header_page_height").val();
    h = parseFloat(h);
    $(".header_page").css("height", h + "cm");
}

function SetFooterPageHeight() {
    var h = $("#footer_page_height").val();
    h = parseFloat(h);

    var height = 0;
    var page_direction = $("#page_direction").val();
    if (page_direction == 1) {
        height = $("#page_height").val();
    }
    else if (page_direction == 2) {
        height = $("#page_width").val();
    }

    $(".footer_page").css({ "height": h + "cm", "top": (height - h) + "cm" });
}

function ItemSearch() {
    $("#search-result").empty();
    var key = $.trim($("#item-search").val().toLowerCase());
    if (key == "") {
        $("#data_insert").find(".model-con").show();
        $("#data_insert").find(".model-arrow").removeClass("close").addClass("open");
        $(".add_item").show();
        return;
    }
    $("#data_insert").find(".model-con").each(function () {
        var items = $(this).find(".add_list > .add_item");
        var conshow = false;
        for (var i = 0; i < items.length; i++) {
            var curtxt = $(items[i]).text().toLowerCase();
            if (curtxt.indexOf(key) > -1) {
                conshow = true;
                //$(items[i]).show();
                $("#search-result").append($(items[i]).clone());
            }
            //else {
            //    $(items[i]).hide();
            //}
        }
        if (conshow) {
            $(this).show();
        }
        else {
            $(this).hide();
        }
    });
}

function SetTtemPattern() {
    if (__currentType == "order" && __currentSubType == "send") {
        _Float("SetTtemPatternOrder.aspx?isCNP=" + __isCNP, "500px", "460px");
    }
    else {
        _Float("SetTtemPattern.aspx?isCNP=" + __isCNP, "500px", "460px");
    }
}
function SaveMaxItem() {
    _CallPage("SaveMaxItem");
}

function AddItem(addType, groupName, itemId, itemName, defaultCtrl) {
    if (addType != "item") {
        //菜鸟电子面单
        if (!__isSelf) {
            //$.msg("已复制变量到剪贴板：<%=_data." + itemId + "%>，请在菜鸟模板打印项中使用。");
            return false;
        }

        var item = $("<div class='data _f" + itemId + "'></div>").text("{" + itemName + "}").addClass("dataitem").mousemove(function (e) {
            ItemMove(e, this);
        }).mousedown(function (e) {
            return ItemDown(e, this);
        }).click(function (e) { ItemClick(this, e); });

        CurrentPageAdd(item);

        ItemClick(item, null);
    }
    else {
        if (!__isSelf) {
            return false;
        }

        if (CurrentPage != "page") {
            $.msg("页眉页脚不支持表格！");
            return false;
        }

        var itemList = $(".item_list");
        if (itemList.length == 0) {
            itemList = $("<table cellpadding='0' cellspacing='0' border='1'  class='item_list'><tr class='item_head_tr'></tr><tr class='item_body_tr'></tr></table>")
                .mousemove(function (e) {
                    ItemMove(e, this);
                }).mousedown(function (e) {
                    ItemListDown(e, this);
                }).click(function () { });

            CurrentPageAdd(itemList);

        }

        var tr1 = $(itemList).find("tr").eq(0);
        var tr2 = $(itemList).find("tr").eq(1);

        var cellIndex = tr1.children().length - 1;
        if (_ActiveItem != null) {
            var tagName = $(_ActiveItem).get(0).tagName.toLowerCase();
            if (tagName == "td") {
                cellIndex = $(_ActiveItem).prevAll().length;
            }
        }

        var td1 = $("<td class='item_head'></td>").text(itemName).click(function (e) {
            ItemHeadClick(e, this);
        }).mousemove(function (e) {
            ItemMove(e, this);
        }).mousedown(function (e) {
            ItemHeadDown(e, this);
        }).dblclick(function () { SetHeadText(this); }).attr("title", "双击修改表头文本");


        var td2 = $("<td class='item_body'></td>").append($("<div class='item_text _if" + itemId + "'></div>").text("{" + itemName + "}")).click(function (e) {
            ItemBodyClick(e, this);
        }).mousemove(function (e) {
            ItemMove(e, this);
        }).mousedown(function (e) {
            ItemBodyDown(e, this);
        });

        if (cellIndex == tr1.children().length - 1) {
            $(tr1).append(td1);
            $(tr2).append(td2);

        }
        else {
            $(tr1).children().eq(cellIndex).after(td1);
            $(tr2).children().eq(cellIndex).after(td2);
        }

        td2.click();
    }

    if (defaultCtrl == "qrcode") {
        SetQRCode();
    }
    else if (defaultCtrl == "img" || defaultCtrl == "pic") {
        var size = itemId.substring(3, itemId.length);
        if (isNaN(size) || size < 0) {
            size = itemId.substring(6, itemId.length);
        }
        if (!verifyPositiveInteger(size)) {
            var sizeArray = [30, 60, 120];
            for (var i = 0; i < sizeArray.length; i++) {
                var _size = sizeArray[i].toString() + "*" + sizeArray[i].toString();
                if (itemName.indexOf(_size) > -1) {
                    size = sizeArray[i];
                    break;
                }
            }
        }
        SetPic(parseInt(size));
    }
    else if (defaultCtrl == "barcode") {
        SetBarCode()
    }
    else if (defaultCtrl == "wash") {
        SetPic(30);
    }

    //SetUnDragImg();
}

function AddUserText() {

    //菜鸟电子面单
    if (!__isSelf) {
        return false;
    }

    var text = $("#user_text").val();
    if (text.length == 0) {
        return;
    }
        var item = $("<div class='user'></div>").text(text).addClass("dataitem").bind("selectstart", function () {
            return false;
        }).mousemove(function (e) {
            ItemMove(e, this);

        }).mousedown(function (e) {
            return ItemDown(e, this);
        }).click(function (e) {
            ItemClick(this, e);
        });
        CurrentPageAdd(item);
        ItemClick(item, null);
}

function AddLineBlock() {
    AddLine({ "border": "1px solid #333333", "width": "100px", "height": "40px", "z-index": 1 });
}

function AddDotteLineBlock() {
    AddLine({ "border": "1px dotted #000", "width": "100px", "height": "40px", "z-index": 1 });
}

function AddVLine() {
    AddLine({ "border-right": "1px solid #333", "width": "10px", "height": "100px", "z-index": 1 });
}

function AddDotteVLine() {
    AddLine({ "border-right": "1px dotted #000", "width": "10px", "height": "100px", "z-index": 1 });
}

function AddHLine() {
    AddLine({ "border-bottom": "1px solid #333", "width": "100px", "height": "10px", "z-index": 1 });
}

function AddDotteHLine() {
    AddLine({ "border-bottom": "1px dotted #000", "width": "100px", "height": "10px", "z-index": 1 });
}


function AddHeaderPage() {

    if ($(".dataitem").hasClass("header_page")) {
        $.msg("已经添加页眉！");
        return;
    }
    var width = 0;
    var page_direction = $("#page_direction").val();
    if (page_direction == 1) {
        width = $("#page_width").val();
    }
    else if (page_direction == 2) {
        width = $("#page_height").val();
    }
    var header = { "background-color": "#00000010", "border-bottom": "1px dotted #000", "z-index": 1, "top": 0, "left": 0, "width": width + "cm", "height": "1.5cm" };
    var item = $("<div class='user line header_page header_item'></div>").addClass("dataitem").css(header).bind("selectstart", function () { return false; })
    $(".page").append(item);
    $("#header_page_height").val(1.5);

    InitEditItems();
    $("#editctrls").val("header_page");
    SelectEditCtrl();
}

function AddFooterPage() {

    if ($(".dataitem").hasClass("footer_page")) {
        $.msg("已经添加页脚！");
        return;
    }
    var width = 0;
    var height = 0;
    var page_direction = $("#page_direction").val();
    if (page_direction == 1) {
        width = $("#page_width").val();
        height = $("#page_height").val();
    }
    else if (page_direction == 2) {
        width = $("#page_height").val();
        height = $("#page_width").val();
    }

    var footer = { "background-color": "#00000010", "border-top": "1px dotted #000", "z-index": 1, "top": (height - 1.5) + "cm", "left": 0, "width": width + "cm", "height": "1.5cm" };
    var item = $("<div class='user line footer_page footer_item'></div>").addClass("dataitem").css(footer).bind("selectstart", function () { return false; })
    $(".page").append(item);
    $("#footer_page_height").val(1.5);
    InitEditItems();
    $("#editctrls").val("footer_page");
    SelectEditCtrl();
}

function AddPagingIndex() {
    var item = $("<div class='user paging_index'></div>").css({ "z-index": 1 }).addClass("dataitem").text("{分页页码}").bind("selectstart", function () { return false; }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) { ItemClick(this, e); });
    CurrentPageAdd(item);
    ItemClick(item, null);
}

function AddLine(css) {
    var item = $("<div class='user line'></div>").css({ "z-index": 1 }).addClass("dataitem").css(css).bind("selectstart", function () { return false; }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) { ItemClick(this, e); });
    CurrentPageAdd(item);
    ItemClick(item, null);
}

function CurrentPageAdd(target) {
    if (CurrentPage == "header_page") {
        target.css("top", 0);
        target.addClass("header_item");
    }
    else if (CurrentPage == "footer_page") {
        target.css("top", 0);
        target.addClass("footer_item");
    }
    $("." + CurrentPage).append(target);

}

function ModelShow(target) {
    var self = $(target);
    var arrowCtrl = self.find(".model-arrow");
    var conCtrl = self.parent().find(".model-con");
    var isShow = self.find(".model-arrow").hasClass("open");
    if (isShow) {
        arrowCtrl.removeClass("open").addClass("close");
        conCtrl.hide();
    }
    else {
        arrowCtrl.removeClass("close").addClass("open");
        conCtrl.show();
    }
}

/**********  right - end   *************/

/**********  main - begin   *************/

var _ActiveItem = null;
var _CurrentItem = null;
var _CheckItems = new Array();
var _MouseType = null;
var _X1 = 0;
var _Y1 = 0;
var _X2 = 0;
var _Y2 = 0;

function MouseReset() {
    //if (_CurrentItem != null)
    //{
    //    $(_CurrentItem).removeClass("active");
    //}
    //_CurrentItem = null;
    _MouseType = null;
    $(".page").css("cursor", "");
    //$("#drag_over").hide();
}

function DocUp(e) {
    MouseReset();
}

function DocLeave(e) {
    MouseReset();
}

function CheckAndShowOver(e, ctrl) {
    return;
    var tagname = $(ctrl).get(0).tagName.toLowerCase();

    if (tagname == "img") {
        if (_MouseType == "size") {
            $("#drag_over").show().css("cursor", "se-resize");
        }
        else {
            $("#drag_over").show().css("cursor", "move");
        }
    }
}

function DownFalse() {
    return false;
}

function SetUnDragImg() {
    $("img").unbind("mousedown", DownFalse).mousedown(DownFalse);
}

function ItemMove(e, ctrl) {
    //if (_CurrentItem == null)
    //{
    if (CheckResize(e, ctrl)) {
        $(ctrl).css("cursor", "se-resize");
    }
    else {
        $(ctrl).css("cursor", "default");
    }
    //}
}

function CheckResize(e, ctrl) {

    var positionX = e.originalEvent.x - $(ctrl).offset().left || e.originalEvent.layerX - $(ctrl).offset().left || 0;
    var positionY = e.originalEvent.y - $(ctrl).offset().top || e.originalEvent.layerY - $(ctrl).offset().top || 0;

    var width = $(ctrl).width();
    var height = $(ctrl).height();

    if (width - positionX < 4 && height - positionY < 4) {
        return true;
    }
    else {
        return false;
    }
}

function ResetAcitve() {
    if (_CurrentItem != null) {
        $(_CurrentItem).removeClass("active");
    }
    if (_ActiveItem != null) {
        $(_ActiveItem).removeClass("active");
    }
}

function ItemCheck(ctrl) {
    if (_ActiveItem != null) {
        $(_ActiveItem).addClass("check_item");
    }
    $(ctrl).addClass("check_item");
}

function ClearItemCheck() {
    $(".check_item").removeClass("check_item");
}

function ClearOtherItemCheck(ctrl) {
    $(".check_item").removeClass("check_item");
    $(ctrl).addClass("check_item");
}

//设置当前有效元素的坐标
function SetItemAxis(ctrl) {
    _CheckItems = new Array();

    //if (ctrl != null || isSelectAll) {
    //    _X2 = parseInt($(ctrl).css("left") || "100px");
    //    _Y2 = parseInt($(ctrl).css("top") || "100px");

    //    var checkItems = $(".check_item");
    //    if (checkItems.length > 0) {
    //        checkItems.each(function () {
    //            var o = new Object();
    //            if ($(this).tagname() == "TD") {
    //                o.ctrl = $(".item_list");
    //            }
    //            else {
    //                o.ctrl = this;
    //            }
    //            o.X = parseInt($(o.ctrl).css("left"));
    //            o.Y = parseInt($(o.ctrl).css("top"));
    //            _CheckItems.push(o);
    //        });
    //    }
    //}
}

function IsReturn(ctrl) {

    var isReturn = true;
    var isHeaderPage = $(ctrl).hasClass("header_page");
    var isFooterPage = $(ctrl).hasClass("footer_page");
    var isHeaderItem = $(ctrl).hasClass("header_item");
    var isFooterItem = $(ctrl).hasClass("footer_item");

    if (isHeaderPage || isFooterPage) {
        isReturn = true;
    }
    else if (isHeaderItem) {
        if (CurrentPage == "header_page") {
            isReturn = false;
        }
    }
    else if (isFooterItem) {
        if (CurrentPage == "footer_page") {
            isReturn = false;
        }
    }
    else if (CurrentPage == "page") {
        isReturn = false;
    }

    return isReturn;
}

function ItemDown(e, ctrl) {

    if (IsReturn(ctrl)) {
        return;
    }

    if (!e.ctrlKey) {
        _CheckItems = new Array();
        //if (!isSelectAll) {
        //    ClearItemCheck();
        //}
        ResetAcitve();
        _CurrentItem = ctrl;

        //$(_CurrentItem).bind("drop", function () { return true; });
        if (CheckResize(e, ctrl)) {
            _MouseType = "size";
        }
        else {
            _X1 = e.pageX;
            _Y1 = e.pageY;
            _MouseType = "move";

            _X2 = parseInt($(ctrl).css("left"));
            _Y2 = parseInt($(ctrl).css("top"));

            var checkItems = $(".check_item");
            if (checkItems.length > 0) {
                var hasItemList = false;
                checkItems.each(function () {
                    var o = new Object();
                    if ($(this).tagname() == "TD") {
                        o.ctrl = $(".item_list");
                    }
                    else {
                        o.ctrl = this;
                    }
                    o.X = parseInt($(o.ctrl).css("left"));
                    o.Y = parseInt($(o.ctrl).css("top"));
                    _CheckItems.push(o);
                });
            }
        }
        $(_CurrentItem).addClass("active");
        CheckAndShowOver(e, ctrl);
    }

    return false;
}

function ItemListDown(e, ctrl) {
    //if (CheckResize(e, ctrl))
    //{

    //}
    //else
    //{
    //    _CurrentItem = ctrl;

    //    _X1 = e.pageX;
    //    _Y1 = e.pageY;

    //    _X2 = parseInt($(ctrl).css("left"));
    //    _Y2 = parseInt($(ctrl).css("top"));

    //    _MouseType = "move";
    //}
    return false;
}

function ItemHeadDown(e, ctrl) {

    if (IsReturn(ctrl)) {
        return;
    }

    if (!e.ctrlKey) {
        //if (!isSelectAll) {
        //    ClearItemCheck();
        //}
        ResetAcitve();
        $(ctrl).addClass("active");
        _CheckItems = new Array();
        if (CheckResize(e, ctrl)) {
            _CurrentItem = ctrl;
            _MouseType = "size";
        }
        else {
            _CurrentItem = $(".item_list");
            _MouseType = "move";
            _X1 = e.pageX;
            _Y1 = e.pageY;

            _X2 = parseInt($(_CurrentItem).css("left"));
            _Y2 = parseInt($(_CurrentItem).css("top"));

            var checkItems = $(".check_item");
            if (checkItems.length > 0) {
                checkItems.each(function () {
                    var o = new Object();
                    o.ctrl = this;
                    o.X = parseInt($(this).css("left"));
                    o.Y = parseInt($(this).css("top"));
                    _CheckItems.push(o);
                });
            }
        }
        _ActiveItem = $(".item_list");
    }

    return false;
}

function ItemBodyDown(e, ctrl) {

    if (IsReturn(ctrl)) {
        return;
    }

    if (!e.ctrlKey) {
        _CheckItems = new Array();
        //if (!isSelectAll) {
        //    ClearItemCheck();
        //}
        ResetAcitve();
        $(ctrl).addClass("active");
        if (CheckResize(e, ctrl)) {
            _CurrentItem = ctrl;
            _MouseType = "size";
        }
        else {
            _CurrentItem = $(".item_list");
            _MouseType = "move";
            _X1 = e.pageX;
            _Y1 = e.pageY;

            _X2 = parseInt($(_CurrentItem).css("left"));
            _Y2 = parseInt($(_CurrentItem).css("top"));

            var checkItems = $(".check_item");
            if (checkItems.length > 0) {
                checkItems.each(function () {
                    var o = new Object();
                    o.ctrl = this;
                    o.X = parseInt($(this).css("left"));
                    o.Y = parseInt($(this).css("top"));
                    _CheckItems.push(o);
                });
            }
        }
        CheckAndShowOver(e, ctrl);
    }

    return false;
}

function ItemClick(ctrl, e) {

    var isActive = $(ctrl).hasClass("active");
    var isCheckItem = $(ctrl).hasClass("check_item");

    if (IsReturn(ctrl)) {
        return;
    }

    if (e != null && e.ctrlKey) {
        if (isActive || isCheckItem) {
            $(ctrl).removeClass("active").removeClass("check_item");
            $("#selectall").prop("checked", false);
            isSelectAll = false;
            _CurrentItem = null;
            if (isActive) {
                _ActiveItem = null;
            }
            return;
        }
        ItemCheck(ctrl);
        CheckSelectAll();
    }
    else {
        if (!isSelectAll) {
            SetSelectAll(false);
        }
        //ClearOtherItemCheck(ctrl);
    }
    ResetAcitve();
    $(ctrl).addClass("active");
    ParseCtrlFont(ctrl);
    ParseCtrlCss(ctrl);
    ParseCtrlBarcodeType(ctrl);
    ParseCtrlSize(ctrl);
    ParseCtrlOpacity(ctrl);
    ParseCtrl(ctrl);
    _ActiveItem = ctrl;
}

function ItemHeadClick(e, ctrl) {
    var isActive = $(ctrl).hasClass("active");
    var isCheckItem = $(ctrl).hasClass("check_item");

    if (IsReturn(ctrl)) {
        return;
    }

    if (e != null && e.ctrlKey) {
        if (isActive || isCheckItem) {
            $(ctrl).removeClass("active").removeClass("check_item");
            $("#selectall").prop("checked", false);
            isSelectAll = false;
            _CurrentItem = null;
            if (isActive) {
                _ActiveItem = null;
            }
            return;
        }
        ItemCheck(ctrl);
        CheckSelectAll();
    }
    else {
        if (!isSelectAll) {
            SetSelectAll(false);
        }
        //ClearOtherItemCheck(ctrl);
    }
    ResetAcitve();
    $(ctrl).addClass("active");
    ParseCtrlFont(ctrl);
    ParseCtrlCss(ctrl);
    ParseCtrlBarcodeType(ctrl);
    ParseCtrlSize(ctrl);
    ParseCtrlOpacity(ctrl);
    ParseCtrl(ctrl);
    _ActiveItem = ctrl;
}

function ItemBodyClick(e, ctrl) {

    var isActive = $(ctrl).hasClass("active");
    var isCheckItem = $(ctrl).hasClass("check_item");

    if (IsReturn(ctrl)) {
        return;
    }

    if (e != null && e.ctrlKey) {
        if (isActive || isCheckItem) {
            $(ctrl).removeClass("active").removeClass("check_item");
            $("#selectall").prop("checked", false);
            isSelectAll = false;
            _CurrentItem = null;
            if (isActive) {
                _ActiveItem = null;
            }
            return;
        }
        ItemCheck(ctrl);
        CheckSelectAll();
    }
    else {
        if (!isSelectAll) {
            SetSelectAll(false);
        }
        //ClearOtherItemCheck(ctrl);
    }
    ResetAcitve();
    $(ctrl).addClass("active");
    ParseCtrlFont(ctrl);
    ParseCtrlCss(ctrl);
    ParseCtrlBarcodeType(ctrl);
    ParseCtrlSize(ctrl);
    ParseCtrlOpacity(ctrl);
    ParseCtrl(ctrl);
    _ActiveItem = ctrl;
}

function DocMove(e) {
    if (_CurrentItem != null) {
        if (_MouseType == "size") {
            $(".page").css("cursor", "se-resize");
            //$("#drag_over").show().css("cursor", "se-resize");
            var width = e.pageX - $(_CurrentItem).offset().left + 4;
            var height = e.pageY - $(_CurrentItem).offset().top + 4;
            var tagName = $(_CurrentItem).get(0).tagName.toLowerCase();

            if (width > 0) {
                if (tagName == "td") {
                    var cellIndex = $(_CurrentItem).prevAll().length;

                    var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
                    if (childrentagName != "img") {
                        $(".item_head_tr").children().eq(cellIndex).outerWidth(width);
                        $(".item_body_tr").children().eq(cellIndex).outerWidth(width);
                        $(".item_body_tr").children().eq(cellIndex).children().outerWidth(width);

                        //  $(_CurrentItem).outerWidth(width);
                    }
                }
                else {
                    $(_CurrentItem).outerWidth(width);
                }
            }
            if (height > 0) {
                if (tagName == "td") {
                    var cellIndex = $(_CurrentItem).prevAll().length;

                    var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
                    if (childrentagName != "img") {
                        $(_CurrentItem).parent().outerHeight(height);
                        $(_CurrentItem).parent().find("div").outerHeight(height);
                    }
                }
                else {
                    $(_CurrentItem).outerHeight(height);
                }
            }
        }
        else if (_MouseType == "move") {
            $(".page").css("cursor", "move");
            // $("#drag_over").show().css("cursor", "move");
            var x1 = e.pageX;
            var y1 = e.pageY;

            var x2 = x1 - _X1;
            var y2 = y1 - _Y1;

            var left = _X2 + x2;
            var top = _Y2 + y2;

            $(_CurrentItem).css("left", left);
            $(_CurrentItem).css("top", top);

            for (var i = 0; i < _CheckItems.length; i++) {
                var ci = _CheckItems[i];
                if ($(ci.ctrl).hasClass("header_page") || $(ci.ctrl).hasClass("footer_page")) {
                    continue;
                }
                var left = ci.X + x2;
                var top = ci.Y + y2;

                $(ci.ctrl).css("left", left);
                $(ci.ctrl).css("top", top);
            }
        }
    }
}

function DocMoveKeyBoard(e) {
    GetCheckItems();
    if ((_CheckItems.length > 0) && (e.keyCode == 37 || e.keyCode == 38 || e.keyCode == 39 || e.keyCode == 40) && !e.ctrlKey) {
        if (e.target.tagName == "SELECT") {
            return;
        }

        //var SetCtrl = null;

        //if (_ActiveItem != null && $(_ActiveItem).tagname() == "TD") {
        //    SetCtrl = $(".item_list");
        //}
        //else {
        //    SetCtrl = _ActiveItem;
        //}

        //SetItemAxis();

        var temCheckItems = new Array();
        for (var i = 0; i < _CheckItems.length; i++) {
            var ct = _CheckItems[i];
            var o = new Object();
            if ($(ct.ctrl).tagname() == "TD") {
                o.ctrl = $(".item_list");
            }
            else {
                o.ctrl = ct.ctrl;
            }
            o.X = parseInt($(o.ctrl).css("left"));
            o.Y = parseInt($(o.ctrl).css("top"));
            temCheckItems.push(o);
        }


        var x2 = 0
        var y2 = 0;

        switch (e.keyCode) {
            case 37:
                x2 = -1;
                break;
            case 38:
                y2 = -1;
                break;
            case 39:
                x2 = 1;
                break;
            case 40:
                y2 = 1;
                break;
        }

        var left = _X2 + x2;
        var top = _Y2 + y2;

        //$(SetCtrl).css(
        //{
        //    "left": left,
        //    "top": top
        //});

        for (var i = 0; i < temCheckItems.length; i++) {
            var ci = temCheckItems[i];
            if ($(ci.ctrl).hasClass("header_page") || $(ci.ctrl).hasClass("footer_page")) {
                continue;
            }
            var left = ci.X + x2;
            var top = ci.Y + y2;

            $(ci.ctrl).css("left", left);
            $(ci.ctrl).css("top", top);
        }
    }
}

function DocSetSize(e) {
    if (_ActiveItem != null && (e.keyCode == 37 || e.keyCode == 38 || e.keyCode == 39 || e.keyCode == 40) && e.ctrlKey) {
        var width = 0;
        var height = 0;
        var tagName = $(_ActiveItem).get(0).tagName.toLowerCase();

        switch (e.keyCode) {
            case 37:
                width = -4;
                break;
            case 38:
                height = -4;
                break;
            case 39:
                width = 4;
                break;
            case 40:
                height = 4;
                break;
        }
        if (width != 0) {
            width += $(_ActiveItem).outerWidth();
            $("#item_width").val(width);
            if (tagName == "td") {
                var cellIndex = $(_ActiveItem).prevAll().length;

                var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
                if (childrentagName != "img") {
                    $(".item_head_tr").children().eq(cellIndex).outerWidth(width);
                    $(".item_body_tr").children().eq(cellIndex).outerWidth(width);
                    $(".item_body_tr").children().eq(cellIndex).children().outerWidth(width);
                }
            }
            else {
                $(_ActiveItem).outerWidth(width);
            }
        }
        if (height != 0) {
            height += $(_ActiveItem).outerHeight();
            $("#item_height").val(height);
            if (tagName == "td") {
                var cellIndex = $(_ActiveItem).prevAll().length;

                var childrentagName = $(".item_body_tr").children().eq(cellIndex).children().get(0).tagName.toLowerCase();
                if (childrentagName != "img") {
                    $(_ActiveItem).parent().outerHeight(height);
                    $(_ActiveItem).parent().find("div").outerHeight(height);
                }
            }
            else {
                $(_ActiveItem).outerHeight(height);
            }
        }
    }
}

function EnterEvent(e) {
    if (e.keyCode == 13 && e.target.tagName == "INPUT") {
        if (e.target.id == "user_text") {
            AddUserText();
        }
    }
}

function SelectAllEvent(e) {
    if (e.ctrlKey && e.keyCode == 65) {
        SetSelectAll(true);
    }
}

function RemoveCtrl(e) {
    if (e.keyCode == 46 || e.keyCode == 8) {
        //是选择框时允许删除
        if (e.target.tagName == "INPUT" && e.target.type == "text") {
            return;
        }

        if (_ActiveItem != null || $(".check_item").length > 0) {
            $.cfm("请确认需要删除当前选定对象", function (isOk) {
                if (isOk) {
                    Delete();
                }
            });
        }
    }
}

function CheckDelete() {
    GetCheckItems();
    if (_CheckItems.length > 0) {
        $.cfm("请确认需要删除当前选定对象", function (isOk) {
            if (isOk) {
                Delete();
            }
        });
    }
}

function Delete() {
    GetCheckItems();
    for (var i = 0; i < _CheckItems.length; i++) {
        var itemCtrl = _CheckItems[i].ctrl;
        var setCtrl = GetSetCtrl(itemCtrl);
        if ($(itemCtrl).tagname() == "TD") {
            var cellIndex = $(itemCtrl).prevAll().length;
            $(".item_head_tr").children().eq(cellIndex).remove();
            $(".item_body_tr").children().eq(cellIndex).remove();
            if ($(".item_head_tr").children().length == 0) {
                $(".item_list").remove();
            }
        }
        else {
            $(setCtrl).remove();
            if ($(setCtrl).hasClass("header_page") || $(setCtrl).hasClass("footer_page")) {
                InitEditItems();
                SelectEditCtrl();
            }
        }
    }

    _ActiveItem = null;
}

function GetCtrlText(setCtrl) {
	
	//console.log(setCtrl);
    //SetUnDragImg();
    if ($(setCtrl).tagname() == "TD") {
        if ($(setCtrl).children().length > 0) {
            setCtrl = $(setCtrl).children().eq(0);
        }
    }
    if ($(setCtrl).tagname() == "IMG") {
    	
        var text = $(setCtrl).attr("title");
        if (text != "" && text != null) {
        	
            return text;
        }
        if ($(setCtrl).attr("class").indexOf("qrcoder") != -1) {
        	
            var url = $(setCtrl).attr("src").split("?")[1].substr(2);
          
            return decode(url);
            
        }
        else {
        	
            return $(setCtrl).attr("src");
        }
    }

    else if ($(setCtrl).attr("class").indexOf("barcode") != -1) {
    	
        return $(setCtrl).text().replace("*", "").replace("*", "");
    }
    else {
        return $(setCtrl).text();
    }
}

function GetSetCtrl(setCtrl) {
    if ($(setCtrl).tagname() == "TD") {
        if ($(setCtrl).children().length > 0) {
            return $(setCtrl).children().eq(0);
        }
    }
    return setCtrl;
}

function ActiveCtrl(setCtrl) {
    if ($(setCtrl).parent().tagname() == "TD") {
        ItemClick($(setCtrl).parent(), null);
    }
    else {
        ItemClick(setCtrl, null);
    }
}

function SetHeadText(ctrl) {
    _Prompt("请确认表头名称", $(ctrl).text(), function (headText) {
        $(ctrl).text(headText);
    });
}

function SetColor(type, color) {
    GetCheckItems();
    for (var i = 0; i < _CheckItems.length; i++) {
        var setCtrl = GetSetCtrl(_CheckItems[i].ctrl);
        $(setCtrl).css(type, color);
    }
}

function InitColorCtrl() {

    $('#item_bg_color').clColor({
        defaultColor: "#ffff00",
        type: "background",
        title: "填充颜色&#10;对所选标签设置背景色。&#10;&#10;单机箭头可选择不同的背景颜色",
        click: function (color) {
            SetColor('background-color', color);
        }
    });

    $('#item_font_color').clColor({
        title: "字体颜色&#10;设置文字的颜色。&#10;&#10;单机箭头可选择不同的文字颜色",
        click: function (color) {
            SetColor('color', color);
        }
    });
}

function Init() {

    InitEditItems(true);

    $(".dataitem").mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) {
        ItemClick(this, e);
    });

    $(".item_list").mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemListDown(e, this);
    });

    $(".item_head").click(function (e) {
        ItemHeadClick(e, this);
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemHeadDown(e, this);
    }).dblclick(function () {
        SetHeadText(this);
    }).attr("title", "双击修改表头文本");

    $(".item_body").click(function (e) {
        ItemBodyClick(e, this);
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemBodyDown(e, this);
    });

    $(".active").removeClass("active");
    $(".check_item").removeClass("check_item");
    $(".foot").removeClass("foot");

    $(".bg_color").width($(".page").width());
    $(".bg_color").height($(".page").height());

    InitSettings();
    InitCtrlItems();

    //SetPageWidth();
    //SetPageHeight();

    $("#page_set").contextmenu(function () { return false; });

    LoadPts();

    $("#item-search").bind("input propertychange change", function () {
        ItemSearch();
    });


    $("#user_custom .model-arrow").removeClass("close").addClass("open");
    $("#user_custom .model-con").show();

    $("#data_insert .set-model:first .model-arrow").removeClass("close").addClass("open");
    $("#data_insert .set-model:first .model-con").show();

    InitColorCtrl();
}

var __pageSettings = {};

function InitSettings() {
    var pageSetting = $("#page_setting").text();
    if (pageSetting.length > 10) {
        try {
            var ps = $.parseJSON(pageSetting);
            if (ps) {
                __pageSettings = ps;
                for (var p in ps) {
                    if (p != null && p == "pt_id") {
                        continue;
                    }

                    var pi = $("#" + p);
                    if (pi) {
                        pi.val(ps[p]);
                    }
                }

                if (__isCNP) {
                    var vs = $('#cnp_keys').val();
                    if (vs && vs.length > 0) {
                        __cnpKeys = vs.split(',');
                    }
                } else {
                    $("#show_bg").prop("checked", ps.show_bg);
                    SetShowBg();
                }
            }
        }
        catch (e) { }
    }
}

function SetSize() {
    var h = $(document.body).height() - $("#top_set").height() - 2;
    $("#page_parent").outerWidth($(document.body).width() - 300).outerHeight(h);
    $("#set_list,#content_body").outerHeight(h);
}

var Config = null;
function LoadSetFld() {
    var configHtml = $("#config").html();
    if (configHtml.length > 10) {
        Config = $.parseJSON(configHtml);
    }
}

$(document).ready(function () {
    try {
        SetSize();
        LoadSetFld();
    }
    catch (ex) { }

    $(document.body).mouseup(function (e) {
        DocUp();
    }).mousemove(function (e) {
        DocMove(e);
    }).keyup(function (e) {
        RemoveCtrl(e);
        DocMoveKeyBoard(e);
        DocSetSize(e);
        EnterEvent(e);
    }).keydown(function (e) {
        SelectAllEvent(e);
    });

    $(document.body).click(function (e) {
        var elem = event.target;
        while (elem) {
            if (elem.id == "showPtList" || elem.id == "pts") {
                return;
            }
            elem = elem.parentNode;
        }
        HidePtList();
    });

    $("#page_set").mouseleave(function (e) {
        DocLeave(e);
    });

    Init();

    if (typeof (__setRange) == "function") {
        __setRange();
    }

    //SetUnDragImg();
});

$(window).resize(function () {
    SetSize();
});


/***  other begin  ***/

function PMsg(text) {
    $("#p_msg").text(text);
}

function ShowCode39Help() {
    $.msg("下载字体文件,然后复制到系统字体文件夹(一般为C:\\Windows\\Fonts)内即可");
}

function GetSetterSample() {
    return $("#data").text();
}

//拿到模板
function myselfmodel() {
    $.post({
        url: "http://localhost:8080/printpage/findAll",
        success:function(data){
            console.log(data);
           // window.document.getElementById("myprintpage").innerHTML=data;
            StandardPost(data);
        }
    });
}

// POST任意内容并跳转

function StandardPost(html) {

    localStorage.removeItem('edittemplate');

    localStorage.setItem('edittemplate',html);

    window.location = "http://localhost:8080/between.html";

}

//自己调用自己并给page里面的所有div加上监听事件

(function(){

   // $('.page div').addEventListener("mousemove", ItemMove(e, this));
   // $('.page div').addEventListener("mousedown", ItemDown(e, this));
    $('.page div').bind("selectstart", function () {
        return false;
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) {
        ItemClick(this, e);
    });

    $('.page img').bind("selectstart", function () {
        return false;
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) {
        ItemClick(this, e);
    });



    //for(var i = 0;i <divs.length; i++) {
       // console.log(divs[i]);
      //  console.log("我去");
    //}
})();

function  myprintback(){


    // $('.page div').addEventListener("mousemove", ItemMove(e, this));
    // $('.page div').addEventListener("mousedown", ItemDown(e, this));
    $('.page div').bind("selectstart", function () {
        return false;
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) {
        ItemClick(this, e);
    });

    $('.page img').bind("selectstart", function () {
        return false;
    }).mousemove(function (e) {
        ItemMove(e, this);
    }).mousedown(function (e) {
        return ItemDown(e, this);
    }).click(function (e) {
        ItemClick(this, e);
    });



    //for(var i = 0;i <divs.length; i++) {
    // console.log(divs[i]);
    //  console.log("我去");
    //}
}

function mmm() {
    alert("ss");
    console.log("yosus");

    // var url = "../print/Printer.aspx?preview=true&setter=true&type=" + __currentType
    //     + "&sub_type=" + __currentSubType
    //     + "&pt_id=" + _current_pt_id
    // window.open(url);
}








/***  other end  ***/