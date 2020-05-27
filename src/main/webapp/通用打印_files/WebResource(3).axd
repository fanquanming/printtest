Array.prototype.contains = function (v, ignorecase)
{
    for (ic = 0; ic < this.length; ic++)
    {
        if (ignorecase)
        {
            if ((this[ic] + "").toUpperCase() == (v + "").toUpperCase())
            {
                return true;
            }
        }
        else
        {
            if (this[ic] == v)
            {
                return true;
            }
        }
    }
    return false;
}
Array.prototype.groupBy = function (ignorecase)
{
    var groupData = {};

    for (ic = 0; ic < this.length; ic++)
    {
        var v = this[ic];
        var srcV = v;
        if (ignorecase)
        {
            v = (v + "").toUpperCase();
        }
        else
        {
            v = (v + "");
        }

        if (groupData[v])
        {
            groupData[v].push(srcV);
        }
        else
        {
            groupData[v] = [srcV];
        }
    }

    var rv = [];
    for (var k in groupData)
    {
        rv.push(groupData[k]);
    }
    return rv;
}
Array.prototype.insert = function (index, item)
{
    this.splice(index, 0, item);
};
function MaxFractionDigits(v, fractionDigits)
{
    if (v)
    {
        v = v.toString();
        if (v.indexOf(".") > -1)
        {
            var tf = v.length - v.indexOf(".") - 1;

            if (tf > fractionDigits)
            {
                fractionDigits = tf;
            }
        }
    }

    return fractionDigits;
}

Array.prototype.index = function (v)
{
    for (ic = 0; ic < this.length; ic++)
    {
        if (this[ic] == v)
        {
            ic;
        }
    }
    return -1;
}
Array.prototype.remove = function (v)
{
    var ia = $.inArray(v, this);
    if (ia >= 0)
    {
        this.splice(ia, 1);
    }
}
Array.prototype.removeAt = function (idx)
{
    this.splice(idx, 1);
}
Array.prototype.clone = function () { return this.slice(0); }
String.prototype.compare = function (str)
{
    //不区分大小写
    if (str == null)
    {
        str = "";
    }
    if (this.toLowerCase() == str.toLowerCase())
    {
        return true; // 正确
    }
    else
    {
        return false; // 错误
    }
}

String.prototype.rpl = function (oldString, newString)
{
    var src = this + "";
    if (src == null || src.length == 0)
    {
        return src;
    }
    if (oldString == null || oldString.length == 0)
    {
        return src + "";
    }
    var ss = src.split(oldString);
    if (ss.length <= 1)
    {
        return ss[0];
    }

    return ss.join(newString);
}
String.prototype.right = function (len)
{
    var src = this;
    if (src == null || src.length == 0 || src.length < len)
    {
        return src;
    }

    return src.substr(src.length - len);
}
String.prototype.left = function (len)
{
    var src = this;
    if (src == null || src.length == 0 || src.length < len)
    {
        return src;
    }

    return src.substr(0, len);
}
String.prototype.htmlEncode = function ()
{
    var src = this;
    return $('<div/>').text(src).html();
}


function Base64()
{

    // private property  
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    // public method for encoding  
    this.encode = function (input)
    {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length)
        {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2))
            {
                enc3 = enc4 = 64;
            }
            else if (isNaN(chr3))
            {
                enc4 = 64;
            }
            output = output +
                _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
                _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }

    // public method for decoding  
    this.decode = function (input)
    {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length)
        {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64)
            {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64)
            {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }

    // private method for UTF-8 encoding  
    _utf8_encode = function (string)
    {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++)
        {
            var c = string.charCodeAt(n);
            if (c < 128)
            {
                utftext += String.fromCharCode(c);
            }
            else if ((c > 127) && (c < 2048))
            {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else
            {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }
        return utftext;
    }

    // private method for UTF-8 decoding  
    _utf8_decode = function (utftext)
    {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while (i < utftext.length)
        {
            c = utftext.charCodeAt(i);
            if (c < 128)
            {
                string += String.fromCharCode(c);
                i++;
            }
            else if ((c > 191) && (c < 224))
            {
                c2 = utftext.charCodeAt(i + 1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            }
            else
            {
                c2 = utftext.charCodeAt(i + 1);
                c3 = utftext.charCodeAt(i + 2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}

var _JMsgNext = null;
var _JMustPrompt = false;
jQuery.extend({
    isTrue: function (text)
    {
        if (text == null || text == false || text == 0)
        {
            return false;
        }
        if (text == true || text == 1)
        {
            return true;
        }
        text = text.toString().toLowerCase();
        if (text == "true" || text == "checked" || text == "yes" || text == "ok" || text == "on" ||
            text == "t" || text == "y" || text == "confirm")
        {
            return true;
        }
        return false;
    },
    ReplaceUrl: function (text)
    {
        if (text == null || text == "")
        {
            return text;
        }
        var re = /(http[s]?:\/\/([\w-]+.)+([:\d+])?(\/[\w-\.\/\?%&=]*)?)/gi;
        var s = text.replace(re, function (a)
        {
            var aCtrl = $("<a target='_blank'></a>");
            aCtrl.attr("href", a).text(a);
            return aCtrl.html();
        });
        return s;
    },
    BuildUrl: function (text, ctrlTag)
    {

        if (typeof (ctrlTag) == "undefined" || ctrlTag == null)
        {
            ctrlTag = "div";
        }

        var c = $("<" + ctrlTag + "></" + ctrlTag + ">");
        if (text == null || text == "")
        {
            return c;
        }
        text = text.toString();
        var urlIndex = 0;
        var urlList = [];
        var re = /(http[s]?:\/\/([\w-]+.)+([:\d+])?(\/[\w-\.\/\?%&=]*)?)/gi;
        var s = text.replace(re, function (a)
        {
            var aCtrl = $("<a target='_blank'></a>");
            aCtrl.attr("href", a).text(a);

            urlList.push(aCtrl);
            return "{@URL-" + (urlList.length - 1) + "}";
        });

        c.txt(s);
        var newHtml = c[0].innerHTML;

        for (var i = 0; i < urlList.length; i++)
        {
            newHtml = newHtml.rpl("{@URL-" + i + "}", urlList[i][0].outerHTML);
        }

        c[0].innerHTML = newHtml;

        return c;
    },
    textareaPopup: function (arg)
    {
        var ctrl = $("<div style='padding:10px;'></div>");

        if (!arg.width)
        {
            arg.width = "600px";
        }
        if (!arg.height)
        {
            if (arg.remark)
            {
                arg.height = "320px";
            }
            else
            {
                arg.height = "260px";
            }
        }
        if (arg.remark)
        {
            ctrl.append($("<div style='color:#666;margin-bottom:12px;'></div>").text(arg.remark));
        }

        var ta = $("<textarea style='width:100%;height:150px;'></textarea>").appendTo(ctrl);
        if (arg.textarea_height)
        {
            ta.attr("height", arg.textarea_height);
        }
        if (arg.value)
        {
            ta.val(arg.value);
        }
        arg.toolbar = {
            tools: [{
                text: "确定", click: function ()
                {
                    dialogClose(ta.val());
                }
            }]
        };

        arg.ctrl = ctrl;
        arg.close = function (rv)
        {
            arg.callback(rv);
        };
        dialog(arg);
    },
    isJQuery: function (obj)
    {
        if (obj == null)
        {
            return false;
        }
        return obj instanceof jQuery;
    },
    isInt: function (text)
    {
        text = text + "";
        if (text == "0")
        {
            return true;
        }
        if (text.length == 0)
        {
            return false;
        }

        for (var i = 0; i < text.length; i++)
        {
            if (i == 0 && text[i] == "-" && text.length > 1)
            {
                continue;
            }
            if (text[i] > "9" || text[i] < "0")
            {
                return false;
            }
        }


        return true;
    },
    cbx: function (ctrlName, values)
    {
        if (values != undefined && values != null)
        {
            var cbxs = $(":checkbox[name='" + ctrlName + "']");
            cbxs.each(function ()
            {
                var ctrl = $(this);
                ctrl.prop("checked", false);

                if (values === true)
                {
                    ctrl.prop("checked", true);
                    return;
                }
                if (values === false)
                {
                    return;
                }
                if (values && !$.isArray(values))
                {
                    values = values.toString().split(",");
                }
                for (var v = 0; v < values.length; v++)
                {
                    if (ctrl.val().toUpperCase() == values[v].toUpperCase())
                    {
                        ctrl.prop("checked", true);
                    }
                }

            });

            return cbxs;
        }
        else
        {
            var rvs = new Array();
            var ctrls = $(":checkbox[name='" + ctrlName + "']:checked").each(function ()
            {
                rvs.push($(this).val());
            });

            return rvs;
        }
    },

    cbxs: function (values)
    {
        var rvs = {};


        var ctrls = $(":checkbox").each(function ()
        {
            var ctrl = $(this);
            var name = ctrl.attr("name");

            if (ctrl.prop("checked"))
            {
                if (rvs[name])
                {
                    rvs[name].push(ctrl.val());
                }
                else
                {
                    rvs[name] = [ctrl.val()];
                }
            }
        });

        return rvs;

    },
    rdo: function (ctrlName, value)
    {
        if (value != undefined && value != null)
        {
            var rdos = $(":radio[name='" + ctrlName + "']");
            rdos.each(function ()
            {
                var ctrl = $(this);
                if (ctrl.val().toUpperCase() == value.toString().toUpperCase())
                {
                    ctrl.prop("checked", true);
                }
            });

            return rdos;
        }
        else
        {
            return $(":radio[name='" + ctrlName + "']:checked").val();
        }
    },
    pageHeight: function (minHeight, lessHeight, maxHeight)
    {
        if (typeof (minHeight) == "undefined")
        {
            minHeight = 100;
        }
        if (typeof (lessHeight) == "undefined")
        {
            lessHeight = 0;
        }
        var height = $(document.body).height();
        if (typeof (maxHeight) == "undefined")
        {
            maxHeight = height;
        }
        if (height - lessHeight < minHeight)
        {
            return minHeight + "px";
        }
        else if (maxHeight && height - lessHeight > maxHeight)
        {
            return maxHeight + "px";
        }

        return (height - lessHeight) + "px";
    },
    pageWidth: function (minWidth, lessWidth, maxWidth)
    {
        if (typeof (minWidth) == "undefined")
        {
            minWidth = 600;
        }
        if (typeof (lessWidth) == "undefined")
        {
            lessWidth = 0;
        }
        var width = $(document.body).width();
        if (typeof (maxWidth) == "undefined")
        {
            maxWidth = width;
        }
        if (width - lessWidth < minWidth)
        {
            return minWidth + "px";
        }
        else if (maxWidth && width - lessWidth > maxWidth)
        {
            return maxWidth + "px";
        }

        return (width - lessWidth) + "px";
    },
    rdos: function ()
    {
        var rdos = $(":radio");

        var rvs = {};
        for (var rdo in rdos)
        {
            if (rdo.prop("checked"))
            {
                rvs[rdo.attr("name")] = rdo.val();
            }
        }

        return rvs;
    },
    ts: function ()
    {
        return (new Date()).getTime();
    },
    resetMust: function ()
    {
        if (_JMustPrompt)
        {
            var musts = $("select.must_prompt option");

            $(musts).each(function ()
            {
                if ($(this).text() == "{这里必选}")
                {
                    $(this).remove();
                }

            });

            var musts = $(".must_prompt");

            $(musts).removeClass("must_prompt").addClass("must");
            //musts.find("select").each(function ()
            //{
            //    $(this).find("option:contains('{这里必选}')").remove();
            //});
        }
        _JMustPrompt = false;

        return this;
    },
    flicker: function (ctrl, allCount, currentCount)
    {
        //ctrl.each(function ()
        //{
        if (currentCount % 2 == 0)
        {
            $(ctrl).css("padding", "2px");
        }
        else
        {
            $(ctrl).css("padding", "0px");
        }
        //});
        if (currentCount + 1 < allCount)
        {
            setTimeout($.flicker, 500, ctrl, allCount, currentCount + 1);
        }
    },
    mustRemove: function ()
    {
        $(".must_pop").remove();
        $(document.body).unbind("click", $.mustRemove).unbind("keydown", $.mustRemove);
        if (this.TimeOutId1)
        {
            clearTimeout(this.TimeOutId);
        }
        if (this.TimeOutId2)
        {
            clearTimeout(this.TimeOutId2);
        }

    },
    checkMust: function (isPop, musts)
    {
        $.mustRemove();
        var isChecked = true;
        isPop = typeof (isPop) == "undefined" || isPop;
        if (!musts)
        {
            musts = $(".must,.must_prompt");
        }

        return musts.checkMust(isPop);
    },
    tabFrame: function (option)
    {
        sample_option = {
            type: "v",//v.h
            showDisplay: true,
            showText: function () { return false; },
            hideText: function () { return false; },
            items: [
                { text: "", pic: "", url: "", hideText: function (item) { }, showText: function (item) { }, active: function (item) { return false; }, unactive: function (item) { }, is_active: true },
                { ctrl: $("<div>ddd</div>"), frame: $("#div1") },
                { ctrl: function () { return $("<div>ddd</div>") }, active: function (item) { }, frame: $("#div1") },
                { spt: true },
                { text: "", pic: "", frame: function () { return $("#div1") } },
            ]
        };
        var type = option.type ? option.type : "v";
        option.type = type;
        var typeClass = "_tf_" + type;

        var tb = $("<table cellpadding='0' cellspacing='0' class='_tf'></table>");
        var tabRow = $("<tr class='_tf_tab_row'></tr>").appendTo(tb);

        var tabCell = $("<td class='_tf_tab_cell _tf_text'></td>").addClass(typeClass);
        var frameCell = $("<td class='_tf_tab_frame'></td>").addClass(typeClass);
        tabCell.appendTo(tabRow);
        tabRow.addClass(typeClass);

        if (type == "h")
        {
            var frameRow = $("<tr></tr>").appendTo(tb);
            frameCell.appendTo(frameRow);
        }
        else
        {
            frameCell.appendTo(tabRow);
        }

        var frameP = $("<div class='_tf_frame_list'></div>").appendTo(frameCell);
        this.option = option;
        var items = option.items;


        if (type == "v" && !(option.showDisplay === false))
        {
            var displayCtrl = $("<div  class='_tf_display _tf_text'></div>").appendTo(tabCell);
            ShowText = true;

            displayCtrl.click(function ()
            {

                ShowText = !ShowText;
                if (ShowText && option.showText)
                {
                    if (option.showText() === false)
                    {
                        return;
                    }
                }
                else if (!ShowText && option.hideText)
                {
                    if (option.hideText() === false)
                    {
                        return;
                    }
                }
                if (ShowText)
                {
                    for (var i = 0; i < items.length; i++)
                    {
                        var item = items[i];
                        if (item.showText)
                        {
                            var st = item.showText(item);
                            if (st === false)
                            {
                                continue;
                            }
                            if (st === "break")
                            {
                                break;
                            }
                        }
                        if (item.ctrl)
                        {
                            item.ctrl.addClass("_tf_text");
                            if (item.text_ctrl)
                            {
                                item.text_ctrl.show();
                            }
                            if (item.mark_ctrl)
                            {
                                item.mark_ctrl.hide();
                            }
                        }


                    }

                    tabCell.addClass("_tf_text");
                    displayCtrl.addClass("_tf_text");
                }
                else
                {
                    for (var i = 0; i < items.length; i++)
                    {
                        var item = items[i];
                        if (item.hideText)
                        {
                            var ht = item.hideText(item);
                            if (ht === false)
                            {
                                continue;
                            }
                            if (ht === "break")
                            {
                                break;
                            }
                        }
                        if (item.ctrl)
                        {
                            if (item.text_ctrl)
                            {
                                item.text_ctrl.hide();
                            }
                            if (item.mark_ctrl && !item.pic)
                            {
                                item.mark_ctrl.show();
                            }
                            item.ctrl.removeClass("_tf_text");
                        }

                    }
                    tabCell.removeClass("_tf_text");
                    displayCtrl.removeClass("_tf_text");
                }
            });
        }


        var oldItem = null;
        this.ActiveItem = null;
        this.Open = function (item)
        {

            if (item.frame)
            {
                if ($.isFunction(item.frame))
                {
                    item.frame(item).show();
                }
                else
                {
                    if (!item.is_appended)
                    {
                        item.frame.appendTo(frameP);
                        item.is_appended = true;
                    }
                    item.frame.show();
                }
            }
            else
            {
                if (item.url)
                {
                    item.frame = $("<iframe class='full _tf_frame'></iframe>").attr("src", item.url).appendTo(frameP);
                }

            }

        }
        this.RenderItem = function (mf, tabCell, oldItem, item)
        {
            if (item.spt)
            {
                var ctrlSpt = $("<div class='_tf_spt'></div>").appendTo(tabCell).addClass(typeClass);

                return;
            }
            if (item.ctrl)
            {
                var ctrlP = null;
                if ($.isFunction(item.ctrl))
                {
                    ctrlP = item.ctrl(item).appendTo(tabCell);
                }
                else
                {
                    ctrlP = item.ctrl.appendTo(tabCell);
                }

                if (item.active)
                {
                    setTimeout(function () { ctrlP.click(); }, 500);
                }
            }
            else
            {
                //var ctrlP = $("<div class='_tf_item_p'></div>").appendTo(tabCell).addClass(typeClass);

                var ctrl = $("<div class='_tf_item _tf_text'></div>").appendTo(tabCell).addClass(typeClass);

                if (item.pic)
                {
                    ctrl.css("background-image", "url(" + item.pic + ")");
                    if (type == "h")
                    {
                        ctrl.addClass("_tf_pic");
                    }
                }
                var text = " ";
                if (item.name || item.text)
                {
                    text = item.name ? item.name : item.text;

                    var textCtrl = $("<div class='_tf_item_text'></div>").text(text).appendTo(ctrl).addClass(typeClass);
                    item.text_ctrl = textCtrl;
                    ctrl.attr("title", text);
                }
                if (type == "v")
                {
                    var mark = item.mark ? item.mark : text.substr(0, 1);
                    if (!item.pic)
                    {
                        var markCtrl = $("<div class='_tf_item_mark'></div>").text(mark).appendTo(ctrl).hide();
                        item.mark_ctrl = markCtrl;
                    }
                }
                item.ctrl = ctrl;
                if (item.id)
                {
                    ctrl.attr("id", item.id);
                }
                ctrl.click(function ()
                {
                    if (mf.ActiveItem)
                    {
                        if (mf.ActiveItem.unactive)
                        {
                            if (mf.ActiveItem.unactive(mf.ActiveItem) === false)
                            {
                                return;
                            }
                        }

                    }

                    if (item.active)
                    {
                        if (item.active(item) === false)
                        {
                            return;
                        }
                    }




                    if (mf.ActiveItem)
                    {
                        mf.ActiveItem.ctrl.removeClass("_tf_active");
                        if (mf.ActiveItem.frame)
                        {
                            if ($.isFunction(mf.ActiveItem.frame))
                            {
                                mf.ActiveItem.frame(mf.ActiveItem).hide();
                            }
                            else
                            {
                                mf.ActiveItem.frame.hide();
                            }
                        }
                    }
                    ctrl.addClass("_tf_active");
                    mf.ActiveItem = item;

                    mf.Open(item);

                });

                if (item.is_active)
                {
                    setTimeout(function () { ctrl.click(); }, 500);
                }
            }
        }

        for (var i = 0; i < items.length; i++)
        {
            var item = items[i];
            this.RenderItem(this, tabCell, oldItem, item);
            oldItem = item;


        }

        return tb;
    },



    prompt: function (text, value, callback)
    {
        var opt = text;
        if (opt.text)
        {
            text = opt.text;
            value = opt.value;
            callback = opt.callback;
        }
        if (typeof (__Prompt) != "undefined")
        {
            __Prompt(text, value, callback);
        }
        else if (typeof (top._Prompt) != "undefined")
        {
            top._Prompt(text, value, callback);
        }
        else if (typeof (_Prompt) != "undefined")
        {
            _Prompt(text, value, callback);
        }
        else
        {
            if (text.html || text.text)
            {
                if (text.html)
                {
                    var v = prompt(text.html, text.value);
                    if (text.callback)
                    {
                        text.callback(v);
                    }
                }
                else if (text.text)
                {
                    var v = prompt(text.text, text.value);
                    if (text.callback)
                    {
                        text.callback(v);
                    }
                }
            }
            else
            {
                var v = prompt(text, value);
                if (callback)
                {
                    callback(v);
                }
            }
        }

    },
    msg: function (text, timeout, onClose)
    {

        if (typeof (onClose) == "undefined" && typeof (_Msg_OnClosed) != "undefined")
        {
            onClose = _Msg_OnClosed;
        }
        if (typeof (__Msg) != "undefined")
        {
            __Msg(text, timeout, onClose);
        }
        else if (typeof (top._Msg) != "undefined")
        {
            top._Msg(text, timeout, onClose);
        }
        else if (typeof (_Msg) != "undefined")
        {
            _Msg(text, timeout, onClose);
        }
        else
        {
            if (text.html || text.text)
            {
                if (text.html)
                {
                    alert(text.html);
                }
                else if (text.text)
                {
                    alert(text.text);
                }
            }
            else
            {
                alert(text);
            }
            if (onClose)
            {
                onClose();
            }
        }
    },
    cfm: function (text, fConfirmed)
    {
        if (typeof (__Confirm) != "undefined")
        {
            return __Confirm(text, fConfirmed);
        }
        if (typeof (top._Confirm) != "undefined")
        {
            return top._Confirm(text, fConfirmed);
        }
        else if (typeof (_Confirm) != "undefined")
        {
            return _Confirm(text, fConfirmed);
        }
        else if (typeof (fConfirmed) != "undefined" && fConfirmed != null)
        {
            fConfirmed(window.confirm(text));
        }
        else
        {
            return window.confirm(text);
        }//inArray
    },
    arrayRemove: function (arr, item)
    {
        arr.splice($.inArray(item, arr), 1);
    },
    calValue: function (selector, msg)
    {
        var v = $(selector).val();
        if (v.toString() == "")
        {
            try
            {
                if (msg != null && msg != "")
                {
                    this.msg(msg);
                }
                $(selector).focus();
            }
            catch (e)
            {
            }
            return false;
        }
        return v;
    },
    showBlank: function (srcCtrl, overCtrl)
    {
        srcCtrl = $(srcCtrl);
        overCtrl = $(overCtrl);
        if (srcCtrl.val() == "")
        {
            overCtrl.text(srcCtrl.attr("title"));
            overCtrl.outerWidth(srcCtrl.outerWidth()).outerHeight(srcCtrl.outerHeight());
            overCtrl.css("line-height", srcCtrl.outerHeight() + "px");
            //  overCtrl.css("margin-left", "0px").css("margin-top", "0px");

            overCtrl.show();

            var posInput = srcCtrl.position();
            var posOver = overCtrl.position();
            //-parseFloat(overCtrl.css("margin-left"))
            overCtrl.css("margin-left", posInput.left - posOver.left);
            overCtrl.css("margin-top", posInput.top - posOver.top);

            if (typeof (_BlankShowed) != "undefined")
            {
                _BlankShowed(srcCtrl, overCtrl);
            }
        }
        else
        {
            overCtrl.hide();
        }
    },
    floatBtn: function (btnInfo, parentCtrl)
    {
        var bls = $("<div class='_fb'></div>");
        for (var i = 0; i < btnInfo.btns.length; i++)
        {
            var btn = btnInfo.btns[i];
            if (typeof (btn.show) != "undefined")
            {
                if (!btn.show)
                {
                    continue;
                }
            }
            var b = $("<span class='_fb_i'></span>");
            if (btn.pic)
            {
                b.css("background-image", "url(" + btn.pic + ")");
                b.css("padding-left", "20px");
            }
            if (btn.text)
            {
                b.text(btn.text);
            }

            if (btn.fun)
            {
                b.click(function (e)
                {
                    btn.fun(e);
                });
            }

            bls.append(b);
        }

        if (btnInfo.css)
        {
            bls.css(btnInfo.css);
        }
        if (parentCtrl)
        {
            $(parentCtrl).append(bls);

            if (btnInfo.margin)
            {
                var h = bls.outerHeight();
                var w = bls.outerWidth();
                if (h < 0)
                {
                    h = 0;
                }
                if (w < 0)
                {
                    w = 0;
                }

                bls.css({ "margin-left": "-" + w + "px", "margin-top": "-" + h / 2 + "px" });
            }
        }

        if (btnInfo.hide)
        {
            bls.hide();
        }
        return bls;
    },
    parseDatetimeValue: function (leftDate, l1, l2, maxValue)
    {
        var rv = {};
        var s = leftDate.substr(0, l1);
        if (parseInt(s) > maxValue)
        {
            s = leftDate.substr(0, l2);
            leftDate = leftDate.substr(l2);
        }
        else
        {
            leftDate = leftDate.substr(l1);
        }

        rv.v = s;
        rv.left = leftDate;

        return rv;
    },
    padDatetime: function (time)
    {
        if (time.length == 1)
        {
            time = "0" + time;
        }

        return time;
    },
    parseAndFormatTime: function (oldTime)
    {
        if (oldTime.length == 0)
        {
            return "";
        }
        oldTime = oldTime.rpl("  ", " ").rpl("　", " ");
        var hour = "";
        var minute = "";
        var second = "";
        var millisecond = "";
        var leftTime = "";

        var mIndex = oldTime.indexOf(".");
        if (mIndex > 0)
        {
            millisecond = oldTime.substr(mIndex + 1, 3);
            oldTime = oldTime.substr(0, mIndex);
        }


        var time1 = oldTime.split(":");

        if (time1.length == 1)
        {
            leftTime = time1[0];
            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 23);
                hour = pv.v;
                leftTime = pv.left;

            }
            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 59);
                minute = pv.v;
                leftTime = pv.left;

            }
            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 59);
                second = pv.v;
                leftTime = pv.left;
            }
            if (leftTime.length > 0 && millisecond.length == 0)
            {
                millisecond = leftTime.substr(0, 3);
            }
        }
        else if (time1.length == 2)
        {
            hour = time1[0];
            leftTime = time1[1];

            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 59);
                minute = pv.v;
                leftTime = pv.left;
            }
            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 59);
                second = pv.v;
                leftTime = pv.left;
            }
            if (leftTime.length > 0 && millisecond.length == 0)
            {
                millisecond = leftTime.substr(0, 3);
            }
        }
        else if (time1.length == 3)
        {
            hour = time1[0];
            minute = time1[1];
            leftTime = time1[2];


            if (leftTime.length > 0)
            {
                var pv = $.parseDatetimeValue(leftTime, 2, 1, 59);
                second = pv.v;
                leftTime = pv.left;
            }
            if (leftTime.length > 0 && millisecond.length == 0)
            {
                millisecond = leftTime.substr(0, 3);
            }
        }
        else if (time1.length == 4)
        {
            hour = time1[0];
            minute = time1[1];
            second = time1[2];
            leftTime = time1[3];

            if (leftTime.length > 0 && millisecond.length == 0)
            {
                millisecond = leftTime.substr(0, 3);
            }
        }

        var newTime = "";
        if (hour.length > 0)
        {
            newTime += $.padDatetime(hour);
        }
        if (minute.length > 0)
        {
            newTime += ":" + $.padDatetime(minute);
        }
        if (second.length > 0)
        {
            newTime += ":" + $.padDatetime(second);
        }
        if (millisecond.length > 0)
        {
            newTime += "." + millisecond;
        }
        return newTime;
    },
    parseAndFormatDate: function (oldDate, isFormatTime)
    {
        var date1 = oldDate.split("-");
        if (date1.length == 1)
        {
            date1 = oldDate.split("/");
        }
        var year = "";
        var month = "";
        var day = "";
        var oldTime = "";


        if (date1.length == 1)
        {
            var leftDate = date1[0];

            year = leftDate.substr(0, 4);
            leftDate = leftDate.substr(4);

            var pv = $.parseDatetimeValue(leftDate, 2, 1, 12);
            month = pv.v;
            leftDate = pv.left;

            var pv = $.parseDatetimeValue(leftDate, 2, 1, 31);
            day = pv.v;
            leftDate = pv.left;

            if (leftDate.length > 0 && isFormatTime)
            {
                oldTime = leftDate.substr(0);
            }
        }
        else if (date1.length == 2)
        {
            year = date1[0];

            var leftDate = date1[1];

            var pv = $.parseDatetimeValue(leftDate, 2, 1, 12);
            month = pv.v;
            leftDate = pv.left;


            var pv = $.parseDatetimeValue(leftDate, 2, 1, 31);
            day = pv.v;
            leftDate = pv.left;


            if (leftDate.length > 0 && isFormatTime)
            {
                oldTime = leftDate.substr(0);
            }
        }
        else if (date1.length == 3)
        {
            year = date1[0];
            month = date1[1];
            var leftDate = date1[2];

            var pv = $.parseDatetimeValue(leftDate, 2, 1, 31);
            day = pv.v;
            leftDate = pv.left;


            if (leftDate.length > 0 && isFormatTime)
            {
                oldTime = leftDate.substr(0);
            }
        }
        if (year.length == 2)
        {
            year = "20" + year;
        }
        var newDate = year + "-" + $.padDatetime(month) + "-" + $.padDatetime(day);

        if (isFormatTime)
        {
            newTime = $.parseAndFormatTime(oldTime);
            if (newTime)
            {
                newDate += " " + newTime;
            }
        }
        return newDate;

    },
    formatDatetime: function (sdate)
    {
        var s1 = sdate.split(" ");

        var newTime = "";
        var newDate = "";

        if (s1.length > 1)
        {
            newTime = $.parseAndFormatTime(s1[1]);
            newDate = $.parseAndFormatDate(s1[0], false);
            if (newTime)
            {
                newDate += " " + newTime;
            }

            return newDate;
        }
        else 
        {
            newDate = $.parseAndFormatDate(s1[0], true);
            return newDate;
        }
    }
});

jQuery.fn.extend({
    verifyDate: function ()
    {
        $(this).live("change", function (e)
        {
            var ctrl = $(this);
            var v = ctrl.val();

            if (v != "")
            {
                if (!$.isDate(v))
                {
                    var newV = $.formatDatetime(v);
                    if (!$.isDate(newV))
                    {
                        $.msg("日期格式错误,必须输入有效格式如:[2000-2-1]或[2010-2-1 10:10:10]", 0, function ()
                        {
                            ctrl.select().focus();
                        });
                    }
                    else
                    {
                        ctrl.val(newV);
                    }
                }
            }
        });
        return this;
    },
    cbx: function ()
    {
        var cbxv = {};
        $(this).each(function ()
        {
            var cbxc = $(this);
            var v = cbxc.val();
            var name = cbxc.attr("name");
            var vs = cbxv[name];
            if (!vs)
            {
                vs = [];
                cbxv[name] = vs;
            }

            vs.push(v);
        });

        return cbxv;
    },
    checkMust: function (isPop)
    {
        isPop = typeof (isPop) == "undefined" || isPop;
        $(document.body).unbind("click", $.mustRemove).unbind("keydown", $.mustRemove);

        var musts = this;
        var isChecked = true;
        musts.each(function ()
        {
            var v = $(this).val();

            if ($(this)[0].tagName.toLowerCase() == "input" || $(this)[0].tagName.toLowerCase() == "textarea")
            {
                if (v == "")
                {
                    if (isChecked)
                    {
                        $(this).focus();
                    }
                    if (isPop)
                    {
                        var pop = $("<div class='must_pop'><div class='opacity_bg'>&nbsp;</div><div class='must_text' style='line-height:" + ($(this).outerHeight() - 2) + "px;'>这里必填</div></div>");


                        $(this).parent().append(pop);

                        var posThis = $(this).position();
                        var posPop = pop.position();

                        pop.css("margin-left", posThis.left - posPop.left);
                        pop.css("margin-top", posThis.top - posPop.top);
                        pop.outerWidth($(this).outerWidth());
                        pop.outerHeight($(this).outerHeight());

                    }
                    else
                    {
                        $(this).removeClass("must").addClass("must_prompt").click(function () { $.resetMust(); }).keydown(function () { $.resetMust(); });
                    }
                    isChecked = false;
                    _JMustPrompt = true;

                }
            }
            else if ($(this)[0].tagName.toLowerCase() == "select")
            {

                if (v == "" || v == null)
                {
                    if (isChecked)
                    {
                        $(this).focus();
                    }
                    if (isPop)
                    {
                        var pop = $("<div class='must_pop'><div class='opacity_bg'>&nbsp;</div><div class='must_text' style='line-height:" + ($(this).outerHeight() - 2) + "px;'>这里必选</div></div>");


                        $(this).parent().append(pop);

                        var posThis = $(this).position();
                        var posPop = pop.position();

                        pop.css("margin-left", posThis.left - posPop.left);
                        pop.css("margin-top", posThis.top - posPop.top);
                        pop.outerWidth($(this).outerWidth());
                        pop.outerHeight($(this).outerHeight());
                    }
                    else
                    {
                        $(this).removeClass("must").addClass("must_prompt").click(function () { $.resetMust(); }).keydown(function () { $.resetMust(); });

                        var opt = $("<option style=\"color:#ff0000\" value=\"\">{这里必选}</option>");
                        $(this).prepend(opt);
                        $(opt).prop("selected", true);
                    }
                    isChecked = false;
                    _JMustPrompt = true;
                }
            }
        });

        if (!isChecked)
        {
            if (this.TimeOutId1)
            {
                clearTimeout(this.TimeOutId);
            }
            if (this.TimeOutId2)
            {
                clearTimeout(this.TimeOutId2);
            }


            // setTimeout($.flicker, 100, $(".must_pop"), 8, 0);
            this.TimeOutId2 = setTimeout(function ()
            {
                $(document.body).one("click", $.mustRemove).one("keydown", $.mustRemove);
            }, 100);
            this.TimeOutId1 = setTimeout($.mustRemove, 2000);
        }
        return isChecked;
    },
    verifyDates: function ()
    {
        var isV = true;
        this.each(function ()
        {
            var v = $(this).val();
            if (v != "")
            {
                if (!$.isDate(v))
                {
                    v = $.formatDatetime(v);
                    if (!$.isDate(v))
                    {
                        var ctrl = $(this);
                        $.msg("[ " + v + " ] 不是正确的日期格式,必须输入有效格式如:[2000-2-1]或[2010-2-1 10:10:10]", 0, function ()
                        {
                            ctrl.select().focus();
                        });
                        isV = false;
                        return;
                    }
                    else
                    {
                        $(this).val(v);
                    }
                }

            }
        });
        return isV;
    },
    verifyNumerics: function ()
    {
        var isV = true;
        this.each(function ()
        {
            var v = $(this).val();
            //var removeString = $(this).attr("disabled-verify");
            //if (removeString.length > 0)
            //{
            //    v = v.rpl(removeString, "");
            //}
            if (v != "")
            {
                if (!$.isNumeric(v))
                {
                    var ctrl = $(this);
                    $.msg("[ " + v + " ] 不是正确的数字格式,请输入数字", 0, function ()
                    {
                        ctrl.select().focus();
                    });
                    isV = false;
                }
            }

        });
        return isV;
    },
    verifyInts: function ()
    {
        var isV = true;
        this.each(function ()
        {
            var v = $(this).val();
            if (v != "")
            {
                if (!$.isNumeric(v) || parseInt(v) != parseFloat(v))
                {
                    var ctrl = $(this);
                    $.msg("[ " + v + " ] 不是正确的整数,请输入有效的整数", 0, function ()
                    {
                        ctrl.select().focus();
                    });
                    isV = false;
                }
            }
        });
        return isV;
    },
    bindBlank: function ()
    {
        var isPlaceholder = false;
        var input = document.createElement('input');

        isPlaceholder = "placeholder" in input;

        this.each(function ()
        {
            var ctrl = $(this);
            var title = $(ctrl).attr("title");
            if (isPlaceholder)
            {
                ctrl.attr("placeholder", title);
            }
            else
            {
                if (title != "")
                {
                    var overCtrl = $("<div class='blank_text'></div>").css("margin-left", "0px").css("margin-top", "0px").appendTo(ctrl.parent()).click(function ()
                    {
                        ctrl.focus();
                        $(this).hide();
                    }).focus(function ()
                    {
                        ctrl.focus();
                        $(this).hide()
                    });
                    ctrl.blur(function ()
                    {
                        $.showBlank(ctrl, overCtrl);

                    }).focus(function ()
                    {
                        $(overCtrl).hide();
                    }).change(function ()
                    {
                        $.showBlank(ctrl, overCtrl);
                    });

                    $.showBlank(ctrl, overCtrl);
                }
            }
        });

        return this;
    },
    verifyNumeric: function ()
    {
        $(this).live("change", function (e)
        {
            var v = $(this).val();
            if (v != "")
            {
                //var removeString = $(this).attr("disabled-verify");

                //if (removeString != null && removeString.length > 0)
                //{
                //    v = v.rpl(removeString, "");
                //}
                if (!$.isNumeric(v))
                {
                    var ctrl = $(this);
                    $.msg("错误的数字格式,请输入有效的数字", 0, function ()
                    {
                        ctrl.select().focus();
                    });
                }
            }
        });
        return this;
    },
    verifyInt: function ()
    {
        $(this).live("keyup", function (e)
        {
            var v = $(this).val();
            if (v != "")
            {
                var ctrl = $(this);
                if (!$.isNumeric(v) && v != "-")
                {
                    //$.createPopup(ctrl, { "text": "错误的数字格式`请输入有效的整数", "align": "bottom", "color": "#f00" });
                    $.msg("错误的数字格式,请输入有效的整数", 0, function ()
                    {
                        ctrl.select().focus();
                    });
                }
                else if (v != "-")
                {

                    if (parseInt(v + "1") != parseFloat(v + "1"))
                    {
                        ctrl.val(parseInt(v));
                    }
                }
            }
        });
        return this;
    },
    tagname: function ()
    {
        return this.get(0).tagName.toUpperCase();
    },
    sv: function (v)
    {
        if (this.length == 0)
        {
            return this;
        }
        if (this.tagname() == "INPUT")// && (this.attr("type") == "checkbox" || this.attr("type") == "radio"))
        {
            if (this.attr("type") == "checkbox")
            {
                this.removeAttr("checked");
                if (v === true)
                {
                    this.prop("checked", true);
                }
                else if (v === false)
                {

                }
                else
                {
                    if (this.length > 1)
                    {
                        if (this.val() == v)
                        {
                            this.prop("checked", true);
                        }
                    }
                    else
                    {
                        var vs = v.split(",");
                        this.each(function ()
                        {
                            var ipt = $(this);
                            if (vs.contains(ipt.val()))
                            {
                                ipt.prop("checked", true);// "checked");
                            }
                        });
                    }
                }
            }
            else if (this.attr("type") == "radio")
            {
                this.removeAttr("checked");
                if (v === true)
                {
                    this.prop("checked", true);// "checked");
                }
                else if (v === false)
                {

                }
                else
                {
                    this.each(function ()
                    {
                        var ipt = $(this);
                        if (ipt.val() == v)
                        {
                            ipt.prop("checked", true);//, "checked");

                        }
                    });
                }
            }
            else
            {
                this.val(v);
            }
        }
        else
        {
            this.val(v);
        }

        return this;
    }
});
jQuery.extend({
    queryString: function (query)
    {
        var search = window.location.search + '';
        if (search.charAt(0) != '?')
        {
            return null;
        }
        else
        {
            if (query)
            {
                search = search.replace('?', '').split('&');
                for (var i = 0; i < search.length; i++)
                {
                    if (search[i].split('=')[0] == query)
                    {
                        return $.unescape(search[i].split('=')[1]);
                    }
                }
                return null;
            }
            else
            {
                search = search.replace('?', '').split('&');
                var rvs = {};
                for (var i = 0; i < search.length; i++)
                {
                    var searchSplit = search[i].split('=');
                    rvs[searchSplit[0]] = $.unescape(searchSplit[1]);
                }
                return rvs;
            }
        }

    },
    rqs: function (query)
    {
        return this.queryString(query);
    },
    buildQueryString: function (ds)
    {
        var r = [];
        for (var k in ds)
        {
            var v = ds[k];
            r.push(k + "=" + $.escape(v));
        }
        return r.join("&");
    },
    isDate: function (value)
    {
        if (value == null || value == "" || value == "今天" || value == "明天" || value == "昨天" || value == "后天" || value == "前天")
        {
            return true;
        }
        var fDateIndex = value.indexOf("天前");
        if (fDateIndex < 0)
        {
            fDateIndex = value.indexOf("天后");
        }
        if (fDateIndex > 0)
        {
            var dayCount = value.substr(0, fDateIndex);
            if (!$.isInt(dayCount))
            {
                $.msg("指定【*天前】或者【*天后】时，前面必须为整数数字");
                return false;
            }

            if (fDateIndex + 2 > value.length)
            {
                value = "2000-1-1" + value.substr(fDateIndex + 2);
            }
            else
            {
                value = "2000-1-1";
            }
        }

        if (value.indexOf("-") == -1 && value.indexOf("/") == -1)
        {
            return false;
        }
        var value1 = value.replace("-", "/");
        var value2 = value.replace("/", "-");

        return !isNaN(Date.parse(value1)) || !isNaN(Date.parse(value2));
    },
    showWait: function ()
    {
        var waitDiv = $("div.wait");
        if (waitDiv.length == 0)
        {
            waitDiv = $("<div class='wait'></div>").prependTo($(document.body));

        }

        waitDiv.show();
        return waitDiv;
    },
    hideWait: function ()
    {
        $("div.wait").hide();


    },
    errorResult: null,
    call: function (eventTarget, eventArgument, method, callCtrl, callBack, showWait)
    {
        var oSend = new Object();
        oSend.Method = method;
        if (typeof (showWait) == "undefined")
        {
            showWait = false;
        }
        if (showWait)
        {
            $.showWait();
        }
        if (eventArgument == null)
        {
        }
        else if (typeof (eventArgument) == "object")
        {
            oSend.Args = eventArgument;
        }
        else
        {
            oSend.Args = new Array();
            oSend.Args.push(eventArgument);
        }
        if (callCtrl)
        {
            oSend.CallControl = callCtrl;
        }
        var postData = $.createPostData() + "__CALLBACKID=" + $.escape(eventTarget) +
            "&__CALLBACKPARAM=" + $.escape($.toJSON(oSend));
        var form = $("form")[0];
        if (form["__EVENTVALIDATION"])
        {
            postData += "&__EVENTVALIDATION=" + $.escape(form["__EVENTVALIDATION"].value);
        }
        var callReturnValue = null;

        var isAsync = false;
        if (typeof (callBack) != "undefined" && callBack != null)
        {
            isAsync = true;
        }

        $.ajax({
            type: "POST",
            async: isAsync,
            url: AppendAjaxTs(window.document.location.href),
            data: postData,
            success: function (result)
            {
                if (showWait)
                {
                    $.hideWait();
                }
                var i1 = result.indexOf("|");
                if (i1 > 0 && i1 < 6)
                {
                    var i2 = parseInt(result.substr(0, i1));
                    var callReutrn = $.parseJSON(result.substr(i1 + 1 + i2));
                    callReturnValue = $.parseCallReturn(callReutrn);
                    if (typeof (callBack) != "undefined" && callBack != null)
                    {
                        callBack(callReturnValue);
                    }

                }
                else
                {
                    // alert(result);
                }
            },
            error: function (result)
            {
                $.errorResult = result;
                if (showWait)
                {
                    $.hideWait();
                }
                if (typeof (callBack) != "undefined" && callBack != null)
                {
                    callBack(undefined);
                }
 
            }
        });
        if (showWait && !isAsync)
        {
            $.hideWait();
        }
        return callReturnValue;
    },
    copy: function(text)
    {
        var copyInput = $("#_copy___");
        if (copyInput.length == 0)
        {
            copyInput = $("<input type='text' style='position:abolute;top:-100px;'/>").prependTo($(document.body));
        }
        copyInput.val(text);
        copyInput.select(); 
        document.execCommand("Copy");
        copyInput.remove();
    },
    encodeURI: function (text)
    {
        return this.escape(text);
    },
    escape: function (text)
    {
        if (text == null)
        {
            return "";
        }
        if (encodeURIComponent)
        {
            return encodeURIComponent(text);
        }
        else
        {
            return escape(parameter);
        }
    },
    unescape: function (text)
    {
        if (text == null)
        {
            return "";
        }
        if (decodeURIComponent)
        {
            return decodeURIComponent(text);
        }
        else if (unescape)
        {
            return unescape(text);
        }
        else
        {
            return decodeURI(parameter);
        }
    },
    gotoLogin: function ()
    {
        if (typeof (top._GotoLogin) != "undefined")
        {
            top._GotoLogin();
        }
        else if (typeof (_GotoLogin) != "undefined")
        {
            _GotoLogin();
        }
        else
        {
            top.location.reload(true);
        }
    },
    parseCallReturn: function (callReutrn)
    {
        if (callReutrn.Message)
        {
            if (callReutrn.Message != "")
            {
                if (typeof (_CallMessage) != "undefined")
                {
                    _CallMessage(callReutrn.Message);
                }
                else
                {
                    $.msg(callReutrn.Message);
                }
            }
        }
        if (callReutrn.GotoLogin)
        {
            $.gotoLogin();
        }
        if (callReutrn.ClientScript)
        {
            if (callReutrn.ClientScript != "")
            {
                eval(callReutrn.ClientScript);
            }
        }
        if (callReutrn.IsReloadData)
        {
            if (_I_ReloadData)
            {
                _I_ReloadData();
            }
        }
        if (callReutrn.IsResetData)
        {
            if (_I_ResetData)
            {
                _I_ResetData(callReutrn.ReturnValue);
            }
        }

        if (callReutrn.IsReloadPage)
        {
            document.location.reload(true);
        }
        if (callReutrn.LocationUrl)
        {
            if (callReutrn.LocationUrl != "")
            {
                document.location.href = callReutrn.LocationUrl;
            }
        }
        if (callReutrn.OpenUrl)
        {
            if (callReutrn.OpenUrl != "")
            {
                window.open(callReutrn.OpenUrl);
            }
        }
        if (callReutrn.IsSuccess)
        {
            return callReutrn.ReturnValue;

        }
        else
        {
            if (callReutrn.ExceptionMessage != null)
            {
                if (callReutrn.ExceptionMessage == "{not_logged_in}")
                {
                    $.msg("没有登录或登录超时");
                }
                else
                {
                    if (typeof (_CallException) != "undefined")
                    {
                        _CallException(callReutrn.ExceptionMessage, callReutrn.ReturnValue);
                    }
                    else
                    {
                        $.msg(callReutrn.ExceptionMessage);
                    }
                }
            }
            return callReutrn.ReturnValue;
        }
    },

    createPostData: function ()
    {
        var form = $("form")[0];
        var postData = "";
        var count = form.elements.length;
        var element;
        var iFE = 0;

        var checkedCtrls = new Array();
        var noCheckedCtrls = new Array();
        var formItemNames = [];


        while (form.elements[iFE] != null)
        {
            element = form.elements[iFE];
            iFE++;

            if (element.name == null || element.name == "")
            {
                continue;
            }
            var tagName = element.tagName.toLowerCase();

            if (tagName == "input")
            {
                var type = element.type;
                if ((type == "text" || type == "hidden" || type == "password") &&
                    (element.id != "__EVENTVALIDATION"))
                {
                    postData += $.escape(element.name) + "=" + $.escape(element.value) + "&";
                }
                else if (type == "checkbox" || type == "radio")
                {
                    if (element.checked)
                    {
                        checkedCtrls.push(element.name);
                        var checkValue = "true";
                        if (element.value != "on")
                        {
                            checkValue = element.value;
                        }

                        postData += $.escape(element.name) + "=" + $.escape(checkValue) + "&";
                    }
                    else
                    {
                        noCheckedCtrls.push(element.name);
                    }
                }
            }
            else if (tagName == "select")
            {
                var selectCount = element.options.length;
                for (var jFE = 0; jFE < selectCount; jFE++)
                {
                    var selectChild = element.options[jFE];
                    if (selectChild.selected == true)
                    {
                        postData += $.escape(element.name) + "=" + $.escape(element.value) + "&";
                    }
                }
            }
            else if (tagName == "textarea")
            {
                postData += $.escape(element.name) + "=" + $.escape(element.value) + "&";
            }

            formItemNames.push(element.name);
        }

        for (var jFE = 0; jFE < noCheckedCtrls.length; jFE++)
        {
            var noCheckedCtrl = noCheckedCtrls[jFE];
            if (!checkedCtrls.contains(noCheckedCtrl))
            {
                postData += $.escape(noCheckedCtrl) + "=" + $.escape("") + "&";
                checkedCtrls.push(noCheckedCtrl);

            }

        }
        if (typeof (_Call_PostForm) != "undefined")
        {
            for (var pName in _Call_PostForm)
            {
                if (!formItemNames.contains(pName, true))
                {
                    postData += $.escape(pName) + "=" + $.escape(_Call_PostForm[pName]) + "&";
                }
            }
        }
        var ucid = $.cookie("u_cid");
        if (ucid)
        {
            postData += "__ajax_token=" + $.escape("1." + ucid + "-") + "&";
        }
        return postData;
    }

});
function jSpliterBind(moveCtrlId, vh, fSplitReturn)
{
    if ($("#" + moveCtrlId).length > 0)
    {
        jSpliter($("#" + moveCtrlId)[0], vh, fSplitReturn);
    }
    else
    {
        setTimeout(function () { jSpliterBind(moveCtrlId, vh, fSplitReturn) }, 100);
    }
}
function jSpliter(moveCtrl, vh, fSplitReturn)
{
    this.MoveCtrl = moveCtrl;
    this.VH = vh == "v" ? 1 : 0;
    this.Cursor = this.VH == 1 ? "n-resize" : "s-resize";
    this.Return = fSplitReturn;

    this.x1 = null;
    this.y1 = null;

    this.x2 = null;
    this.y2 = null;
    this.OverCtrl = null;
    this.ShowCtrl = null;
    this.MouseDown = false;

    this.Move = function (e)
    {
        if (this.MouseDown)
        {
            if (this.OverCtrl == null)
            {
                this.OverCtrl = $("<div></div>");
                $(this.OverCtrl).css({ "position": "absolute", "width": "100%", "top": "0px", "left": "0px", "height": "100%", "z-index": 9999 });
                $(document.body).append(this.OverCtrl);
                this.ShowCtrl = $("<div></div>");

                $(this.ShowCtrl).css({ "position": "absolute", "cursor": "n-resize", "width": "100%", "background-color": "#cccccc", "height": "5px", "z-index": 9999 });
                $(this.OverCtrl).append(this.ShowCtrl);
            }
            else
            {
                $(this.OverCtrl).css("display", "");
            }
            $(this.ShowCtrl).css("top", e.pageY - 2);
        }
    }

    this.Down = function (e)
    {
        if (e.target == this.MoveCtrl)
        {
            this.MouseDown = true;
            this.x1 = e.pageX;
            this.y1 = e.pageY;
        }
    }

    this.Up = function (e)
    {
        if (this.MouseDown && this.y1 != e.pageY)
        {
            this.x2 = e.pageX;
            this.y2 = e.pageY;

            fSplitReturn(this);
        }
        if (this.MouseDown)
        {
            this.Reset();
        }
    }

    this.Reset = function ()
    {
        if (this.OverCtrl != null)
        {
            $(this.OverCtrl).css("display", "none");
        }
        this.MouseDown = false;
    }

    var js = this;
    $(moveCtrl).css("cursor", js.Cursor).mousedown(function (e) { js.Down(e); });
    $(document.body).mouseup(function (e)
    {
        js.Up(e);
    }).mouseleave(function ()
    {
        if (js.MouseDown)
        {
            js.Reset();
        }
    }).mousemove(function (e)
    {
        js.Move(e);

    });
}


function _SetFrameHeight()
{
    var ifs = $("iframe");

    $(ifs).each(function ()
    {

        if (this.style.height == "" || this.style.height == "100%")
        {
            if ($(this).parent().height() - 10 > $(this).height())
            {
                $(this).height($(this).parent().height());
            }
        }
    });
}
//$(document).ready(function ()
//{
//    var ifs = $("iframe");
//    $(ifs).attr("frameborder", "0");

//   // _SetFrameHeight();
//});



/*! jQuery UI - v1.9.2 - 2014-02-23
* http://jqueryui.com
* Includes: jquery.ui.core.js, jquery.ui.datepicker.js
* Copyright 2014 jQuery Foundation and other contributors; Licensed MIT */

(function ($, undefined)
{

    var uuid = 0,
        runiqueId = /^ui-id-\d+$/;

    // prevent duplicate loading
    // this is only a problem because we proxy existing functions
    // and we don't want to double proxy them
    $.ui = $.ui || {};
    if ($.ui.version)
    {
        return;
    }

    $.extend($.ui, {
        version: "1.9.2",

        keyCode: {
            BACKSPACE: 8,
            COMMA: 188,
            DELETE: 46,
            DOWN: 40,
            END: 35,
            ENTER: 13,
            ESCAPE: 27,
            HOME: 36,
            LEFT: 37,
            NUMPAD_ADD: 107,
            NUMPAD_DECIMAL: 110,
            NUMPAD_DIVIDE: 111,
            NUMPAD_ENTER: 108,
            NUMPAD_MULTIPLY: 106,
            NUMPAD_SUBTRACT: 109,
            PAGE_DOWN: 34,
            PAGE_UP: 33,
            PERIOD: 190,
            RIGHT: 39,
            SPACE: 32,
            TAB: 9,
            UP: 38
        }
    });

    // plugins
    $.fn.extend({
        _focus: $.fn.focus,
        focus: function (delay, fn)
        {
            return typeof delay === "number" ?
                this.each(function ()
                {
                    var elem = this;
                    setTimeout(function ()
                    {
                        $(elem).focus();
                        if (fn)
                        {
                            fn.call(elem);
                        }
                    }, delay);
                }) :
                this._focus.apply(this, arguments);
        },
        enterTab: function (lastEvent)
        {
            var inputs = this;
            inputs.keypress(function (e)
            {
                if (e.keyCode == 13)
                {
                    var idx = inputs.index(this);
                    if (idx < inputs.length - 1)
                    {
                        inputs[idx + 1].focus();
                    }
                    else if (lastEvent)
                    {
                        lastEvent();
                    }
                }
            });
        },
        //hasClass: function (className)
        //{
        //    var c = this.attr("class");
        //    if (c)
        //    {
        //        var cs = c.split(" ");
        //        for (var i = 0; i < cs.length; i++)
        //        {
        //            cs[i] = cs[i].replace(/" "/g, "");
        //        }
        //        return cs.contains(className);
        //    }

        //    return false;
        //},
        scrollParent: function ()
        {
            var scrollParent;
            if (($.ui.ie && (/(static|relative)/).test(this.css('position'))) || (/absolute/).test(this.css('position')))
            {
                scrollParent = this.parents().filter(function ()
                {
                    return (/(relative|absolute|fixed)/).test($.css(this, 'position')) && (/(auto|scroll)/).test($.css(this, 'overflow') + $.css(this, 'overflow-y') + $.css(this, 'overflow-x'));
                }).eq(0);
            } else
            {
                scrollParent = this.parents().filter(function ()
                {
                    return (/(auto|scroll)/).test($.css(this, 'overflow') + $.css(this, 'overflow-y') + $.css(this, 'overflow-x'));
                }).eq(0);
            }

            return (/fixed/).test(this.css('position')) || !scrollParent.length ? $(document) : scrollParent;
        },

        zIndex: function (zIndex)
        {
            if (zIndex !== undefined)
            {
                return this.css("zIndex", zIndex);
            }

            if (this.length)
            {
                var elem = $(this[0]), position, value;
                while (elem.length && elem[0] !== document)
                {
                    // Ignore z-index if position is set to a value where z-index is ignored by the browser
                    // This makes behavior of this function consistent across browsers
                    // WebKit always returns auto if the element is positioned
                    position = elem.css("position");
                    if (position === "absolute" || position === "relative" || position === "fixed")
                    {
                        // IE returns 0 when zIndex is not specified
                        // other browsers return a string
                        // we ignore the case of nested elements with an explicit value of 0
                        // <div style="z-index: -10;"><div style="z-index: 0;"></div></div>
                        value = parseInt(elem.css("zIndex"), 10);
                        if (!isNaN(value) && value !== 0)
                        {
                            return value;
                        }
                    }
                    elem = elem.parent();
                }
            }

            return 0;
        },

        uniqueId: function ()
        {
            return this.each(function ()
            {
                if (!this.id)
                {
                    this.id = "ui-id-" + (++uuid);
                }
            });
        },

        removeUniqueId: function ()
        {
            return this.each(function ()
            {
                if (runiqueId.test(this.id))
                {
                    $(this).removeAttr("id");
                }
            });
        }
    });

    // selectors
    function focusable(element, isTabIndexNotNaN)
    {
        var map, mapName, img,
            nodeName = element.nodeName.toLowerCase();
        if ("area" === nodeName)
        {
            map = element.parentNode;
            mapName = map.name;
            if (!element.href || !mapName || map.nodeName.toLowerCase() !== "map")
            {
                return false;
            }
            img = $("img[usemap=#" + mapName + "]")[0];
            return !!img && visible(img);
        }
        return (/input|select|textarea|button|object/.test(nodeName) ?
            !element.disabled :
            "a" === nodeName ?
                element.href || isTabIndexNotNaN :
                isTabIndexNotNaN) &&
            // the element and all of its ancestors must be visible
            visible(element);
    }

    function visible(element)
    {
        return $.expr.filters.visible(element) &&
            !$(element).parents().andSelf().filter(function ()
            {
                return $.css(this, "visibility") === "hidden";
            }).length;
    }

    $.extend($.expr[":"], {
        data: $.expr.createPseudo ?
            $.expr.createPseudo(function (dataName)
            {
                return function (elem)
                {
                    return !!$.data(elem, dataName);
                };
            }) :
            // support: jQuery <1.8
            function (elem, i, match)
            {
                return !!$.data(elem, match[3]);
            },

        focusable: function (element)
        {
            return focusable(element, !isNaN($.attr(element, "tabindex")));
        },

        tabbable: function (element)
        {
            var tabIndex = $.attr(element, "tabindex"),
                isTabIndexNaN = isNaN(tabIndex);
            return (isTabIndexNaN || tabIndex >= 0) && focusable(element, !isTabIndexNaN);
        }
    });

    // support
    $(function ()
    {
        var body = document.body,
            div = body.appendChild(div = document.createElement("div"));

        // access offsetHeight before setting the style to prevent a layout bug
        // in IE 9 which causes the element to continue to take up space even
        // after it is removed from the DOM (#8026)
        div.offsetHeight;

        $.extend(div.style, {
            minHeight: "100px",
            height: "auto",
            padding: 0,
            borderWidth: 0
        });

        $.support.minHeight = div.offsetHeight === 100;
        $.support.selectstart = "onselectstart" in div;

        // set display to none to avoid a layout bug in IE
        // http://dev.jquery.com/ticket/4014
        body.removeChild(div).style.display = "none";
    });

    // support: jQuery <1.8
    if (!$("<a>").outerWidth(1).jquery)
    {
        $.each(["Width", "Height"], function (i, name)
        {
            var side = name === "Width" ? ["Left", "Right"] : ["Top", "Bottom"],
                type = name.toLowerCase(),
                orig = {
                    innerWidth: $.fn.innerWidth,
                    innerHeight: $.fn.innerHeight,
                    outerWidth: $.fn.outerWidth,
                    outerHeight: $.fn.outerHeight
                };

            function reduce(elem, size, border, margin)
            {
                $.each(side, function ()
                {
                    size -= parseFloat($.css(elem, "padding" + this)) || 0;
                    if (border)
                    {
                        size -= parseFloat($.css(elem, "border" + this + "Width")) || 0;
                    }
                    if (margin)
                    {
                        size -= parseFloat($.css(elem, "margin" + this)) || 0;
                    }
                });
                return size;
            }

            $.fn["inner" + name] = function (size)
            {
                if (size === undefined)
                {
                    return orig["inner" + name].call(this);
                }

                return this.each(function ()
                {
                    $(this).css(type, reduce(this, size) + "px");
                });
            };

            $.fn["outer" + name] = function (size, margin)
            {
                if (typeof size !== "number")
                {
                    return orig["outer" + name].call(this, size);
                }

                return this.each(function ()
                {
                    $(this).css(type, reduce(this, size, true, margin) + "px");
                });
            };
        });
    }

    // support: jQuery 1.6.1, 1.6.2 (http://bugs.jquery.com/ticket/9413)
    if ($("<a>").data("a-b", "a").removeData("a-b").data("a-b"))
    {
        $.fn.removeData = (function (removeData)
        {
            return function (key)
            {
                if (arguments.length)
                {
                    return removeData.call(this, $.camelCase(key));
                } else
                {
                    return removeData.call(this);
                }
            };
        })($.fn.removeData);
    }





    // deprecated

    (function ()
    {
        var uaMatch = /msie ([\w.]+)/.exec(navigator.userAgent.toLowerCase()) || [];
        $.ui.ie = uaMatch.length ? true : false;
        $.ui.ie6 = parseFloat(uaMatch[1], 10) === 6;
    })();

    $.fn.extend({
        disableSelection: function ()
        {
            return this.bind(($.support.selectstart ? "selectstart" : "mousedown") +
                ".ui-disableSelection", function (event)
                {
                    event.preventDefault();
                });
        },

        enableSelection: function ()
        {
            return this.unbind(".ui-disableSelection");
        }
    });

    $.extend($.ui, {
        // $.ui.plugin is deprecated.  Use the proxy pattern instead.
        plugin: {
            add: function (module, option, set)
            {
                var i,
                    proto = $.ui[module].prototype;
                for (i in set)
                {
                    proto.plugins[i] = proto.plugins[i] || [];
                    proto.plugins[i].push([option, set[i]]);
                }
            },
            call: function (instance, name, args)
            {
                var i,
                    set = instance.plugins[name];
                if (!set || !instance.element[0].parentNode || instance.element[0].parentNode.nodeType === 11)
                {
                    return;
                }

                for (i = 0; i < set.length; i++)
                {
                    if (instance.options[set[i][0]])
                    {
                        set[i][1].apply(instance.element, args);
                    }
                }
            }
        },

        contains: $.contains,

        // only used by resizable
        hasScroll: function (el, a)
        {

            //If overflow is hidden, the element might have extra content, but the user wants to hide it
            if ($(el).css("overflow") === "hidden")
            {
                return false;
            }

            var scroll = (a && a === "left") ? "scrollLeft" : "scrollTop",
                has = false;

            if (el[scroll] > 0)
            {
                return true;
            }

            // TODO: determine which cases actually cause this to happen
            // if the element doesn't have the scroll set, see if it's possible to
            // set the scroll
            el[scroll] = 1;
            has = (el[scroll] > 0);
            el[scroll] = 0;
            return has;
        },

        // these are odd functions, fix the API or move into individual plugins
        isOverAxis: function (x, reference, size)
        {
            //Determines when x coordinate is over "b" element axis
            return (x > reference) && (x < (reference + size));
        },
        isOver: function (y, x, top, left, height, width)
        {
            //Determines when x, y coordinates is over "b" element
            return $.ui.isOverAxis(y, top, height) && $.ui.isOverAxis(x, left, width);
        }
    });

})(jQuery);
(function ($, undefined)
{

    $.extend($.ui, { datepicker: { version: "1.9.2" } });

    var PROP_NAME = 'datepicker';
    var dpuuid = new Date().getTime();
    var instActive;

    /* Date picker manager.
       Use the singleton instance of this class, $.datepicker, to interact with the date picker.
       Settings for (groups of) date pickers are maintained in an instance object,
       allowing multiple different settings on the same page. */

    function Datepicker()
    {
        this.debug = false; // Change this to true to start debugging
        this._curInst = null; // The current instance in use
        this._keyEvent = false; // If the last event was a key event
        this._disabledInputs = []; // List of date picker inputs that have been disabled
        this._datepickerShowing = false; // True if the popup picker is showing , false if not
        this._inDialog = false; // True if showing within a "dialog", false if not
        this._mainDivId = 'ui-datepicker-div'; // The ID of the main datepicker division
        this._inlineClass = 'ui-datepicker-inline'; // The name of the inline marker class
        this._appendClass = 'ui-datepicker-append'; // The name of the append marker class
        this._triggerClass = 'ui-datepicker-trigger'; // The name of the trigger marker class
        this._dialogClass = 'ui-datepicker-dialog'; // The name of the dialog marker class
        this._disableClass = 'ui-datepicker-disabled'; // The name of the disabled covering marker class
        this._unselectableClass = 'ui-datepicker-unselectable'; // The name of the unselectable cell marker class
        this._currentClass = 'ui-datepicker-current-day'; // The name of the current day marker class
        this._dayOverClass = 'ui-datepicker-days-cell-over'; // The name of the day hover marker class
        this.regional = []; // Available regional settings, indexed by language code
        this.regional[''] = { // Default regional settings
            closeText: '确定', // Display text for close link
            prevText: '3', // Display text for previous month link
            nextText: '4', // Display text for next month link
            currentText: '今天', // Display text for current month link
            monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                '七月', '八月', '九月', '十月', '十一月', '十二月'], // Names of months for drop-down and formatting
            monthNamesShort: ['一月', '二月', '三月', '四月', '五月', '六月',
                '七月', '八月', '九月', '十月', '十一月', '十二月'], // For formatting
            dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'], // For formatting
            dayNamesShort: ['日', '一', '二', '三', '四', '五', '六'], // For formatting
            dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'], // Column headings for days starting at Sunday
            weekHeader: 'Wk', // Column header for week of the year
            dateFormat: 'yy-mm-dd', // See format options on parseDate
            firstDay: 0, // The first day of the week, Sun = 0, Mon = 1, ...
            isRTL: false, // True if right-to-left language, false if left-to-right
            showMonthAfterYear: true, // True if the year select precedes month, false for month then year
            yearSuffix: '' // Additional text to append to the year in the month headers
        };
        this._defaults = { // Global defaults for all the date picker instances
            showOn: 'focus', // 'focus' for popup on focus,
            // 'button' for trigger button, or 'both' for either
            showAnim: 'fadeIn', // Name of jQuery animation for popup
            showOptions: {}, // Options for enhanced animations
            defaultDate: null, // Used when field is blank: actual date,
            // +/-number for offset from today, null for today
            appendText: '', // Display text following the input box, e.g. showing the format
            buttonText: '...', // Text for trigger button
            buttonImage: '', // URL for trigger button image
            buttonImageOnly: false, // True if the image appears alone, false if it appears on a button
            hideIfNoPrevNext: false, // True to hide next/previous month links
            // if not applicable, false to just disable them
            navigationAsDateFormat: false, // True if date formatting applied to prev/today/next links
            gotoCurrent: false, // True if today link goes back to current selection instead
            changeMonth: true, // True if month can be selected directly, false if only prev/next
            changeYear: true, // True if year can be selected directly, false if only prev/next
            yearRange: 'c-10:c+10', // Range of years to display in drop-down,
            // either relative to today's year (-nn:+nn), relative to currently displayed year
            // (c-nn:c+nn), absolute (nnnn:nnnn), or a combination of the above (nnnn:-n)
            showOtherMonths: false, // True to show dates in other months, false to leave blank
            selectOtherMonths: false, // True to allow selection of dates in other months, false for unselectable
            showWeek: false, // True to show week of the year, false to not show it
            calculateWeek: this.iso8601Week, // How to calculate the week of the year,
            // takes a Date and returns the number of the week for it
            shortYearCutoff: '+10', // Short year values < this are in the current century,
            // > this are in the previous century,
            // string value starting with '+' for current year + value
            minDate: null, // The earliest selectable date, or null for no limit
            maxDate: null, // The latest selectable date, or null for no limit
            duration: 'fast', // Duration of display/closure
            beforeShowDay: null, // Function that takes a date and returns an array with
            // [0] = true if selectable, false if not, [1] = custom CSS class name(s) or '',
            // [2] = cell title (optional), e.g. $.datepicker.noWeekends
            beforeShow: null, // Function that takes an input field and
            // returns a set of custom settings for the date picker
            onSelect: null, // Define a callback function when a date is selected
            onChangeMonthYear: null, // Define a callback function when the month or year is changed
            onClose: null, // Define a callback function when the datepicker is closed
            numberOfMonths: 1, // Number of months to show at a time
            showCurrentAtPos: 0, // The position in multipe months at which to show the current month (starting at 0)
            stepMonths: 1, // Number of months to step back/forward
            stepBigMonths: 12, // Number of months to step back/forward for the big links
            altField: '', // Selector for an alternate field to store selected dates into
            altFormat: '', // The date format to use for the alternate field
            constrainInput: true, // The input is constrained by the current date format
            showButtonPanel: false, // True to show button panel, false to not show it
            autoSize: false, // True to size the input for the date format, false to leave as is
            disabled: false, // The initial disabled state
            showTime: false, //显示时间
            varDate: false
        };
        $.extend(this._defaults, this.regional['']);
        this.dpDiv = bindHover($('<div id="' + this._mainDivId + '" class="ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>'));
    }

    $.extend(Datepicker.prototype, {
        /* Class name added to elements to indicate already configured with a date picker. */
        markerClassName: 'hasDatepicker',

        //Keep track of the maximum number of rows displayed (see #7043)
        maxRows: 4,

        /* Debug logging (if enabled). */
        log: function ()
        {
            if (this.debug)
                console.log.apply('', arguments);
        },

        // TODO rename to "widget" when switching to widget factory
        _widgetDatepicker: function ()
        {
            return this.dpDiv;
        },

        /* Override the default settings for all instances of the date picker.
           @param  settings  object - the new settings to use as defaults (anonymous object)
           @return the manager object */
        setDefaults: function (settings)
        {
            extendRemove(this._defaults, settings || {});
            return this;
        },

        /* Attach the date picker to a jQuery selection.
           @param  target    element - the target input field or division or span
           @param  settings  object - the new settings to use for this date picker instance (anonymous) */
        _attachDatepicker: function (target, settings)
        {
            // check for settings on the control itself - in namespace 'date:'
            var inlineSettings = null;
            for (var attrName in this._defaults)
            {
                var attrValue = target.getAttribute('date:' + attrName);
                if (attrValue)
                {
                    inlineSettings = inlineSettings || {};
                    try
                    {
                        inlineSettings[attrName] = eval(attrValue);
                    } catch (err)
                    {
                        inlineSettings[attrName] = attrValue;
                    }
                }
            }
            var nodeName = target.nodeName.toLowerCase();
            var inline = (nodeName == 'div' || nodeName == 'span');
            if (!target.id)
            {
                this.uuid += 1;
                target.id = 'dp' + this.uuid;
            }
            var inst = this._newInst($(target), inline);
            inst.settings = $.extend({}, settings || {}, inlineSettings || {});

            if ($(target).hasClass("show-time"))
            {
                inst.settings.showTime = true;
            }
            if ($(target).hasClass("var-date"))
            {
                inst.settings.varDate = true;
            }

            if (nodeName == 'input')
            {
                this._connectDatepicker(target, inst);
            } else if (inline)
            {
                this._inlineDatepicker(target, inst);
            }
        },

        /* Create a new instance object. */
        _newInst: function (target, inline)
        {
            var id = target[0].id.replace(/([^A-Za-z0-9_-])/g, '\\\\$1'); // escape jQuery meta chars
            return {
                id: id, input: target, // associated target
                selectedDay: 0, selectedMonth: 0, selectedYear: 0, // current selection
                drawMonth: 0, drawYear: 0, // month being drawn
                inline: inline, // is datepicker inline or not
                dpDiv: (!inline ? this.dpDiv : // presentation div
                    bindHover($('<div class="' + this._inlineClass + ' ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"></div>')))
            };
        },

        /* Attach the date picker to an input field. */
        _connectDatepicker: function (target, inst)
        {
            var input = $(target);
            inst.append = $([]);
            inst.trigger = $([]);
            if (input.hasClass(this.markerClassName))
                return;
            this._attachments(input, inst);
            input.addClass(this.markerClassName).keydown(this._doKeyDown).
                keypress(this._doKeyPress).keyup(this._doKeyUp).
                bind("setData.datepicker", function (event, key, value)
                {
                    inst.settings[key] = value;
                }).bind("getData.datepicker", function (event, key)
                {
                    return this._get(inst, key);
                });
            this._autoSize(inst);
            $.data(target, PROP_NAME, inst);
            //If disabled option is true, disable the datepicker once it has been attached to the input (see ticket #5665)
            if (inst.settings.disabled)
            {
                this._disableDatepicker(target);
            }
        },

        /* Make attachments based on settings. */
        _attachments: function (input, inst)
        {
            var appendText = this._get(inst, 'appendText');
            var isRTL = this._get(inst, 'isRTL');
            if (inst.append)
                inst.append.remove();
            if (appendText)
            {
                inst.append = $('<span class="' + this._appendClass + '">' + appendText + '</span>');
                input[isRTL ? 'before' : 'after'](inst.append);
            }
            input.unbind('focus', this._showDatepicker);
            if (inst.trigger)
                inst.trigger.remove();
            var showOn = this._get(inst, 'showOn');
            if (showOn == 'focus' || showOn == 'both') // pop-up date picker when in the marked field
                input.focus(this._showDatepicker);
            if (showOn == 'button' || showOn == 'both')
            { // pop-up date picker when button clicked
                var buttonText = this._get(inst, 'buttonText');
                var buttonImage = this._get(inst, 'buttonImage');
                inst.trigger = $(this._get(inst, 'buttonImageOnly') ?
                    $('<img/>').addClass(this._triggerClass).
                        attr({ src: buttonImage, alt: buttonText, title: buttonText }) :
                    $('<button type="button"></button>').addClass(this._triggerClass).
                        html(buttonImage == '' ? buttonText : $('<img/>').attr(
                            { src: buttonImage, alt: buttonText, title: buttonText })));
                input[isRTL ? 'before' : 'after'](inst.trigger);
                inst.trigger.click(function ()
                {
                    if ($.datepicker._datepickerShowing && $.datepicker._lastInput == input[0])
                        $.datepicker._hideDatepicker();
                    else if ($.datepicker._datepickerShowing && $.datepicker._lastInput != input[0])
                    {
                        $.datepicker._hideDatepicker();
                        $.datepicker._showDatepicker(input[0]);
                    } else
                        $.datepicker._showDatepicker(input[0]);
                    return false;
                });
            }
        },

        /* Apply the maximum length for the date format. */
        _autoSize: function (inst)
        {
            if (this._get(inst, 'autoSize') && !inst.inline)
            {
                var date = new Date(2009, 12 - 1, 20); // Ensure double digits
                var dateFormat = this._get(inst, 'dateFormat');
                if (dateFormat.match(/[DM]/))
                {
                    var findMax = function (names)
                    {
                        var max = 0;
                        var maxI = 0;
                        for (var i = 0; i < names.length; i++)
                        {
                            if (names[i].length > max)
                            {
                                max = names[i].length;
                                maxI = i;
                            }
                        }
                        return maxI;
                    };
                    date.setMonth(findMax(this._get(inst, (dateFormat.match(/MM/) ?
                        'monthNames' : 'monthNamesShort'))));
                    date.setDate(findMax(this._get(inst, (dateFormat.match(/DD/) ?
                        'dayNames' : 'dayNamesShort'))) + 20 - date.getDay());
                }
                inst.input.attr('size', this._formatDate(inst, date).length);
            }
        },

        /* Attach an inline date picker to a div. */
        _inlineDatepicker: function (target, inst)
        {
            var divSpan = $(target);
            if (divSpan.hasClass(this.markerClassName))
                return;
            divSpan.addClass(this.markerClassName).append(inst.dpDiv).
                bind("setData.datepicker", function (event, key, value)
                {
                    inst.settings[key] = value;
                }).bind("getData.datepicker", function (event, key)
                {
                    return this._get(inst, key);
                });
            $.data(target, PROP_NAME, inst);
            this._setDate(inst, this._getDefaultDate(inst), true);
            this._updateDatepicker(inst);
            this._updateAlternate(inst);
            //If disabled option is true, disable the datepicker before showing it (see ticket #5665)
            if (inst.settings.disabled)
            {
                this._disableDatepicker(target);
            }
            // Set display:block in place of inst.dpDiv.show() which won't work on disconnected elements
            // http://bugs.jqueryui.com/ticket/7552 - A Datepicker created on a detached div has zero height
            inst.dpDiv.css("display", "block");
        },

        /* Pop-up the date picker in a "dialog" box.
           @param  input     element - ignored
           @param  date      string or Date - the initial date to display
           @param  onSelect  function - the function to call when a date is selected
           @param  settings  object - update the dialog date picker instance's settings (anonymous object)
           @param  pos       int[2] - coordinates for the dialog's position within the screen or
                             event - with x/y coordinates or
                             leave empty for default (screen centre)
           @return the manager object */
        _dialogDatepicker: function (input, date, onSelect, settings, pos)
        {
            var inst = this._dialogInst; // internal instance
            if (!inst)
            {
                this.uuid += 1;
                var id = 'dp' + this.uuid;
                this._dialogInput = $('<input type="text" id="' + id +
                    '" style="position: absolute; top: -100px; width: 0px;"/>');
                this._dialogInput.keydown(this._doKeyDown);
                $('body').append(this._dialogInput);
                inst = this._dialogInst = this._newInst(this._dialogInput, false);
                inst.settings = {};
                $.data(this._dialogInput[0], PROP_NAME, inst);
            }
            extendRemove(inst.settings, settings || {});
            date = (date && date.constructor == Date ? this._formatDate(inst, date) : date);
            this._dialogInput.val(date);

            this._pos = (pos ? (pos.length ? pos : [pos.pageX, pos.pageY]) : null);
            if (!this._pos)
            {
                var browserWidth = document.documentElement.clientWidth;
                var browserHeight = document.documentElement.clientHeight;
                var scrollX = document.documentElement.scrollLeft || document.body.scrollLeft;
                var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
                this._pos = // should use actual width/height below
                    [(browserWidth / 2) - 100 + scrollX, (browserHeight / 2) - 150 + scrollY];
            }

            // move input on screen for focus, but hidden behind dialog
            this._dialogInput.css('left', (this._pos[0] + 20) + 'px').css('top', this._pos[1] + 'px');
            inst.settings.onSelect = onSelect;
            this._inDialog = true;
            this.dpDiv.addClass(this._dialogClass);
            this._showDatepicker(this._dialogInput[0]);
            if ($.blockUI)
                $.blockUI(this.dpDiv);
            $.data(this._dialogInput[0], PROP_NAME, inst);
            return this;
        },

        /* Detach a datepicker from its control.
           @param  target    element - the target input field or division or span */
        _destroyDatepicker: function (target)
        {
            var $target = $(target);
            var inst = $.data(target, PROP_NAME);
            if (!$target.hasClass(this.markerClassName))
            {
                return;
            }
            var nodeName = target.nodeName.toLowerCase();
            $.removeData(target, PROP_NAME);
            if (nodeName == 'input')
            {
                inst.append.remove();
                inst.trigger.remove();
                $target.removeClass(this.markerClassName).
                    unbind('focus', this._showDatepicker).
                    unbind('keydown', this._doKeyDown).
                    unbind('keypress', this._doKeyPress).
                    unbind('keyup', this._doKeyUp);
            } else if (nodeName == 'div' || nodeName == 'span')
                $target.removeClass(this.markerClassName).empty();
        },

        /* Enable the date picker to a jQuery selection.
           @param  target    element - the target input field or division or span */
        _enableDatepicker: function (target)
        {
            var $target = $(target);
            var inst = $.data(target, PROP_NAME);
            if (!$target.hasClass(this.markerClassName))
            {
                return;
            }
            var nodeName = target.nodeName.toLowerCase();
            if (nodeName == 'input')
            {
                target.disabled = false;
                inst.trigger.filter('button').
                    each(function () { this.disabled = false; }).end().
                    filter('img').css({ opacity: '1.0', cursor: '' });
            }
            else if (nodeName == 'div' || nodeName == 'span')
            {
                var inline = $target.children('.' + this._inlineClass);
                inline.children().removeClass('ui-state-disabled');
                inline.find("select.ui-datepicker-month, select.ui-datepicker-year").
                    prop("disabled", false);
            }
            this._disabledInputs = $.map(this._disabledInputs,
                function (value) { return (value == target ? null : value); }); // delete entry
        },

        /* Disable the date picker to a jQuery selection.
           @param  target    element - the target input field or division or span */
        _disableDatepicker: function (target)
        {
            var $target = $(target);
            var inst = $.data(target, PROP_NAME);
            if (!$target.hasClass(this.markerClassName))
            {
                return;
            }
            var nodeName = target.nodeName.toLowerCase();
            if (nodeName == 'input')
            {
                target.disabled = true;
                inst.trigger.filter('button').
                    each(function () { this.disabled = true; }).end().
                    filter('img').css({ opacity: '0.5', cursor: 'default' });
            }
            else if (nodeName == 'div' || nodeName == 'span')
            {
                var inline = $target.children('.' + this._inlineClass);
                inline.children().addClass('ui-state-disabled');
                inline.find("select.ui-datepicker-month, select.ui-datepicker-year").
                    prop("disabled", true);
            }
            this._disabledInputs = $.map(this._disabledInputs,
                function (value) { return (value == target ? null : value); }); // delete entry
            this._disabledInputs[this._disabledInputs.length] = target;
        },

        /* Is the first field in a jQuery collection disabled as a datepicker?
           @param  target    element - the target input field or division or span
           @return boolean - true if disabled, false if enabled */
        _isDisabledDatepicker: function (target)
        {
            if (!target)
            {
                return false;
            }
            for (var i = 0; i < this._disabledInputs.length; i++)
            {
                if (this._disabledInputs[i] == target)
                    return true;
            }
            return false;
        },


        _getInst: function (target)
        {
            try
            {
                return $.data(target, PROP_NAME);
            }
            catch (err)
            {
                throw 'Missing instance data for this datepicker';
            }
        },

        _optionDatepicker: function (target, name, value)
        {
            var inst = this._getInst(target);
            if (arguments.length == 2 && typeof name == 'string')
            {
                return (name == 'defaults' ? $.extend({}, $.datepicker._defaults) :
                    (inst ? (name == 'all' ? $.extend({}, inst.settings) :
                        this._get(inst, name)) : null));
            }
            var settings = name || {};
            if (typeof name == 'string')
            {
                settings = {};
                settings[name] = value;
            }
            if (inst)
            {
                if (this._curInst == inst)
                {
                    this._hideDatepicker();
                }
                var date = this._getDateDatepicker(target, true);
                var minDate = this._getMinMaxDate(inst, 'min');
                var maxDate = this._getMinMaxDate(inst, 'max');
                extendRemove(inst.settings, settings);
                // reformat the old minDate/maxDate values if dateFormat changes and a new minDate/maxDate isn't provided
                if (minDate !== null && settings['dateFormat'] !== undefined && settings['minDate'] === undefined)
                    inst.settings.minDate = this._formatDate(inst, minDate);
                if (maxDate !== null && settings['dateFormat'] !== undefined && settings['maxDate'] === undefined)
                    inst.settings.maxDate = this._formatDate(inst, maxDate);
                this._attachments($(target), inst);
                this._autoSize(inst);
                this._setDate(inst, date);
                this._updateAlternate(inst);
                this._updateDatepicker(inst);
            }
        },

        // change method deprecated
        _changeDatepicker: function (target, name, value)
        {
            this._optionDatepicker(target, name, value);
        },

        /* Redraw the date picker attached to an input field or division.
           @param  target  element - the target input field or division or span */
        _refreshDatepicker: function (target)
        {
            var inst = this._getInst(target);
            if (inst)
            {
                this._updateDatepicker(inst);
            }
        },


        _setDateDatepicker: function (target, date)
        {
            var inst = this._getInst(target);
            if (inst)
            {
                this._setDate(inst, date);
                this._updateDatepicker(inst);
                this._updateAlternate(inst);
            }
        },


        _getDateDatepicker: function (target, noDefault)
        {
            var inst = this._getInst(target);
            if (inst && !inst.inline)
                this._setDateFromField(inst, noDefault);
            return (inst ? this._getDate(inst) : null);
        },

        /* Handle keystrokes. */
        _doKeyDown: function (event)
        {
            var inst = $.datepicker._getInst(event.target);
            var handled = true;
            var isRTL = inst.dpDiv.is('.ui-datepicker-rtl');
            inst._keyEvent = true;
            if ($.datepicker._datepickerShowing)
                switch (event.keyCode)
                {
                    case 9: $.datepicker._hideDatepicker();
                        handled = false;
                        break; // hide on tab out
                    case 13: var sel = $('td.' + $.datepicker._dayOverClass + ':not(.' +
                        $.datepicker._currentClass + ')', inst.dpDiv);
                        if (sel[0])
                            $.datepicker._selectDay(event.target, inst.selectedMonth, inst.selectedYear, sel[0]);
                        var onSelect = $.datepicker._get(inst, 'onSelect');
                        if (onSelect)
                        {
                            var dateStr = $.datepicker._formatDate(inst);

                            // trigger custom callback
                            onSelect.apply((inst.input ? inst.input[0] : null), [dateStr, inst]);
                        }
                        else
                            $.datepicker._hideDatepicker();
                        return false; // don't submit the form
                        break; // select the value on enter
                    case 27: $.datepicker._hideDatepicker();
                        break; // hide on escape
                    case 33: $.datepicker._adjustDate(event.target, (event.ctrlKey ?
                        -$.datepicker._get(inst, 'stepBigMonths') :
                        -$.datepicker._get(inst, 'stepMonths')), 'M');
                        break; // previous month/year on page up/+ ctrl
                    case 34: $.datepicker._adjustDate(event.target, (event.ctrlKey ?
                        +$.datepicker._get(inst, 'stepBigMonths') :
                        +$.datepicker._get(inst, 'stepMonths')), 'M');
                        break; // next month/year on page down/+ ctrl
                    case 35: if (event.ctrlKey || event.metaKey) $.datepicker._clearDate(event.target);
                        handled = event.ctrlKey || event.metaKey;
                        break; // clear on ctrl or command +end
                    case 36: if (event.ctrlKey || event.metaKey) $.datepicker._gotoToday(event.target);
                        handled = event.ctrlKey || event.metaKey;
                        break; // current on ctrl or command +home
                    case 37: if (event.ctrlKey || event.metaKey) $.datepicker._adjustDate(event.target, (isRTL ? +1 : -1), 'D');
                        handled = event.ctrlKey || event.metaKey;
                        // -1 day on ctrl or command +left
                        if (event.originalEvent.altKey) $.datepicker._adjustDate(event.target, (event.ctrlKey ?
                            -$.datepicker._get(inst, 'stepBigMonths') :
                            -$.datepicker._get(inst, 'stepMonths')), 'M');
                        // next month/year on alt +left on Mac
                        break;
                    case 38: if (event.ctrlKey || event.metaKey) $.datepicker._adjustDate(event.target, -7, 'D');
                        handled = event.ctrlKey || event.metaKey;
                        break; // -1 week on ctrl or command +up
                    case 39: if (event.ctrlKey || event.metaKey) $.datepicker._adjustDate(event.target, (isRTL ? -1 : +1), 'D');
                        handled = event.ctrlKey || event.metaKey;
                        // +1 day on ctrl or command +right
                        if (event.originalEvent.altKey) $.datepicker._adjustDate(event.target, (event.ctrlKey ?
                            +$.datepicker._get(inst, 'stepBigMonths') :
                            +$.datepicker._get(inst, 'stepMonths')), 'M');
                        // next month/year on alt +right
                        break;
                    case 40: if (event.ctrlKey || event.metaKey) $.datepicker._adjustDate(event.target, +7, 'D');
                        handled = event.ctrlKey || event.metaKey;
                        break; // +1 week on ctrl or command +down
                    default: handled = false;
                }
            else if (event.keyCode == 36 && event.ctrlKey) // display the date picker on ctrl+home
                $.datepicker._showDatepicker(this);
            else
            {
                handled = false;
            }
            if (handled)
            {
                event.preventDefault();
                event.stopPropagation();
            }
        },

        /* Filter entered characters - based on date format. */
        _doKeyPress: function (event)
        {
            var inst = $.datepicker._getInst(event.target);
            if ($.datepicker._get(inst, 'constrainInput'))
            {
                var chars = $.datepicker._possibleChars($.datepicker._get(inst, 'dateFormat'));
                var chr = String.fromCharCode(event.charCode == undefined ? event.keyCode : event.charCode);
                return event.ctrlKey || event.metaKey || (chr < ' ' || !chars || chars.indexOf(chr) > -1);
            }
        },

        /* Synchronise manual entry and field/alternate field. */
        _doKeyUp: function (event)
        {
            var inst = $.datepicker._getInst(event.target);
            if (inst.input.val() != inst.lastVal)
            {
                try
                {
                    var date = $.datepicker.parseDate($.datepicker._get(inst, 'dateFormat'),
                        (inst.input ? inst.input.val() : null),
                        $.datepicker._getFormatConfig(inst));
                    if (date)
                    { // only if valid
                        $.datepicker._setDateFromField(inst);
                        $.datepicker._updateAlternate(inst);
                        $.datepicker._updateDatepicker(inst);
                    }
                }
                catch (err)
                {
                    $.datepicker.log(err);
                }
            }
            return true;
        },

        _showDatepicker: function (input)
        {
            input = input.target || input;
            if ($(input).hasClass("disabled-show"))
            {
                return;
            }
            if (input.nodeName.toLowerCase() != 'input') // find from button/image trigger
                input = $('input', input.parentNode)[0];
            if ($.datepicker._isDisabledDatepicker(input) || $.datepicker._lastInput == input) // already here
                return;
            var inst = $.datepicker._getInst(input);
            if ($.datepicker._curInst && $.datepicker._curInst != inst)
            {
                $.datepicker._curInst.dpDiv.stop(true, true);
                if (inst && $.datepicker._datepickerShowing)
                {
                    $.datepicker._hideDatepicker($.datepicker._curInst.input[0]);
                }
            }
            var beforeShow = $.datepicker._get(inst, 'beforeShow');
            var beforeShowSettings = beforeShow ? beforeShow.apply(input, [input, inst]) : {};
            if (beforeShowSettings === false)
            {
                //false
                return;
            }
            extendRemove(inst.settings, beforeShowSettings);
            inst.lastVal = null;
            $.datepicker._lastInput = input;
            $.datepicker._setDateFromField(inst);
            if ($.datepicker._inDialog) // hide cursor
                input.value = '';
            if (!$.datepicker._pos)
            { // position below input
                $.datepicker._pos = $.datepicker._findPos(input);
                $.datepicker._pos[1] += input.offsetHeight; // add the height
            }
            var isFixed = false;
            $(input).parents().each(function ()
            {
                isFixed |= $(this).css('position') == 'fixed';
                return !isFixed;
            });
            var offset = { left: $.datepicker._pos[0], top: $.datepicker._pos[1] };
            $.datepicker._pos = null;
            //to avoid flashes on Firefox
            inst.dpDiv.empty();
            // determine sizing offscreen
            inst.dpDiv.css({ position: 'absolute', display: 'block', top: '-1000px' });
            $.datepicker._updateDatepicker(inst);
            // fix width for dynamic number of date pickers
            // and adjust position before showing
            offset = $.datepicker._checkOffset(inst, offset, isFixed);
            inst.dpDiv.css({
                position: ($.datepicker._inDialog && $.blockUI ?
                    'static' : (isFixed ? 'fixed' : 'absolute')), display: 'none',
                left: offset.left + 'px', top: offset.top + 'px'
            });
            if (!inst.inline)
            {
                var showAnim = $.datepicker._get(inst, 'showAnim');
                var duration = $.datepicker._get(inst, 'duration');
                var postProcess = function ()
                {
                    var cover = inst.dpDiv.find('iframe.ui-datepicker-cover'); // IE6- only
                    if (!!cover.length)
                    {
                        var borders = $.datepicker._getBorders(inst.dpDiv);
                        cover.css({
                            left: -borders[0], top: -borders[1],
                            width: inst.dpDiv.outerWidth(), height: inst.dpDiv.outerHeight()
                        });
                    }
                };
                // inst.dpDiv.zIndex($(input).zIndex() + 1);
                inst.dpDiv.zIndex(10);
                $.datepicker._datepickerShowing = true;

                // DEPRECATED: after BC for 1.8.x $.effects[ showAnim ] is not needed
                if ($.effects && ($.effects.effect[showAnim] || $.effects[showAnim]))
                    inst.dpDiv.show(showAnim, $.datepicker._get(inst, 'showOptions'), duration, postProcess);
                else
                    inst.dpDiv[showAnim || 'show']((showAnim ? duration : null), postProcess);
                if (!showAnim || !duration)
                    postProcess();
                if (inst.input.is(':visible') && !inst.input.is(':disabled'))
                    inst.input.focus();
                $.datepicker._curInst = inst;
            }
        },

        /* Generate the date picker content. */
        _updateDatepicker: function (inst)
        {
            this.maxRows = 4; //Reset the max number of rows being displayed (see #7043)
            var borders = $.datepicker._getBorders(inst.dpDiv);
            instActive = inst; // for delegate hover events
            inst.dpDiv.empty().append(this._generateHTML(inst));
            this._attachHandlers(inst);
            var cover = inst.dpDiv.find('iframe.ui-datepicker-cover'); // IE6- only
            if (!!cover.length)
            { //avoid call to outerXXXX() when not in IE6
                cover.css({ left: -borders[0], top: -borders[1], width: inst.dpDiv.outerWidth(), height: inst.dpDiv.outerHeight() })
            }
            inst.dpDiv.find('.' + this._dayOverClass + ' a').mouseover();
            var numMonths = this._getNumberOfMonths(inst);
            var cols = numMonths[1];
            var width = 17;
            inst.dpDiv.removeClass('ui-datepicker-multi-2 ui-datepicker-multi-3 ui-datepicker-multi-4').width('');
            if (cols > 1)
                inst.dpDiv.addClass('ui-datepicker-multi-' + cols).css('width', (width * cols) + 'em');
            inst.dpDiv[(numMonths[0] != 1 || numMonths[1] != 1 ? 'add' : 'remove') +
                'Class']('ui-datepicker-multi');
            inst.dpDiv[(this._get(inst, 'isRTL') ? 'add' : 'remove') +
                'Class']('ui-datepicker-rtl');
            if (inst == $.datepicker._curInst && $.datepicker._datepickerShowing && inst.input &&
                // #6694 - don't focus the input if it's already focused
                // this breaks the change event in IE
                inst.input.is(':visible') && !inst.input.is(':disabled') && inst.input[0] != document.activeElement)
                inst.input.focus();
            // deffered render of the years select (to avoid flashes on Firefox)
            if (inst.yearshtml)
            {
                var origyearshtml = inst.yearshtml;
                setTimeout(function ()
                {
                    //assure that inst.yearshtml didn't change.
                    if (origyearshtml === inst.yearshtml && inst.yearshtml)
                    {
                        inst.dpDiv.find('select.ui-datepicker-year:first').replaceWith(inst.yearshtml);
                    }
                    origyearshtml = inst.yearshtml = null;
                }, 0);
            }
        },

        _getBorders: function (elem)
        {
            var convert = function (value)
            {
                return { thin: 1, medium: 2, thick: 3 }[value] || value;
            };
            return [parseFloat(convert(elem.css('border-left-width'))),
            parseFloat(convert(elem.css('border-top-width')))];
        },

        /* Check positioning to remain on screen. */
        _checkOffset: function (inst, offset, isFixed)
        {
            var dpWidth = inst.dpDiv.outerWidth();
            var dpHeight = inst.dpDiv.outerHeight();
            var inputWidth = inst.input ? inst.input.outerWidth() : 0;
            var inputHeight = inst.input ? inst.input.outerHeight() : 0;
            var viewWidth = document.documentElement.clientWidth + (isFixed ? 0 : $(document).scrollLeft());
            var viewHeight = document.documentElement.clientHeight + (isFixed ? 0 : $(document).scrollTop());

            offset.left -= (this._get(inst, 'isRTL') ? (dpWidth - inputWidth) : 0);
            offset.left -= (isFixed && offset.left == inst.input.offset().left) ? $(document).scrollLeft() : 0;
            offset.top -= (isFixed && offset.top == (inst.input.offset().top + inputHeight)) ? $(document).scrollTop() : 0;

            // now check if datepicker is showing outside window viewport - move to a better place if so.
            offset.left -= Math.min(offset.left, (offset.left + dpWidth > viewWidth && viewWidth > dpWidth) ?
                Math.abs(offset.left + dpWidth - viewWidth) : 0);
            offset.top -= Math.min(offset.top, (offset.top + dpHeight > viewHeight && viewHeight > dpHeight) ?
                Math.abs(dpHeight + inputHeight) : 0);

            return offset;
        },

        /* Find an object's position on the screen. */
        _findPos: function (obj)
        {
            var inst = this._getInst(obj);
            var isRTL = this._get(inst, 'isRTL');
            while (obj && (obj.type == 'hidden' || obj.nodeType != 1 || $.expr.filters.hidden(obj)))
            {
                obj = obj[isRTL ? 'previousSibling' : 'nextSibling'];
            }
            var position = $(obj).offset();
            return [position.left, position.top];
        },

        /* Hide the date picker from view.
           @param  input  element - the input field attached to the date picker */
        _hideDatepicker: function (input)
        {
            var inst = this._curInst;


            if (!inst || (input && inst != $.data(input, PROP_NAME)))
                return;
            if (this._datepickerShowing)
            {
                var showAnim = this._get(inst, 'showAnim');
                var duration = this._get(inst, 'duration');
                var postProcess = function ()
                {
                    $.datepicker._tidyDialog(inst);
                };

                // DEPRECATED: after BC for 1.8.x $.effects[ showAnim ] is not needed
                if ($.effects && ($.effects.effect[showAnim] || $.effects[showAnim]))
                    inst.dpDiv.hide(showAnim, $.datepicker._get(inst, 'showOptions'), duration, postProcess);
                else
                    inst.dpDiv[(showAnim == 'slideDown' ? 'slideUp' :
                        (showAnim == 'fadeIn' ? 'fadeOut' : 'hide'))]((showAnim ? duration : null), postProcess);
                if (!showAnim)
                    postProcess();
                this._datepickerShowing = false;
                var onClose = this._get(inst, 'onClose');
                if (onClose)
                    onClose.apply((inst.input ? inst.input[0] : null),
                        [(inst.input ? inst.input.val() : ''), inst]);
                this._lastInput = null;
                if (this._inDialog)
                {
                    this._dialogInput.css({ position: 'absolute', left: '0', top: '-100px' });
                    if ($.blockUI)
                    {
                        $.unblockUI();
                        $('body').append(this.dpDiv);
                    }
                }
                this._inDialog = false;


                if (inst.input)
                {
                    if (!inst.input.prop("readonly") && !inst.input.prop("disabled"))
                    {
                        inst.input.addClass("disabled-show");
                        inst.input.focus();
                        setTimeout(function ()
                        {
                            inst.input.removeClass("disabled-show");
                        }, 100);

                    }
                }

            }
        },

        /* Tidy up after a dialog display. */
        _tidyDialog: function (inst)
        {
            inst.dpDiv.removeClass(this._dialogClass).unbind('.ui-datepicker-calendar');
        },

        /* Close date picker if clicked elsewhere. */
        _checkExternalClick: function (event)
        {
            if (!$.datepicker._curInst)
                return;

            var $target = $(event.target),
                inst = $.datepicker._getInst($target[0]);

            if ((($target[0].id != $.datepicker._mainDivId &&
                $target.parents('#' + $.datepicker._mainDivId).length == 0 &&
                !$target.hasClass($.datepicker.markerClassName) &&
                !$target.closest("." + $.datepicker._triggerClass).length &&
                $.datepicker._datepickerShowing && !($.datepicker._inDialog && $.blockUI))) ||
                ($target.hasClass($.datepicker.markerClassName) && $.datepicker._curInst != inst))
                $.datepicker._hideDatepicker();
        },

        /* Adjust one of the date sub-fields. */
        _adjustDate: function (id, offset, period)
        {
            var target = $(id);
            var inst = this._getInst(target[0]);
            if (this._isDisabledDatepicker(target[0]))
            {
                return;
            }
            this._adjustInstDate(inst, offset +
                (period == 'M' ? this._get(inst, 'showCurrentAtPos') : 0), // undo positioning
                period);
            this._updateDatepicker(inst);
        },

        /* Action for current link. */
        _gotoToday: function (id)
        {
            var target = $(id);
            var inst = this._getInst(target[0]);
            if (this._get(inst, 'gotoCurrent') && inst.currentDay)
            {
                inst.selectedDay = inst.currentDay;
                inst.drawMonth = inst.selectedMonth = inst.currentMonth;
                inst.drawYear = inst.selectedYear = inst.currentYear;
            }
            else
            {
                var date = new Date();
                inst.selectedDay = date.getDate();
                inst.drawMonth = inst.selectedMonth = date.getMonth();
                inst.drawYear = inst.selectedYear = date.getFullYear();
            }
            this._notifyChange(inst);
            this._adjustDate(target);
        },

        /* Action for selecting a new month/year. */
        _selectMonthYear: function (id, select, period)
        {
            var target = $(id);
            var inst = this._getInst(target[0]);
            inst['selected' + (period == 'M' ? 'Month' : 'Year')] =
                inst['draw' + (period == 'M' ? 'Month' : 'Year')] =
                parseInt(select.options[select.selectedIndex].value, 10);
            this._notifyChange(inst);
            this._adjustDate(target);
        },

        /* Action for selecting a day. */
        _selectDay: function (id, month, year, td)
        {
            var target = $(id);
            if ($(td).hasClass(this._unselectableClass) || this._isDisabledDatepicker(target[0]))
            {
                return;
            }
            var inst = this._getInst(target[0]);
            inst.selectedDay = inst.currentDay = $('a', td).html();
            inst.selectedMonth = inst.currentMonth = month;
            inst.selectedYear = inst.currentYear = year;
            this._selectDate(id, this._formatDate(inst,
                inst.currentDay, inst.currentMonth, inst.currentYear));
        },

        /* Erase the input field and hide the date picker. */
        _clearDate: function (id)
        {
            var target = $(id);
            var inst = this._getInst(target[0]);
            this._selectDate(target, '');
        },

        /* Update the input field with the selected date. */
        _selectDate: function (id, dateStr)
        {
            var target = $(id);
            var inst = this._getInst(target[0]);
            dateStr = (dateStr != null ? dateStr : this._formatDate(inst));
            if (inst.input)
                inst.input.val(dateStr);
            this._updateAlternate(inst);
            var onSelect = this._get(inst, 'onSelect');
            if (onSelect)
                onSelect.apply((inst.input ? inst.input[0] : null), [dateStr, inst]);  // trigger custom callback
            else if (inst.input)
                inst.input.trigger('change'); // fire the change event
            if (inst.inline)
                this._updateDatepicker(inst);
            else
            {
                this._hideDatepicker();
                this._lastInput = inst.input[0];
                if (typeof (inst.input[0]) != 'object')
                    inst.input.focus(); // restore focus
                this._lastInput = null;
            }
        },

        /* Update any alternate field to synchronise with the main field. */
        _updateAlternate: function (inst)
        {
            var altField = this._get(inst, 'altField');
            if (altField)
            { // update alternate field too
                var altFormat = this._get(inst, 'altFormat') || this._get(inst, 'dateFormat');
                var date = this._getDate(inst);
                var dateStr = this.formatDate(altFormat, date, this._getFormatConfig(inst));
                $(altField).each(function () { $(this).val(dateStr); });
            }
        },


        noWeekends: function (date)
        {
            var day = date.getDay();
            return [(day > 0 && day < 6), ''];
        },


        iso8601Week: function (date)
        {
            var checkDate = new Date(date.getTime());
            // Find Thursday of this week starting on Monday
            checkDate.setDate(checkDate.getDate() + 4 - (checkDate.getDay() || 7));
            var time = checkDate.getTime();
            checkDate.setMonth(0); // Compare with Jan 1
            checkDate.setDate(1);
            return Math.floor(Math.round((time - checkDate) / 86400000) / 7) + 1;
        },

        parseDate: function (format, value, settings)
        {
            if (format == null || value == null)
                throw 'Invalid arguments';
            value = (typeof value == 'object' ? value.toString() : value + '');
            if (value == '')
                return null;
            var shortYearCutoff = (settings ? settings.shortYearCutoff : null) || this._defaults.shortYearCutoff;
            shortYearCutoff = (typeof shortYearCutoff != 'string' ? shortYearCutoff :
                new Date().getFullYear() % 100 + parseInt(shortYearCutoff, 10));
            var dayNamesShort = (settings ? settings.dayNamesShort : null) || this._defaults.dayNamesShort;
            var dayNames = (settings ? settings.dayNames : null) || this._defaults.dayNames;
            var monthNamesShort = (settings ? settings.monthNamesShort : null) || this._defaults.monthNamesShort;
            var monthNames = (settings ? settings.monthNames : null) || this._defaults.monthNames;
            var year = -1;
            var month = -1;
            var day = -1;
            var doy = -1;
            var literal = false;
            // Check whether a format character is doubled
            var lookAhead = function (match)
            {
                var matches = (iFormat + 1 < format.length && format.charAt(iFormat + 1) == match);
                if (matches)
                    iFormat++;
                return matches;
            };
            // Extract a number from the string value
            var getNumber = function (match)
            {
                var isDoubled = lookAhead(match);
                var size = (match == '@' ? 14 : (match == '!' ? 20 :
                    (match == 'y' && isDoubled ? 4 : (match == 'o' ? 3 : 2))));
                var digits = new RegExp('^\\d{1,' + size + '}');
                var num = value.substring(iValue).match(digits);
                if (!num)
                    throw 'Missing number at position ' + iValue;
                iValue += num[0].length;
                return parseInt(num[0], 10);
            };
            // Extract a name from the string value and convert to an index
            var getName = function (match, shortNames, longNames)
            {
                var names = $.map(lookAhead(match) ? longNames : shortNames, function (v, k)
                {
                    return [[k, v]];
                }).sort(function (a, b)
                {
                    return -(a[1].length - b[1].length);
                });
                var index = -1;
                $.each(names, function (i, pair)
                {
                    var name = pair[1];
                    if (value.substr(iValue, name.length).toLowerCase() == name.toLowerCase())
                    {
                        index = pair[0];
                        iValue += name.length;
                        return false;
                    }
                });
                if (index != -1)
                    return index + 1;
                else
                    throw 'Unknown name at position ' + iValue;
            };
            // Confirm that a literal character matches the string value
            var checkLiteral = function ()
            {
                if (value.charAt(iValue) != format.charAt(iFormat))
                    throw 'Unexpected literal at position ' + iValue;
                iValue++;
            };
            var iValue = 0;
            for (var iFormat = 0; iFormat < format.length; iFormat++)
            {
                if (literal)
                    if (format.charAt(iFormat) == "'" && !lookAhead("'"))
                        literal = false;
                    else
                        checkLiteral();
                else
                    switch (format.charAt(iFormat))
                    {
                        case 'd':
                            day = getNumber('d');
                            break;
                        case 'D':
                            getName('D', dayNamesShort, dayNames);
                            break;
                        case 'o':
                            doy = getNumber('o');
                            break;
                        case 'm':
                            month = getNumber('m');
                            break;
                        case 'M':
                            month = getName('M', monthNamesShort, monthNames);
                            break;
                        case 'y':
                            year = getNumber('y');
                            break;
                        case '@':
                            var date = new Date(getNumber('@'));
                            year = date.getFullYear();
                            month = date.getMonth() + 1;
                            day = date.getDate();
                            break;
                        case '!':
                            var date = new Date((getNumber('!') - this._ticksTo1970) / 10000);
                            year = date.getFullYear();
                            month = date.getMonth() + 1;
                            day = date.getDate();
                            break;
                        case "'":
                            if (lookAhead("'"))
                                checkLiteral();
                            else
                                literal = true;
                            break;
                        default:
                            checkLiteral();
                    }
            }
            if (iValue < value.length)
            {
                var extra = value.substr(iValue);
                if (!/^\s+/.test(extra))
                {
                    throw "Extra/unparsed characters found in date: " + extra;
                }
            }
            if (year == -1)
                year = new Date().getFullYear();
            else if (year < 100)
                year += new Date().getFullYear() - new Date().getFullYear() % 100 +
                    (year <= shortYearCutoff ? 0 : -100);
            if (doy > -1)
            {
                month = 1;
                day = doy;
                do
                {
                    var dim = this._getDaysInMonth(year, month - 1);
                    if (day <= dim)
                        break;
                    month++;
                    day -= dim;
                } while (true);
            }
            var date = this._daylightSavingAdjust(new Date(year, month - 1, day));
            if (date.getFullYear() != year || date.getMonth() + 1 != month || date.getDate() != day)
                throw 'Invalid date'; // E.g. 31/02/00
            return date;
        },

        /* Standard date formats. */
        ATOM: 'yy-mm-dd', // RFC 3339 (ISO 8601)
        COOKIE: 'D, dd M yy',
        ISO_8601: 'yy-mm-dd',
        RFC_822: 'D, d M y',
        RFC_850: 'DD, dd-M-y',
        RFC_1036: 'D, d M y',
        RFC_1123: 'D, d M yy',
        RFC_2822: 'D, d M yy',
        RSS: 'D, d M y', // RFC 822
        TICKS: '!',
        TIMESTAMP: '@',
        W3C: 'yy-mm-dd', // ISO 8601

        _ticksTo1970: (((1970 - 1) * 365 + Math.floor(1970 / 4) - Math.floor(1970 / 100) +
            Math.floor(1970 / 400)) * 24 * 60 * 60 * 10000000),


        formatDate: function (format, date, settings)
        {
            if (!date)
                return '';
            var dayNamesShort = (settings ? settings.dayNamesShort : null) || this._defaults.dayNamesShort;
            var dayNames = (settings ? settings.dayNames : null) || this._defaults.dayNames;
            var monthNamesShort = (settings ? settings.monthNamesShort : null) || this._defaults.monthNamesShort;
            var monthNames = (settings ? settings.monthNames : null) || this._defaults.monthNames;
            // Check whether a format character is doubled
            var lookAhead = function (match)
            {
                var matches = (iFormat + 1 < format.length && format.charAt(iFormat + 1) == match);
                if (matches)
                    iFormat++;
                return matches;
            };
            // Format a number, with leading zero if necessary
            var formatNumber = function (match, value, len)
            {
                var num = '' + value;
                if (lookAhead(match))
                    while (num.length < len)
                        num = '0' + num;
                return num;
            };
            // Format a name, short or long as requested
            var formatName = function (match, value, shortNames, longNames)
            {
                return (lookAhead(match) ? longNames[value] : shortNames[value]);
            };
            var output = '';
            var literal = false;
            if (date)
                for (var iFormat = 0; iFormat < format.length; iFormat++)
                {
                    if (literal)
                        if (format.charAt(iFormat) == "'" && !lookAhead("'"))
                            literal = false;
                        else
                            output += format.charAt(iFormat);
                    else
                        switch (format.charAt(iFormat))
                        {
                            case 'd':
                                output += formatNumber('d', date.getDate(), 2);
                                break;
                            case 'D':
                                output += formatName('D', date.getDay(), dayNamesShort, dayNames);
                                break;
                            case 'o':
                                output += formatNumber('o',
                                    Math.round((new Date(date.getFullYear(), date.getMonth(), date.getDate()).getTime() - new Date(date.getFullYear(), 0, 0).getTime()) / 86400000), 3);
                                break;
                            case 'm':
                                output += formatNumber('m', date.getMonth() + 1, 2);
                                break;
                            case 'M':
                                output += formatName('M', date.getMonth(), monthNamesShort, monthNames);
                                break;
                            case 'y':
                                output += (lookAhead('y') ? date.getFullYear() :
                                    (date.getYear() % 100 < 10 ? '0' : '') + date.getYear() % 100);
                                break;
                            case '@':
                                output += date.getTime();
                                break;
                            case '!':
                                output += date.getTime() * 10000 + this._ticksTo1970;
                                break;
                            case "'":
                                if (lookAhead("'"))
                                    output += "'";
                                else
                                    literal = true;
                                break;
                            default:
                                output += format.charAt(iFormat);
                        }
                }
            return output;
        },

        /* Extract all possible characters from the date format. */
        _possibleChars: function (format)
        {
            var chars = '';
            var literal = false;
            // Check whether a format character is doubled
            var lookAhead = function (match)
            {
                var matches = (iFormat + 1 < format.length && format.charAt(iFormat + 1) == match);
                if (matches)
                    iFormat++;
                return matches;
            };
            for (var iFormat = 0; iFormat < format.length; iFormat++)
                if (literal)
                    if (format.charAt(iFormat) == "'" && !lookAhead("'"))
                        literal = false;
                    else
                        chars += format.charAt(iFormat);
                else
                    switch (format.charAt(iFormat))
                    {
                        case 'd': case 'm': case 'y': case '@':
                            chars += '0123456789 :';
                            break;
                        case 'D': case 'M':
                            return null; // Accept anything
                        case "'":
                            if (lookAhead("'"))
                                chars += "'";
                            else
                                literal = true;
                            break;
                        default:
                            chars += format.charAt(iFormat);
                    }
            return chars;
        },

        /* Get a setting value, defaulting if necessary. */
        _get: function (inst, name)
        {
            return inst.settings[name] !== undefined ?
                inst.settings[name] : this._defaults[name];
        },

        /* Parse existing date and initialise date picker. */
        _setDateFromField: function (inst, noDefault)
        {
            if (inst.input.val() == inst.lastVal)
            {
                return;
            }
            var dateFormat = this._get(inst, 'dateFormat');
            var dates = inst.lastVal = inst.input ? inst.input.val() : null;
            var date, defaultDate;
            date = defaultDate = this._getDefaultDate(inst);
            var settings = this._getFormatConfig(inst);
            try
            {
                date = this.parseDate(dateFormat, dates, settings) || defaultDate;
            } catch (event)
            {
                this.log(event);
                dates = (noDefault ? '' : dates);
            }
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            inst.currentDay = (dates ? date.getDate() : 0);
            inst.currentMonth = (dates ? date.getMonth() : 0);
            inst.currentYear = (dates ? date.getFullYear() : 0);
            this._adjustInstDate(inst);
        },

        /* Retrieve the default date shown on opening. */
        _getDefaultDate: function (inst)
        {
            return this._restrictMinMax(inst,
                this._determineDate(inst, this._get(inst, 'defaultDate'), new Date()));
        },

        /* A date may be specified as an exact value or a relative one. */
        _determineDate: function (inst, date, defaultDate)
        {
            var offsetNumeric = function (offset)
            {
                var date = new Date();
                date.setDate(date.getDate() + offset);
                return date;
            };
            var offsetString = function (offset)
            {
                try
                {
                    return $.datepicker.parseDate($.datepicker._get(inst, 'dateFormat'),
                        offset, $.datepicker._getFormatConfig(inst));
                }
                catch (e)
                {
                    // Ignore
                }
                var date = (offset.toLowerCase().match(/^c/) ?
                    $.datepicker._getDate(inst) : null) || new Date();
                var year = date.getFullYear();
                var month = date.getMonth();
                var day = date.getDate();
                var pattern = /([+-]?[0-9]+)\s*(d|D|w|W|m|M|y|Y)?/g;
                var matches = pattern.exec(offset);
                while (matches)
                {
                    switch (matches[2] || 'd')
                    {
                        case 'd': case 'D':
                            day += parseInt(matches[1], 10); break;
                        case 'w': case 'W':
                            day += parseInt(matches[1], 10) * 7; break;
                        case 'm': case 'M':
                            month += parseInt(matches[1], 10);
                            day = Math.min(day, $.datepicker._getDaysInMonth(year, month));
                            break;
                        case 'y': case 'Y':
                            year += parseInt(matches[1], 10);
                            day = Math.min(day, $.datepicker._getDaysInMonth(year, month));
                            break;
                    }
                    matches = pattern.exec(offset);
                }
                return new Date(year, month, day);
            };
            var newDate = (date == null || date === '' ? defaultDate : (typeof date == 'string' ? offsetString(date) :
                (typeof date == 'number' ? (isNaN(date) ? defaultDate : offsetNumeric(date)) : new Date(date.getTime()))));
            newDate = (newDate && newDate.toString() == 'Invalid Date' ? defaultDate : newDate);
            if (newDate)
            {
                newDate.setHours(0);
                newDate.setMinutes(0);
                newDate.setSeconds(0);
                newDate.setMilliseconds(0);
            }
            return this._daylightSavingAdjust(newDate);
        },

        _daylightSavingAdjust: function (date)
        {
            if (!date) return null;
            date.setHours(date.getHours() > 12 ? date.getHours() + 2 : 0);
            return date;
        },

        /* Set the date(s) directly. */
        _setDate: function (inst, date, noChange)
        {
            var clear = !date;
            var origMonth = inst.selectedMonth;
            var origYear = inst.selectedYear;
            var newDate = this._restrictMinMax(inst, this._determineDate(inst, date, new Date()));
            inst.selectedDay = inst.currentDay = newDate.getDate();
            inst.drawMonth = inst.selectedMonth = inst.currentMonth = newDate.getMonth();
            inst.drawYear = inst.selectedYear = inst.currentYear = newDate.getFullYear();
            if ((origMonth != inst.selectedMonth || origYear != inst.selectedYear) && !noChange)
                this._notifyChange(inst);
            this._adjustInstDate(inst);
            if (inst.input)
            {
                inst.input.val(clear ? '' : this._formatDate(inst));
            }
        },

        /* Retrieve the date(s) directly. */
        _getDate: function (inst)
        {
            var startDate = (!inst.currentYear || (inst.input && inst.input.val() == '') ? null :
                this._daylightSavingAdjust(new Date(
                    inst.currentYear, inst.currentMonth, inst.currentDay)));
            return startDate;
        },

        /* Attach the onxxx handlers.  These are declared statically so
         * they work with static code transformers like Caja.
         */
        _attachHandlers: function (inst)
        {
            var stepMonths = this._get(inst, 'stepMonths');
            var id = '#' + inst.id.replace(/\\\\/g, "\\");
            inst.dpDiv.find('[data-handler]').map(function ()
            {
                var handler = {
                    prev: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._adjustDate(id, -stepMonths, 'M');
                    },
                    next: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._adjustDate(id, +stepMonths, 'M');
                    },
                    hide: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._hideDatepicker();
                    },
                    today: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._gotoToday(id);
                    },
                    selectDay: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._selectDay(id, +this.getAttribute('data-month'), +this.getAttribute('data-year'), this);
                        return false;
                    },
                    selectMonth: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._selectMonthYear(id, this, 'M');
                        return false;
                    },
                    selectYear: function ()
                    {
                        window['DP_jQuery_' + dpuuid].datepicker._selectMonthYear(id, this, 'Y');
                        return false;
                    }
                };
                $(this).bind(this.getAttribute('data-event'), handler[this.getAttribute('data-handler')]);
            });
        },

        /* Generate the HTML for the current state of the date picker. */
        _generateHTML: function (inst)
        {
            var today = new Date();
            today = this._daylightSavingAdjust(
                new Date(today.getFullYear(), today.getMonth(), today.getDate())); // clear time
            var isRTL = this._get(inst, 'isRTL');
            var showButtonPanel = this._get(inst, 'showButtonPanel');
            var hideIfNoPrevNext = this._get(inst, 'hideIfNoPrevNext');
            var navigationAsDateFormat = this._get(inst, 'navigationAsDateFormat');
            var numMonths = this._getNumberOfMonths(inst);
            var showCurrentAtPos = this._get(inst, 'showCurrentAtPos');
            var stepMonths = this._get(inst, 'stepMonths');
            var isMultiMonth = (numMonths[0] != 1 || numMonths[1] != 1);
            var currentDate = this._daylightSavingAdjust((!inst.currentDay ? new Date(9999, 9, 9) :
                new Date(inst.currentYear, inst.currentMonth, inst.currentDay)));
            var minDate = this._getMinMaxDate(inst, 'min');
            var maxDate = this._getMinMaxDate(inst, 'max');
            var drawMonth = inst.drawMonth - showCurrentAtPos;
            var drawYear = inst.drawYear;
            if (drawMonth < 0)
            {
                drawMonth += 12;
                drawYear--;
            }
            if (maxDate)
            {
                var maxDraw = this._daylightSavingAdjust(new Date(maxDate.getFullYear(),
                    maxDate.getMonth() - (numMonths[0] * numMonths[1]) + 1, maxDate.getDate()));
                maxDraw = (minDate && maxDraw < minDate ? minDate : maxDraw);
                while (this._daylightSavingAdjust(new Date(drawYear, drawMonth, 1)) > maxDraw)
                {
                    drawMonth--;
                    if (drawMonth < 0)
                    {
                        drawMonth = 11;
                        drawYear--;
                    }
                }
            }
            inst.drawMonth = drawMonth;
            inst.drawYear = drawYear;
            var prevText = this._get(inst, 'prevText');
            prevText = (!navigationAsDateFormat ? prevText : this.formatDate(prevText,
                this._daylightSavingAdjust(new Date(drawYear, drawMonth - stepMonths, 1)),
                this._getFormatConfig(inst)));
            prevText = "";

            var prev = (this._canAdjustMonth(inst, -1, drawYear, drawMonth) ?
                '<a class="ui-datepicker-prev ui-corner-all" data-handler="prev" data-event="click"' +
                ' title="' + "上一月" + '"><span class="ui-icon ui-pre ui-icon-circle-triangle-' + (isRTL ? 'e' : 'w') + '">' + prevText + '</span></a>' :
                (hideIfNoPrevNext ? '' : '<a class="ui-datepicker-prev ui-corner-all ui-state-disabled" title="' + "上一月" + '"><span class="ui-icon ui-pre ui-icon-circle-triangle-' + (isRTL ? 'e' : 'w') + '">' + prevText + '</span></a>'));
            var nextText = this._get(inst, 'nextText');
            nextText = (!navigationAsDateFormat ? nextText : this.formatDate(nextText,
                this._daylightSavingAdjust(new Date(drawYear, drawMonth + stepMonths, 1)),
                this._getFormatConfig(inst)));

            nextText = "";
            var next = (this._canAdjustMonth(inst, +1, drawYear, drawMonth) ?
                '<a class="ui-datepicker-next ui-corner-all" data-handler="next" data-event="click"' +
                ' title="' + "下一月" + '"><span class="ui-icon ui-next ui-icon-circle-triangle-' + (isRTL ? 'w' : 'e') + '">' + nextText + '</span></a>' :
                (hideIfNoPrevNext ? '' : '<a class="ui-datepicker-next ui-corner-all ui-state-disabled" title="' + "下一月" + '"><span class="ui-icon ui-next ui-icon-circle-triangle-' + (isRTL ? 'w' : 'e') + '">' + nextText + '</span></a>'));
            var currentText = this._get(inst, 'currentText');
            var gotoDate = (this._get(inst, 'gotoCurrent') && inst.currentDay ? currentDate : today);
            currentText = (!navigationAsDateFormat ? currentText :
                this.formatDate(currentText, gotoDate, this._getFormatConfig(inst)));
            var controls = (!inst.inline ? '<button type="button" class="ui-datepicker-close ui-state-default ui-priority-primary ui-corner-all" data-handler="hide" data-event="click">' +
                this._get(inst, 'closeText') + '</button>' : '');
            var buttonPanel = (showButtonPanel) ? '<div class="ui-datepicker-buttonpane ui-widget-content">' + (isRTL ? controls : '') +
                (this._isInRange(inst, gotoDate) ? '<button type="button" class="ui-datepicker-current ui-state-default ui-priority-secondary ui-corner-all" data-handler="today" data-event="click"' +
                    '>' + currentText + '</button>' : '') + (isRTL ? '' : controls) + '</div>' : '';
            var firstDay = parseInt(this._get(inst, 'firstDay'), 10);
            firstDay = (isNaN(firstDay) ? 0 : firstDay);
            var showWeek = this._get(inst, 'showWeek');
            var dayNames = this._get(inst, 'dayNames');
            var dayNamesShort = this._get(inst, 'dayNamesShort');
            var dayNamesMin = this._get(inst, 'dayNamesMin');
            var monthNames = this._get(inst, 'monthNames');
            var monthNamesShort = this._get(inst, 'monthNamesShort');
            var beforeShowDay = this._get(inst, 'beforeShowDay');
            var showOtherMonths = this._get(inst, 'showOtherMonths');
            var selectOtherMonths = this._get(inst, 'selectOtherMonths');
            var calculateWeek = this._get(inst, 'calculateWeek') || this.iso8601Week;
            var defaultDate = this._getDefaultDate(inst);
            var html = '';
            for (var row = 0; row < numMonths[0]; row++)
            {
                var group = '';
                this.maxRows = 4;
                for (var col = 0; col < numMonths[1]; col++)
                {
                    var selectedDate = this._daylightSavingAdjust(new Date(drawYear, drawMonth, inst.selectedDay));
                    var cornerClass = ' ui-corner-all';
                    var calender = '';
                    if (isMultiMonth)
                    {
                        calender += '<div class="ui-datepicker-group';
                        if (numMonths[1] > 1)
                            switch (col)
                            {
                                case 0: calender += ' ui-datepicker-group-first';
                                    cornerClass = ' ui-corner-' + (isRTL ? 'right' : 'left'); break;
                                case numMonths[1] - 1: calender += ' ui-datepicker-group-last';
                                    cornerClass = ' ui-corner-' + (isRTL ? 'left' : 'right'); break;
                                default: calender += ' ui-datepicker-group-middle'; cornerClass = ''; break;
                            }
                        calender += '">';
                    }
                    calender += '<div class="ui-datepicker-header ui-widget-header ui-helper-clearfix' + cornerClass + '">' +
                        (/all|left/.test(cornerClass) && row == 0 ? (isRTL ? next : prev) : '') +
                        (/all|right/.test(cornerClass) && row == 0 ? (isRTL ? prev : next) : '') +
                        this._generateMonthYearHeader(inst, drawMonth, drawYear, minDate, maxDate,
                            row > 0 || col > 0, monthNames, monthNamesShort) + // draw month headers
                        '</div><table class="ui-datepicker-calendar"><thead>' +
                        '<tr>';
                    var thead = (showWeek ? '<th class="ui-datepicker-week-col">' + this._get(inst, 'weekHeader') + '</th>' : '');
                    for (var dow = 0; dow < 7; dow++)
                    { // days of the week
                        var day = (dow + firstDay) % 7;
                        thead += '<th' + ((dow + firstDay + 6) % 7 >= 5 ? ' class="ui-datepicker-week-end"' : '') + '>' +
                            '<span title="' + dayNames[day] + '">' + dayNamesMin[day] + '</span></th>';
                    }
                    calender += thead + '</tr></thead><tbody>';
                    var daysInMonth = this._getDaysInMonth(drawYear, drawMonth);
                    if (drawYear == inst.selectedYear && drawMonth == inst.selectedMonth)
                        inst.selectedDay = Math.min(inst.selectedDay, daysInMonth);
                    var leadDays = (this._getFirstDayOfMonth(drawYear, drawMonth) - firstDay + 7) % 7;
                    var curRows = Math.ceil((leadDays + daysInMonth) / 7); // calculate the number of rows to generate
                    var numRows = (isMultiMonth ? this.maxRows > curRows ? this.maxRows : curRows : curRows); //If multiple months, use the higher number of rows (see #7043)
                    this.maxRows = numRows;
                    var printDate = this._daylightSavingAdjust(new Date(drawYear, drawMonth, 1 - leadDays));
                    for (var dRow = 0; dRow < numRows; dRow++)
                    { // create date picker rows
                        calender += '<tr>';
                        var tbody = (!showWeek ? '' : '<td class="ui-datepicker-week-col">' +
                            this._get(inst, 'calculateWeek')(printDate) + '</td>');
                        for (var dow = 0; dow < 7; dow++)
                        { // create date picker days
                            var daySettings = (beforeShowDay ?
                                beforeShowDay.apply((inst.input ? inst.input[0] : null), [printDate]) : [true, '']);
                            var otherMonth = (printDate.getMonth() != drawMonth);
                            var unselectable = (otherMonth && !selectOtherMonths) || !daySettings[0] ||
                                (minDate && printDate < minDate) || (maxDate && printDate > maxDate);
                            tbody += '<td class="' +
                                ((dow + firstDay + 6) % 7 >= 5 ? ' ui-datepicker-week-end' : '') + // highlight weekends
                                (otherMonth ? ' ui-datepicker-other-month' : '') + // highlight days from other months
                                ((printDate.getTime() == selectedDate.getTime() && drawMonth == inst.selectedMonth && inst._keyEvent) || // user pressed key
                                    (defaultDate.getTime() == printDate.getTime() && defaultDate.getTime() == selectedDate.getTime()) ?
                                    // or defaultDate is current printedDate and defaultDate is selectedDate
                                    ' ' + this._dayOverClass : '') + // highlight selected day
                                (unselectable ? ' ' + this._unselectableClass + ' ui-state-disabled' : '') +  // highlight unselectable days
                                (otherMonth && !showOtherMonths ? '' : ' ' + daySettings[1] + // highlight custom dates
                                    (printDate.getTime() == currentDate.getTime() ? ' ' + this._currentClass : '') + // highlight selected day
                                    (printDate.getTime() == today.getTime() ? ' ui-datepicker-today' : '')) + '"' + // highlight today (if different)
                                ((!otherMonth || showOtherMonths) && daySettings[2] ? ' title="' + daySettings[2] + '"' : '') + // cell title
                                (unselectable ? '' : ' data-handler="selectDay" data-event="click" data-month="' + printDate.getMonth() + '" data-year="' + printDate.getFullYear() + '"') + '>' + // actions
                                (otherMonth && !showOtherMonths ? '&#xa0;' : // display for other months
                                    (unselectable ? '<span class="ui-state-default">' + printDate.getDate() + '</span>' : '<a class="ui-state-default' +
                                        ((dow + firstDay + 6) % 7 >= 5 ? ' ui-datepicker-week-end' : '') +
                                        (printDate.getTime() == today.getTime() ? ' ui-state-highlight' : '') +
                                        (printDate.getTime() == currentDate.getTime() ? ' ui-state-active' : '') + // highlight selected day
                                        (otherMonth ? ' ui-priority-secondary' : '') + // distinguish dates from other months
                                        '" href="#">' + printDate.getDate() + '</a>')) + '</td>'; // display selectable date
                            printDate.setDate(printDate.getDate() + 1);
                            printDate = this._daylightSavingAdjust(printDate);
                        }
                        calender += tbody + '</tr>';
                    }
                    drawMonth++;
                    if (drawMonth > 11)
                    {
                        drawMonth = 0;
                        drawYear++;
                    }

                    var showTime = this._get(inst, "showTime");
                    var varDate = this._get(inst, "varDate");

                    if (showTime && false) //未实现
                    {
                        calender += '<tr><td colspan="7" style="text-align:right;">';
                        calender += '<input type="text" maxlength="2" placeholder="时" title="请先输入时分秒，然后选择具体的日期确定" class="ui-datepicker-input"/>:';
                        calender += '<input type="text" maxlength="2" placeholder="分" title="请先输入时分秒，然后选择具体的日期确定" class="ui-datepicker-input"/>:';
                        calender += '<input type="text" maxlength="2" placeholder="秒" title="请先输入时分秒，然后选择具体的日期确定" class="ui-datepicker-input"/>';
                        calender += '</td></tr>';
                    }

                    calender += '</tbody></table>' + (isMultiMonth ? '</div>' +
                        ((numMonths[0] > 0 && col == numMonths[1] - 1) ? '<div class="ui-datepicker-row-break"></div>' : '') : '');
                    group += calender;
                }
                html += group;
            }
            html += buttonPanel + ($.ui.ie6 && !inst.inline ?
                '<iframe src="javascript:false;" class="ui-datepicker-cover" frameborder="0"></iframe>' : '');
            inst._keyEvent = false;
            return html;
        },

        /* Generate the month and year header. */
        _generateMonthYearHeader: function (inst, drawMonth, drawYear, minDate, maxDate,
            secondary, monthNames, monthNamesShort)
        {
            var changeMonth = this._get(inst, 'changeMonth');
            var changeYear = this._get(inst, 'changeYear');
            var showMonthAfterYear = this._get(inst, 'showMonthAfterYear');
            var html = '<div class="ui-datepicker-title">';
            var monthHtml = '';
            // month selection
            if (secondary || !changeMonth)
                monthHtml += '<span class="ui-datepicker-month">' + monthNames[drawMonth] + '</span>';
            else
            {
                var inMinYear = (minDate && minDate.getFullYear() == drawYear);
                var inMaxYear = (maxDate && maxDate.getFullYear() == drawYear);
                monthHtml += '<select class="ui-datepicker-month" data-handler="selectMonth" data-event="change">';
                for (var month = 0; month < 12; month++)
                {
                    if ((!inMinYear || month >= minDate.getMonth()) &&
                        (!inMaxYear || month <= maxDate.getMonth()))
                        monthHtml += '<option value="' + month + '"' +
                            (month == drawMonth ? ' selected="selected"' : '') +
                            '>' + monthNamesShort[month] + '</option>';
                }
                monthHtml += '</select>';
            }
            if (!showMonthAfterYear)
                html += monthHtml + (secondary || !(changeMonth && changeYear) ? '&#xa0;' : '');
            // year selection
            if (!inst.yearshtml)
            {
                inst.yearshtml = '';
                if (secondary || !changeYear)
                    html += '<span class="ui-datepicker-year">' + drawYear + '</span>';
                else
                {
                    // determine range of years to display
                    var years = this._get(inst, 'yearRange').split(':');
                    var thisYear = new Date().getFullYear();
                    var determineYear = function (value)
                    {
                        var year = (value.match(/c[+-].*/) ? drawYear + parseInt(value.substring(1), 10) :
                            (value.match(/[+-].*/) ? thisYear + parseInt(value, 10) :
                                parseInt(value, 10)));
                        return (isNaN(year) ? thisYear : year);
                    };
                    var year = determineYear(years[0]);
                    var endYear = Math.max(year, determineYear(years[1] || ''));
                    year = (minDate ? Math.max(year, minDate.getFullYear()) : year);
                    endYear = (maxDate ? Math.min(endYear, maxDate.getFullYear()) : endYear);
                    inst.yearshtml += '<select class="ui-datepicker-year" data-handler="selectYear" data-event="change">';
                    for (; year <= endYear; year++)
                    {
                        inst.yearshtml += '<option value="' + year + '"' +
                            (year == drawYear ? ' selected="selected"' : '') +
                            '>' + year + '</option>';
                    }
                    inst.yearshtml += '</select>';

                    html += inst.yearshtml;
                    inst.yearshtml = null;
                }
            }
            html += this._get(inst, 'yearSuffix');
            if (showMonthAfterYear)
                html += (secondary || !(changeMonth && changeYear) ? '&#xa0;' : '') + monthHtml;
            html += '</div>'; // Close datepicker_header
            return html;
        },

        /* Adjust one of the date sub-fields. */
        _adjustInstDate: function (inst, offset, period)
        {
            var year = inst.drawYear + (period == 'Y' ? offset : 0);
            var month = inst.drawMonth + (period == 'M' ? offset : 0);
            var day = Math.min(inst.selectedDay, this._getDaysInMonth(year, month)) +
                (period == 'D' ? offset : 0);
            var date = this._restrictMinMax(inst,
                this._daylightSavingAdjust(new Date(year, month, day)));
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            if (period == 'M' || period == 'Y')
                this._notifyChange(inst);
        },

        /* Ensure a date is within any min/max bounds. */
        _restrictMinMax: function (inst, date)
        {
            var minDate = this._getMinMaxDate(inst, 'min');
            var maxDate = this._getMinMaxDate(inst, 'max');
            var newDate = (minDate && date < minDate ? minDate : date);
            newDate = (maxDate && newDate > maxDate ? maxDate : newDate);
            return newDate;
        },

        /* Notify change of month/year. */
        _notifyChange: function (inst)
        {
            var onChange = this._get(inst, 'onChangeMonthYear');
            if (onChange)
                onChange.apply((inst.input ? inst.input[0] : null),
                    [inst.selectedYear, inst.selectedMonth + 1, inst]);
        },

        /* Determine the number of months to show. */
        _getNumberOfMonths: function (inst)
        {
            var numMonths = this._get(inst, 'numberOfMonths');
            return (numMonths == null ? [1, 1] : (typeof numMonths == 'number' ? [1, numMonths] : numMonths));
        },

        /* Determine the current maximum date - ensure no time components are set. */
        _getMinMaxDate: function (inst, minMax)
        {
            return this._determineDate(inst, this._get(inst, minMax + 'Date'), null);
        },

        /* Find the number of days in a given month. */
        _getDaysInMonth: function (year, month)
        {
            return 32 - this._daylightSavingAdjust(new Date(year, month, 32)).getDate();
        },

        /* Find the day of the week of the first of a month. */
        _getFirstDayOfMonth: function (year, month)
        {
            return new Date(year, month, 1).getDay();
        },

        /* Determines if we should allow a "next/prev" month display change. */
        _canAdjustMonth: function (inst, offset, curYear, curMonth)
        {
            var numMonths = this._getNumberOfMonths(inst);
            var date = this._daylightSavingAdjust(new Date(curYear,
                curMonth + (offset < 0 ? offset : numMonths[0] * numMonths[1]), 1));
            if (offset < 0)
                date.setDate(this._getDaysInMonth(date.getFullYear(), date.getMonth()));
            return this._isInRange(inst, date);
        },

        /* Is the given date in the accepted range? */
        _isInRange: function (inst, date)
        {
            var minDate = this._getMinMaxDate(inst, 'min');
            var maxDate = this._getMinMaxDate(inst, 'max');
            return ((!minDate || date.getTime() >= minDate.getTime()) &&
                (!maxDate || date.getTime() <= maxDate.getTime()));
        },

        /* Provide the configuration settings for formatting/parsing. */
        _getFormatConfig: function (inst)
        {
            var shortYearCutoff = this._get(inst, 'shortYearCutoff');
            shortYearCutoff = (typeof shortYearCutoff != 'string' ? shortYearCutoff :
                new Date().getFullYear() % 100 + parseInt(shortYearCutoff, 10));
            return {
                shortYearCutoff: shortYearCutoff,
                dayNamesShort: this._get(inst, 'dayNamesShort'), dayNames: this._get(inst, 'dayNames'),
                monthNamesShort: this._get(inst, 'monthNamesShort'), monthNames: this._get(inst, 'monthNames')
            };
        },

        /* Format the given date for display. */
        _formatDate: function (inst, day, month, year)
        {
            if (!day)
            {
                inst.currentDay = inst.selectedDay;
                inst.currentMonth = inst.selectedMonth;
                inst.currentYear = inst.selectedYear;
            }
            var date = (day ? (typeof day == 'object' ? day :
                this._daylightSavingAdjust(new Date(year, month, day))) :
                this._daylightSavingAdjust(new Date(inst.currentYear, inst.currentMonth, inst.currentDay)));
            return this.formatDate(this._get(inst, 'dateFormat'), date, this._getFormatConfig(inst));
        }
    });

    /*
     * Bind hover events for datepicker elements.
     * Done via delegate so the binding only occurs once in the lifetime of the parent div.
     * Global instActive, set by _updateDatepicker allows the handlers to find their way back to the active picker.
     */
    function bindHover(dpDiv)
    {
        var selector = 'button, .ui-datepicker-prev, .ui-datepicker-next, .ui-datepicker-calendar td a';
        return dpDiv.delegate(selector, 'mouseout', function ()
        {
            $(this).removeClass('ui-state-hover');
            if (this.className.indexOf('ui-datepicker-prev') != -1) $(this).removeClass('ui-datepicker-prev-hover');
            if (this.className.indexOf('ui-datepicker-next') != -1) $(this).removeClass('ui-datepicker-next-hover');
        })
            .delegate(selector, 'mouseover', function ()
            {
                if (!$.datepicker._isDisabledDatepicker(instActive.inline ? dpDiv.parent()[0] : instActive.input[0]))
                {
                    $(this).parents('.ui-datepicker-calendar').find('a').removeClass('ui-state-hover');
                    $(this).addClass('ui-state-hover');
                    if (this.className.indexOf('ui-datepicker-prev') != -1) $(this).addClass('ui-datepicker-prev-hover');
                    if (this.className.indexOf('ui-datepicker-next') != -1) $(this).addClass('ui-datepicker-next-hover');
                }
            });
    }

    /* jQuery extend now ignores nulls! */
    function extendRemove(target, props)
    {
        $.extend(target, props);
        for (var name in props)
            if (props[name] == null || props[name] == undefined)
                target[name] = props[name];
        return target;
    };


    $.fn.datepicker = function (options)
    {

        /* Verify an empty collection wasn't passed - Fixes #6976 */
        if (!this.length)
        {
            return this;
        }

        /* Initialise the date picker. */
        if (!$.datepicker.initialized)
        {
            $(document).mousedown($.datepicker._checkExternalClick).
                find(document.body).append($.datepicker.dpDiv);
            $.datepicker.initialized = true;
        }

        var otherArgs = Array.prototype.slice.call(arguments, 1);
        if (typeof options == 'string' && (options == 'isDisabled' || options == 'getDate' || options == 'widget'))
            return $.datepicker['_' + options + 'Datepicker'].
                apply($.datepicker, [this[0]].concat(otherArgs));
        if (options == 'option' && arguments.length == 2 && typeof arguments[1] == 'string')
            return $.datepicker['_' + options + 'Datepicker'].
                apply($.datepicker, [this[0]].concat(otherArgs));
        return this.each(function ()
        {
            typeof options == 'string' ?
                $.datepicker['_' + options + 'Datepicker'].
                    apply($.datepicker, [this].concat(otherArgs)) :
                $.datepicker._attachDatepicker(this, options);
        });
    };

    $.datepicker = new Datepicker(); // singleton instance
    $.datepicker.initialized = false;
    $.datepicker.uuid = new Date().getTime();
    $.datepicker.version = "1.9.2";

    // Workaround for #4055
    // Add another global to avoid noConflict issues with inline event handlers
    window['DP_jQuery_' + dpuuid] = $;

})(jQuery);

jQuery.extend({ bindDatepicker: function () { $("input.date").datepicker().verifyDate(); return this; } });
jQuery.extend({ bindNumeric: function () { $("input.numeric").verifyNumeric(); return this; } });
jQuery.extend({ bindInt: function () { $("input.int").verifyInt(); return this; } });


jQuery.extend({
    getSelectText: function ()
    {
        var txt = null;
        if (window.getSelection)
        {
            txt = window.getSelection();
        }
        else if (document.getSelection)
        {
            txt = document.getSelection();
        }
        else if (document.selection)
        {
            txt = document.selection.createRange().text;
        }
        return txt;
    },
    innerText: function (text)
    {
        //1.首先动态创建一个容器标签元素，如DIV
        var temp = document.createElement("div");
        //2.然后将要转换的字符串设置为这个元素的innerHTML(ie，火狐，google都支持)
        temp.innerText = text;
        //3.最后返回这个元素的innerText(ie支持)或者textContent(火狐，google支持)，即得到经过HTML解码的字符串了。
        var output = temp.innerHTML;
        temp = null;
        return output;
    },
    unSelect: function ()
    {
        if (window.getSelection)
        {
            window.getSelection().removeAllRanges();
        }
        else if (document.getSelection)
        {
            document.getSelection().removeAllRanges();
        }
        else if (document.selection)
        {
            document.selection.empty();
        }

    },
    createPopup: function (pCtrl, options)
    {
        pCtrl = $(pCtrl);
        if (!options)
        {
            options = {};
        }
        if (!options.autoPostion && options.autoPostion !== false)
        {
            options.autoPostion = true;
        }

        if (!options.text)
        {
            options.text = pCtrl.attr("popup");
        }

        if (!options.text)
        {
            return;
        }

        $("#_popup_float").remove();
        var popupFloat = $("<div id='_popup_float'></div>").appendTo(pCtrl.parent());
        if (options.css)
        {
            popupFloat.css(options.css);
        }
        else
        {
            var css = pCtrl.attr("popup-css");
            if (css)
            {
                css = css.replace(/'/g, "\"");
                css = $.parseJSON(css);
                popupFloat.css(css);
                options.css = css;

            }
        }

        if (!options.align)
        {
            options.align = pCtrl.attr("popup-align");
            if (!options.align)
            {
                options.align = "top";
            }
        }


        var pArrow = $("<div id='_popup_" + options.align + "'></div>").appendTo(popupFloat);

        var oText = $("<div id='_popup_text'></div>").appendTo(popupFloat);
        var sMsg = options.text;
        if (options.color)
        {
            oText.css("color", options.color);
        }
        if (options.bodyCss)
        {
            oText.css(options.bodyCss);
        }
        else
        {
            var css = pCtrl.attr("popup-body-css");
            if (css)
            {
                css = css.replace(/'/g, "\"");
                css = $.parseJSON(css);
                oText.css(css);
                options.bodyCss = css;
            }
        }
        if (sMsg.indexOf("@") != 0)
        {
            oText.text(sMsg);
            sMsg = $(oText).html();
            sMsg = sMsg.replace(/\n/ig, "<br/>");
            sMsg = sMsg.replace(/`/g, "<br/>");
        }
        else
        {
            sMsg = sMsg.substr(1);
        }
        if (sMsg.length == 0)
        {
            return;
        }
        $(oText).html(sMsg);

        $.showPopup(pCtrl, popupFloat, options);
    },

    showPopup: function (srcCtrl, overCtrl, options)
    {
        var popupAlign = options.align;
        srcCtrl = $(srcCtrl);
        overCtrl = $(overCtrl);

        var scrHeight = srcCtrl.outerHeight();
        var overHeight = overCtrl.outerHeight();

        //console.log("overHeight:" + overHeight);
        //setTimeout(function ()
        //{
        //    console.log("overHeight2:" + overCtrl.outerHeight());
        //},100);
        var scrWidth = srcCtrl.outerWidth();
        var overWidth = overCtrl.outerWidth();
        if (popupAlign == "bottom" || popupAlign == "top")
        {
            if (scrWidth > overWidth && (!options.css || !options.css.width))
            {
                overCtrl.outerWidth(scrWidth);
                overWidth = scrWidth;
            }
        }
        if (popupAlign == "left" || popupAlign == "right")
        {
            if (scrHeight > overHeight && (!options.css || !options.css.height))
            {
                overCtrl.outerHeight(scrHeight);
                overHeight = scrHeight;
            }
        }
        var posInput = srcCtrl.position();
        var posOver = overCtrl.position();

        var marginTop = parseFloat($.css(srcCtrl[0], "marginTop")) || 0;
        var marginLeft = parseFloat($.css(srcCtrl[0], "marginLeft")) || 0;

        if (popupAlign == "bottom")
        {
            var left = posInput.left - posOver.left + marginLeft - (overWidth - scrWidth) / 2;
            if (options.autoPostion)
            {
                if (left + posInput.left < 0)
                {
                    left = 0 - posInput.left;
                }
            }
            overCtrl.css("margin-left", left);
            overCtrl.css("margin-top", (posInput.top - posOver.top + marginTop) + scrHeight + 4);
        }
        else if (popupAlign == "top")
        {
            var left = posInput.left - posOver.left + marginLeft - (overWidth - scrWidth) / 2;
            if (options.autoPostion)
            {
                if (left + posInput.left < 0)
                {
                    left = 0 - posInput.left;
                }
                if (left + posOver.left < 0)
                {
                    left = 0 - posOver.left;
                }
            }

            //$.msg("posInput.left " + posInput.left + " posOver.left " + posOver.left);
            overCtrl.css("margin-left", left);
            overCtrl.css("margin-top", (posInput.top - posOver.top + marginTop) - overHeight - 4);

        }
        else if (popupAlign == "left")
        {
            overCtrl.css("margin-left", posInput.left - marginLeft - posOver.left - overWidth - 4);
            overCtrl.css("margin-top", 0 - (posOver.top - posInput.top - marginTop) - (overHeight - scrHeight) / 2);

        }
        else if (popupAlign == "right")
        {
            overCtrl.css("margin-left", posInput.left - marginLeft - posOver.left + scrWidth + 4);
            overCtrl.css("margin-top", 0 - (posOver.top - posInput.top - marginTop) - (overHeight - scrHeight) / 2);
        }
        if (typeof (_PopupShowed) != "undefined")
        {
            _PopupShowed(srcCtrl, overCtrl, options);
        }
        if (options.show)
        {
            options.show(srcCtrl, overCtrl, options);
        }
    },
    cmShow: function (e, getParms, event)
    {
        if (event)
        {
            event();
        }

        var defaultParms = { width: 180, items: [], head: null, show: null, hide: null }
        if (!getParms)
        {
            return;
        }
        var parms = getParms();
        if (!parms)
        {
            return;
        }
        for (var p in parms)
        {
            defaultParms[p] = parms[p];
        }
        if (parms.show)
        {
            defaultParms.show = parms.show();
        }
        var cm = $("#_cm");
        if (cm.length == 0)
        {
            cm = $("<div id='_cm' class='_float_box' style='display:none;'></div>").appendTo(document.body).contextmenu(function (ec)
            {
                if (ec.target.tagName != "INPUT")
                {

                    return false;
                }
            });
        }
        else
        {
            cm.empty();
        }
        if (defaultParms.head != null)
        {
            var hd = $("<div id='_cm_head' class='_cmi_show'></div>").appendTo(cm).text(defaultParms.head.text);
            if (defaultParms.head.pic)
            {
                hd.css("background-color", defaultParms.head.pic);
            }
            if (defaultParms.head.css)
            {
                hd.css(defaultParms.head.css);
            }
            $("<div class='_cmi_show _cmi_space'></div>").appendTo(cm);
        }
        for (var i = 0; i < defaultParms.items.length; i++)
        {
            if (defaultParms.items[i] && defaultParms.items[i].show)
            {
                cm.append(defaultParms.items[i].ctrl);
            }
        }
        cm.show();
        var bd = $(document.body);
        var top = e.pageY;

        var allHeight = bd.height() + $(document).scrollTop();
        var allWidth = bd.width() + $(document).scrollLeft();
        if (top + cm.height() > allHeight)
        {
            top = top - cm.height();
            if (top < 0)
            {
                top = 0;
            }
        }

        var left = e.pageX;
        if (left + defaultParms.width > allWidth)
        {
            left = left - defaultParms.width;
            if (left < 0)
            {
                left = 0;
            }
        }


        cm.options = defaultParms;
        cm.outerWidth(defaultParms.width).css("top", top + "px").css("left", left + "px");
        $.cm_show = cm;

        if (defaultParms.show != null)
        {
            defaultParms.show();
        }

    },
    cmHide: function (e1)
    {

        if ($.cm_show === null)
        {
            return;
        }
        if ($.cm_show)
        {
            if (e1)
            {
                // var cls = $(e.target).parents("#_cm");
                if ($(e1.target).parents("._cmi_show").length > 0 || $(e1.target).hasClass("_cmi_show"))
                {
                    return;
                }
            }
            if ($.cm_show.options && $.cm_show.options.hide)
            {
                $.cm_show.options.hide();
            }
            $.cm_show = null;
            $("#_cm").hide();

        }
    },
    cmItem: function (ps)
    {
        var cmi = { ctrl: null, click: null, pic: null, text: null, separation: true, title: null, enabled: true, creat: null, cindex: 1, show: true };

        if (ps != null)
        {
            cmi.separation = false;
            for (var p in ps)
            {
                cmi[p] = ps[p];
            }


        }
        if (cmi.separation || cmi.spt)
        {
            cmi.ctrl = $("<div class='_cmi_spt _cmi_show'></div>");

        }
        else if (cmi.creat != null)
        {
            cmi.ctrl = cmi.creat();
        }
        else
        {
            cmi.ctrl = $("<div></div>").text(cmi.text);
            if (cmi.click != null && cmi.enabled)
            {
                cmi.ctrl.click(cmi.click);
            }
            if (!cmi.enabled)
            {
                cmi.ctrl.prop("disabled", true).addClass("_cmi_disabled").addClass("_cmi_show");
            }
            else
            {
                cmi.ctrl.addClass("_cmi" + cmi.cindex);
            }

            if (cmi.pic != null && cmi.pic != "")
            {
                cmi.ctrl.css("background-image", "url('" + cmi.pic + "')");
            }
        }

        if (cmi.title && cmi.ctrl)
        {
            $(cmi.ctrl).attr("title", cmi.title.replace(/`/g, "\r"));
        }

        return cmi;
    },

    cm_show: null
});
(function ($)
{
    $.combobox = {
        defaultOptions: {
            width: "100px",
            id: null,
            name: null,
            items: null,
            css: null,
            text: null,
            classes: null,
            enabled: true,
            readonly: true,
            multiple: true,
            itemHeight: "auto",
            title: null,
            itemWidth: "parent",
            checkAll: null,
            check: null,
        }
    }
    $.BuildData = function (p)
    {
        if (!p)
        {
            p = $("form")[0];
        }

        p = $(p);


        var postData = {};

        var texts = p.find(":hidden,:text,select");
        texts.each(function ()
        {
            var c = $(this);
            var fld = c.attr("name");
            if (!fld)
            {
                fld = c.attr("id");
            }
            if (fld && fld.indexOf("_cbb_") != 0)
            {
                var v = $.trim(c.val());

                postData[fld] = v;
            }
        });

        var rdos = p.find(":radio:checked");
        rdos.each(function ()
        {
            var c = $(this);
            var fld = c.attr("name");
            if (fld)
            {
                var v = $.trim(c.val());

                postData[fld] = v;
            }
        });

        var cbxs = p.find(":checkbox:checked");
        cbxs.each(function ()
        {
            var c = $(this);
            var fld = c.attr("name");
            if (c.prop("checked") && fld && fld.indexOf("_cbb_") != 0)
            {
                var v = $.trim(c.val());
                var oldV = postData[fld];
                if (oldV)
                {
                    postData[fld] = oldV + "," + v;
                }
                else
                {
                    postData[fld] = v;
                }
            }
        });

        return postData;
    }
    $.fn.bindMoveTr = function (arg)
    {
        //var markDiv = $("#bindmovetr_markdiv");
        //if (markDiv.length == 0)
        //{
        //    markDiv = $("<div id='bindmovetr_markdiv' class='_cm_show'></div>").appendTo($(document.body));
        //}
        var minRowIndex = 1;
        if (arg && (arg.min_rowindex || arg.min_rowindex == 0))
        {
            minRowIndex = arg.min_rowindex;
        }
        var eventSrc = $(this);
        eventSrc.mousedown(function (e)
        {
            if (e.target.nodeName.toUpperCase() == "INPUT" || $(e.target).hasClass("disabled-move"))
            {
                return;
            }
            var tr = $(e.target).closest("TR"), si = tr.index(), sy = e.pageY, b = $(document.body), drag = false;
            if (si < minRowIndex)
            {
                return;
            }
            b.css("userSelect", "none");
            function move(e)
            {

                if (!drag && Math.abs(e.pageY - sy) < 10)
                {
                    return;
                }

                if (!drag)
                {
                    b.addClass("drag-tr");
                    tr.addClass("drag-tr");
                    drag = true;
                }

                tr.siblings().each(function ()
                {
                    var s = $(this), i = s.index(), y = s.offset().top;

                    if (i >= minRowIndex && e.pageY >= y && e.pageY < y + s.outerHeight())
                    {
                        if (i < tr.index())
                        {
                            s.insertAfter(tr);
                        }
                        else
                        {
                            s.insertBefore(tr);
                        }
                        return false;
                    }
                });
            }
            function up(e)
            {
                drag = false;
                if (drag && si != tr.index())
                {
                    if (arg && arg.moved)
                    {
                        var dragRv = { tr: tr };
                        arg.moved(dragRv);
                    }
                }
                $(document).unbind("mousemove", move).unbind("mouseup", up);
                b.removeClass("drag-tr").css("userSelect", "");
                tr.removeClass("drag-tr");

            }
            $(document).mousemove(move).mouseup(up);
        });
    }

    $.fn.bindMove = function (arg)
    {
        var bd = $(document.body);
        var Move = {};
        var overDiv = $("#____move_cover");
        if (overDiv.length == 0)
        {
            overDiv = $("<div id='____move_cover' style='position:absolute;width:100%;height:100%;top:0px;left:0px;z-index:10000000;cursor:move;display:none;'></div>").appendTo(bd).click(function ()
            {
                overDiv.hide();
            });
        }

        var MoveFalse = function ()
        {
            return false;
        }
        var MoveReset = function (eventCtrl)
        {
            overDiv.hide();
            eventCtrl.css("cursor", Move.OldCursor);
            Move.down = false;
            bd.unbind("selectstart", MoveFalse);
        }

        var eventCtrl = this;
        var moveCtrl = arg.ctrl;
        var moveCallback = null;
        if (arg.move_callback)
        {
            moveCallback = arg.move_callback;
        }
        var checkMoveAble = null;

        if (arg.check_moveable)
        {
            checkMoveAble = arg.check_moveable;
        }

        Move.down = false;
        Move.OldCursor = eventCtrl.css("cursor");

        eventCtrl.mousedown(function (e)
        {
            bd.bind("selectstart", MoveFalse);
            Move.down = true;
            Move.x = e.pageX;
            Move.y = e.pageY;
            Move.left = moveCtrl[0].offsetLeft;
            Move.top = moveCtrl[0].offsetTop;
            Move.marginTop = parseFloat($.css(moveCtrl[0], "marginTop")) || 0;
            Move.marginLeft = parseFloat($.css(moveCtrl[0], "marginLeft")) || 0;
        });

        bd.mouseup(function ()
        {
            MoveReset(eventCtrl);
        }).mouseleave(function ()
        {
            MoveReset(eventCtrl);
        }).mousemove(function (e)
        {
            if (Move.down)
            {
                var x = e.pageX - Move.x + Move.left - Move.marginLeft;
                var y = e.pageY - Move.y + Move.top - Move.marginTop;

                Move.move_left = x - Move.left;
                Move.move_top = y - Move.top;
                Move.move_y = y;
                Move.move_x = x;
                if (checkMoveAble)
                {
                    if (!checkMoveAble(Move))
                    {
                        overDiv.hide();
                        return;
                    }
                }
                if (Move.move_left != 0 || Move.move_top != 0)
                {
                    overDiv.show();
                    moveCtrl.css("left", x + "px");
                    moveCtrl.css("top", y + "px");
                    if (moveCallback)
                    {
                        moveCallback(Move);
                    }
                }
            }
        });

        return eventCtrl;
    }



    $.fn.combobox = function (options)
    {
        var cbb = this;
        cbb.options = options = $.extend({}, $.combobox.defaultOptions, options);

        var ctrlP = $("<span class='_cbb_p'></span>");
        var ctrl = $("<input type='text'/>");
        var ctrlItems = $("<div class='_cbb_items _cbb_size'></div>").hide();
        cbb.items_ctrl = ctrlItems;
        if (cbb.options.enabled)
        {
            ctrl.addClass("_cbb _cbb_size");
        }
        else
        {
            ctrl.addClass("_cbb_disabled _cbb_size");
        }
        if (cbb.options.title)
        {
            ctrl.addClass("blank").attr("title", cbb.options.title).attr("placeholder", cbb.options.title);
        }

        if (cbb.options.readonly)
        {
            ctrl.prop("readonly", cbb.options.readonly);
        }
        else
        {
            ctrl.focus(function ()
            {
                setTimeout(function () { ctrl.select() }, 100);
            });
            ctrl.keydown(function (e)
            {
                if (e.keyCode == 9)
                {
                    setTimeout(function ()
                    {
                        ctrlItems.hide();
                    }, 100);

                    return;
                }
            });
            ctrl.keyup(function (e)
            {
                if (ctrlItems.css("display") == "none" && e.keyCode != 9)
                {
                    ctrlItems.show();
                }
                var v = $.trim(ctrl.val().toUpperCase());

                if (e.keyCode == 13)
                {

                    var searchItems = [];
                    for (var i = 0; i < cbb.options.items.length; i++)
                    {
                        var item = cbb.options.items[i];

                        if (item.text && item.text.toUpperCase().indexOf(v) == 0)
                        {

                            searchItems.push(item);
                        }
                        else if (item.py && item.py.toUpperCase().indexOf(v) == 0)
                        {
                            searchItems.push(item);
                        }
                    }

                    if (searchItems.length == 1)
                    {
                        ctrl.val(searchItems[0].text);
                        ctrlItems.hide();
                        if (cbb.options.check)
                        {
                            cbb.options.check(cbb);
                        }
                        return;
                    }

                }


                if (v.length > 0)
                {

                    for (var i = 0; i < cbb.options.items.length; i++)
                    {
                        var item = cbb.options.items[i];
                        if (item.text && item.text.toUpperCase().indexOf(v) == 0)
                        {
                            item.ctrl.show();
                        }
                        else if (item.py && item.py.toUpperCase().indexOf(v) == 0)
                        {
                            item.ctrl.show();
                        }
                        else
                        {
                            item.ctrl.hide();
                        }
                    }


                }
                else
                {
                    for (var i = 0; i < cbb.options.items.length; i++)
                    {
                        cbb.options.items[i].ctrl.show();
                    }
                }
                // }
            });
        }
        if (cbb.options.id)
        {
            $("#" + cbb.options.id).remove();
            ctrl.attr("id", cbb.options.id);
        }
        if (cbb.options.name)
        {
            ctrl.attr("name", cbb.options.name);
        }
        else if (cbb.options.id)
        {
            ctrl.attr("name", cbb.options.id);
        }
        if (cbb.options.css)
        {
            ctrl.css(cbb.options.css);
        }
        if (cbb.options.classes)
        {
            ctrl.addClass(cbb.options.classes);
        }

        if (cbb.options.width)
        {
            ctrlP.width(cbb.options.width);
            ctrl.width("100%");
        }

        cbb.append(ctrlP.append(ctrl).append(ctrlItems));
        if (cbb.options.itemWidth == "parent")
        {
            ctrlItems.css("min-width", ctrlP.width() + "px");
        }
        else
        {
            ctrlItems.css("width", cbb.options.itemWidth);

        }
        if (cbb.options.itemHeight != "auto")
        {
            ctrlItems.css("max-height", cbb.options.itemHeight);
        }

        cbb.createItem = function ()
        {
            ctrlItems.empty();
            if (cbb.options.items)
            {
                if (cbb.options.checkAll == null && cbb.options.items.length > 10)
                {
                    cbb.options.checkAll = true;
                }
                var name = "_cbb" + Math.random() + "_" + Math.random();
                if (cbb.options.id)
                {
                    name = "_cbb_" + cbb.options.id;
                }


                var itemsP = $("<div style='width:100%;display:table;'></div>").appendTo(ctrlItems);
                if (cbb.options.multiple && cbb.options.checkAll)
                {
                    var itemCtrl = $("<div class='_cbb_check_all'></div>").appendTo(itemsP);
                    var ctrlCboxP = $("<span class='_cbb_cbx_p'></span>").appendTo(itemCtrl);
                    var ctrlLabel = $("<label class='_cbb_label'>{全选}</label>").appendTo(itemCtrl);
                    ctrlLabel.attr("for", name + "_checkall");
                    var cbAll = $("<input type='checkbox'/>").appendTo(ctrlCboxP).attr("id", name + "_checkall");

                    cbAll.click(function ()
                    {
                        cbAll.parent().parent().parent().find(":checkbox").prop("checked", cbAll.prop("checked"));
                        ctrl.val($.cbx(name));
                        if (cbb.options.check)
                        {
                            cbb.options.check(cbb);
                        }
                    });
                }

                for (var i = 0; i < cbb.options.items.length; i++)
                {
                    var item = cbb.options.items[i];

                    if (item.spt || item.separation || (!item.text && !item.pic))
                    {
                        var itemCtrl = $("<div class='_cbb_spt _cbb_size'><span class='_cbb_spt'></span></div>");
                        if (cbb.options.multiple)
                        {
                            itemCtrl.append($("<span  class='_cbb_spt'></span>"));
                        }
                        item.ctrl = itemCtrl;
                        ctrlItems.append(itemCtrl);
                    }
                    else
                    {
                        var itemCtrl = $("<div class='_cbb_item'></div>").appendTo(itemsP);
                        item.ctrl = itemCtrl;
                        if (item.id)
                        {
                            itemCtrl.attr("id", item.id);
                        }
                        if (cbb.options.multiple)
                        {
                            var ctrlCboxP = $("<span class='_cbb_cbx_p'></span>").appendTo(itemCtrl)
                            var ctrlCbox = $("<input type='checkbox'/>").appendTo(ctrlCboxP);
                            if (item.id)
                            {
                                ctrlCbox.attr("id", item.id + "_cbx");
                            }
                            else if (cbb.options.id)
                            {
                                ctrlCbox.attr("id", cbb.options.id + "_" + i);
                            }
                            else
                            {
                                ctrlCbox.attr("id", name + "_" + i);
                            }
                            if (item.value || item.value === 0)
                            {
                                ctrlCbox.attr("value", item.value);
                            }
                            else if (item.text)
                            {
                                ctrlCbox.attr("value", item.text);
                            }
                            ctrlCbox.attr("name", name);
                            item.cbx = ctrlCbox;

                            ctrlCbox.click(function ()
                            {
                                ctrl.val($.cbx(name));
                                if (cbb.options.check)
                                {
                                    cbb.options.check(cbb);
                                }
                            });
                        }
                        if (item.text)
                        {
                            if (item.text.indexOf("@") == 0)
                            {
                                itemCtrl.html(item.text.substr(1));
                            }
                            else
                            {
                                var ctrlLabel = $("<label class='_cbb_label'></label>").appendTo(itemCtrl);
                                ctrlLabel.text(item.text);

                                item.label_ctrl = ctrlLabel;
                                if (item.cbx)
                                {
                                    ctrlLabel.attr("for", item.cbx.attr("id"));
                                }
                                else
                                {
                                    ctrlLabel.click(function ()
                                    {
                                        ctrl.val($(this).attr("value"));
                                        ctrlItems.hide();
                                        if (cbb.options.check)
                                        {
                                            cbb.options.check(cbb);
                                        }
                                    }).css("padding-left", "4px");
                                }

                                if (item.value || item.value === 0)
                                {
                                    ctrlLabel.attr("value", item.value);
                                }
                                else if (item.text)
                                {
                                    ctrlLabel.attr("value", item.text);

                                }
                                if (item.label_css)
                                {
                                    ctrlLabel.css(item.label_css);
                                }
                            }
                        }

                        if (item.css)
                        {
                            itemCtrl.css(item.css);
                        }
                        if (item.classes)
                        {
                            itemCtrl.addClass(item.classes);
                        }
                    }
                }
            }
        };

        cbb.createItem();

        ctrlP.mouseenter(function ()
        {
            if (cbb.options.enabled && !ctrl.prop("disabled"))
            {
                if (cbb.options.multiple)
                {
                    var values = ctrl.val().split(",");
                    for (var i = 0; i < cbb.options.items.length; i++)
                    {
                        if (cbb.options.items[i].cbx)
                        {
                            var itemCbx = cbb.options.items[i].cbx;
                            if (values.contains(itemCbx.val()))
                            {
                                itemCbx.prop("checked", true);
                            }
                            else
                            {
                                itemCbx.prop("checked", false);

                            }
                        }
                    }
                }
                ctrlItems.show();
            }
            for (var i = 0; i < cbb.options.items.length; i++)
            {
                cbb.options.items[i].ctrl.show();
            }
        }).mouseleave(function ()
        {
            if (cbb.options.enabled)
            {
                ctrlItems.hide();
            }
        });
        return cbb;
    }
})(jQuery);

(function ($)
{
    $.dropbutton = {
        defaultOptions: {
            width: "auto",
            id: null,
            items: null,
            enabled: true,
            css: null,
            itemsCss: null,
            text: null,
            pic: null,
            classes: null,
            emptyParent: true,
            itemWidth: "auto",
            show: null,
            hide: null,
            iconShow: false,
            function: null,
        }
    }

    $.fn.dropbutton = function (options)
    {
        var db = this;

        db.options = options = $.extend({}, $.dropbutton.defaultOptions, options);

        var ctrl = $("<span></span>");
        var arrowCtrl = $("<span class='_db_arrow'><span class='_db_arrow_cover1'></span><span class='_db_arrow_cover2'></span></span>").appendTo(ctrl);


        if (db.options.enabled)
        {
            ctrl.addClass("_db");
        }
        else
        {
            ctrl.addClass("_db_disabled");
            arrowCtrl.addClass("_db_disabled");
        }


        if (db.options.iconShow && db.options.enabled)
        {
            ctrl.addClass("_db_iconshow");
        }


        if (db.options.id)
        {
            $("#" + db.options.id).remove();
            ctrl.attr("id", db.options.id);
        }
        if (db.options.css)
        {
            ctrl.css(db.options.css);
        }
        var txtCtrl = $("<span class='_db_txt'></span>").text(db.options.text).appendTo(ctrl);
        if (db.options.pic)
        {
            txtCtrl.addClass("_db_pic").css("background-image", "url(" + db.options.pic + ")");
        }

        if (db.options.function)
        {
            txtCtrl.click(db.options.function);
        }

        if (db.options.emptyParent)
        {
            this.empty();
        }

        this.append(ctrl);

        if (db.options.items != null && db.options.items.length > 0)
        {
            var itemsCtrl = $("<div class='_db_items'></div>");
            if (db.options.iconShow)
            {
                itemsCtrl.appendTo(arrowCtrl);
            }
            else
            {
                itemsCtrl.appendTo(ctrl);
            }
            if (db.options.itemsCss)
            {
                itemsCtrl.css(db.options.itemsCss);
            }
            if (db.options.itemWidth && db.options.itemWidth != "auto")
            {
                itemsCtrl.css("width", db.options.itemWidth);
            }
            for (var i = 0; i < db.options.items.length; i++)
            {
                var item = db.options.items[i];
                if (item == null)
                {
                    continue;
                }
                if (item.show === false)
                {
                    continue;
                }

                if (item.spt || item.separation || (!item.text && !item.pic))
                {
                    var itemCtrl = $("<div class='_db_spt'></div>").appendTo(itemsCtrl);

                    continue;
                }
                var itemCtrl = $("<div></div>").appendTo(itemsCtrl);
                if (item.id)
                {
                    itemCtrl.attr("id", item.id);
                }
                if (item.text && item.text.indexOf("@") == 0)
                {
                    itemCtrl.html(item.text.substr(1));
                }
                else
                {
                    itemCtrl.text(item.text);
                }
                if (item.enabled === false)
                {
                    itemCtrl.addClass("_db_item_disabled").prop("disabled", true);
                }
                else
                {
                    item.enabled = true;
                    itemCtrl.addClass("_db_item").prop("disabled", false);
                }

                if (item.pic)
                {
                    itemCtrl.addClass("_db_item_imgbg").css("background-image", "url(" + item.pic + ")");
                }
                if (item.title)
                {
                    itemCtrl.attr("title", item.title.replace(/`/g, "\n"));
                }
                if (item.click)
                {
                    itemCtrl.click(item.click);
                }
                if (item.enabled)
                {
                    // itemCtrl.click(function () { itemsCtrl.hide(); itemCtrl.mouseleave() });
                }
                if (item.css)
                {
                    itemCtrl.css(item.css);
                }
            }
            if (db.options.enabled)
            {
                var showCtrl = db.options.iconShow ? arrowCtrl : ctrl;

                showCtrl.mouseenter(function ()
                {
                    if (db.options.show)
                    {
                        db.options.show();
                    }
                });
                ctrl.mouseleave(function ()
                {
                    if (db.options.hide)
                    {
                        db.options.hide();
                    }
                });
            }
        }

        return this;
    }
})(jQuery);


(function ($)
{
    $.step = {
        defaultOptions: {
            id: null,
            items: null,
            ctrl: null,
            itemWidth: "auto",//avg,auto
            width: null
        },
    }

    hxjStep = function (options)
    {
        var step = this;

        step.options = options = $.extend({}, $.step.defaultOptions, options);
        this.Create = function ()
        {
            var stepTb = $("<div class='table _step_tb'></div>");
            var stepRow = $("<div class='row'></div>").appendTo(stepTb);
            if (step.options.id)
            {
                stepTb.attr("id", step.options.id);
            }
            if (step.options.width)
            {
                stepTb.css("width", step.options.width);
            }

            if (step.options.items != null && step.options.items.length > 0)
            {
                var w = null;
                if (step.options.itemWidth == "avg")
                {
                    w = (100.0 / step.options.items.length) + "%";
                }
                else if (step.options.itemWidth && step.options.itemWidth != "auto")
                {
                    w = step.options.itemWidth;
                }

                for (var i = 0; i < step.options.items.length; i++)
                {
                    var stepItem = step.options.items[i];

                    var stepCell = $("<div class='cell _step'></div>").txt(stepItem.text).appendTo(stepRow);
                    if (stepItem.id != null)
                    {
                        stepCell.attr("id", stepItem.id);
                    }
                    if (stepItem.width)
                    {
                        w = stepItem.width;
                    }
                    if (w)
                    {
                        stepCell.css("width", w);
                    }
                    stepItem.ctrl = stepCell;
                    if (i < step.options.items.length - 1)
                    {
                        stepCell.addClass("_step_next");
                    }
                    else
                    {
                        stepCell.addClass("_step_next_end");
                    }

                    if (stepItem.active)
                    {
                        step.Active(stepItem);
                    }



                }
            }
            //$("<div class='cell'></div>").appendTo(stepRow).html("&nbsp;");
            return stepTb;
        }

        this.Active = function (activeItem)
        {
            if ($.isNumeric(activeItem))
            {
                activeItem = step.options.items[parseInt(activeItem)];
            }
            var iCell = $.inArray(activeItem, step.options.items, 0);

            for (var i = 0; i < step.options.items.length; i++)
            {
                var stepItem = step.options.items[i];
                if (stepItem.ctrl)
                {
                    stepItem.ctrl.removeClass("_step_next").removeClass("_step_pre").removeClass("_step_pre_cur").removeClass("_step_cur").removeClass("_step_cur_end");

                }

            }

            for (var i = 0; i < iCell - 1; i++)
            {
                var stepItem = step.options.items[i];
                stepItem.ctrl.addClass("_step_pre");

            }
            if (iCell > 0)
            {
                var stepItem = step.options.items[iCell - 1];
                stepItem.ctrl.addClass("_step_pre_cur");

            }
            if (iCell < step.options.items.length - 1)
            {
                activeItem.ctrl.addClass("_step_cur");
                for (var i = iCell + 1; i < step.options.items.length - 1; i++)
                {
                    var stepItem = step.options.items[i];
                    if (stepItem.ctrl)
                    {
                        stepItem.ctrl.addClass("_step_next");
                    }
                }
                var lastItem = step.options.items[step.options.items.length - 1];
                if (lastItem.ctrl)
                {
                    lastItem.ctrl.addClass("_step_next_end");
                }
            }
            else
            {
                activeItem.ctrl.removeClass("_step_next_end").addClass("_step_cur_end");

            }
        }
    }

})(jQuery);


jQuery.fn.extend({
    cmenu: function (getParms, event)
    {
        this.contextmenu(function (e)
        {
            if (!e.ctrlKey)
            {
                $.cmShow(e, getParms, event); return false;
            }
        });

    },
    bindPopup: function ()
    {
        this.live("focus", function ()
        {
            var pCtrl = $(this);
            $.createPopup(pCtrl);
        }).live("blur", function ()
        {
            $("#_popup_float").remove();
        });
        return this;
    },
    step: function (options)
    {
        var step = new hxjStep(options);
        if (step.options.id != null)
        {
            $("#" + step.options.id).remove();
        }

        this.append(step.Create());
        this.step = step;
        return this;
    },
    txt: function (value, defaultValue)
    {
        if (value == null)
        {
            if (typeof (defaultValue) != "undefined")
            {
                value = defaultValue;
            }
            else
            {
                value = "";
            }
        }

        return this.text(value);
    }
});

/*!
 * jQuery Cookie Plugin v1.4.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */
(function (factory)
{
    if (typeof define === 'function' && define.amd)
    {
        // AMD
        define(['jquery'], factory);
    } else if (typeof exports === 'object')
    {
        // CommonJS
        factory(require('jquery'));
    } else
    {
        // Browser globals
        factory(jQuery);
    }
}(function ($)
{

    var pluses = /\+/g;

    function encode(s)
    {
        return config.raw ? s : encodeURIComponent(s);
    }

    function decode(s)
    {
        return config.raw ? s : decodeURIComponent(s);
    }

    function stringifyCookieValue(value)
    {
        return encode(config.json ? JSON.stringify(value) : String(value));
    }

    function parseCookieValue(s)
    {
        if (s.indexOf('"') === 0)
        {
            // This is a quoted cookie as according to RFC2068, unescape...
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
        }

        try
        {
            // Replace server-side written pluses with spaces.
            // If we can't decode the cookie, ignore it, it's unusable.
            // If we can't parse the cookie, ignore it, it's unusable.
            s = decodeURIComponent(s.replace(pluses, ' '));
            return config.json ? JSON.parse(s) : s;
        } catch (e) { }
    }

    function read(s, converter)
    {
        var value = config.raw ? s : parseCookieValue(s);
        return $.isFunction(converter) ? converter(value) : value;
    }

    var config = $.cookie = function (key, value, options)
    {

        // Write

        if (value !== undefined && !$.isFunction(value))
        {
            options = $.extend({}, config.defaults, options);

            if (typeof options.expires === 'number')
            {
                var days = options.expires, t = options.expires = new Date();
                t.setTime(+t + days * 864e+5);
            }

            return (document.cookie = [
                encode(key), '=', stringifyCookieValue(value),
                options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
                options.path ? '; path=' + options.path : '; path=/',
                options.domain ? '; domain=' + options.domain : '',
                options.secure ? '; secure' : ''
            ].join(''));
        }

        // Read

        var result = key ? undefined : {};

        // To prevent the for loop in the first place assign an empty array
        // in case there are no cookies at all. Also prevents odd result when
        // calling $.cookie().
        var cookies = document.cookie ? document.cookie.split('; ') : [];

        for (var i = 0, l = cookies.length; i < l; i++)
        {
            var parts = cookies[i].split('=');
            var name = decode(parts.shift());
            var cookie = parts.join('=');

            if (key && key === name)
            {
                // If second argument (value) is a function it's a converter...
                result = read(cookie, value);
                break;
            }

            // Prevent storing a cookie that we couldn't decode.
            if (!key && (cookie = read(cookie)) !== undefined)
            {
                result[name] = cookie;
            }
        }

        return result;
    };

    config.defaults = {};

    $.removeCookie = function (key, options)
    {
        if ($.cookie(key) === undefined)
        {
            return false;
        }

        // Must not alter options, thus extending a fresh object...
        $.cookie(key, '', $.extend({}, options, { expires: -1 }));
        return !$.cookie(key);
    };
    $.cookieKeyValue = function (cookieName, key, value)
    {
        var cv = $.cookie(cookieName);

        if (value === undefined)
        {
            if (cv)
            {
                cvo = $.parseJSON(cv);
                if (cvo[key])
                {
                    return cvo[key];
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }
        else
        {
            if (cv)
            {
                cvo = $.parseJSON(cv);
            }
            else
            {
                cvo = {};

            }
            cvo[key] = value;
            $.cookie(cookieName, $.toJSON(cvo), { expires: new Date(2200, 1, 1) });
        }
    }

}));
(function ($)
{
    $.extend({
        tabbar: function (srcOptions)
        {
            var barOptions = { size: "big", skin: "tab", css: {}, align: "top", tabs: [] };

            var options = $.extend({}, barOptions, srcOptions);
            srcOptions.tabbar = options;

            var skinClass = "tabbar_skin_" + options.skin;

            var ctrl = $("<div class='tabbar_bar'></div>").addClass(options.size).addClass(options.align).addClass(skinClass);
            if (options.css)
            {
                ctrl.css(options.css);
            }

            ctrl.tabbar = options;
            options.ctrl = ctrl;
            options.active = function (activeTab)
            {
                if (activeTab.click)
                {
                    var crv = activeTab.click(activeTab, activeTab.ctrl);
                    if (crv === false)
                    {
                        return;
                    }
                }

                for (var i = 0; i < options.tabs.length; i++)
                {
                    var t = options.tabs[i];
                    if (t.panel)
                    {
                        $(t.panel).hide();
                    }
                    t.active = false;
                    if (t.ctrl)
                    {
                        t.ctrl.removeClass("active");
                    }
                    if (t.preSpt)
                    {
                        t.preSpt.removeClass("active");
                    }
                    if (t.nextSpt)
                    {
                        t.nextSpt.removeClass("active");
                    }
                }

                activeTab.active = true;
                if (activeTab.panel)
                {
                    $(activeTab.panel).show();
                }
                if (activeTab.preSpt)
                {
                    activeTab.preSpt.addClass("active");
                }
                if (activeTab.nextSpt)
                {
                    activeTab.nextSpt.addClass("active");
                }

                activeTab.ctrl.addClass("active");

            };

            var preSpt = null;
            for (var i = 0; i < options.tabs.length; i++)
            {
                var ot = options.tabs[i];
                ot = options.tabs[i] = $.tab(options, ot, skinClass);
                ctrl.append(ot.ctrl);

                ot.preSpt = preSpt;

                if (i < options.tabs.length - 1 && ot.show)
                {
                    var spt = $("<div class='tabbar_spt'></div>").appendTo(ctrl).addClass(options.size).addClass(skinClass);
                    ot.nextSpt = spt;
                    preSpt = spt;
                }

                if (ot.active)
                {
                    options.active(ot);
                }
            }



            return ctrl;
        },
        tab: function (bar, options, skinClass)
        {
            var tabOptions = { id: null, pic: null, active: false, ctrl: null, preSpt: null, nextSpt: null, panel: null, text: null, html: null, show: true, enabled: true, click: null, css: {} };
            options = $.extend({}, tabOptions, options);

            var ctrl = $("<div class='tabbar_tab'></div>").addClass(bar.size).addClass(bar.align).addClass(skinClass);
            if (options.html)
            {
                ctrl.html(options.html);
            }
            else if (options.text)
            {
                ctrl.text(options.text);
            }
            if (options.pic)
            {
                ctrl.addClass("tab_icon").css("background-image", "url(" + options.pic + ")");

            }
            if (options.css)
            {
                ctrl.css(options.css);
            }
            options.disable = function ()
            {
                ctrl.addClass("disabled");
                options.enabled = false;
            }
            options.enable = function ()
            {
                ctrl.removeClass("disabled");
                options.enabled = true;
            }
            options.ctrl = ctrl;


            if (!options.enabled)
            {
                ctrl.addClass("disabled");
            }
            if (!options.show)
            {
                ctrl.hide();
            }
            ctrl.click(function ()
            {
                if (options.enabled)
                {

                    bar.active(options);
                }
            });


            return options;
        }

    });
}(jQuery));

function AppendAjaxTs(url)
{
    if (url.indexOf("ts___") == -1)
    {
        if (url.indexOf("?") == -1)
        {
            url = url + "?ts___=" + $.ts();
        }
        else
        {
            url = url + "&ts___=" + $.ts();
        }
    }

    return url;
}

function _ACU(url, method, callBack, oArgs)
{
    var oPostArg = oArgs;
    if (arguments.length > 4)
    {
        var oPostArg = new Array();
        for (var iAa1 = 3; iAa1 < arguments.length; iAa1++)
        {
            if (arguments[iAa1] == null)
            {
                oPostArg.push(null);
            }
            else
            {
                oPostArg.push(arguments[iAa1].toString());
            }
        }
    }

    callCtrl = "{page}";
    var oSend = new Object();
    oSend.Method = method;

    $.showWait();

    if (oPostArg == null)
    {
    }
    else if (typeof (oPostArg) == "object")
    {
        oSend.Args = oPostArg;
    }
    else
    {
        oSend.Args = new Array();
        oSend.Args.push(oPostArg);
    }
    if (callCtrl)
    {
        oSend.CallControl = callCtrl;
    }
    var postData = $.createPostData() + "__CALLBACKID=" + $.escape("ACall1") +
        "&__CALLBACKPARAM=" + $.escape($.toJSON(oSend));
    postData = postData.rpl("__VIEWSTATE=", "__VIEWSTATE_DEL=") + "&__VIEWSTATE=";
    var form = $("form")[0];
    if (form["__EVENTVALIDATION"])
    {
        postData += "&__EVENTVALIDATION=" + $.escape(form["__EVENTVALIDATION"].value);
    }

    $.ajax({
        type: "POST",
        async: true,
        url: AppendAjaxTs(url),
        data: postData,
        success: function (result)
        {
            $.hideWait();

            var i1 = result.indexOf("|");
            if (i1 > 0 && i1 < 6)
            {
                var i2 = parseInt(result.substr(0, i1));
                var callReutrn = $.parseJSON(result.substr(i1 + 1 + i2));
                callReturnValue = $.parseCallReturn(callReutrn);
                if (typeof (callBack) != "undefined" && callBack != null)
                {
                    callBack(callReturnValue);
                }
            }
            else
            {
                // alert(result);
            }
        },
        error: function (result)
        {
            $.hideWait();

            if (typeof (callBack) != "undefined" && callBack != null)
            {
                callBack(undefined);
            }
        }
    });
}

///
///_Dialog
///

var _Dialog = new function ()
{
    this.dialogList = [];
    this.beginIndex = 61;
    this.Current = function ()
    {
        if (this.dialogList.length == 0)
        {
            return null;
        }
        return this.dialogList[this.dialogList.length - 1];
    }
    this.Find = function (dialogid)
    {
        if (this.dialogList.length == 0)
        {
            return null;
        }
        for (var i = 0; i < this.dialogList.length; i++)
        {
            var d = this.dialogList[i];
            if (d.id == dialogid)
            {
                d._find_index = i;
                return d;
            }
        }

        return null;
    }

    this.Remove = function (dialog)
    {
        if (dialog)
        {
            var findIndex = d._find_index;
            this.dialogList.removeAt(findIndex);
        }
    }

    this.Table = function (className, rowCount, cellCount)
    {
        var dialogTable = $("<table class='" + className + "'></table>");
        dialogTable.rows = [];
        dialogTable.cells = [];
        if (!rowCount)
        {
            rowCount = 1;
        }
        if (!cellCount)
        {
            cellCount = 1;
        }
        for (var i = 0; i < rowCount; i++)
        {
            var dialogRow = $("<tr></tr>").appendTo(dialogTable);
            dialogTable.rows.push(dialogRow);
            for (var j = 0; j < cellCount; j++)
            {
                var dialogCell = $("<td class='" + className + "'></td>").appendTo(dialogRow);
                dialogTable.cells.push(dialogCell);

            }
        }

        return dialogTable;
    }


    this.ZIndex = function (zIndex)
    {
        for (var i = 0; i < this.dialogList.length; i++)
        {
            this.dialogList[i].dialog_ctrl.css("z_index", this.beginIndex + i + 1);
        }
    }

    this.Show = function (arg)
    {
        arg.dialog = true;
        arg.close_type = arg.close_type ? arg.close_type : "close";//close:hide

        if (arg.close_type == "hide" && arg.dialog_ctrl != null)
        {
            if (arg.onload)
            {
                arg.onload();
            }
            arg.dialog_ctrl.show();
            this.Cover(parseInt(arg.dialog_ctrl.css("z-index")) - this.beginIndex);
            return;
        }
        var title = arg.title;
        var close = arg.close;
        var path = arg.path;

        arg.auto_position = arg.auto_position && arg.refer && !arg.left && !arg.top;
        if (arg.auto_position == null)
        {
            arg.auto_position = false;
        }
        this.Cover(this.dialogList.length + 1);
        this.ZIndex();


        var dialogCtrl = this.Table("_dialog_ctrl").appendTo($(document.body));
        arg.dialog_ctrl = dialogCtrl;

        if (arg["free_close"])
        {
            dialogCtrl.click(function (e)
            {
                var findCtrl = $(e.target).parents("._dialog_panel");

                if (findCtrl.length == 0)
                {
                    _Dialog.Close(arg);
                }
            });
        }

        dialogCtrl.css("z-index", this.beginIndex + this.dialogList.length + 1);

        var dialogAlign = $("<div class='_dialog_panel'></div>").appendTo(dialogCtrl.cells[0]);
        arg.html_panel_parent = dialogAlign[0];
        var dialogPanel = $("<div class='_dialog_panel _float_box'></div>").appendTo(dialogAlign);

        if (arg.auto_position)
        {
            var lt = $.cookieKeyValue("dkv", "pst" + arg.refer);

            if (lt)
            {
                var lt = lt.split(',');
                arg.left = lt[0] + "px";
                arg.top = lt[1] + "px";
            }
        }

        if (typeof (arg.postData) == "undefined")
        {
            arg.postData = null;
        }

        if (arg.width)
        {
            dialogAlign.css("width", arg.width);
        }
        if (arg.height)
        {
            dialogAlign.css("height", arg.height);
        }

        if (arg.left)
        {
            dialogPanel.css("left", arg.left);
        }
        if (arg.top)
        {
            dialogPanel.css("top", arg.top);
        }



        var dialogTitle = this.Table("_dialog_title", 1, 2).appendTo(dialogPanel);
        if (arg.title_noborder)
        {
            dialogTitle.addClass("noborder");
        }
        arg.panel = dialogPanel;
        arg.html_panel = dialogPanel[0];
        arg.title_ctrl = dialogTitle;
        dialogTitle.cells[0].addClass("_dialog_text _yh").text(title);
        var dialogClose = $("<span class='_dialog_close_btn'></span>");
        dialogTitle.cells[1].addClass("_dialog_close _yh").append(dialogClose);
        arg.title_text_ctrl = dialogTitle.cells[0];
        dialogClose.click(function () { _Dialog.Close(arg) });

        var dialogContent = $("<div class='_dialog_frame'></div>").appendTo(dialogPanel);

        if (arg.ctrl)
        {
            dialogContent.append(arg.ctrl);
        }
        else if (path)
        {
            if (!arg["id"])
            {
                arg.id = "id" + $.ts();
            }
            else
            {
                arg.id = $.escape(arg.id);
            }

            var dialogIframe = $("<iframe class='_dialog_frame' id='" + arg.id + "' name='" + arg.id + "'><iframe>").appendTo(dialogContent);
            arg.frame = dialogIframe;

            if (path.indexOf("?") == -1)
            {
                path = path + "?";
            }
            else
            {
                path = path + "&";
            }
            path += "_dialog=true&_t=" + $.ts() + "&_dialog_id=" + arg.id;

            if (arg.postData != null)
            {

                var tmpForm = $("#____dialog_form_tmp").empty();
                if (tmpForm.length == 0)
                {
                    tmpForm = $("<form id='____dialog_form_tmp' name='____dialog_form_tmp' method='post' style='display:none;'></form>").appendTo($(document.body));
                }
                dialogIframe.attr("src", "about:blank");

                tmpForm.attr("target", arg.id);
                tmpForm.attr("action", path);

                for (var k in arg.postData)
                {
                    var hideInout = $("<input type='hidden'/>").attr("id", k).attr("name", k).val(arg.postData[k]).appendTo(tmpForm);
                }

                setTimeout(function ()
                {
                    ____dialog_form_tmp.submit();
                    setTimeout(function () { tmpForm.remove(); }, 200);
                }, 100);
            }
            else
            {
                dialogIframe.attr("src", path);
            }

            if (arg.onload)
            {
                setTimeout(function ()
                {
                    var frameWindow = $(arg.frame[0].contentWindow.document);
                    frameWindow.ready(function () { arg.onload(); });
                }, 100);
            }

            arg.reload = function ()
            {
                document.getElementById(arg.frame.attr("id")).contentWindow.document.location.reload(true);
            };
        }
        if (arg.toolbar)
        {
            var dialogToolbar = this.CreateToolbar(arg).appendTo(dialogPanel);
            arg.toolbar_ctrl = dialogToolbar;
            dialogToolbar.css("margin-top", "-" + arg.toolbar_ctrl.outerHeight() + "px");
            dialogContent.css("border-bottom", arg.toolbar_ctrl.outerHeight() + "px solid #fff");
        }
        this.dialogList.push(arg);

        arg.title_ctrl.bindMove({
            ctrl: dialogPanel, check_moveable: function (m)
            {
                //if (m.move_y < -10)
                //{
                //    return false;
                //}
                return true;
            }
        });
        //_Dialog_BindMove(arg);
    }
    this.BuildTool = function (tool, isLast, arg)
    {
        var toolCtrl = $("<span></span>").text(tool.text);
        tool.ctrl = toolCtrl;
        if (tool.id)
        {
            toolCtrl.attr("id", tool.id);
        }
        if (tool.class)
        {
            toolCtrl.addClass(tool.class);
        }
        else
        {
            toolCtrl.addClass("_dialog_tool");
            if (!(toolCtrl.hasClass("tool_blue") || toolCtrl.hasClass("tool_line")))
            {
                if (isLast)
                {
                    toolCtrl.addClass("_dialog_tool tool_blue");
                }
                else
                {
                    toolCtrl.addClass("_dialog_tool tool_line");
                }
            }
        }
        if (tool.css)
        {
            toolCtrl.css(tool.css);
        }
        if (tool.click)
        {
            toolCtrl.click(tool.click);
        }
        else if (tool.onclick)
        {
            var onclick = tool.onclick;
            if (arg && arg.frame)
            {
                onclick = "document.getElementById('" + arg.frame.attr("id") + "').contentWindow." + onclick;
            }
            toolCtrl.attr("onclick", onclick);
        }

        return toolCtrl;
    }
    this.CreateToolbar = function (arg)
    {
        var bar = $("<div class='_dialog_toolbar'></div>");
        if (arg.toolbar.css)
        {
            bar.css(arg.toolbar.css);
        }
        if (arg.toolbar.ctrl)
        {
            bar.append(arg.toolbar.ctrl);
        }
        else if (arg.toolbar.html)
        {
            bar.html(arg.toolbar.html);
        }
        else if (arg.toolbar.tools)
        {
            for (var i = 0; i < arg.toolbar.tools.length; i++)
            {
                var tool = arg.toolbar.tools[i];
                if (!tool)
                {
                    continue;
                }
                if (tool.ctrl)
                {
                    tool.ctrl.appendTo(bar);
                    continue;
                }
                this.BuildTool(tool, i == arg.toolbar.tools.length - 1, arg).appendTo(bar);
            }
        }

        if (typeof (arg.toolbar.created) != "undefined")
        {
            arg.toolbar.created(bar);
        }
        return bar;
    }
    this.WritePosition = function (arg)
    {
        if (typeof (arg.refer) != "undefined")
        {
            var p = arg.panel.position();
            $.cookieKeyValue("dkv", "pst" + arg.refer, p.left + "," + p.top);
        }
    }
    this.ShowDialogIndex = function ()
    {
        for (var i = this.dialogList.length - 1; i >= 0; i--)
        {
            var d = this.dialogList[i];
            if (d.dialog)
            {
                return parseInt(d.dialog_ctrl.css("z-index")) - this.beginIndex;
            }
        }

        return 0;
    }

    this.Close = function (arg, rv)
    {
        if (arg && arg.auto_position)
        {
            this.WritePosition(arg);

        }
        if (typeof (arg.close) != "undefined" && arg.close != null)
        {
            var isClose = arg.close(rv);
            if (isClose === false)
            {
                return;
            }
        }
        if (arg.close_type == "close")
        {
            arg.dialog_ctrl.remove();
            arg.dialog_ctrl = null;
            arg.dialog = false;
            this.dialogList.remove(arg);

            this.Cover(this.ShowDialogIndex());
        }
        else
        {
            arg.dialog = false;
            arg.dialog_ctrl.hide();
            //var hasDialog = false;

            this.Cover(this.ShowDialogIndex());
            //for (var i = 0; i < this.dialogList.length; i++)
            //{
            //    var d = this.dialogList[i];
            //    if (d.dialog)
            //    {
            //        this.Cover(i + 1);
            //        hasDialog = true;
            //        break;
            //    }
            //}

            //if (!hasDialog)
            //{
            //    this.Cover(0);
            //}
        }

    }

    this.Cover = function (zIndex)
    {
        var dc = $("#_dialog_cover").show();

        if (zIndex == 0)
        {
            dc.hide();
            return;
        }
        if (dc.length == 0)
        {
            dc = $("<div id='_dialog_cover' class='_opacity'></div>").appendTo($(document.body));
        }
        dc.css("z-index", this.beginIndex + zIndex);
    }

}

var __DialogProvider = null;

function _FindDialog(dialogId)
{
    if (dialogId)
    {
        if (typeof (top._Dialog) != "undefined")
        {
            d = top._Dialog.Find(dialogId);
            if (d != null)
            {
                top._Dialog.Remove(d);
                return d;
            }
        }
        if (typeof (parent._Dialog) != "undefined")
        {
            d = parent._Dialog.Find(dialogId);
            if (d != null)
            {
                parent._Dialog.Remove(d);
                return d;
            }
        }
        else
        {
            var d = _Dialog.Find(dialogId);
            _Dialog.Remove(d);
            return d;
        }

    }

    return null;
}

function _DialogProvider(dialogId)
{

    var d = {};
    if (typeof (top._Dialog) != "undefined")
    {
        d = top._Dialog;
    }
    else if (typeof (parent._Dialog) != "undefined")
    {
        d = parent._Dialog;
    }
    else
    {
        d = _Dialog;
    }


    return d;
}

function dialogClose(rv, provider)
{
    if (typeof (provider) == "undefined")
    {
        provider = _DialogProvider();
    }
    provider.Close(provider.Current(), rv);
}

function dialog(arg)
{
    provider = null;
    if (arg.provider)
    {
        provider = arg.provider;
    }
    else
    {
        provider = _DialogProvider();
    }

    provider.Show(arg);
}

var _BindShiftCheckCurrentCbx;
var _BindShiftCheckShiftKey = false;

function CbxBindShiftSelectStart(e)
{
    if (_BindShiftCheckCurrentCbx != null && _BindShiftCheckShiftKey)
    {
        return false;
    }
    return true;
}

function CbxBindShiftCheck(name)
{
    var f = function (JCbxs, cbx, idx)
    {
        var jCbx = $(cbx);
        var id = jCbx.attr("id");
        jCbx.label = null;
        jCbx.idx = idx;
        jCbx.parent().bind("selectstart", CbxBindShiftSelectStart)
        if (id.length > 0)
        {
            var label = $("label[for='" + id + "']");
            jCbx.label = label;
        }

        jCbx.click(function (e)
        {
            if (e.shiftKey)
            {
                if (e.altKey)
                {
                    if (e.ctrlKey)
                    {
                        for (var i = 0; i < JCbxs.length; i++)
                        {
                            JCbxs[i].prop("checked", false);
                        }
                    }
                    else
                    {
                        for (var i = 0; i < JCbxs.length; i++)
                        {
                            JCbxs[i].prop("checked", true);
                        }
                    }
                    return;
                }
                if (_BindShiftCheckCurrentCbx != null && _BindShiftCheckCurrentCbx != jCbx && _BindShiftCheckCurrentCbx.attr("name") == name)
                {
                    try
                    {
                        var preIndex = _BindShiftCheckCurrentCbx.idx;
                        var thisIndex = jCbx.idx;

                        if (preIndex > thisIndex)
                        {
                            for (var i = thisIndex; i < preIndex; i++)
                            {
                                JCbxs[i].prop("checked", true);
                            }
                            if (!e.ctrlKey)
                            {
                                for (var i = 0; i < thisIndex; i++)
                                {
                                    JCbxs[i].prop("checked", false);
                                }
                                for (var i = preIndex + 1; i < JCbxs.length; i++)
                                {
                                    JCbxs[i].prop("checked", false);
                                }
                            }
                        }
                        else
                        {
                            for (var i = preIndex; i < thisIndex; i++)
                            {
                                JCbxs[i].prop("checked", true);
                            }

                            if (!e.ctrlKey)
                            {
                                for (var i = 0; i < preIndex; i++)
                                {
                                    JCbxs[i].prop("checked", false);
                                }
                                for (var i = thisIndex + 1; i < JCbxs.length; i++)
                                {
                                    JCbxs[i].prop("checked", false);
                                }
                            }
                        }
                    }
                    catch (ex)
                    {
                        console.log(ex);
                    }
                }
            }
            else
            {
                var _title = "按住shift键可以实现批量选取功能，同时按住ctrl键可以重复批量选取";
                if (_BindShiftCheckCurrentCbx && _BindShiftCheckCurrentCbx.label)
                {
                    _BindShiftCheckCurrentCbx.label.removeClass("checked");
                    var title = _BindShiftCheckCurrentCbx.label.attr("title");
                    if (title == _title)
                    {
                        _BindShiftCheckCurrentCbx.label.attr("title", "");
                    }
                }


                _BindShiftCheckCurrentCbx = jCbx;

                if (_BindShiftCheckCurrentCbx.label)
                {
                    _BindShiftCheckCurrentCbx.label.addClass("checked");
                    var title = _BindShiftCheckCurrentCbx.label.attr("title");
                    if (!title)
                    {
                        _BindShiftCheckCurrentCbx.label.attr("title", _title);
                    }
                }

            }
        });

        return jCbx;
    };

    var cbxs = $(":checkbox[name='" + name + "']:enabled");
    var JCbxs = [];

    for (var i = 0; i < cbxs.length; i++)
    {
        var cbx = cbxs[i];
        JCbxs.push(f(JCbxs, cbx, i));
    }
}

function BindShiftCheckInit()
{
    $(document.body).keydown(function (e)
    {
        if (e.ctrlKey || e.shiftKey)
        {
            _BindShiftCheckShiftKey = true;
        }
    }).keyup(function ()
    {
        _BindShiftCheckShiftKey = false;
    });

    $(window).blur(function ()
    {
        _BindShiftCheckShiftKey = false;
    });

}

$(document).ready(function ()
{
    $.bindDatepicker();
    $.bindNumeric();
    $.bindInt();
    $(".popup").bindPopup();
    $(document.body).click(function (e) { $.cmHide(e) });
    $(document.body).contextmenu(function (e) { $.cmHide(e) });
    $(window).resize(function () { $.cmHide(null) });
    BindShiftCheckInit();
    setTimeout(function ()
    {
        $("input.blank,textarea.blank").bindBlank();
    }, 100);
});


function _ACX(className, method, callback)
{
    var oPostArg = new Array();
    if (arguments.length > 3)
    {
        for (var iAa1 = 3; iAa1 < arguments.length; iAa1++)
        {
            oPostArg.push(arguments[iAa1]);
        }
    }

    var classNames = className.split(".");

    var path = "/" + classNames[1] + "/" + classNames[2] + "/xcode.aspx";

    _ACU(path, "Call", callback, className, method, $.toJSON(oPostArg));

}