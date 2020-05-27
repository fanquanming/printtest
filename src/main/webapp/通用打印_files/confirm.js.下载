//var _Confirm_Next = null;
function _Confirm(sText,fConfirm)
{
    var cfmObj = {};
    //_Confirm_Next = fConfirm;
    if (typeof (sText) === "string")
    {
        cfmObj.text = sText;
        cfmObj.title = "请确认 ? ";
        cfmObj.callback = fConfirm;
    }
    else
    {
        cfmObj = sText;
    }
    if (!cfmObj.title)
    {
        cfmObj.title = "请确认 ? ";
    }
    var oDiv = $("#confirm_top");// document.getElementById("confirm_top");
    var oText = $("#confirm_text").css("max-height", ($(document.body).outerHeight() - 100) + "px").text(cfmObj.text)
	//oText.innerText = sText;
    $("#confirm_title").text(cfmObj.title);

    sText = $(oText).html();// oText.innerHTML;
	if (sText.indexOf("@") != 0)
	{
	    sText = sText.replace(/\n/ig, "<br/>");
	    sText = sText.replace(/`/g, "<br/>");
	}
 	$(oText).html(sText);
	//oText.innerHTML = sText;
 	$(oDiv).show();
 	
 	
 	$("#confirm_confirm").unbind().focus().one("click", function () { _ConfirmHide(); cfmObj.callback(true); });
 	$("#confirm_close").unbind().one("click", function () { _ConfirmHide(); cfmObj.callback(false); });
 }

//function _Confirmed(isOk)
//{
//	var isNext = _Confirm_Next(isOk);
//	if (!(isNext == false))
//	{
//	    _ConfirmHide();
//	}
//}


 
 
function _ConfirmHide()
{
    $("#confirm_top").hide();
 }
