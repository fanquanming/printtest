/**
 * 颜色选择器
 */
/************************ 参数介绍 ***************************/
// defaultColor: (string)默认颜色
// customColor: (array)自定义颜色
// format: (array)标准色
// type:1.color=字体颜色，
//      2.background=背景颜色

; (function ($) {
    $.fn.clColor = function (options) {
        var defaults = {
            defaultColor: '#000000',
            type:'color',
            title:''
        };
        defaults.customColor = [
            '#ffffff', '#000000', '#eeece1', '#1f497d', '#4f81bd',
            '#c0504d', '#9bbb59', '#8064a2', '#4bacc6', '#f79646',
            '#f2f2f2', '#808080', '#ddd9c3', '#c6d9f1', '#dce6f2',
            '#f2dcdb', '#ebf1de', '#e6e0ec', '#dbeef4', '#fdeada',
            '#d9d9d9', '#595959', '#c4bd97', '#8eb4e3', '#b9cde5',
            '#e6b9b8', '#d7e4bd', '#ccc1da', '#b7dee8', '#fcd5b5',
            '#bfbfbf', '#404040', '#948a54', '#558ed5', '#95b3d7',
            '#d99694', '#c3d69b', '#b3a2c7', '#93cddd', '#fac090',
            '#a6a6a6', '#262626', '#4a452a', '#17375e', '#376092',
            '#953735', '#77933c', '#604a7b', '#31859c', '#e46c0a',
            '#7f7f7f', '#0d0d0d', '#1e1c11', '#10243f', '#254061',
            '#632523', '#4f6228', '#403152', '#215968', '#984807'
        ];
        defaults.formatColor = [
            '#c00000', '#ff0000', '#ffc000', '#ffff00', '#92d050',
            '#00b050', '#00b0f0', '#0070c0', '#002060', '#7030a0'
        ];

        var settings = $.extend(defaults, options);

        var clColor = this;

        var event = function () {
            clColor.hover(
                function () {
                    clColor.addClass("jst_clColor-hover");
                    self.arrorCtrl.addClass("arrow-hover");
                },
                function () {
                    clColor.removeClass("jst_clColor-hover");
                    self.arrorCtrl.removeClass("arrow-hover");
                }
            );

            self.currentCtrl.click(function () {
                if (settings.click) {
                    var color = self.bgColor.attr('data-color');
                    settings.click(color);
                }
            });

            self.arrorCtrl.click(function () {
                $(".clColor").hide();
                self.containerDiv.show();
            });

            self.defaultDiv.click(function () {
                selectColor(this);
            });

            self.customDiv.find('.aCol').click(function () {
                selectColor(this);
            });

            self.formatDiv.find('.aCol').click(function () {
                selectColor(this);
            });

            $(document).click(function (e) {
                var elem = e.target;
                while (elem) {
                    if (elem.nodeName == "#document") {
                        break;
                    }
                    if (elem.className == undefined) {
                        continue;
                    }
                    if (elem.className.indexOf("jst_clColor") > -1 || elem.className.indexOf("clColor") > -1) {
                        return;
                    }
                    elem = elem.parentNode;
                }
                $(clColor).find(".clColor").hide();
            });
        }

        var selectColor = function (target) {
            self.containerDiv.hide();
            var color = $(target).attr('data-color');
            self.bgColor.css({ 'background-color': color }).attr('data-color', color);
            if (settings.click) {
                settings.click(color)
            }
        }

        var self = new function () {
            this.currentCtrl = $('<span class="current-color" title="' + settings.title + '"></span>');
            this.bgIcon = $('<span class="clIcon"></span>');
            this.bgColor = $('<span class="bg-color"></span>');
            this.arrorCtrl = $('<span class="arrow"></span>');
            this.containerDiv = $('<div class="clColor" style="display: none"></div>');
            this.defaultDiv = $('<div class="clColor-default"></div>');
            this.customDiv = $('<div class="clColor-custom"></div>');
            this.formatDiv = $('<div class="clColor-format"></div>');

            this.bgColor.attr('data-color', settings.defaultColor).css("background-color", settings.defaultColor);

            if (settings.type == "color") {
                this.bgIcon.addClass("cl-color");
            }
            else if (settings.type == "background") {
                this.bgIcon.addClass("cl-background");
                defaults.customColor[0] = "transparent";
            }

            this.currentCtrl.append(this.bgIcon, this.bgColor);

            clColor.addClass('jst_clColor').append(this.currentCtrl, this.arrorCtrl);

            this.containerDiv.css('top', this.currentCtrl.outerHeight());

            this.defaultDiv.attr('data-color', settings.defaultColor);

            this.defaultDiv.append('<span class="aCol" style="background-color: ' + settings.defaultColor + '"></span>&nbsp;&nbsp;自动');

            var liHtml = '';

            $.each(settings.customColor, function (i, e) {
                liHtml += '<li class="aCol" data-color="' + e + '" style="background-color: ' + e + '"></li>';
            });

            this.customDiv.append('<div class="title">主题颜色</div><ul>' + liHtml + '</ul>');

            liHtml = '';

            $.each(settings.formatColor, function (i, e) {
                liHtml += '<li class="aCol" data-color="' + e + '" style="background-color: ' + e + '"></li>';
            });

            this.customDiv.append('<div class="title">标准色</div><ul>' + liHtml + '</ul>');

            this.containerDiv.append(this.defaultDiv, this.customDiv, this.formatDiv);

            clColor.append(this.containerDiv);
        }

        event();
    };
})(jQuery);