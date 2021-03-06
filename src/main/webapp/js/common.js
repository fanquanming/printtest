﻿function MultiLineInput(e)
{
    top._XPrompt({
        "text": "请输入", callback: function (rv)
        {
            if (rv)
            {
                rv = rv.rpl(" ", "");
                var rvs = rv.replace(/\r/ig, ",").replace(/\n/ig, ",").split(",");
                var newRv = [];
                for (var i = 0; i < rvs.length; i++)
                {
                    if (rvs[i].length > 0)
                    {
                        newRv.push(rvs[i]);
                    }
                }
                $(e.target).val(newRv.join(","));
            }
        }
    });
}


function xPrompt(options)
{
    var defaultOptions = { text: null, html: null, multiLine: false, callback: null, height: 400, width: 600, title: "请输入" };
    options = $.extend({}, defaultOptions, options);

    var xPromptCtrl = top.$("#_xPrompt_p");
    if (xPromptCtrl.length == 0)
    {
        xPromptCtrl = top.$("<div id='_xPrompt_p'  class='_float_box'></div>");
    }
    else
    {
        xPromptCtrl.empty();
    }

    xPromptCtrl.height(options.height);
    xPromptCtrl.width(options.width);

    var titleCtrl = top.$("<div id='_xPrompt_title' style='height:40px;' class='_title'></div>").text(options.title);
}


function _MoveCtrl(nextCtrlName)
{
    if (window.event.keyCode == 13)
    {
        $("[name='" + nextCtrlName + "']")[0].focus();
    }
}

function _EditFldInfo()
{
    var rv = jTable.Call("GetTableInfo");
    if (rv)
    {
        var rvData = $.parseJSON(rv);
        _PageFloat({ "width": "800px", "height": "dock.right", "url": "/app/common/data/FldInfo/FldInfo.aspx?table=" + $.escape(rvData["table"]) + "&database=" + $.escape(rvData["database"]) });
    }
}

function _MoveTo(nextCtrlName)
{
    $("[name='" + nextCtrlName + "']")[0].focus();
}
function _IS_Enter(ctrlId)
{
    $("#_is_opts__" + ctrlId).show();
}
function _IS_Leave(ctrlId)
{
    $("#_is_opts__" + ctrlId).hide();
}
function _Label(option)
{
    var ctrl = $("<span class='label'></span>");
    if (option["css"])
    {
        ctrl.css(option.css);
    }
    if (option.text)
    {
        ctrl.text(option.text);
    }
    if (option.title)
    {
        ctrl.attr("title", option.title);
    }
    if (option.bgcolor)
    {
        ctrl.css("background-color", option.bgcolor);
    }

    return ctrl;
}
function _HideDock()
{
    $("div.dock").hide();
}

function _ReInput(input)
{
    $("input:text").prop("readonly", true);
    $(input).prop("readonly", false).focus().val("");
}

function __AppendCoid(obj)
{
    var oci, awci;
    if (typeof (_AuthorizeAndPartners) != "undefined")
    {
        oci = __OwnerCoid();
        awci = __AuthorizeCoid();
    }
    else
    {
        oci = $.rqs("owner_co_id");
        awci = $.rqs("authorize_co_id");
    }

    if (typeof (obj) == "string")
    {
        var args = {};
        if ($.isInt(oci))
        {
            args["owner_co_id"] = parseInt(oci);
        }
        if ($.isInt(awci))
        {
            args["authorize_co_id"] = parseInt(awci);
        }
        return _BuildPath(obj, args);
    }
    else if (typeof (obj) == "object")
    {
        if ($.isInt(oci))
        {
            obj.owner_co_id = parseInt(oci);
        }
        if ($.isInt(awci))
        {
            obj.authorize_co_id = parseInt(awci);
        }

        return obj;
    }
    else
    {
        $.msg("错误的__AppendCoid请求");
    }


    return obj;
}

function _BuildPath(path, args)
{
    if (args)
    {
        if (path.indexOf("?") != -1)
        {
            path += "&";
        }
        else
        {
            path += "?";
        }
        var ik = 0;
        for (var k in args)
        {
            var v = args[k];
            if (ik > 0)
            {
                path += "&";
            }
            path += k + "=" + $.escape(v);
            ik++;
        }
    }
    return path;
}


var __PRINT_URL = "/app/print/print/Printer.aspx";



function __CreatePrinterFrame()
{
    var __PrinterFrameHtml = '<div style="position:absolute; left:-1000px; top:-800px;z-index:-1;height:0px;overflow:hidden;">' +
        '<iframe src="/app/print/print/Printer.aspx?type=tags&sub_type=dp&ts=' + $.ts() + '" id="async" name="async" style="width:800px;height:600px;margin:0px;"></iframe>' +
        '</div>';

    return $(__PrinterFrameHtml);
}


function __CnpPrint(printForm, isCnpQuickPrint, callback, showWait)
{

    if (typeof (isCnpQuickPrint) == "undefined" || !isCnpQuickPrint)
    {
        printForm.preview = true;
        __PRINTX(printForm);
    }
    else
    {
        printForm.preview = false;

        if (!window.top.PrintAsync || typeof (window.top.PrintAsync) != "function")
        {
            $.msg("ERP系统连接菜鸟组件异常，请确保菜鸟组件开启的情况下，刷新ERP系统重新连接。");
        }
        else
        {
            window.top.PrintAsync("", printForm, callback, showWait);
        }
    }
}


function __PRINTX(printForm)
{
    __POST(__PRINT_URL, printForm);
}


function __POST(URL, PARAMS)
{
    var temp_form = document.createElement("form");
    temp_form.action = URL;
    temp_form.target = "_blank";
    temp_form.method = "post";
    temp_form.style.display = "none";

    for (var x in PARAMS)
    {
        var opt = document.createElement("textarea");
        opt.name = x;
        opt.value = PARAMS[x];

        temp_form.appendChild(opt);
    }

    document.body.appendChild(temp_form);
    temp_form.submit();
    document.body.removeChild(temp_form);
}


function ___Print(option)
{
    var path = "/app/print/print/print.aspx";
    if (option && option.path)
    {
        path = option.path;
    }
    if (option && option.arg)
    {
        if (path.indexOf("?") == -1)
        {
            path += "?";
        }
        else
        {
            path += "&";
        }
        path += option.arg;
    }
    var isPost = option.post || (option.ids && option.ids.join(",").length > 1500);
    if (!isPost && option.ids)
    {
        path += "&ids=" + option.ids.join(",");
    }
    if (path.indexOf("time=") == -1)
    {
        var nowTime = new Date();
        nowTime = nowTime.getHours() + "_" + nowTime.getMinutes() + "_" + nowTime.getSeconds();
        path += "&time=" + nowTime;
    }
    if (isPost && !option.ids)
    {
        option.ids = [];
    }

    var isJstBrowser = (typeof (app) != "undefined" && typeof (app.print) != "undefined");
    if (!(option.open === false) || isJstBrowser)
    {
        if (isJstBrowser)
        {
            if (path.indexOf("close=") == -1)
            {
                path += "&close=true";
            }
            path += "&hide=true";
        }
        if (isPost)
        {
            //            var postForm = ___PrintGetPostForm(option.form_id);
            if (option.delay)
            {
                setTimeout(function () { ___PrintPost("_blank", option, path); }, option.delay);
            }
            else
            {
                ___PrintPost("_blank", option, path);
            }
        }
        else
        {
            OpenAndVerify(path);
        }
    }
    else
    {
        var fid = option.frame_id ? option.frame_id : "___print_iframe";
        var o = $("#" + fid).remove();
        if (o.length > 0)
        {
            o.remove();
        }
        if (path.indexOf("&onlyone") == -1)
        {
            path += "&onlyone=true";
        }
        o = $("<iframe disabled='disabled' class='print_iframe'></iframe>").attr("id", fid).attr("name", fid).appendTo($(document.body));

        if (isPost)
        {
            if (option.delay)
            {
                setTimout(function () { ___PrintPost(fid, option, path); }, option.delay);
            }
            else
            {
                ___PrintPost(fid, option, path);
            }
        }
        else
        {
            o.attr("src", path);
        }
    }
}

function ___PrintPost(target, option, path)
{
    var postForm = ___PrintGetPostForm(option.form_id);
    postForm.ids.val("");
    postForm.attr("target", target);
    postForm.ids.val(option.ids.join(","));

    postForm.attr("action", path);
    postForm.submit();

    setTimeout(function ()
    {
        postForm.ids.val("");
        postForm.attr("action", "");
    }, 100);
}
function ___RemovePrint()
{
    $("#___print_form").remove();
    $("#___print_iframe").remove();
    $("iframe.print_iframe").remove();
}
function ___PrintGetPostForm(formId)
{
    formId = formId || "___print_form";

    var f = $("#" + formId).remove();

    if (f.length > 0)
    {
        f.remove();
    }

    f = $("<form target='_blank' id='" + formId + "' name='___" + formId + "' method='post'  style='display:none;'><input name='ids' id='___print_ids' type='hidden'/></form>").appendTo($(document.body))
    f.ids = f.find("#___print_ids");
    f.oids = f.find("#___print_oids");

    return f;
}

function _Print(option)
{
    ___Print(option);


}

function _I_VerifySearch()
{
    var verfiy = $(".s.date").verifyDates();
    if (!verfiy)
    {
        return false;
    }

    var verfiy = $(".s.numeric").verifyNumerics();
    if (!verfiy)
    {
        return false;
    }

    var verfiy = $(".s.int").verifyInts();
    if (!verfiy)
    {
        return false;
    }

    return true;
}

function _IS_Click(ctrlId, eventCtrl)
{
    $("#_is_opts__" + ctrlId).hide();
    eventCtrl = $(eventCtrl);
    var txt = eventCtrl.text();
    var id = eventCtrl.attr("id").substr(8);
    $("#" + ctrlId).attr("title", txt).attr("placeholder", txt).attr("name", id).focus();
    $("#_is_desc__" + ctrlId).text(txt);
}

function _CheckMusts()
{
    return $.checkMust();

}
function _SetIdName(srcId, toId)
{
    var idCtrl = $("#" + srcId);
    var toCtrl = $("#" + toId);
    toCtrl.attr("name", idCtrl.val());

    toCtrl.attr("title", $(idCtrl).find(":selected").text());
    toCtrl.focus();
}
function _CheckMust(ctrlId, msg)
{
    var value = $("#" + ctrlId).val();
    if (value == null || value == "")
    {
        $("#" + ctrlId).focus();
        if (typeof (msg) != "undefined")
        {
            $.msg(msg);
        }
        else
        {
            $.msg("该项必项");
        }
        return false;
    }

    return true;
}

function SetStatusColor(cell, statusText)
{
    var lowerStatusText = statusText.toLowerCase();

    if (lowerStatusText == "cancelled" || lowerStatusText == "cancel" || statusText == "作废" || statusText == "取消")
    {
        $(cell).css("background-color", "#ff0000").css("color", "#fff");
    }
    else if (lowerStatusText == "waitpay" || statusText == "待付款" || statusText == "下架" || lowerStatusText == "草拟")
    {
        $(cell).css("background-color", "#fffcd5").css("color", "#666");
    }
    else if (lowerStatusText == "merged" || statusText == "被合并" || lowerStatusText == "split" || statusText == "被拆分")
    {
        $(cell).css("background-color", "#ccc").css("color", "#333");
    }
    else if (lowerStatusText == "WaitOuterSent" || statusText == "等供销商发货" || statusText == "等供销商|外仓发货")
    {
        $(cell).css("background-color", "#d4fd94").css("color", "#333");
    }
    else if (lowerStatusText == "waitconfirm" || lowerStatusText == "waitprint" || statusText == "待打印" || statusText == "待审核" || statusText == "已付款待审核" || statusText == "待确认" || statusText == "待出库" || statusText == "待调拨" || lowerStatusText == "待入库")
    {
        $(cell).css("background-color", "#fde7ab").css("color", "#666");
    }
    else if (lowerStatusText == "waitdeliver" || statusText.indexOf("已审") != -1 || statusText == "已审核待配快递")
    {
        $(cell).css("background-color", "#e0fdad").css("color", "#017c1a");
    }
    else if (lowerStatusText == "waitconfirm" || statusText.indexOf("待财审") != -1 || statusText == "已客审待财审")
    {
        $(cell).css("background-color", "#e4b987").css("color", "#000");
    }
    else if (lowerStatusText == "question" || statusText.indexOf("问题") != -1 || statusText == "异常")
    {
        $(cell).css("background-color", "#a9834f").css("color", "#fff");
    }
    else if (lowerStatusText == "Delivering" || lowerStatusText == "waitdeliver" || lowerStatusText == "partprinted" || statusText == "部分打印" || statusText == "发货中" || statusText == "待发货" || statusText == "调拨中")
    {
        $(cell).css("background-color", "#c6e3ef").css("color", "#0a87ba");
    }
    else if (lowerStatusText == "confirm" || lowerStatusText == "printed" || lowerStatusText == "已打印" || lowerStatusText == "已出库" || lowerStatusText == "已入库" || lowerStatusText == "confirmed" || statusText == "生效" || statusText == "确认" || statusText == "已确认" || lowerStatusText == "waitreceive" || statusText == "待收货" || statusText == "待退款")
    {
        $(cell).css("background-color", "#abd46e").css("color", "#fff");
    }
    else if (lowerStatusText == "finished" || lowerStatusText == "Archive" || statusText == "归档" || lowerStatusText == "finish" || lowerStatusText == "sent" || statusText == "已发货" || statusText == "完成" || statusText == "已收货" || statusText == "退款完成")
    {
        $(cell).css("background-color", "#009f3c").css("color", "#fff");
    }
    else if (lowerStatusText == "VirtualFinished" || statusText == "虚拟完成")
    {
        $(cell).css("background-color", "#16c4e0").css("color", "#fff");
    }
    else
    {
        $(cell).css("background-color", "");
    }
}

function SearchReset()
{
    $(".s:not(:checkbox):not(:radio)").val("");
    if (typeof (Search) != "undefined")
    {
        Search();
    }
}
//function _Confirm(sText, fConfirm)
//{
//    if (top.__Confirm)
//    {
//        top.__Confirm(sText, fConfirm);
//    }
//    else
//    {
//        __Confirm(sText, fConfirm);
//    }
//}
function OpenAndVerify(path, name)
{
    var openWin = window.open(path);

    try
    {

        if (openWin)
        {
            if (openWin.close)
            {
            }
            else
            {
                $.msg("弹出窗口被浏览器拦截，请关闭浏览器对ERP系统的拦截功能。 如果有疑问请咨询ERP技术支持工程师");
            }
        }
        else
        {
            $.msg("弹出窗口被浏览器拦截，请关闭浏览器对ERP系统的拦截功能。 如果有疑问请咨询ERP技术支持工程师");

        }
    }
    catch (ex)
    {
        $.msg("弹出窗口被浏览器拦截，请关闭浏览器对ERP系统的拦截功能。 如果有疑问请咨询ERP技术支持工程师");
    }
}
function _Open(nameOrOptions, url, pic)
{
    OpenTabOrWindow(nameOrOptions, url, pic);
}
function OpenTabOrWindow(nameOrOptions, url, pic)
{
    if (typeof (top.OpenTab) != "undefined")
    {
        top.OpenTab(nameOrOptions, url, pic);
    }
    else
    {
        if (url)
        {
            window.open(url);
        }
        else
        {
            window.open(nameOrOptions.url);
        }
    }
}
function _PageFloat(options)
{
    var width = options.width;
    var height = options.height;
    var url = options.url;

    if (typeof (_Float) != "undefined")
    {
        if (!width)
        {
            width = _FloatCalcWidth(400, 100);
        }
        if (!height)
        {
            height = _FloatCalcHeight(400, 60);
        }
        _Float(url, width, height, options.close);
    }
    else
    {
        window.open(options.url);
    }

}
function _TopFloat(options)
{
    var width = options.width;
    var height = options.height;
    var url = options.url;
    if (options.name)
    {
        url = "/frame/tabframe.aspx?url=" + $.escape(url) + "&title=" + $.escape(options.name);
    }
    if (top._Float)
    {
        if (!width)
        {
            width = top._FloatCalcWidth(400, 100);
        }
        if (!height)
        {
            height = top._FloatCalcHeight(400, 60);
        }
        top._Float(url, width, height, options.close);
    }
    else if (typeof (_Float) != "undefined")
    {
        if (!width)
        {
            width = _FloatCalcWidth(400, 100);
        }
        if (!height)
        {
            height = _FloatCalcHeight(400, 60);
        }
        _Float(url, width, height, options.close);
    }
    else
    {
        window.open(options.url);
    }

}

function getUrlParam(name)
{
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}


function RegMaxWindow()
{

    if (typeof (top.MaxWindow) != "undefined")
    {
        var pFrame;

        if (!pFrame)
        {
            var iframes = window.parent.document.getElementsByTagName("iframe");
            for (var i = 0; i < iframes.length; i++)
            {
                if (iframes[i].contentWindow == window)
                {
                    pFrame = iframes[i];
                    break;
                }
            }

        }


        top.MaxWindow(window, pFrame, !$(pFrame).hasClass("max_window"));

    }
}


// 对Date的扩展，将 Date 转化为指定格式的String   
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)    
Date.prototype.Format = function (fmt)
{ //author: meizz   
    var o = {
        "M+": this.getMonth() + 1,                 //月份   
        "d+": this.getDate(),                    //日   
        "h+": this.getHours(),                   //小时   
        "m+": this.getMinutes(),                 //分   
        "s+": this.getSeconds(),                 //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds()             //毫秒   
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}



///
/// dialog
///
try
{

    //选项卡
    $.fn.MyTabsSlider = function ()
    {
        var _tabs = $(this);

        //设置必要样式
        _tabs.css("overflow", "hidden");
        _tabs.css("background-color", "#fff");
        _tabs.css("padding", "0");

        _tabs.find(".tabbar_bar").css("padding", "2px 16px 0");
        _tabs.find(".tabbar_bar").css("position", "absolute");
        _tabs.find(".tabbar_bar").css("z-index", "3");

        //补齐线条
        _tabs.append('<div style="border-bottom:1px solid #ddd;width:100%;position:absolute;top:37px;z-index:2;"></div>');

        var _tabs_left_html = '<div class="tabs_move_left" style="width:16px;height:100%;background-color:#fff;position:absolute;top:0;left:0;z-index:3;display:none;cursor:pointer;"><img src="/image/pre.gif" style="position:absolute;top:50%;left:0;margin-top:-8px;"></img></div>';
        var _tabs_right_html = '<div class="tabs_move_right" style="width:16px;height:100%;background-color:#fff;position:absolute;top:0;right:0;z-index:3;display:none;cursor:pointer;"><img src="/image/next.gif" style="position:absolute;top:50%;left:0;margin-top:-8px;"></img></div>';
        _tabs.append(_tabs_left_html);
        _tabs.append(_tabs_right_html);

        var _tabs_bar_width = 2;
        _tabs.find(".tabbar_tab, .tabbar_spt ").each(function ()
        {
            _tabs_bar_width += $(this).outerWidth(true);
        });
        _tabs.find(".tabbar_bar").width(_tabs_bar_width);

        //容器宽度小于选项卡容器宽度时
        _tabs.width(_tabs.parent().width());
        if (_tabs.width() < _tabs.find(".tabbar_bar").outerWidth(true))
        {
            _tabs.find(".tabs_move_left").show();
            _tabs.find(".tabs_move_right").show();
        } else
        {
            _tabs.find(".tabbar_bar").css("left", "0");
            _tabs.find(".tabbar_bar").css("top", "0");

            _tabs.find(".tabs_move_left").hide();
            _tabs.find(".tabs_move_right").hide();
        }

        //页面的大小变动事件
        $(window).resize(function ()
        {
            //容器宽度小于选项卡容器宽度时
            _tabs.width(_tabs.parent().width());
            if (_tabs.width() < _tabs.find(".tabbar_bar").outerWidth(true))
            {
                _tabs.find(".tabs_move_left").show();
                _tabs.find(".tabs_move_right").show();
            } else
            {
                _tabs.find(".tabbar_bar").css("left", "0");
                _tabs.find(".tabbar_bar").css("top", "0");

                _tabs.find(".tabs_move_left").hide();
                _tabs.find(".tabs_move_right").hide();
            }
        });

        _tabs.find(".tabs_move_left").click(function ()
        {
            var _left = _tabs.find(".tabbar_bar").position().left;
            var _list = _tabs.find(".tabbar_tab");

            for (var i = 0; i < _list.length; i++)
            {
                var _item_left = _list.eq(i).position().left;
                var _item_width = _list.eq(i).outerWidth(true);

                if (_item_left + _item_width + _left + 16 >= 0)
                {
                    //如果已经是第一个节点
                    if (i < 1)
                    {
                        _tabs.find(".tabbar_bar").css("left", "0");
                    } else
                    {
                        _left = 16 - _item_left + _list.eq(i - 1).outerWidth(true) / 2;
                        _tabs.find(".tabbar_bar").css("left", _left + "px");
                    }
                    break;
                }
            }
        });

        _tabs.find(".tabs_move_right").click(function ()
        {
            var _left = _tabs.find(".tabbar_bar").position().left;
            var _list = _tabs.find(".tabbar_tab");

            for (var i = _list.length - 1; i >= 0; i--)
            {
                var _item_left = _list.eq(i).position().left;
                var _item_width = _list.eq(i).outerWidth(true);

                if (_left + _item_left - _tabs.outerWidth() <= 0)
                {
                    if (i > _list.length - 2)
                    {
                        _left = -1 - _tabs.find(".tabbar_bar").outerWidth(true) + _tabs.outerWidth();
                        _tabs.find(".tabbar_bar").css("left", _left + "px");
                    } else
                    {
                        _left = 0 - _item_left - _list.eq(i + 1).outerWidth(true) / 2 - _item_width + _tabs.outerWidth();
                        _tabs.find(".tabbar_bar").css("left", _left + "px");
                    }
                    break;
                }
            }
        });

        _tabs.find(".tabs_move_left, .tabs_move_right").hover(function ()
        {
            $(this).css("background-color", "#f3f3f3");
        }, function ()
        {
            $(this).css("background-color", "#fff");
        });
    }

} catch (e)
{

}


var FrameError = "ERP框架顶层连接菜鸟的插件异常，请尝试确保菜鸟组件开启的情况下，刷新ERP系统。";
var PRINTER = {};

PRINTER.showPrintWait = function ()
{
    var waitDiv = $("div.wait_print");
    if (waitDiv.length == 0)
    {
        waitDiv = $("<div class='wait_print'></div>").prependTo($(document.body));
    }

    waitDiv.show();
};

PRINTER.hidePrintWait = function ()
{
    $("div.wait_print").hide();
};


PRINTER.showPreviewPDF = function ()
{
    var waitDiv = $("div.preview_to_pdf");
    if (waitDiv.length == 0)
    {
        waitDiv = $("<div class='preview_to_pdf'></div>").prependTo($(document.body));
    }

    waitDiv.show();
};

PRINTER.hidePreviewPDF = function ()
{
    $("div.preview_to_pdf").hide();
};

//验证是否为数字
function isNumber(value)
{
    var patrn = /^(-)?\d+(\.\d+)?$/;
    if (patrn.test(value))
    {
        return true;
    } else
    {
        return false;
    }
}

//验证大于零的数字，并返回保留位数
function validationNumber(txt, num)
{
    var regu = /^[0-9]+\.?[0-9]*$/;
    if (txt != "")
    {
        if (!regu.test(txt))
        {
            return false;
        }
    }
    return true;
}

//验证是否为整数
function isInt(value)
{
    var patrn = /^(-)?\d+?$/;
    if (patrn.test(value))
    {
        return true;
    } else
    {
        return false;
    }
}

//验证正整数
function verifyPositiveInteger(txt)
{
    var z = /^[0-9]*$/;
    if (z.test(txt))
    {
        return true;
    } else
    {
        return false;
    };
}
//数字转 都逗号  123,312.80
var NumberChange = {
    parseTxt: function (txt, pointlen)
    {
        var len = -1;
        if (!isNaN(pointlen) && parseInt(pointlen) >= 0)
        {
            len = parseInt(pointlen);
        }

        if (txt == "0" || txt == 0)
        {
            if (len >= 0)
            {
                var l = "0000000000000";
                txt = txt.toString() + "." + l.substring(0, len);
            }
            return txt;
        }
        if (txt == null || txt == "")
        {
            return "";
        }
        txt = txt.toString();
        var v = txt.split(".");
        if (v.length > 1 && len >= 0)
        {
            v[1] = v[1] + "0000000000000";
            v[1] = v[1].substring(0, len);
        }

        var str = v[0];
        var re = /(?=(?!(\b))(\d{3})+$)/g;
        str = str.replace(re, ",");
        if (v.length > 1)
        {
            str = str + "." + v[1];
        }
        return str;
    },
    parseNum: function (txt)
    {
        if (txt == null || txt == "")
        {
            return "";
        }
        txt = txt.toString();
        while (txt.indexOf(",") != -1)
        {
            txt = txt.replace(",", "");
        }
        return txt;
    }
}

var _Help_Mag =
{
    msgobj: null,
    init: function ()
    {
        $("body").delegate(".jst-help", "mouseover", function ()
        {
            if (_Help_Mag.msgobj != null)
            {
                _Help_Mag.hide();
            }
            var txt = $(this).attr("jst-help-msg");
            var layer = $("<div class='jst-help-layer'style='display:none;'><div>").appendTo($("body"));
            var box = $("<div class='jst-help-class' ><div>").appendTo($(layer));
            if ($(this).hasClass("jst-help-big"))
            {
                $(box).addClass("jst-help-big");
            }
            else if ($(this).hasClass("jst-help-large"))
            {
                $(box).addClass("jst-help-large");
            }
            if ($(this).hasClass("jst-help-up") == true)
            {
                $(box).addClass("jst-help-up");
            }
            else
            {
                $(box).addClass("jst-help-down");
            }
            if ($(this).hasClass("jst-help-left") == true)
            {
                $(box).addClass("jst-help-left");
            }
            else
            {
                $(box).addClass("jst-help-right");
            }
            var inner = $("<div class='jst-help-inner'></div>").appendTo($(box));
            $(inner).html(txt);

            var l = $(this).position().left;
            var t = $(this).position().top;
            var h = $(this).outerHeight(true);
            var w = $(layer).outerWidth(true);
            if ($(this).hasClass("jst-help-up") == true)
            {
                var _h = $(layer).outerHeight(true);
                $(layer).css("top", t - _h - 1);
            }
            else
            {
                $(layer).css("top", h + t + 1);
            }

            if ($(this).hasClass("jst-help-left") == true)
            {
                $(layer).css("left", l - w + 24);
            }
            else
            {
                $(layer).css("left", l - 10);
            }
            $(layer).slideDown(30);
            _Help_Mag.msgobj = layer;
        });

        $("body").delegate(".jst-help", "mouseout", function ()
        {
            _Help_Mag.hide();
        });
    },
    hide: function ()
    {
        _Help_Mag.msgobj.remove();
        _Help_Mag.msgobj = null;
    }
}

function GroupPicker(arg)
{
    if (typeof (arg.auto_position) == "undefined")
    {
        arg.auto_position = false;
    }
    if (!arg.title)
    {
        arg.title = "请选择";
    }
    if (!arg.width)
    {
        arg.width = "680px";
    }
    if (!arg.height)
    {
        arg.height = "480px";
    }
    if (arg.keys == null || arg.keys == undefined)
    {
        arg.keys = [];
    }
    var ctrl = $("<div style='padding:8px;line-height:20px;height:100%;overflow:auto;padding-top:5px;padding-bottom:5px;padding-right:40px;'></div>");
    var ctrlType = arg.ctrl_type;

    if (!ctrlType)
    {
        ctrlType = "radio";
    }
    var gName = "gp_" + $.ts();

    var tags = arg.tags;

    var colCount = tags.length > 28 ? 2 : 1;

    var tagBar = $("<table style='position:absolute;top:10px;left:100%;margin-left:-36px;'></table>").appendTo(ctrl);
    if (colCount == 2)
    {
        tagBar.css("margin-left", "-48px");
    }
    var allTagCtrls = {};
    var allCharPanel = [];
    var allOptions = [];
    var tagTr;
    for (var i = 0; i < tags.length; i++)
    {
        var tag = tags[i];
        if (i % colCount == 0)
        {
            tagTr = $("<tr style='cursor:pointer;'></tr>").appendTo(tagBar);
        }
        var tagTd = $("<td style='width:16px;'></td>").text(tag).appendTo(tagTr);

        var charPanel = $("<div style='padding:10px;'></div>").appendTo(ctrl);
        allCharPanel.push(charPanel);
        var tagLine = $("<div style='' class='b'></div>").appendTo(charPanel).text(tag);
        var tagChar = tag;
        GroupPickerGoto(tagTd, charPanel);

        allTagCtrls[tagChar] = tagLine;
        if (tagChar == "#")
        {
            tagChar = "_";
        }

        options = arg.options[tag];


        for (var j = 0; j < options.length; j++)
        {
            _PickerIndex++;
            var opt = options[j];


            var v = opt.v;
            var t = opt.t;
            if (!v && v != 0 && v != "0")
            {
                v = t;
            }
            else if (!t)
            {
                t = v;
            }

            opt.v = v;
            var id = "dc___" + _PickerIndex;

            if (ctrlType == "checkbox")
            {
                var optDiv = $("<div class='cbx'></div>").appendTo(charPanel);
                var optCbx = $("<input type='checkbox' id='" + id + "'/>").appendTo(optDiv).attr("name", gName);

                if (arg.keys.contains(opt.v))
                {
                    optCbx.attr("checked", "checked")
                }
                var optSpan = $("<span class='cbx nobr'><span class='cbx-checked'></span></span>").appendTo(optDiv);
                var optLabel = $("<label class='c6'></label>").appendTo(ctrl).attr("for", id).appendTo(optDiv).txt(t);
                opt.char_panel = charPanel;
                opt.div = optDiv;
                opt.ctrl = optCbx;
            }
            else if (ctrlType == "radio")
            {
                var optDiv = $("<div class='rdo'></div>").appendTo(charPanel);
                opt.div = optDiv;

                var optRdo = $("<input type='radio' id='" + id + "' name='" + gName + "'/>").appendTo(optDiv);
                var optSpan = $("<span class='rdo nobr'><span class='rdo-checked'></span></span>").appendTo(optDiv);
                var optLabel = $("<label class='c6'></label>").appendTo(charPanel).attr("for", id).appendTo(optDiv).txt(t);
                opt.char_panel = charPanel;
                opt.ctrl = optRdo;
            }


            allOptions.push(opt);
        }

    }
    arg.all_options = allOptions;
    arg.ctrl = ctrl;

    var tb = $("<div></div>");

    if (ctrlType == "checkbox")
    {
        _PickerIndex++;
        var id = "dc___" + _PickerIndex;
        var optDiv = $("<div class='cbx' style='display:inline-block;float:left;margin-right:10px;'></div>").appendTo(tb);
        var optAllCbx = $("<input type='checkbox' id='" + id + "'/>").appendTo(optDiv).attr("name", gName);
        var optSpan = $("<span class='cbx'><span class='cbx-checked'></span></span>").appendTo(optDiv);
        var optLabel = $("<label class='c6'>{全选} </label>").appendTo(ctrl).attr("for", id).appendTo(optDiv);


        optAllCbx.click(function ()
        {
            var checked = optAllCbx.prop("checked");

            for (var i = 0; i < arg.all_options.length; i++)
            {
                var opt = arg.all_options[i];
                if (!opt.hide)
                {
                    opt.ctrl.prop("checked", checked);
                }
            }
        });
    }

    var searchCtrl = $("<input type='text' class='input_text search' placeholder='回车搜索' style='width:140px;float:left;'/>").appendTo(tb);
    searchCtrl.keydown(function (e)
    {
        var showCharPanel = [];
        if (e.keyCode == 13)
        {
            var sv = searchCtrl.val().toUpperCase();
            var showTag = {};
            for (var i = 0; i < arg.all_options.length; i++)
            {
                var opt = arg.all_options[i];

                if (sv == "")
                {
                    opt.div.show();
                    opt.hide = false;
                    showTag.all = true;
                }
                if (opt.t.toUpperCase().indexOf(sv) >= 0 || opt.py.toUpperCase().indexOf(sv) == 0)
                {
                    opt.div.show();
                    showCharPanel.push(opt.char_panel);
                    opt.hide = false;
                    showTag[opt.tag] = true;

                }
                else
                {
                    opt.hide = true;
                    opt.div.hide();
                }
            }

            if (showTag.all)
            {
                for (var tagChar in allTagCtrls)
                {
                    allTagCtrls[tagChar].show();
                }

                for (var i = 0; i < allCharPanel.length; i++)
                {
                    allCharPanel[i].show();
                }
            }
            else
            {
                for (var tagChar in allTagCtrls)
                {
                    allTagCtrls[tagChar].hide();
                }
                for (var i = 0; i < allCharPanel.length; i++)
                {
                    allCharPanel[i].hide();
                }
                for (var tagChar in showTag)
                {
                    allTagCtrls[tagChar].show();
                }

                for (var i = 0; i < showCharPanel.length; i++)
                {
                    showCharPanel[i].show();
                }
            }
        }
    });
    var tools = [];

    if (arg.tools)
    {
        for (var i = 0; i < arg.tools.length; i++)
        {
            tools.splice(i, 0, arg.tools[i]);
        }
    }

    tools.push({
        text: "确定", click: function ()
        {
            var rv = {};
            for (var i = 0; i < arg.all_options.length; i++)
            {
                var opt = arg.all_options[i];
                if (opt.ctrl.prop("checked") && !opt.hide)
                {
                    if (arg.ctrl_type == "radio")
                    {
                        rv.v = opt.v;
                        rv.t = opt.t;
                        break;
                    }
                    else
                    {
                        rv[opt.v] = opt.t;
                    }
                }
            }

            parent._Dialog.Close(arg, rv);
        }
    });

    for (var i = 0; i < tools.length; i++)
    {
        tb.append(_Dialog.BuildTool(tools[i], i == tools.length - 1, arg));
    }

    arg.toolbar = { ctrl: tb };

    dialog(arg);
    if (_DrpCoidFromArg.groupPickerLoadedCallBack != null && _DrpCoidFromArg.groupPickerLoadedCallBack != undefined)
    {
        _DrpCoidFromArg.groupPickerLoadedCallBack();
    }
}
function GroupPickerGoto(tagTd, charPanel)
{
    tagTd.click(function ()
    {
        charPanel[0].scrollIntoView({ block: "center" });
        charPanel.addClass("goto-active");
        setTimeout(function ()
        {
            charPanel.removeClass("goto-active");
        }, 1000);
    });
}
var _PickerIndex = 0;
function CheckboxPicker(arg)
{
    if (!arg.title)
    {
        arg.title = "请选择";
    }
    if (!arg.width)
    {
        arg.width = "680px";
    }
    if (!arg.height)
    {
        arg.height = "480px";
    }
    var ctrl = $("<div style='padding:20px;line-height:20px;height:100%;overflow:auto;'></div>");

    if (!arg.options)
    {
        if (arg.texts)
        {
            arg.options = [];
            var checkeds = arg.checkeds;
            if (!checkeds)
            {
                checkeds = [];
            }
            for (var i = 0; i < arg.texts.length; i++)
            {
                var v = arg.texts[i];
                var opt = { v: v };

                if (checkeds.contains(v))
                {
                    opt["checked"] = true;
                }
                arg.options.push(opt);
            }
        }
        else
        {
            $.msg("请指定options:[{v:\"id1\",t:\"值\"}]");

            return;
        }
    }
    var options = arg.options;
    _PickerIndex++;
    var id = "_dc__" + _PickerIndex;
    var optDiv = $("<div class='cbx' style='margin-bottom:20px;'></div>").appendTo(ctrl);
    var optAllCbx = $("<input type='checkbox' id='" + id + "'/>").appendTo(optDiv);
    var optSpan = $("<span class='cbx'><span class='cbx-checked'></span></span>").appendTo(optDiv);
    var optLabel = $("<label class='c6'>{全选}</label>").appendTo(ctrl).attr("for", id).appendTo(optDiv);

    for (var i = 0; i < options.length; i++)
    {
        _PickerIndex++;
        var opt = options[i];
        var v = opt.v;
        var t = opt.t;
        if (!v && v != 0 && v != "0")
        {
            v = t;
        }
        else if (!t)
        {
            t = v;
        }

        opt.v = v;

        var id = "_dc__" + _PickerIndex;
        var optDiv = $("<div class='cbx'></div>").appendTo(ctrl);
        var optCbx = $("<input type='checkbox' id='" + id + "'/>").appendTo(optDiv);
        if (opt.checked)
        {
            optCbx.prop("checked", true);
        }
        var optSpan = $("<span class='cbx nobr'><span class='cbx-checked'></span></span>").appendTo(optDiv);
        var optLabel = $("<label class='c6'></label>").appendTo(ctrl).attr("for", id).appendTo(optDiv).txt(t);

        opt.cbx = optCbx;
    }

    optAllCbx.click(function ()
    {
        var checked = optAllCbx.prop("checked");
        for (var i = 0; i < options.length; i++)
        {
            var opt = options[i];
            opt.cbx.prop("checked", checked);
        }
    });

    arg.ctrl = ctrl;
    arg.toolbar = {
        tools: [{
            text: "确定", click: function ()
            {
                var rv = [];
                for (var i = 0; i < options.length; i++)
                {
                    var opt = options[i];
                    if (opt.cbx.prop("checked"))
                    {
                        rv.push(opt.v);
                    }
                }

                dialogClose(rv);
            }
        }]
    };

    if (arg.tools)
    {
        for (var i = 0; i < arg.tools.length; i++)
        {
            arg.toolbar.tools.splice(i, 0, arg.tools[i]);
        }
    }

    dialog(arg);
}


function RadioPicker(arg)
{
    if (!arg.title)
    {
        arg.title = "请选择";
    }
    if (!arg.width)
    {
        arg.width = "680px";
    }
    if (!arg.height)
    {
        arg.height = "480px";
    }
    var ctrl = $("<div style='padding:20px;line-height:20px;height:100%;overflow:auto;'></div>");

    if (!arg.options)
    {
        if (arg.texts)
        {
            arg.options = [];
            for (var i = 0; i < arg.texts.length; i++)
            {
                arg.options.push({ v: arg.texts[i] });
            }
        }
        else
        {
            $.msg("请指定options:[{v:\"id1\",t:\"值\"}]");

            return;
        }
    }
    var options = arg.options;

    for (var i = 0; i < options.length; i++)
    {
        _PickerIndex++;
        var opt = options[i];
        var v = opt.v;
        var t = opt.t;
        if (!v && v != 0 && v != "0")
        {
            v = t;
        }
        else if (!t)
        {
            t = v;
        }

        opt.v = v;
        var id = "_dc__" + _PickerIndex;
        var optDiv = $("<div class='rdo'></div>").appendTo(ctrl);
        var optRdo = $("<input type='radio' id='" + id + "' name='_dialog_RadioPicker___'/>").appendTo(optDiv);
        var optSpan = $("<span class='rdo nobr'><span class='rdo-checked'></span></span>").appendTo(optDiv);
        var optLabel = $("<label class='c6'></label>").appendTo(ctrl).attr("for", id).appendTo(optDiv).txt(t);

        opt.rdo = optRdo;
    }

    arg.ctrl = ctrl;
    arg.toolbar = {
        tools: [{
            text: "确定", click: function ()
            {

                for (var i = 0; i < options.length; i++)
                {
                    var opt = options[i];
                    if (opt.rdo.prop("checked"))
                    {
                        dialogClose(opt.v);
                        return;
                    }
                }

                $.msg("未选择任何数据");

                return;
            }
        }]
    };

    if (arg.tools)
    {
        for (var i = 0; i < arg.tools.length; i++)
        {
            arg.toolbar.tools.splice(i, 0, arg.tools[i]);
        }
    }

    dialog(arg);
}

function DisplayCollapse(ct)
{

    ct.click(function (e)
    {
        var srcElement = $(e.srcElement);
        if (srcElement.hasClass("btn_blue"))
        {
            return;
        }
        if (srcElement.hasClass("btn"))
        {
            return;
        }
        if (srcElement.hasClass("disable-collapse"))
        {
            return;
        }

        console.log(e);

        var ctp = ct.parent();
        var p = ctp.children(".collapse-content");
        var icon = ctp.find(".collapse-open,.collapse-close");
        if (p.css("display") == "none")
        {
            p.show();
            icon.removeClass("collapse-close").addClass("collapse-open");
        }
        else
        {
            p.hide();
            icon.removeClass("collapse-open").addClass("collapse-close");
        }
    });
}


function DisplayTab(tabbarCtrl)
{
    var tabs = tabbarCtrl.find(".h-tab,.v-tab");


    var allTabs = {};
    for (var i = 0; i < tabs.length; i++)
    {
        var tab = $(tabs[i]);
        var forid = tab.attr("for");
        if (forid)
        {
            allTabs[forid] = tab;
        }
    }
    for (var i = 0; i < tabs.length; i++)
    {
        var tab = $(tabs[i]);
        DisplayActiveTab(tab, allTabs);
    }


}

function DisplayActiveTab(eventTab, allTabs)
{
    var eventForid = eventTab.attr("for");
    if (!eventForid)
    {
        return;
    }
    eventTab.click(function ()
    {
        for (var forid in allTabs)
        {
            var tab = allTabs[forid];
            tab.removeClass("active");
            $("#" + forid).hide();
        }
        eventTab.addClass("active");
        $("#" + eventForid).show();
    });
}
var _IsReady = false;
function CommonReady()
{
    if (typeof ($) == "undefined")
    {
        setTimeout(CommonReady, 1000);
    }
    else
    {
        if (_IsReady)
        {
            return;
        }
        _IsReady = true;
        $(document).ready(function ()
        {
            $(".collapse-head").each(function ()
            {
                DisplayCollapse($(this));
            });

            $(".tabbar.h-tab,.tabbar.v-tab").each(function ()
            {
                DisplayTab($(this));
            });

            $("span.clear,div.clear").attr("title", "清空内容").click(function ()
            {
                var c = $(this);
                var ip = c.siblings("input");
                if (!ip.prop("disabled"))
                {
                    ip.val("").focus();
                }
            });
            $(":text.s").prop("autocomplete", "off");
        });
    }
}

try
{
    CommonReady();
}
catch (e)
{
}

var _LS_ = {};
_LS_.setItem = function (k, v)
{
    if (window.localStorage)
    {
        window.localStorage.setItem(k, v);
    }
    else
    {
        $.cookie(k, v);
    }
}

_LS_.getItem = function (k)
{
    if (window.localStorage)
    {
        return window.localStorage.getItem(k);
    }
    else
    {
        return $.cookie(k);
    }
}



function BindClickCheck(bindControl, arg)
{
    if (typeof (arg) == "undefined")
    {
        arg = { ctrlKey: true };
    }
    else
    {
        if (typeof (arg.ctrlKey) == "undefined")
        {
            arg.ctrlKey = true;
        }
    }

    if (!bindControl.attr("title"))
    {
        if (arg.ctrlKey)
        {
            bindControl.attr("title", "支持ctrl键或者shift键进行范围选择");
        }
        else
        {
            bindControl.attr("title", "支持shift键进行范围选择");
        }
    }
    var FindUntil = function (r, activeRow)
    {
        var nextAll = r.nextAll();
        var prevAll = r.prevAll();
        var rvRows = new Array();

        var toRow = activeRow[0];

        for (var j = 0; j < nextAll.length; j++)
        {
            rvRows.push(nextAll[j]);

            if (nextAll[j] == toRow)
            {
                rvRows.push(r);
                return rvRows;
            }
        }

        rvRows = new Array();
        for (var j = 0; j < prevAll.length; j++)
        {
            rvRows.push(prevAll[j]);
            if (prevAll[j] == toRow)
            {
                rvRows.push(r);
                return rvRows;
            }
        }

        return new Array(r);
    }
    var frs = bindControl.find(".row,tr");

    frs.click(function (e)
    {
        if (!e.shiftKey)
        {
            bindControl.unbind("selectstart");
        }
        else
        {
            bindControl.bind("selectstart", function (e) { return false; });
        }
        var r = $(this);
        var activeRow = bindControl.find(".row.active,tr.active");
        if (activeRow.length == 0)
        {
            r.addClass("active");
            if (!e.ctrlKey)
            {
                if (r.find(":checkbox:first").prop("checked"))
                {
                    r.addClass("checked");
                }
                else
                {
                    r.removeClass("checked");
                }
                return;
            }
            activeRow = r;
        }

        if (e.ctrlKey && arg.ctrlKey)
        {
            var cbx = r.find(":checkbox:first");
            if (cbx.prop("checked"))
            {
                cbx.prop("checked", false);
                r.removeClass("checked");
            }
            else
            {
                cbx.prop("checked", true);
                r.addClass("checked");
            }
        }
        else if (e.shiftKey)
        {

            bindControl.find(".row,tr").each(function ()
            {
                $(this).removeClass("checked").find(":checkbox:first").prop("checked", false);
            });
            var rs = FindUntil(r, activeRow);

            for (var i = 0; i < rs.length; i++)
            {
                var fr = $(rs[i]);
                var cbx = fr.find(":checkbox:first");

                if (!cbx.hasClass("checkall"))
                {
                    cbx.prop("checked", true);
                    fr.addClass("checked");
                }
            }

        }
        else
        {
            activeRow.removeClass("active");
            r.addClass("active");

            if (r.find(":checkbox:first").prop("checked"))
            {
                r.addClass("checked");
            }
            else
            {
                r.removeClass("checked");
            }
        }

    });
}

//检查图片地址，防止非法图片地址请求自己的服务器
function CheckImgUrl(v)
{
    if (v)
    {
        if (v.indexOf("http://") == 0 || v.indexOf("https://") == 0 || v.indexOf("//") == 0)
        {
            return v;
        }
    }

    return "//";//防止请求当前页面，返回空字符串也会请求当前页面
}

/**
 * 判断是不是数组
 * @param {any} value
 */
function isArrayData(value)
{
    if (typeof Array.isArray === "function")
    {
        return Array.isArray(value);
    }
    else
    {
        return Object.prototype.toString.call(value) === "[object Array]";
    }
}

/**
 * 
 * @param {any} orderDatas 需要解密的订单信息列表
 */
function DeOrderData(orderDatas, databaseName)
{
    if (isArrayData(orderDatas))
    {
        for (var i = 0; i < orderDatas.length; i++)
        {
            orderDatas[i].__js_index = i;
        }

        var pinDuoDuoArray = new Array();

        for (var i = 0; i < orderDatas.length; i++)
        {
            if ("shop_site" in orderDatas[i] && orderDatas[i].shop_site === __ShopSitePinDuoDuo)
            {
                pinDuoDuoArray.push(orderDatas[i]);
            }
        }

        __DePinDuoDuoOrderData(pinDuoDuoArray, databaseName);
    }
    else
    {
        var newOrders = new Array();
        newOrders.push(orderDatas);
        DeOrderData(newOrders);
    }
}


__ShopSitePinDuoDuo = "拼多多";


function __DePinDuoDuoOrderData(orderDatas, database)
{

    console.log("PinDuoDuoDatabase:" + database);
    var request = BuildPinDuoDuoRequest(orderDatas, true, database);

    var response;
    $.ajax({
        url: "http://pddtest.erp321.com/order/getOrdersByIds",    //请求的url地址
        dataType: "json",   //返回格式为json
        type: "POST",
        async: false,
        data: request,
        success: function (data)
        {
            console.log(data);
            response = data;
        },
        error: function (errData)
        {
            console.log("error");
            console.log(errData);
        }
    });

    if (response == undefined || response == null)
    {
        $.msg("拼多多加密请求返回报文异常");
        return;
    }

    if (response.rspcode != "0000")
    {
        $.msg("请求拼多多解密失败，服务端返回消息：" + response.rspmsg);
        return;
    }

    console.log(orderDatas);
    var deOrders = response.data;

    console.log(deOrders);
    if (isArrayData(deOrders))
    {
        var j = 0;
        for (var i = 0; i < deOrders.length; i++)
        {
            var searchCount = 0;
            do
            {
                var orderData = orderDatas[j];

                if (orderData.so_id !== deOrders[i].so_id)
                {
                    ++searchCount;
                    continue;
                }

                jQuery.each(deOrders[i], function (key, val)
                {
                    if (key === "so_id")
                    {
                        return;
                    }

                    orderData[key] = val;
                });

                ++searchCount;
            } while (searchCount < orderDatas.length)
        }
    }

    console.log("解密");
    console.log(orderDatas);
}


/**
 * 组装拼多多解密请求报文
 * @param {any} orderDatas 拼多多订单信息
 * @param {any} isArray 是不是数组
 */
function BuildPinDuoDuoRequest(orderDatas, databaseName)
{
    var request = { 'database': __PinDuoDuoDatabase };

    if (databaseName != undefined && databaseName)
    {
        request.database = databaseName
    }

    var orderIds = new Array();

    for (var i = 0; i < orderDatas.length; i++)
    {
        if ("so_id" in orderDatas[i] && orderDatas[i].so_id != undefined && orderDatas[i].so_id.length > 0)
        {
            orderIds.push(orderDatas[i].so_id);
        }
    }

    request.orderIds = orderIds.join(",");
    request.timestamp = 1111;
    request.sign = "ssss";
    return request;
}


function ShowActionSetting(type)
{
    _Float("/app/user/ActionSetting/ActionSetting.aspx?type="+type+"", "700px", "dock.right", function (rv)
    {
        if (rv)
        {
            document.location.reload(true);
        }
    });
}