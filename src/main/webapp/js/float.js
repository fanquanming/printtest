var _ShowFloadFrame_IsShowed = false;
var _HideFloatFrame_Next = null;
function _Float(frameUrl, width, height, onHide, postData)
{
    _ShowFloatFrame(frameUrl, width, height, onHide, postData);
}

///使用Dialog兼容原有的Float
var i = 0;
var _FloatHoldList = {};
function _FloatDialog(title, frameUrl, width, height, onHide)
{
    _HideFloatFrame_Next = null;
    var arg;
    if (typeof (title) == "object")
    {
        arg = title;
    }
    else
    {
        arg = { title: title, width: width, height: height, path: frameUrl, close: onHide };
    }

    arg.provider = _Dialog;
    if (arg["hold_id"])
    {
        var holdArg = _FloatHoldList[arg["hold_id"]];
        if (holdArg)
        {
            arg = holdArg;
        }
        else
        {
            _FloatHoldList[arg["hold_id"]] = arg;
        }

        arg["close_type"] = "hide";
    }

    if (arg.path.indexOf("?") == -1)
    {
        arg.path = arg.path + "?from_float=true";
    }
    else
    {
        arg.path = arg.path + "&from_float=true";
    }

    _HideFloatFrame_Next = function (rv)
    {
        _Dialog.Close(arg, null);
        if (arg.close)
        {
            arg.close(rv);
        }
    };
    arg.path = arg.path + "&_hide_title=true";
    arg.path = arg.path + "&_h=" + (parseInt(arg.height) - 40 + "px");
    dialog(arg);

    return arg;
}

function _FloatCalcWidth(minWidth, lessWidth, maxWidth)
{
    var width = $(document.body).width();
    if (width - lessWidth < minWidth)
    {
        return minWidth + "px";
    }
    else if (minWidth && width - lessWidth > maxWidth)
    {
        return maxWidth + "px";
    }
    return (width - lessWidth) + "px";
}
function _FloatCalcHeight(minHeight, lessHeight, maxHeight)
{
    var height = $(document.body).height();
    if (height - lessHeight < minHeight)
    {
        return minHeight + "px";
    }
    else if (maxHeight && height - lessHeight > maxHeight)
    {
        return maxHeight + "px";
    }

    return (height - lessHeight) + "px";
}
function _ShowFloatFrame(frameUrl, width, height, onHide, postData)
{
    var floatFrame = document.getElementById("float_frame");
    if (onHide)
    {
        _HideFloatFrame_Next = onHide;
    }
    else
    {
        _HideFloatFrame_Next = null;
    }

    _ShowFloadFrame_IsShowed = true;
    var dock = null;
    if (height == "dock.left")
    {
        dock = "left";
    }
    else if (height == "dock.right")
    {
        dock = "right";
    }
    else if (width == "dock.middle")
    {
        dock = "middle";
    }
    else if (width == "dock.top")
    {
        dock = "top";
    }
    else if (width == "dock.topOuter")
    {
        dock = "top";
    }
    else if (width == "dock.bottom")
    {
        dock = "bottom";
    }
    else if (height == "dock.center")
    {
        dock = "center";
    }
    if (height == "dock.left" || height == "dock.right" || height == "dock.center")
    {
        height = $(document.body).height();
    }
    if (width == "dock.top" || width == "dock.bottom" || width == "dock.middle")
    {
        width = $(document.body).width();
    }
    else if (width == "dock.topOuter")
    {
        width = $(document.body).outerWidth(true);
    }
    if (frameUrl != null && frameUrl != "")
    {
        if (frameUrl.indexOf("_t=") == -1)
        {
            if (frameUrl.indexOf("?") == -1)
            {
                frameUrl += "?";
            }
            else
            {
                frameUrl += "&";
            }
            frameUrl += "_t=" + _FloatT();

        }
        frameUrl += "&_h=" + height + "&_float=true";
        if (dock)
        {
            frameUrl += "&dock=" + dock;
        }
        if (!postData)
        {
            floatFrame.src = frameUrl;

        }
        else
        {
            _FloatPost(frameUrl, postData);
        }
    }
    floatFrame.style.display = "none";
    var ft = document.getElementById("float_table");
    ft.style.width = width;
    var jft = $(ft);

    $(floatFrame).removeClass("dock").removeClass("left").removeClass("right").removeClass("top").removeClass("bottom").removeClass("middle").removeClass("center").removeClass("_float_box").addClass("_float_box")
        .css("top", "").css("left", "").css("margin-left", "").css("margin-top", "");
    if (dock)
    {
        $(floatFrame).addClass("dock").addClass(dock);
    }
    if (dock == "left" || dock == "right" || dock == "center")
    {
        if (dock == "right")
        {
            $(floatFrame).css("margin-left", "-" + width).removeClass("_float_box");
        }
        else if (dock == "center")
        {
            var mw = ($(document.body).width() - parseInt(width)) / 2;
            $(floatFrame).css("margin-left", mw + "px").removeClass("_float_box");
        }
        else
        {
            $(floatFrame).removeClass("_float_box");
        }

    }
    else if (dock == "top" || dock == "bottom" || dock == "middle")
    {
        if (dock == "bottom")
        {
            //$(floatFrame).css("left", "100%").css("top", "-2px");

            $(floatFrame).css("margin-top", "-" + height).removeClass("_float_box");
        }
        else
        {
            $(floatFrame).removeClass("_float_box");
        }
    }
    else
    {
        $(floatFrame).css("left", "auto").css("top", "auto").css("margin-left", "auto");
    }

    $(ft).css("height", height);


    $(floatFrame).css("height", height).css("width", width);


    var ft = document.getElementById("float_top");
    ft.style.display = "";
    setTimeout(_ShowFloatFrame2, 100);

}
function _FloatPost(frameUrl, postData)
{
    var f = $("#_float_post_form").remove();
    f = $("<form id='_float_post_form' target='float_frame' method='post'></form>").attr("action", frameUrl).hide().appendTo($(document.body));
    for (var p in postData)
    {
        var c = $("<input type='hidden'/>").attr("id", p).attr("name", p).val(postData[p]).appendTo(f);
    }

    f.submit();
}

function _FloatT()
{
    return (new Date()).getTime();
}
function _ShowFloatFrame2()
{
    var ff = document.getElementById("float_frame");
    ff.style.display = "";

    //$("#_float_temp_div").remove(true);
    //var tmpDiv = $("<div id='float_temp_div'><span id='float_close_btn' onclick='_HideFloatFrame()' title='关 闭' ><span class='close_btn'>&nbsp;</span></span></div>").appendTo($(ff).parent());
    //$(ff).one("load", function ()
    //{

    //});
}
function _HideFloatFrame(args, arg2, arg3, arg4, arg5)
{
    var ft = document.getElementById("float_top");

    if (_HideFloatFrame_Next)
    {
        var hd = _HideFloatFrame_Next(args, arg2, arg3, arg4, arg5);

        if (hd === false)
        {
            return;
        }
    }
    ft.style.display = "none";
    $("#float_frame").attr("src", "about:blank");

}

function _HideFloat(args, arg2, arg3, arg4, arg5)
{
    _HideFloatFrame(args, arg2, arg3, arg4, arg5);
}

function _FloatFrameTransfer(url, postData)
{
    //$("#float_frame").attr("src", url);
    _FloatPost(url, postData);
}