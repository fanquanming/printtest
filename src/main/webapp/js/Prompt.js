function _Prompt(sText, sValue, fConfirm, width) {
    var oDiv = $("#prompt_top");
    var oText = $("#prompt_text").text(sText);
    var oValue = $("#prompt_value").val(sValue);

    sText = $(oText).html();
    if (sText.indexOf("@") != 0) {
        sText = sText.replace(/\n/ig, "<br/>");
        sText = sText.replace(/`/g, "<br/>");
    }
    $(oText).html(sText);
    $(oDiv).show();
    $(oValue).focus();
    if (width) {
        $("#prompt_body").width(width);
    }

    $("#prompt_confirm").unbind().click(function () {
        _PromptHide();
        _PromptConfirm(fConfirm);
    });
    $("#prompt_close").unbind().click(function () {
        _PromptHide();
    });

    $("#prompt_value").unbind().keyup(function (e) {
        if (e.keyCode == 13) {
            $("#prompt_confirm").unbind();
            $("#prompt_close").unbind();
            setTimeout(function () {
                _PromptConfirm(fConfirm);
            }, 100);
        }
    });
}

function _PromptConfirm(fConfirm) {
    fConfirm($("#prompt_value").val());
    _PromptHide();
}



function _PromptHide() {
    $("#prompt_top").hide();
}

function _XPromptConfirm(callback) {
    callback($("#xprompt_value").val());
    _XPromptHide();
}



function _XPromptHide() {
    $("#xprompt_top").hide();
}


function _XPrompt(opt) {
    var sText = opt.text;
    var sValue = opt.value;
    var fConfirm = opt.callback;
    var width = opt.width;
    var closeCallBack = opt.closeCallBack;

    var oDiv = $("#xprompt_top");
    var oText = $("#xprompt_text").text(sText);
    var oValue = $("#xprompt_value").val(sValue);

    if (opt.html) {
        oText.text(opt.html);
        sText = $(oText).html();
        if (sText.indexOf("@") != 0) {
            sText = sText.replace(/\n/ig, "<br/>");
            sText = sText.replace(/`/g, "<br/>");
        }
        $(oText).html(sText);
    }

    $(oDiv).show();
    $(oValue).focus();
    if (width) {
        $("#xprompt_body").width(width);
    }

    $("#xprompt_confirm").unbind().click(function () {
        _XPromptConfirm(fConfirm);
    });
    $("#xprompt_close").unbind().click(function () {
        if (closeCallBack) {
            fConfirm("CLOSE");
        }

        _XPromptHide();
    });


    if (closeCallBack) {
        $(oValue).unbind().keydown(function (e) {
            if (e.keyCode == 13) {
                $("#xprompt_confirm").unbind();
                $("#xprompt_close").unbind();

                setTimeout(function () {
                    _XPromptConfirm(fConfirm);
                }, 100);
            }
        });
    }

}

function _SPromptConfirm(callback, oValue) {
    callback($(oValue).val());
    _SPromptHide();
}



function _SPromptHide() {
    $("#sprompt_top").hide();
}


function _SPrompt(opt) {
    var html = opt.html;
    var vId = opt.vId;
    var title = opt.title;
    var fConfirm = opt.callback;
    var width = opt.width;
    var closeCallBack = opt.closeCallBack;

    var oDiv = $("#sprompt_top");
    var oText = $("#sprompt_text");

    if (title) {
        $("#sprompt_title").text(title);
    }
    if (html) { 
        $(oText).html(html);
    }

    $(oDiv).show();
    var oValue = $("#" + vId);
    $(oValue).focus();
    if (width) {
        $("#sprompt_body").width(width);
    }

    $("#sprompt_confirm").unbind().click(function () {
        _SPromptConfirm(fConfirm, oValue);
    });
    $("#sprompt_close").unbind().click(function () {
        if (closeCallBack) {
            fConfirm("CLOSE");
        }

        _SPromptHide();
    });


    if (closeCallBack) {
        $(oValue).unbind().keydown(function (e) {
            if (e.keyCode == 13) {
                $("#sprompt_confirm").unbind();
                $("#sprompt_close").unbind();

                setTimeout(function () {
                    _SPromptConfirm(fConfirm,oValue);
                }, 100);
            }
        });
    }

}
