var _msg_color = "#ff0000";
var _Msg_OnClose = null;
var _Msg_Close = true;
var _Msg_AddEvent = false;
var _Msg_Ver = 2.1;
function _Msg(sMsg, iTimeout, onClose)
{
    var opt = {};
    if (sMsg.text || sMsg.html)
    {
        opt = sMsg;
        if (opt.timeout)
        {
            iTimeout = opt.timeout;
        }
        else if (opt.close)
        {
            onClose = opt.close;
        }
       
        if (opt.html)
        {
            sMsg = "@" + opt.html;
        }
        else
        {
            sMsg = opt.text;
        }
    }
    var msgBody = $("#msg_body");
    if (opt.width)
    {
        msgBody.width(opt.width);
    }
    else
    {
        msgBody.width("450px");
    }
    if (sMsg == null)
    {
        return;
    }
    sMsg = sMsg + "";

    if (typeof (onClose) == "undefined")
    {
        _Msg_OnClose = null;
    }
    else
    {
        _Msg_OnClose = onClose;
    }
    var oDiv = $("#msg_top").one("keydown", function (e)
    {
        _MsgCheckHide(e);
    });
    var oText = $("#msg_text").css("max-height", ($(document.body).outerHeight() - 100) + "px");
    if (sMsg.indexOf("@") != 0)
    {
        oText.text(sMsg);
        sMsg = $(oText).html();
        sMsg = sMsg.replace(/\n/ig, "<br/>");
        sMsg = sMsg.replace(/`/g, "<br/>");
        $(oText).html(sMsg);
    }
    else
    {
        sMsg = sMsg.substr(1);
        sMsg = sMsg.rpl("<span", "__SPAN__").rpl("</span", "--SPAN--").rpl("<SPAN", "__SPAN__").rpl("</SPAN", "--SPAN--");
        sMsg = sMsg.rpl("<div", "__DIV__").rpl("</div", "--DIV--").rpl("<DIV", "__DIV__").rpl("</DIV", "--DIV--");
        sMsg = sMsg.rpl("<", "＜");
        sMsg = sMsg.rpl(" class", "__class__").rpl(" style", "__style__");
        sMsg = sMsg.rpl(" ", "　");
        sMsg = sMsg.rpl("__SPAN__", "<span").rpl("--SPAN--", "</span");
        sMsg = sMsg.rpl("__DIV__", "<div").rpl("--DIV--", "</div");
        sMsg = sMsg.rpl("__class__", " class").rpl("__style__", " style");
       
        $(oText).html(sMsg);
    }
  
  
    $(oDiv).show();


    setTimeout(_MsgCloseFocus, 100);

    if (iTimeout > 0)
    {
        setTimeout(_MsgHide, iTimeout);
    }

    _Msg_Close = false;
    if (!_Msg_AddEvent)
    {
        _Msg_AddEvent = true;

        $(document.body).keypress(function (e)
        {
            if (e.keyCode == 13 || e.keyCode == 32)
            {
                if (!_Msg_Close)
                {
                    _MsgHide();
                }
            }
        });
    }
}

function _MsgCloseFocus()
{
    try
    {
        $("#msg_close").focus();
        // var oClose = document.getElementById("msg_close");
        //oClose.focus();
    }
    catch (ex)
    {
    }
}

function _Alert(sMsg)
{
    _Msg(sMsg, 0);
}

function _MsgCheckHide(e)
{
    var kc = e.keyCode;
    if (kc == 32 || kc == 13)
    {
        _MsgHide();
    }
}
function _MsgHide()
{
    _Msg_Close = true;
    setTimeout(function ()
    {
        $("#msg_top").hide();
        //var oDiv = document.getElementById("msg_top");
        //oDiv.style.display = "none";
        if (_Msg_OnClose != null)
        {
            setTimeout(_Msg_OnClose, 10);
        }
    }, 100);
}
