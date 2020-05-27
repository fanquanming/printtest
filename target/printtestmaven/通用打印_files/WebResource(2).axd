/*! jQuery UI - v1.9.2 - 2014-02-23
* http://jqueryui.com
* Includes: jquery.ui.core.css, jquery.ui.datepicker.css, jquery.ui.theme.css
 * Copyright 2014 jQuery Foundation and other contributors; Licensed MIT */

/* Layout helpers
----------------------------------*/
.ui-helper-hidden
{
    display: none;
}

.ui-helper-hidden-accessible
{
    border: 0;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
}

.ui-helper-reset
{
    margin: 0;
    padding: 0;
    border: 0;
    outline: 0;
    line-height: 1.3;
    text-decoration: none;
    font-size: 100%;
    list-style: none;
}

.ui-helper-clearfix:before, .ui-helper-clearfix:after
{
    content: "";
    display: table;
}

.ui-helper-clearfix:after
{
    clear: both;
}

.ui-helper-clearfix
{
    zoom: 1;
}

.ui-helper-zfix
{
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: absolute;
    opacity: 0;
    filter: Alpha(Opacity=0);
}


/* Interaction Cues
----------------------------------*/
.ui-state-disabled
{
    cursor: default !important;
}


/* Icons
----------------------------------*/

/* states and images */
.ui-icon
{
    display: block;
    overflow: hidden;
    background-repeat: no-repeat;
}


/* Misc visuals
----------------------------------*/

/* Overlays */
.ui-widget-overlay
{
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.fixed
{
    table-layout: fixed;
}

.ui-datepicker
{
    width: 17em;
    padding: .2em .2em 0;
    display: none;
}

    .ui-datepicker .ui-datepicker-header
    {
        position: relative;
        padding-bottom: .2em;
    }

    .ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next
    {
        position: absolute;
        top: 0.2em;
        width: 1.8em;
        height: 1.8em;
    }

    .ui-datepicker .ui-datepicker-prev-hover, .ui-datepicker .ui-datepicker-next-hover
    {
        top: 0.2em;
    }

    .ui-datepicker .ui-datepicker-prev
    {
        left: 2px;
    }

    .ui-datepicker .ui-datepicker-next
    {
        right: 2px;
    }

    .ui-datepicker .ui-datepicker-prev-hover
    {
        left: 2px;
    }

    .ui-datepicker .ui-datepicker-next-hover
    {
        right: 2px;
    }

    .ui-datepicker .ui-datepicker-prev span, .ui-datepicker .ui-datepicker-next span
    {
        display: block;
        position: absolute;
        left: 50%;
        margin-left: -8px;
        top: 50%;
        margin-top: -8px;
    }

    .ui-datepicker .ui-datepicker-title
    {
        margin: 0 2.3em;
        line-height: 1.8em;
        text-align: center;
    }

        .ui-datepicker .ui-datepicker-title select
        {
            font-size: 1em;
            margin: 1px 0;
        }

    .ui-datepicker select.ui-datepicker-month-year
    {
        width: 100%;
    }

    .ui-datepicker select.ui-datepicker-month,
    .ui-datepicker select.ui-datepicker-year
    {
        width: 5.4em;
        margin-left: 0.1em;
    }

    .ui-datepicker table
    {
        width: 100%;
        font-size: .9em;
        border-collapse: collapse;
        margin: 0 0 .4em;
    }

.ui-datepicker-input
{
    background-color: #f3f3f3;
    width: 26px;
    text-align: center;
    border: none;
    margin-left: 2px;
    margin-right: 2px;
    font-family: Verdana;
}

.ui-datepicker th
{
    padding: .7em .3em;
    text-align: center;
    font-weight: bold;
    border: 0;
}

.ui-datepicker-week-end, a.ui-datepicker-week-end.ui-state-default
{
}

.ui-datepicker td
{
    border: 0;
    padding: 1px;
}

    .ui-datepicker td span, .ui-datepicker td a
    {
        display: block;
        padding: .3em;
        text-align: right;
        text-decoration: none;
    }

.ui-datepicker .ui-datepicker-buttonpane
{
    background-image: none;
    margin: .7em 0 0 0;
    padding: 0 .2em;
    border-left: 0;
    border-right: 0;
    border-bottom: 0;
}

    .ui-datepicker .ui-datepicker-buttonpane button
    {
        float: right;
        margin: .5em .2em .4em;
        cursor: pointer;
        padding: .2em .6em .3em .6em;
        width: auto;
        overflow: visible;
    }

        .ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current
        {
            float: left;
        }

/* with multiple calendars */
.ui-datepicker.ui-datepicker-multi
{
    width: auto;
}

.ui-datepicker-multi .ui-datepicker-group
{
    float: left;
}

    .ui-datepicker-multi .ui-datepicker-group table
    {
        width: 95%;
        margin: 0 auto .4em;
    }

.ui-datepicker-multi-2 .ui-datepicker-group
{
    width: 50%;
}

.ui-datepicker-multi-3 .ui-datepicker-group
{
    width: 33.3%;
}

.ui-datepicker-multi-4 .ui-datepicker-group
{
    width: 25%;
}

.ui-datepicker-multi .ui-datepicker-group-last .ui-datepicker-header
{
    border-left-width: 0;
}

.ui-datepicker-multi .ui-datepicker-group-middle .ui-datepicker-header
{
    border-left-width: 0;
}

.ui-datepicker-multi .ui-datepicker-buttonpane
{
    clear: left;
}

.ui-datepicker-row-break
{
    clear: both;
    width: 100%;
    font-size: 0em;
}

.ui-pre
{
    background-image: url(WebResource.axd?d=ggU1IiwwhPoKnmTrYE6fJlau8z9YM_M4L_7zoCWc1W4IZqbApWDwMv3C6RijSsy3--pxgHDJZ9fVmniZVxuMc4M-LY3fORrMMa60h3MM82Oe9Zkb0&t=637247910300000000);
}

.ui-next
{
    background-image: url(WebResource.axd?d=-eDGmLcoxGMb7EoDOByfWwkubgdCusmBS3pMKQ891VzjF35moTmifdF-VMg0jrfBuRoCjnIB5EjWgPuTfDtFsi8S6q_6-LCXA_-SWKx-F-5o2zE00&t=637247910300000000);
}

.ui-pre, .ui-next
{
    cursor: pointer;
    background-repeat: no-repeat;
}

.webdings
{
    font-family: Webdings;
    border: none;
    cursor: pointer;
}
/* RTL support */
.ui-datepicker-rtl
{
    direction: rtl;
}

    .ui-datepicker-rtl .ui-datepicker-prev
    {
        right: 2px;
        left: auto;
    }



    .ui-datepicker-rtl .ui-datepicker-next
    {
        left: 2px;
        right: auto;
    }

    .ui-datepicker-rtl .ui-datepicker-prev:hover
    {
        right: 1px;
        left: auto;
    }

    .ui-datepicker-rtl .ui-datepicker-next:hover
    {
        left: 1px;
        right: auto;
    }

    .ui-datepicker-rtl .ui-datepicker-buttonpane
    {
        clear: right;
    }

        .ui-datepicker-rtl .ui-datepicker-buttonpane button
        {
            float: left;
        }

            .ui-datepicker-rtl .ui-datepicker-buttonpane button.ui-datepicker-current
            {
                float: right;
            }

    .ui-datepicker-rtl .ui-datepicker-group
    {
        float: right;
    }

    .ui-datepicker-rtl .ui-datepicker-group-last .ui-datepicker-header
    {
        border-right-width: 0;
        border-left-width: 1px;
    }

    .ui-datepicker-rtl .ui-datepicker-group-middle .ui-datepicker-header
    {
        border-right-width: 0;
        border-left-width: 1px;
    }

/* IE6 IFRAME FIX (taken from datepicker 1.5.3 */
.ui-datepicker-cover
{
    position: absolute; /*must have*/
    z-index: -1; /*must have*/
    filter: mask(); /*must have*/
    top: -4px; /*must have*/
    left: -4px; /*must have*/
    width: 200px; /*must have*/
    height: 200px; /*must have*/
}
/* Component containers
----------------------------------*/
.ui-widget
{
    /*font-family: Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;*/
    font-size: 1.1em;
}

    .ui-widget .ui-widget
    {
        font-size: 1em;
    }

    .ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button
    {
        /*font-family: Trebuchet MS,Tahoma,Verdana,Arial,sans-serif;*/
        font-size: 1em;
    }

.ui-widget-content
{
    border: 1px solid #0094ff;
    background: #ffffff;
    color: #333333;
}

    .ui-widget-content a
    {
        color: #333333;
    }

.ui-widget-header
{
    border: 0px solid #cccccc;
    background: #fcfcfc;
    color: #ffffff;
    font-weight: bold;
}

    .ui-widget-header a
    {
        color: #ffffff;
    }

    /* Interaction states
----------------------------------*/
    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default
    {
        /*border: 1px solid #fcfcfc;*/
        background: #fcfcfc;
        font-weight: bold;
        color: #00a8ec;
    }

        .ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited
        {
            color: #1c94c4;
            text-decoration: none;
        }

    .ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover, .ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus
    {
        /*border: 1px solid #fdf5ce;*/
        background: #d3ecff;
        font-weight: bold;
        /*color: #c77405;*/
    }

        .ui-state-hover a, .ui-state-hover a:hover, .ui-state-hover a:link, .ui-state-hover a:visited
        {
            /*color: #c77405;*/
            text-decoration: none;
        }

    .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active
    {
        /*border: 1px solid #fbd850;*/
        background: #88cdff;
        font-weight: bold;
        color: #fff;
    }

        .ui-state-active a, .ui-state-active a:link, .ui-state-active a:visited
        {
            color: #fff;
            text-decoration: none;
        }

    /* Interaction Cues
----------------------------------*/
    .ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight
    {
        /*border: 1px solid #fed22f;*/
        background: #0094ff;
        color: #fff;
    }

        .ui-state-highlight a, .ui-widget-content .ui-state-highlight a, .ui-widget-header .ui-state-highlight a
        {
            color: #fff;
        }

    .ui-state-error, .ui-widget-content .ui-state-error, .ui-widget-header .ui-state-error
    {
        border: 1px solid #cd0a0a;
        background: #b81900;
        color: #ffffff;
    }

        .ui-state-error a, .ui-widget-content .ui-state-error a, .ui-widget-header .ui-state-error a
        {
            color: #ffffff;
        }

    .ui-state-error-text, .ui-widget-content .ui-state-error-text, .ui-widget-header .ui-state-error-text
    {
        color: #ffffff;
    }

    .ui-priority-primary, .ui-widget-content .ui-priority-primary, .ui-widget-header .ui-priority-primary
    {
        font-weight: bold;
    }

    .ui-priority-secondary, .ui-widget-content .ui-priority-secondary, .ui-widget-header .ui-priority-secondary
    {
        opacity: .7;
        filter: Alpha(Opacity=70);
        font-weight: normal;
    }

    .ui-state-disabled, .ui-widget-content .ui-state-disabled, .ui-widget-header .ui-state-disabled
    {
        opacity: .35;
        filter: Alpha(Opacity=35);
        background-image: none;
    }

        .ui-state-disabled .ui-icon
        {
            filter: Alpha(Opacity=35);
        }
/* For IE8 - See #6059 */

div.wait
{
    top: 0;
    left: 0;
    filter: alpha(opacity=60);
    opacity: 0.6;
    background-color: #fff;
    height: 100%;
    width: 100%;
    position: absolute;
    z-index: 60;
    background-image: url("WebResource.axd?d=gsE8KlPUdRIiIyEir8KnB27IqKy5FHR7GZ8LRtxeRsoqyBEhz4TiGRlZ-HZTcTnWb7TpwuoOSAUpbK1_1wJk2ks1lL6d33LyWmB-pvehGYjRpLAC0&t=637247910300000000");
    background-position: center center;
    background-repeat: no-repeat;
}

.help_bg
{
    background-position: left center;
    background-repeat: no-repeat;
    background-image: url("WebResource.axd?d=cqSBk9SBJu0l0AbQk07fLJYtQtkg3vCTyJG-SHLI3dWyrph2H5eFNIlueHIZ0aPG2yfQM2GYdMY1d0mTnIQXexv3VUZFnYkvLAwuig2&t=637247910300000000");
    padding-left: 12px !important;
}

.ui-icon
{
    width: 16px;
    height: 16px;
    color: #333333;
}




.ui-widget-overlay
{
    background: #666666;
    opacity: .5;
    filter: Alpha(Opacity=50);
}

.ui-widget-shadow
{
    margin: -5px 0 0 -5px;
    padding: 5px;
    background: #000000;
    opacity: .2;
    filter: Alpha(Opacity=20);
    -moz-border-radius: 2px;
    -khtml-border-radius: 2px;
    -webkit-border-radius: 2px;
    border-radius: 2px;
}

.blank_text
{
    color: #c3c3c3;
    font-style: italic;
    font-family: 'Microsoft YaHei';
    position: absolute;
    padding-left: 2px;
}

.must, .must:hover, .must:focus, .must:disabled, .must:read-only
{
    background-image: url("WebResource.axd?d=RMTVZMSk57SRExP8IlTGZESMc4gOtBl5n01HG3MrMAnVFvd-zkINXkljd5MInYfAYGheBRhDROnp1VjZ27UyAxMl6bhMtD6IaJFZtrEEedA9h54o0&t=637247910300000000");
    background-position: right center;
    background-repeat: no-repeat;
    padding-right: 8px;
}

.must_pop
{
    position: absolute;
    border: 1px solid #ff0000;
    /*border-radius:0.5em;*/
    z-index: 99;
    overflow: hidden;
}

.must_text
{
    position: absolute;
    overflow: hidden;
    color: #ff0000;
    width: 100%;
    height: 100%;
    font-family: 'Microsoft YaHei';
    vertical-align: middle;
    text-align: right;
    padding-right: 14px;
    font-style: italic;
}

.opacity_bg
{
    position: absolute;
    filter: alpha(opacity=90);
    opacity: 0.9;
    width: 100%;
    height: 100%;
    background-color: #fef8c1;
}


select.must
{
    padding-right: 0px;
    background-image: none;
}

.must_prompt
{
    background-image: url("WebResource.axd?d=4JOMfAZx01IeCp1pMBYIYp9u7ocivoIb9cPy2igrr2I-iyCPLF6R_cbTBn_DGKYb4KI4jhbDoNA36I0kmflwgO8j8964Ggrp58AWVPCUYmc1t_JF0&t=637247910300000000");
    background-position: left center;
    background-repeat: no-repeat;
}

select.must_prompt
{
    background-image: none;
    color: #ff0000;
}


#_cm
{
    /*border: 1px solid #c3c3c3;
    border-top: 1px solid #0094ff;*/
    padding-top: 2px;
    padding-bottom: 2px;
    border-radius: 2px;
    position: absolute;
    background-color: #fff;
    z-index: 900;
    /*box-shadow: 0 0px 8px 0px #ccc,0 0px 8px 0px #ccc;*/
}

._cmi1, ._cmi1:hover, ._cmi2, ._cmi2:hover, ._cmi3, ._cmi3:hover, ._cmi_disabled, #_cm_head
{
    padding-left: 34px;
    padding-right: 6px;
    background-position: 8px center;
    background-repeat: no-repeat;
}

    ._cmi1, ._cmi1:hover, ._cmi_disabled, ._cmi2, ._cmi2:hover, ._cmi3, ._cmi3:hover
    {
        height: 26px;
        line-height: 25px;
    }

        ._cmi1, ._cmi1:hover, ._cmi2, ._cmi2:hover, ._cmi3, ._cmi3:hover
        {
            cursor: pointer;
        }

._cmi_space
{
    height: 3px;
    overflow: hidden;
    /*margin-bottom:35px;*/
}

#_cm_head
{
    height: 30px;
    line-height: 28px;
    background-color: #0094ff;
    color: #fff;
    /*float:left;
        display:block;

    border-radius:0px 0px 4px 4px;*/
    width: auto;
    margin-top: -2px;
    padding-left: 34px;
    /*border-radius: 3px 3px 0px 0px;*/
    /*margin-left:34px;*/
    /*padding-right:10px;*/
    /*border-bottom: 1px dotted #ccc;
    height: 27px;
    line-height: 24px;
    color: #333;
    margin-top: -2px;
    
    background-color: #fcfcfc;*/
}

._cmi_disabled
{
    cursor: default;
    color: #000;
    filter: gray;
    opacity: 0.3;
    filter: alpha(opacity=30);
    -webkit-filter: grayscale(100%);
    -moz-filter: grayscale(100%);
    -o-filter: grayscale(100%);
    filter: grayscale(100%);
}

._cmi_show
{
}

._cmi1, ._cmi2, ._cmi2
{
    color: #333;
    background-color: #fff;
    /*border: 1px solid #fff;*/
}

    ._cmi1:hover
    {
        color: #fff;
        background-color: #0094ff;
        /*border: 1px solid #0094ff;*/
    }

    ._cmi2:hover
    {
        color: #fff;
        background-color: #08c621;
        /*border: 1px solid #08c621;*/
    }

._cmi3:hover
{
    color: #fff;
    background-color: #333;
    /*border: 1px solid #333;*/
}

._cmi_spt
{
    border-top: 4px solid #fff;
    border-bottom: 4px solid #fff;
    background-color: #efefef;
    height: 9px;
}

._db, ._db:hover, ._db_disabled
{
    display: inline-block;
    height: 30px;
    position: relative;
    font-size: 12px;
    line-height: 29px;
    padding-left: 8px;
    padding-right: 17px;
    background-repeat: no-repeat;
    background-image: url("WebResource.axd?d=xpy1N3GkgpTu6GaQE-JuSleeHT0Gc_v0bo55V0AOcs1v5J624hZzFa_DKAGkqFLNT0T_BlfZV9wqhViNNhuItIKQx0AVSru2ezu2SHokDqfsNE-J0&t=637247910300000000");
    text-align: left;
    border-radius: 2px 2px 0px 0px;
}

span._db._db_iconshow, span._db._db_iconshow:hover
{
    background-image: none;
    padding-right: 0px;
    background-color: inherit;
    color: inherit;
}


    span._db._db_iconshow > ._db_txt._db_pic:hover
    {
        background-color: #d4e5f5;
        color: #00a8ec;
    }

._db_disabled > ._db_items
{
    display: none !important;
}

._db > ._db_items, ._db_arrow > ._db_items
{
    display: none;
}

._db:hover > div._db_items, ._db_arrow:hover > div._db_items
{
    display: block;
}

._db_arrow:hover > ._db_items
{
    margin: 0px;
    border-radius: 0px 2px 2px 2px;
    margin-top: 29px;
}

._db._db_iconshow > ._db_arrow, ._db._db_iconshow > ._db_arrow:hover
{
    height: 29px;
    display: inline-block;
    float: right;
    width: 14px;
    margin-left: 2px;
    border-left: 1px solid #fff;
    overflow: visible;
    position: relative;
}

._db._db_iconshow > ._db_arrow
{
    background-position: -3px -535px;
}

_db_arrow > ._db_arrow_cover1, _db_arrow > ._db_arrow_cover2
{
    display: none;
}

._db_arrow:hover > ._db_arrow_cover1
{
    display: block;
    position: absolute;
    left: -10px;
    height: 100%;
    margin-top: 3px;
    margin-left: -1px;
    width: 36px;
    top: 0px;
    z-index:61;
 
}

._db_arrow:hover > ._db_arrow_cover2
{
    display: block;
    position: absolute;
    left: 0px;
    height: 20px;
    width: 36px;
    top: 60%;
    transform: rotate(30deg);
}


._db._db_iconshow > ._db_arrow:hover, span._db._db_iconshow:hover > ._db_arrow
{
    background-color: #0094ff;
    background-position: -3px -555px;
}    


    ._db:hover
    {
        background-position: right -135px;
        /*border-right: 1px solid #0094ff;*/
    }

._db, ._db_disabled
{
    background-position: right -35px;
    /*border-right: 1px solid #fff;*/
}

    ._db, ._db:hover
    {
        cursor: pointer;
    }

._db_disabled
{
    color: #333;
    background-color: #f3f3f3;
    opacity: 0.7;
    filter: alpha(opacity=70);
    cursor: default;
    -webkit-filter: grayscale(100%);
    -moz-filter: grayscale(100%);
    -o-filter: grayscale(100%);
    filter: grayscale(100%);
    filter: gray;
}

._db_txt
{
    height: 100%;
    display: inline-block;
}

._db_pic + ._db_txt
{
  
}

._db_pic
{
    padding-left: 28px;
    background-repeat: no-repeat;
    background-position: 8px center;
    margin-left: -8px;
}
._db_arrow
{
    background-repeat: no-repeat;
    background-image: url("WebResource.axd?d=xpy1N3GkgpTu6GaQE-JuSleeHT0Gc_v0bo55V0AOcs1v5J624hZzFa_DKAGkqFLNT0T_BlfZV9wqhViNNhuItIKQx0AVSru2ezu2SHokDqfsNE-J0&t=637247910300000000");
}

._db
{
    color: #00a8ec;
}

    ._db:hover
    {
        background-color: #0094ff;
        color: #fff;
    }

div ._db_items
{
    position: absolute;
    border: 1px solid #0094ff;
    min-height: 26px;
    min-width: 28px;
    border-radius: 2px;
    background-color: #fff;
    margin-left: -8px;
    margin-top: -2px;
    padding-top: 2px;
    padding-bottom: 2px;
    z-index: 50;
    /*box-shadow: 0 0px 13px 0px #c3c3c3;*/
}

._db_spt
{
    border-top: 4px solid #fff;
    border-bottom: 4px solid #fff;
    background-color: #e1e1e1;
    height: 9px;
}

._db_item, ._db_item:hover, ._db_item_disabled
{
    height: 26px;
    line-height: 24px;
    padding-left: 32px;
    white-space: nowrap;
    padding-right: 10px;
}

._db_item_imgbg
{
    background-position: 8px center;
    background-repeat: no-repeat;
    min-width: 20px;
}

._db_item_disabled
{
    color: #999;
}

._db_item
{
    color: #666;
}

    ._db_item:hover
    {
        background-color: #0094ff;
        color: #fff;
    }

._fb
{
    position: absolute;
    background-color: #00a8ec;
    border-radius: 3px;
    padding: 2px;
    top: 100%;
    left: 100%;
    word-break: keep-all;
    white-space: nowrap;
}

._fb_i, ._fb_i:hover
{
    border-radius: 3px;
    padding-left: 4px;
    padding-right: 4px;
    height: 20px;
    margin-right: 2px;
    display: inline-block;
    cursor: pointer;
    background-repeat: no-repeat;
    background-position: 4px center;
}

._title
{
    text-align: left;
    font-size: 115%;
    font-family: 'Segoe UI', Arial, 'Microsoft Yahei', Simsun, sans-serif;
}

._disabled
{
    opacity: 0.3;
    filter: alpha(opacity=30);
    cursor: default;
    -webkit-filter: grayscale(100%);
    -moz-filter: grayscale(100%);
    -o-filter: grayscale(100%);
    filter: grayscale(100%);
    filter: gray;
}

._fb_i
{
    color: #fff;
}

    ._fb_i:hover
    {
        background-color: #0d7bd9;
        color: #fff;
    }

._btn, ._btn:hover
{
    text-align: center;
    padding-left: 6px;
    padding-right: 6px;
    border-radius: 2px;
    border: 1px solid #ccc;
    height: 24px;
    line-height: 21px;
    cursor: pointer;
    display: inline-block;
}

._btn
{
    color: #666;
}

    ._btn:hover
    {
        background-color: #f3f3f3;
        color: #333;
    }

/*._step_arrow, ._step_arrow_pre, ._step_arrow_cur, ._step_arrow_last_pre
{
    background-image: url("WebResource.axd?d=jjnsPREXJFOlYgobSSFRlctbuFWde1a2IHA2v2CVjw4XF0PE_hTcBySlbxQAf6YkTc99R7YrSSCkXL6aZPkE6fK78rF3NV9DospUAggtjlTjQD7S0&t=637247910300000000");
    width: 10px;
}

._step_arrow_pre
{
    background-position: left -86px;
    background-color: #00b034;
}

._step_arrow_last_pre
{
    background-position: left -86px;
    background-color: #0094ff;
}

._step_arrow_cur
{
    background-position: right -6px;
    background-color: #0094ff;
}

._step_arrow
{
    background-position: right -6px;
}*/


._step
{
    background-image: url("WebResource.axd?d=jjnsPREXJFOlYgobSSFRlctbuFWde1a2IHA2v2CVjw4XF0PE_hTcBySlbxQAf6YkTc99R7YrSSCkXL6aZPkE6fK78rF3NV9DospUAggtjlTjQD7S0&t=637247910300000000");
    background-repeat: no-repeat;
    white-space: nowrap;
    padding-left: 10px;
    padding-right: 12px;
    /*width: 20px;*/
    vertical-align: middle;
}

._step_pre, ._step_pre_cur
{
    background-color: #00b034;
    color: #fff;
}

._step_cur, ._step_cur_end
{
    background-color: #0094ff;
    color: #fff;
}

._step_next, ._step_next_end
{
    color: #666;
}

._step_next_end, ._step_cur_end
{
    background-position: right -192px;
}

._step_pre
{
    background-position: right -92px;
}

._step_pre_cur
{
    background-position: right -62px;
}

._step_cur
{
    background-position: right -32px;
}

._step_next
{
    background-position: right -2px;
}



._step_tb
{
    background-color: #efefef;
    height: 27px;
    width: 100%;
}


.table
{
    display: table;
}

.row
{
    display: table-row;
}

.cell
{
    display: table-cell;
    vertical-align: top;
}

    .cell._step
    {
        vertical-align: middle;
    }

._cbb_size
{
    font-size: inherit;
    box-sizing: border-box;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
}

._cbb:read-only
{
    background-color: #f9f9f9;
}

._cbb_p, ._cbb_p:hover
{
    display: inline-block;
    cursor: pointer;
    overflow: visible;
    position: relative;
}

._cbb_p
{
    border: 1px solid #ccc;
}

    ._cbb_p:hover
    {
        border: 1px solid #0094ff;
    }

._cbb, ._cbb_disabled
{
    height: 22px;
    margin: 0px;
    padding-right: 12px;
    background-image: url("WebResource.axd?d=xpy1N3GkgpTu6GaQE-JuSleeHT0Gc_v0bo55V0AOcs1v5J624hZzFa_DKAGkqFLNT0T_BlfZV9wqhViNNhuItIKQx0AVSru2ezu2SHokDqfsNE-J0&t=637247910300000000");
    background-repeat: no-repeat;
    background-position: right -400px;
    padding-left: 4px;
    border: none;
    font-size: 12px;
}

._cbb_items
{
    position: absolute;
    z-index: 5;
    min-height: 24px;
    border: 1px solid #0094ff;
    background-color: #fff;
    overflow-y: auto;
    overflow-x: hidden;
    padding-top: 1px;
    padding-bottom: 1px;
    margin-left: -1px;
}
label.checked
{
    background-color: #ffe48d;
}
._cbb_item, ._cbb_item:hover, ._cbb_check_all
{
    height: 24px;
    cursor: pointer;
    padding-left: 6px;
    font-size: 12px;
    white-space: nowrap;
    display: table-row;
}

._cbb_check_all
{
    background-color: #f3f3f3;
    color: #666;
}

._cbb_cbx_p
{
    display: table-cell;
    width: 25px;
    text-align: center;
    vertical-align: middle;
}

._cbb_label
{
    display: table-cell;
    vertical-align: middle;
    padding-right: 4px;
    color: inherit;
    background-repeat: no-repeat;
    background-position: left center;
}

    ._cbb_label:hover
    {
    }

div._cbb_spt
{
    height: 9px;
    display: table-row;
}

span._cbb_spt
{
    border-top: 4px solid #fff;
    border-bottom: 4px solid #fff;
    background-color: #e1e1e1;
    display: table-cell;
}

._cbb_item
{
    color: #666;
}

    ._cbb_item:hover
    {
        background-color: #0094ff;
        color: #fff;
    }

._cbb_disabled
{
    color: #333333;
    background-color: #f3f3f3;
    opacity: 0.7;
    filter: alpha(opacity=70);
    cursor: default;
    -webkit-filter: grayscale(100%);
    -moz-filter: grayscale(100%);
    -o-filter: grayscale(100%);
    filter: grayscale(100%);
    filter: gray;
}


#_popup_float
{
    border: 1px solid #ccc;
    box-shadow: 0px 0px 20px 0px #aaa;
    background-color: #fffde5;
    border-radius: 3px;
    position: absolute;
    padding: 8px;
    z-index: 40;
    padding-top: 6px;
    overflow: visible;
}

#_popup_bottom, #_popup_top
{
    height: 7px;
    width: 100%;
    left: 0px;
    background-image: url("WebResource.axd?d=_kAaTDxYe3aXWT-u_SmXwr8Sg1K9YtD_5cQ79J9BQOM_GhWaSm1AVaIS1trIfcchdnc5AwzUy1HS_MmRcfpD9byWORoWDpJsM7rtef_DGCXnZmY70&t=637247910300000000");
}

#_popup_left, #_popup_right
{
    height: 100%;
    width: 7px;
    top: 0px;
    background-image: url("WebResource.axd?d=CLPPD325DaV3fRivf5HprayjhdhH2lHwEQzHtt7CzFAcWzPuvq6iBkXuR8g_kzdUXToJ5WY0edjVAenjNoqKmrcDnIpxZNWSCrQ-ryctE1HiPyzK0&t=637247910300000000");
}

#_popup_bottom, #_popup_top, #_popup_left, #_popup_right
{
    position: absolute;
    background-repeat: no-repeat;
}

#_popup_top
{
    top: 100%;
    background-position: center -6px;
}

#_popup_bottom
{
    top: -6px;
    background-position: center -27px;
}

#_popup_right
{
    left: -6px;
    background-position: 0px center;
}

#_popup_left
{
    background-position: -14px center;
    left: 100%;
}

#_popup_text
{
    color: #666;
    line-height: 1.5em;
}


._float_box
{
    -webkit-box-shadow: 0 0px 13px 0px #c3c3c3;
    -moz-box-shadow: 0 0px 13px 0px #c3c3c3;
    box-shadow: 0 0px 13px 0px #c3c3c3 !important;
    border: 1px solid #c3c3c3 !important;
    border-top: 1px solid #0094ff !important;
    border-radius: 3px !important;
}

._shadow
{
    -webkit-box-shadow: 0 0px 13px 0px #ccc;
    -moz-box-shadow: 0 0px 13px 0px #ccc;
    box-shadow: 0 0px 13px 0px #ccc;
}

    ._shadow._dropdown
    {
        box-shadow: 0px 5px 5px #ccc;
    }

._opacity
{
    top: 0;
    left: 0;
    filter: alpha(opacity=15);
    opacity: 0.15;
    background-color: #666;
    height: 100%;
    width: 100%;
    position: absolute;
    z-index: 60;
}


.tabbar_bar.big
{
    padding-left: 10px;
    padding-top: 2px;
    height: 38px;
    background-color: #f3f3f3;
}

.tabbar_bar
{
    background-color: #fff;
    border-bottom: 1px solid #ddd;
    overflow-y: visible;
}

.tabbar_tab.tabbar_skin_btn
{
}

.tabbar_tab.tab_icon, .tabbar_tab.tab_icon:hover, .tabbar_tab.tab_icon.active, .tabbar_tab.tab_icon.active:hover
{
    padding-left: 25px;
    background-repeat: no-repeat;
    background-position: 3px center;
}

    .tabbar_tab.tab_icon.big, .tabbar_tab.tab_icon.big:hover, .tabbar_tab.tab_icon.big.active, .tabbar_tab.tab_icon.big.active:hover
    {
        padding-left: 30px;
        background-repeat: no-repeat;
        background-position: 8px center;
    }

        .tabbar_tab.tab_icon.big.active, .tabbar_tab.tab_icon.big.active:hover
        {
            padding-left: 29px;
        }

.tabbar_tab, .tabbar_spt
{
    float: left;
    display: inline-block;
}

    .tabbar_tab.big, .tabbar_tab.big:hover
    {
        padding: 14px;
        padding-bottom: 0px;
        border: none;
        height: 35px;
        cursor: pointer;
        min-width: 60px;
        text-align: center;
        padding-top: 9px;
        color: #666;
    }

        .tabbar_tab.big:hover
        {
            background-color: #f9f9f9;
            color: #0094ff;
        }

    .tabbar_spt.big
    {
        height: 15px;
        width: 1px;
        /*background-color: #ddd;*/
        border-left: 1px solid #ccc;
        margin-top: 10px;
        /*border-bottom: 10px solid hidden;*/
    }

    .tabbar_spt.active.big
    {
        border-left: none;
    }

.tabbar_spt
{
    height: 10px;
    width: 1px;
    /*background-color: #ddd;*/
    border-left: 1px solid #ccc;
    margin-top: 5px;
    /*border-bottom: 10px solid hidden;*/
}

    .tabbar_spt.active
    {
        border-left: none;
    }



.active.tabbar_tab.big, .active.tabbar_tab.big:hover
{
    padding: 13px;
    border: 1px solid #ddd;
    border-bottom: 1px solid #fff;
    /*border-radius: 2px 2px 0px 0px;*/
    background-color: #fff;
    color: #0094ff;
    border-top: 1px solid #0094ff;
    height: 36px;
    padding-bottom: 0px;
    padding-top: 8px;
    cursor: default;
}


.tabbar_tab, .tabbar_tab:hover
{
    padding: 7px;
    padding-bottom: 0px;
    border: none;
    height: 25px;
    cursor: pointer;
    min-width: 60px;
    text-align: center;
    padding-top: 4px;
    color: #666;
}

    .tabbar_tab:hover
    {
        background-color: #f9f9f9;
        color: #0094ff;
    }

.active.tabbar_tab, .active.tabbar_tab:hover
{
    padding: 6px;
    border: 1px solid #ddd;
    border-bottom: 1px solid #fff;
    /*border-radius: 2px 2px 0px 0px;*/
    background-color: #fff;
    color: #0094ff;
    border-top: 1px solid #0094ff;
    height: 26px;
    padding-bottom: 0px;
    padding-top: 4px;
    cursor: default;
}


._tf_spt._tf_v
{
    height: 16px;
}

._tf_spt._tf_h
{
    width: 10px;
    display: inline-block;
    height: 36px;
}

._tf_item._tf_h, ._tf_spt._tf_h
{
    float: left;
}

._tf, ._tf_frame_list, ._tf_frame
{
    width: 100%;
    height: 100%;
}

._tf_frame
{
    border: none;
    overflow: hidden;
}

._tf_tab_cell, ._tf_tab_frame
{
    vertical-align: top;
}

._tf_tab_cell
{
    background-color: #e9e9e9;
}

    ._tf_tab_cell._tf_v
    {
        width: 36px;
    }

._tf_tab_row._tf_h
{
    height: 36px;
}

._tf_tab_cell._tf_h
{
    height: 36px;
}

._tf_tab_cell._tf_text._tf_v
{
    width: 160px;
}

._tf_item_text._tf_h
{
    display: inline-block;
}

._tf_display, ._tf_display:hover
{
    background-image: url("WebResource.axd?d=xpy1N3GkgpTu6GaQE-JuSleeHT0Gc_v0bo55V0AOcs1v5J624hZzFa_DKAGkqFLNT0T_BlfZV9wqhViNNhuItIKQx0AVSru2ezu2SHokDqfsNE-J0&t=637247910300000000");
}

    ._tf_item, ._tf_item:hover, ._tf_display, ._tf_display:hover
    {
        background-repeat: no-repeat;
    }

        ._tf_display, ._tf_display:hover
        {
            height: 20px;
            width: 100%;
            margin-bottom: 12px;
            cursor: pointer;
        }

._tf_display
{
    background-color: #f7f7f7;
}

    ._tf_display:hover
    {
        background-color: #ddd;
    }

    ._tf_display._tf_text
    {
        background-position: center -486px;
    }

._tf_display
{
    background-position: center -516px;
}



._tf_item_mark
{
    position: absolute;
    left: 7px;
    margin-top: 4px;
    width: 22px;
    height: 22px;
    border-radius: 11px;
    text-align: center;
    background-color: #0094ff;
    color: #fff;
    line-height: 20px;
    padding: 0px;
}

._tf_item
{
    background-color: #f7f7f7;
}


    ._tf_item._tf_text
    {
    }

    ._tf_item._tf_v
    {
        padding-left: 31px;
        height: 32px;
        line-height: 31px;
    }

    ._tf_item._tf_h
    {
        padding-right: 10px;
        padding-left: 10px;
        display: inline-block;
        height: 36px;
        line-height: 36px;
    }

        ._tf_item._tf_h._tf_pic
        {
            padding-left: 28px;
        }

    ._tf_item, ._tf_item:hover, ._tf_item._tf_active, ._tf_item._tf_active:hover
    {
        background-position: 7px center;
        font-size: 12px;
    }

        ._tf_item._tf_active, ._tf_item._tf_active:hover
        {
            background-color: #19bcfa;
            color: #0094ff;
        }

        ._tf_item._tf_text._tf_active, ._tf_item._tf_text._tf_active:hover
        {
            /*padding-right: 12px;
          
            background-color: #fff;
            font-style:italic;
              text-align: right;
            font-family:'Microsoft YaHei';*/
            background-color: #19bcfa;
            color: #fff;
        }

        ._tf_item:hover
        {
            background-color: #fff;
            cursor: pointer;
            color: #0094ff;
        }



/*_dialog*/


#_dialog_cover, table._dialog_ctrl
{
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100%;
}

td._dialog_ctrl
{
    text-align: center;
    vertical-align: middle;
}

._dialog_panel
{
    min-width: 100px;
    min-height: 80px;
    display: inline-block;
    position: relative;
    text-align: left;
    vertical-align: top;
}

    ._dialog_panel._float_box
    {
        background-color: #fff;
        position: absolute;
        width: 100%;
        height: 100%;
    }

table._dialog_title
{
    height: 40px;
    border-bottom: 1px solid #eee;
    z-index: 2;
    position: relative;
    width: 100%;
    text-align: left;
}



    table._dialog_title.noborder
    {
        border-bottom: none;
    }

td._dialog_title
{
    padding-left: 14px;
}

._dialog_text
{
    font-size: 14px;
    padding-bottom: 2px;
}

._yh
{
    font-family: 'Microsoft YaHei';
}

td._dialog_close
{
    text-align: right;
    width: 40px;
    padding-right: 7px;
}

._dialog_close_btn, ._dialog_close_btn:hover
{
    cursor: pointer;
    display: inline-block;
    width: 20px;
    height: 20px;
    background-repeat: no-repeat;
    background-image: url(WebResource.axd?d=eYkYCnDAW8UfSATFrER9FEdc6o7v0lthMF89JC7nKT4sie8GO0ISsnAL5_bY_PjhTVUz45DLnbNrBO8WMEZKhJQmPs5Tnzn1-UM62GnrUCZaKlt_0&t=637247910300000000);
}

._dialog_close_btn
{
    background-position: 0px -20px;
}

    ._dialog_close_btn:hover
    {
        background-position: 0px -40px;
        background-color: #f00;
        border-radius: 2px;
    }

._dialog_tool
{
    margin-left: 4px;
}

._dialog_toolbar
{
    position: absolute;
    width: 100%;
    left: 0px;
    top: 100%;
    z-index: 2;
    text-align: right;
    padding: 12px;
    border-radius: 0px 0px 3px 3px;
}

div._dialog_frame
{
    width: 100%;
    height: 100%;
    border-top: 40px solid #fff;
    top: 0px;
    left: 0px;
    position: absolute;
    border-radius: 3px;
    z-index: 1;
}

iframe._dialog_frame
{
    width: 100%;
    height: 100%;
}



.tool_blue, .tool_line, .tool_blue:hover, .tool_line:hover
{
    text-align: center;
    display: inline-block;
    height: 28px;
    text-decoration: none;
    cursor: pointer;
    border-radius: 2px;
    min-width: 60px;
    padding-left: 20px;
    padding-right: 20px;
    margin-left: 4px;
}

    .tool_blue, .tool_blue:hover
    {
        color: #fff;
        border: none;
        line-height: 27px;
    }

.tool_blue
{
    background-color: #0094ff;
}

    .tool_blue:hover
    {
        background-color: #00a8ec;
    }

.tool_line, .tool_line:hover
{
    color: #666;
    border: 1px solid #ddd;
    line-height: 25px;
}

    .tool_line:hover
    {
        color: #0094ff;
        border: 1px solid #0094ff;
    }

body.drag-tr
{
    cursor: move !important;
}

tr.drag-tr, tr.drag-tr:hover
{
    cursor: move !important;
    background-color: #fff799 !important;
    color: #f00 !important;
    outline: #f00 dotted 1px !important;
}

#bindmovetr_markdiv
{
    position: absolute;
    top: 0px;
    left: 0px;
    height: 20px;
    width: 20px;
    z-index: 990;
    border-radius: 1px;
    cursor:move;
}

    #bindmovetr_markdiv.movetr-up, #bindmovetr_markdiv.movetr-down
    {
        border-left: 1px solid #333;
        border-top: 1px solid #333;
    }

    #bindmovetr_markdiv.movetr-up
    {
        transform: rotate(45deg);
    }

    #bindmovetr_markdiv.movetr-down
    {
        transform: rotate(-135deg);
    }
