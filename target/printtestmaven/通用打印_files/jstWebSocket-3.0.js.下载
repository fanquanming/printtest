/// <reference path="jquery-1.11.0.js" />

function JstWebSocket(protocol, port) {
    if (!(this instanceof JstWebSocket)) {
        return new JstWebSocket(protocol, port);
    }

    if (window.location.protocol == "https:") {
        protocol = typeof (protocol) != "undefined" ? protocol : "wss";
        port = typeof (port) != "undefined" ? port : 54323;
    } else {
        protocol = typeof (protocol) != "undefined" ? protocol : "ws";
        port = typeof (port) != "undefined" ? port : 54322;
    }

    function __receive(ws, msg) {
        var data = null;
        try {
            data = JSON.parse(msg);
        } catch (ex) {
            console.log("received data: ", msg);
            return;
        }

        var err_code = data.err_code;
        if (typeof (err_code) == "number") {
            var err_message = data.err_message;
            console.log(ws.appName + " receive error: ", msg);
            if (typeof (ws.onError) == "function") {
                ws.onError(err_code, err_message);
            } else {
                alert(ws.appName + " receive error: [" + err_code + "] " + err_message);
            }
        } else {
            if (ws.onReceiveds.length > 0) {
                for (var i = 0; i < ws.onReceiveds.length; i++) {
                    ws.onReceiveds[i](data);
                }
            }

            var msgidx = data.index;
            if (typeof (msgidx) != "undefined") {

                var pp = ws.msgData["p" + msgidx];
                if (typeof (pp) != "undefined" && typeof (pp["callback"]) == "function") {
                    try {
                        pp.callback(data, pp["state"], pp["data"]);
                    }
                    catch (ex) {
                        console.log(ws.appName + " callback error:", ex);
                    }
                }
                ws.msgData["p" + msgidx] = null;
            }
            else if (typeof (data.sliceIndex) != "undefined") {
                if (ws.msgSlicesQueue.length > 0) {
                    var sld = ws.msgSlicesQueue.shift();
                    ws.msgSocket.send(sld);
                }
                else {
                    __next(ws);
                    ws.msgTimer = -1;
                }
            }
        }
    }

    function __take(ws) {
        if (!ws.ready) {
            ws.load();
        } else {
            try {
                var pi = null;
                var processingSlice = ws.msgSlicesQueue.length > 0 ? true : false;
                if (!processingSlice) pi = ws.msgQueue.shift();
                if (pi) {
                    //为了更高的兼容性，超过120K个字节需分片，每片20K(一个汉字3个字节)
                    var pp = ws.msgData["p" + pi];
                    pp.data["index"] = pi;

                    var originalData = pp.data;

                    var sliceSize = 20 * 1024;  
                    var clonedData = null;
                    var content = JSON.stringify(originalData.value);
                    var slices = [];

                    for (var i = 0; i < content.length; i += sliceSize) {
                        var remain = content.length - i;
                        if (remain >= sliceSize)
                            slices.push(content.substr(i, sliceSize));
                        else
                            slices.push(content.substr(i, remain));
                    }

                    for (var i = 0; i < slices.length; i++) {
                        clonedData = __clone(originalData);
                        clonedData.current_slice = i + 1;           //当前片号
                        clonedData.total_slices = slices.length;    //当前页的分片数
                        clonedData.subcontent = slices[i];          //重新赋值
                        if (clonedData.hasOwnProperty("value")) {   //删除原值
                            delete clonedData["value"];
                        }

                        var ss = JSON.stringify(clonedData);
                        ws.msgSlicesQueue.push(ss);
                    }

                    var sld = ws.msgSlicesQueue.shift();
                    ws.msgSocket.send(sld);
                }
            } catch (ex) {
                console.log(ws.appName + " take error:", ex);
                if (typeof (ws.onError) == "function") {
                    ws.onError(403, ex.message);
                }
                ws.load();
            }
        }
    }

    function __next(ws) {
        if (ws.msgTimer >= -1) {
            ws.msgTimer = window.setTimeout(__take, 100, ws);
        }
    }

    function __clone(source) {
        var key, value;
        var clone = Object.create(source);

        for (key in source) {
            if (key.toString() == "value") {  //需要忽略的项
                continue;
            }

            if (source.hasOwnProperty(key) === true) {
                value = source[key];
                if (value !== null && typeof value === "object")
                    clone[key] = cloneObject(value);
                else
                    clone[key] = value;
            }
        }

        return clone;
    }

    function __changed(ws, status) {
        if (typeof (ws.onChanged) == "function") {
            ws.onChanged(ws, status);
        }
    }


    if (this.appName == undefined) {
        var ws = JstWebSocket.prototype;
        ws.appName = "Jst.WebSocket";
        ws.msgSocket = null;
        ws.msgData = {};
        ws.index = 0;
        ws.msgQueue = [];
        ws.msgSlicesQueue = [];
        ws.msgTimer = -1;
        ws.locked = false;
        ws.ready = false;
        ws.onLoaded = null;
        ws.onError = null;
        ws.onChanged = null;

        ws.guid = function () {
            function S4() {
                return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
            }
            return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
        };

        ws.onReceiveds = [];
        ws.onReceived = function (f) {
            if (typeof (f) == "function") {
                ws.onReceiveds.push(f);
            }
        };

        ws.onClosed = null;
        ws.getName = function (_window) {
            return (_window || self).name;
        };

        ws.load = function (_changed) {
            var ws = this;

            if (typeof (_changed) == "function") {
                ws.onChanged = _changed;
            }

            if (!ws.locked && !ws.ready && ws.msgTimer >= -1) {
                try {
                    var socket = new WebSocket(protocol + "://localhost:" + port);
                    socket.onopen = function (event) {
                        ws.locked = true;
                        socket.onmessage = function (event) {
                            __receive(ws, event.data);
                        };

						socket.onerror = function (event)
						{
							if (console.error)
							{
								console.error(ws.appName + " is error. ");
							}
							else
							{
								console.log(ws.appName + " is error: ", event);
							}
                            __changed(ws, "ERROR");
                            if (typeof (ws.onError) == "function") {
                                ws.onError(401, event.message);
                            }
                        };

                        socket.onclose = function (event) {
                            //console.log(ws.appName + " is closed: ", event);

                            ws.msgTimer = -1;
                            ws.msgSocket = null;
                            ws.locked = false;
                            ws.ready = false;

                            __changed(ws, "OFFLINE");
                            if (typeof (ws.onClosed) == "function") {
                                ws.onClosed(ws);
                            }
                        };

                        //console.log(ws.appName + " is ready!", event);
                        ws.msgSocket = socket;
                        ws.locked = false;
                        ws.ready = true;

                        __changed(ws, "ONLINE");
                        if (typeof (ws.onLoaded) == "function") {
                            ws.onLoaded(ws);
                        }
                    };
                } catch (ex) {
                    console.log(ws.appName + " load error: ", ex);

                    ws.msgSocket = null;
                    ws.locked = false;
                    ws.ready = false;
                    ws.msgTimer = -1;

                    __changed(ws, "ERROR");
                    if (typeof (ws.onError) == "function") {
                        ws.onError(400, ex.message);
                    }
                }
            }
        };

        ws.send = function (data, callback, state) {
            var ws = this;
            if (!ws.ready) {
                console.log(ws.appName + " no ready.");
                if (typeof (ws.onError) == "function") {
                    ws.onError(402, ws.appName + " no ready.");
                }
                return;
            }

            var index = ++ws.index;
            ws.msgQueue.push(index);
            ws.msgData["p" + index] = { "data": data, "callback": callback, "state": state };

            if (ws.msgTimer == -1) {
                __next(ws);
            }


        };
    }

    $(window).unload(this, function (event) {
        var ws = event.data;
        window.clearTimeout(ws.msgTimer);
        ws.msgTimer = -2;
        if (ws.ready) {
            ws.ready = false;
        }
        ws.locked = false;
        if (ws.msgSocket != null) {
            try {
                ws.msgSocket.close(4000);
                ws.msgSocket = null;
                console.log(ws.appName + " is unload.");
            } catch (ex) {
                console.log(ws.appName + " unload error:", ex);
                if (typeof (ws.onError) == "function") {
                    ws.onError(404, ex.message);
                }
            }
        }
    });
}
