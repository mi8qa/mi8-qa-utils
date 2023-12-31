<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <#--https://cdn.jsdelivr.net/npm/jsondiffpatch/dist/jsondiffpatch.umd.min.js-->
    <script type='text/javascript' charset="utf-8">
        !function (t, e) {
            "object" == typeof exports && "undefined" != typeof module ? e(exports, require("./empty")) : "function" == typeof define && define.amd ? define(["exports", "./empty"], e) : e(t.jsondiffpatch = {}, t.chalk)
        }(this, function (t, e) {
            "use strict";
            e = e && e.hasOwnProperty("default") ? e.default : e;
            var h = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (t) {
                    return typeof t
                } : function (t) {
                    return t && "function" == typeof Symbol && t.constructor === Symbol && t !== Symbol.prototype ? "symbol" : typeof t
                },
                i = function (t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                },
                n = function () {
                    function r(t, e) {
                        for (var n = 0; n < e.length; n++) {
                            var r = e[n];
                            r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                        }
                    }

                    return function (t, e, n) {
                        return e && r(t.prototype, e), n && r(t, n), t
                    }
                }(),
                r = function t(e, n, r) {
                    null === e && (e = Function.prototype);
                    var i = Object.getOwnPropertyDescriptor(e, n);
                    if (void 0 === i) {
                        var o = Object.getPrototypeOf(e);
                        return null === o ? void 0 : t(o, n, r)
                    }
                    if ("value" in i) return i.value;
                    var a = i.get;
                    return void 0 !== a ? a.call(r) : void 0
                },
                o = function (t, e) {
                    if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + typeof e);
                    t.prototype = Object.create(e && e.prototype, {
                        constructor: {
                            value: t,
                            enumerable: !1,
                            writable: !0,
                            configurable: !0
                        }
                    }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e)
                },
                a = function (t, e) {
                    if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
                    return !e || "object" != typeof e && "function" != typeof e ? t : e
                },
                l = function (t, e) {
                    if (Array.isArray(t)) return t;
                    if (Symbol.iterator in Object(t)) return function (t, e) {
                        var n = [],
                            r = !0,
                            i = !1,
                            o = void 0;
                        try {
                            for (var a, s = t[Symbol.iterator](); !(r = (a = s.next()).done) && (n.push(a.value), !e || n.length !== e); r = !0) ;
                        } catch (t) {
                            i = !0, o = t
                        } finally {
                            try {
                                !r && s.return && s.return()
                            } finally {
                                if (i) throw o
                            }
                        }
                        return n
                    }(t, e);
                    throw new TypeError("Invalid attempt to destructure non-iterable instance")
                },
                u = function (t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                },
                s = function () {
                    function e(t) {
                        i(this, e), this.selfOptions = t || {}, this.pipes = {}
                    }

                    return n(e, [{
                        key: "options",
                        value: function (t) {
                            return t && (this.selfOptions = t), this.selfOptions
                        }
                    }, {
                        key: "pipe",
                        value: function (t, e) {
                            var n = e;
                            if ("string" == typeof t) {
                                if (void 0 === n) return this.pipes[t];
                                this.pipes[t] = n
                            }
                            if (t && t.name) {
                                if (n = t, n.processor === this) return n;
                                this.pipes[n.name] = n
                            }
                            return n.processor = this, n
                        }
                    }, {
                        key: "process",
                        value: function (t, e) {
                            var n = t;
                            n.options = this.options();
                            for (var r = e || t.pipe || "default", i = void 0, o = void 0; r;) void 0 !== n.nextAfterChildren && (n.next = n.nextAfterChildren, n.nextAfterChildren = null), "string" == typeof r && (r = this.pipe(r)), r.process(n), i = r, r = null, (o = n) && n.next && (n = n.next, r = o.nextPipe || n.pipe || i);
                            return n.hasResult ? n.result : void 0
                        }
                    }]), e
                }(),
                f = function () {
                    function e(t) {
                        i(this, e), this.name = t, this.filters = []
                    }

                    return n(e, [{
                        key: "process",
                        value: function (t) {
                            if (!this.processor) throw new Error("add this pipe to a processor before using it");
                            for (var e = this.debug, n = this.filters.length, r = t, i = 0; i < n; i++) {
                                var o = this.filters[i];
                                if (e && this.log("filter: " + o.filterName), o(r), "object" === (void 0 === r ? "undefined" : h(r)) && r.exiting) {
                                    r.exiting = !1;
                                    break
                                }
                            }
                            !r.next && this.resultCheck && this.resultCheck(r)
                        }
                    }, {
                        key: "log",
                        value: function (t) {
                            console.log("[jsondiffpatch] " + this.name + " pipe, " + t)
                        }
                    }, {
                        key: "append",
                        value: function () {
                            var t;
                            return (t = this.filters).push.apply(t, arguments), this
                        }
                    }, {
                        key: "prepend",
                        value: function () {
                            var t;
                            return (t = this.filters).unshift.apply(t, arguments), this
                        }
                    }, {
                        key: "indexOf",
                        value: function (t) {
                            if (!t) throw new Error("a filter name is required");
                            for (var e = 0; e < this.filters.length; e++) {
                                if (this.filters[e].filterName === t) return e
                            }
                            throw new Error("filter not found: " + t)
                        }
                    }, {
                        key: "list",
                        value: function () {
                            return this.filters.map(function (t) {
                                return t.filterName
                            })
                        }
                    }, {
                        key: "after",
                        value: function (t) {
                            var e = this.indexOf(t),
                                n = Array.prototype.slice.call(arguments, 1);
                            if (!n.length) throw new Error("a filter is required");
                            return n.unshift(e + 1, 0), Array.prototype.splice.apply(this.filters, n), this
                        }
                    }, {
                        key: "before",
                        value: function (t) {
                            var e = this.indexOf(t),
                                n = Array.prototype.slice.call(arguments, 1);
                            if (!n.length) throw new Error("a filter is required");
                            return n.unshift(e, 0), Array.prototype.splice.apply(this.filters, n), this
                        }
                    }, {
                        key: "replace",
                        value: function (t) {
                            var e = this.indexOf(t),
                                n = Array.prototype.slice.call(arguments, 1);
                            if (!n.length) throw new Error("a filter is required");
                            return n.unshift(e, 1), Array.prototype.splice.apply(this.filters, n), this
                        }
                    }, {
                        key: "remove",
                        value: function (t) {
                            var e = this.indexOf(t);
                            return this.filters.splice(e, 1), this
                        }
                    }, {
                        key: "clear",
                        value: function () {
                            return this.filters.length = 0, this
                        }
                    }, {
                        key: "shouldHaveResult",
                        value: function (t) {
                            if (!1 !== t) {
                                if (!this.resultCheck) {
                                    var n = this;
                                    return this.resultCheck = function (t) {
                                        if (!t.hasResult) {
                                            console.log(t);
                                            var e = new Error(n.name + " failed");
                                            throw e.noResult = !0, e
                                        }
                                    }, this
                                }
                            } else this.resultCheck = null
                        }
                    }]), e
                }(),
                c = function () {
                    function t() {
                        i(this, t)
                    }

                    return n(t, [{
                        key: "setResult",
                        value: function (t) {
                            return this.result = t, this.hasResult = !0, this
                        }
                    }, {
                        key: "exit",
                        value: function () {
                            return this.exiting = !0, this
                        }
                    }, {
                        key: "switchTo",
                        value: function (t, e) {
                            return "string" == typeof t || t instanceof f ? this.nextPipe = t : (this.next = t, e && (this.nextPipe = e)), this
                        }
                    }, {
                        key: "push",
                        value: function (t, e) {
                            return t.parent = this, void 0 !== e && (t.childName = e), t.root = this.root || this, t.options = t.options || this.options, this.children ? (this.children[this.children.length - 1].next = t, this.children.push(t)) : (this.children = [t], this.nextAfterChildren = this.next || null, this.next = t), t.next = this
                        }
                    }]), t
                }(),
                d = "function" == typeof Array.isArray ? Array.isArray : function (t) {
                    return t instanceof Array
                };

            function p(t) {
                if ("object" !== (void 0 === t ? "undefined" : h(t))) return t;
                if (null === t) return null;
                if (d(t)) return t.map(p);
                if (t instanceof Date) return new Date(t.getTime());
                if (t instanceof RegExp) return e = /^\/(.*)\/([gimyu]*)$/.exec(t.toString()), new RegExp(e[1], e[2]);
                var e, n = {};
                for (var r in t) Object.prototype.hasOwnProperty.call(t, r) && (n[r] = p(t[r]));
                return n
            }

            var k = function (t) {
                    function r(t, e) {
                        i(this, r);
                        var n = a(this, (r.__proto__ || Object.getPrototypeOf(r)).call(this));
                        return n.left = t, n.right = e, n.pipe = "diff", n
                    }

                    return o(r, c), n(r, [{
                        key: "setResult",
                        value: function (t) {
                            if (this.options.cloneDiffValues && "object" === (void 0 === t ? "undefined" : h(t))) {
                                var e = "function" == typeof this.options.cloneDiffValues ? this.options.cloneDiffValues : p;
                                "object" === h(t[0]) && (t[0] = e(t[0])), "object" === h(t[1]) && (t[1] = e(t[1]))
                            }
                            return c.prototype.setResult.apply(this, arguments)
                        }
                    }]), r
                }(),
                v = function (t) {
                    function r(t, e) {
                        i(this, r);
                        var n = a(this, (r.__proto__ || Object.getPrototypeOf(r)).call(this));
                        return n.left = t, n.delta = e, n.pipe = "patch", n
                    }

                    return o(r, c), r
                }(),
                g = function (t) {
                    function n(t) {
                        i(this, n);
                        var e = a(this, (n.__proto__ || Object.getPrototypeOf(n)).call(this));
                        return e.delta = t, e.pipe = "reverse", e
                    }

                    return o(n, c), n
                }(),
                y = "function" == typeof Array.isArray ? Array.isArray : function (t) {
                    return t instanceof Array
                },
                m = function (t) {
                    if (t.left !== t.right)
                        if (void 0 !== t.left)
                            if (void 0 !== t.right) {
                                if ("function" == typeof t.left || "function" == typeof t.right) throw new Error("functions are not supported");
                                t.leftType = null === t.left ? "null" : h(t.left), t.rightType = null === t.right ? "null" : h(t.right), t.leftType === t.rightType && "boolean" !== t.leftType && "number" !== t.leftType ? ("object" === t.leftType && (t.leftIsArray = y(t.left)), "object" === t.rightType && (t.rightIsArray = y(t.right)), t.leftIsArray === t.rightIsArray ? t.left instanceof RegExp && (t.right instanceof RegExp ? t.setResult([t.left.toString(), t.right.toString()]).exit() : t.setResult([t.left, t.right]).exit()) : t.setResult([t.left, t.right]).exit()) : t.setResult([t.left, t.right]).exit()
                            } else t.setResult([t.left, 0, 0]).exit();
                        else {
                            if ("function" == typeof t.right) throw new Error("functions are not supported");
                            t.setResult([t.right]).exit()
                        } else t.setResult(void 0).exit()
                },
                _ = function (t) {
                    if (void 0 !== t.delta) {
                        if (t.nested = !y(t.delta), !t.nested)
                            if (1 !== t.delta.length)
                                if (2 !== t.delta.length) 3 === t.delta.length && 0 === t.delta[2] && t.setResult(void 0).exit();
                                else {
                                    if (t.left instanceof RegExp) {
                                        var e = /^\/(.*)\/([gimyu]+)$/.exec(t.delta[1]);
                                        if (e) return void t.setResult(new RegExp(e[1], e[2])).exit()
                                    }
                                    t.setResult(t.delta[1]).exit()
                                }
                            else t.setResult(t.delta[0]).exit()
                    } else t.setResult(t.left).exit()
                },
                b = function (t) {
                    void 0 !== t.delta ? (t.nested = !y(t.delta), t.nested || (1 !== t.delta.length ? 2 !== t.delta.length ? 3 === t.delta.length && 0 === t.delta[2] && t.setResult([t.delta[0]]).exit() : t.setResult([t.delta[1], t.delta[0]]).exit() : t.setResult([t.delta[0], 0, 0]).exit())) : t.setResult(t.delta).exit()
                };

            function x(t) {
                if (t && t.children) {
                    for (var e = t.children.length, n = void 0, r = t.result, i = 0; i < e; i++) void 0 !== (n = t.children[i]).result && ((r = r || {})[n.childName] = n.result);
                    r && t.leftIsArray && (r._t = "a"), t.setResult(r).exit()
                }
            }

            function w(t) {
                if (!t.leftIsArray && "object" === t.leftType) {
                    var e = void 0,
                        n = void 0,
                        r = t.options.propertyFilter;
                    for (e in t.left) Object.prototype.hasOwnProperty.call(t.left, e) && (r && !r(e, t) || (n = new k(t.left[e], t.right[e]), t.push(n, e)));
                    for (e in t.right) Object.prototype.hasOwnProperty.call(t.right, e) && (r && !r(e, t) || void 0 === t.left[e] && (n = new k(void 0, t.right[e]), t.push(n, e)));
                    t.children && 0 !== t.children.length ? t.exit() : t.setResult(void 0).exit()
                }
            }

            b.filterName = _.filterName = m.filterName = "trivial", x.filterName = "collectChildren";
            var j = function (t) {
                if (t.nested && !t.delta._t) {
                    var e = void 0,
                        n = void 0;
                    for (e in t.delta) n = new v(t.left[e], t.delta[e]), t.push(n, e);
                    t.exit()
                }
            };
            j.filterName = w.filterName = "objects";
            var A = function (t) {
                if (t && t.children && !t.delta._t) {
                    for (var e = t.children.length, n = void 0, r = 0; r < e; r++) n = t.children[r], Object.prototype.hasOwnProperty.call(t.left, n.childName) && void 0 === n.result ? delete t.left[n.childName] : t.left[n.childName] !== n.result && (t.left[n.childName] = n.result);
                    t.setResult(t.left).exit()
                }
            };
            A.filterName = "collectChildren";
            var O = function (t) {
                if (t.nested && !t.delta._t) {
                    var e = void 0,
                        n = void 0;
                    for (e in t.delta) n = new g(t.delta[e]), t.push(n, e);
                    t.exit()
                }
            };

            function M(t) {
                if (t && t.children && !t.delta._t) {
                    for (var e = t.children.length, n = void 0, r = {}, i = 0; i < e; i++) r[(n = t.children[i]).childName] !== n.result && (r[n.childName] = n.result);
                    t.setResult(r).exit()
                }
            }

            O.filterName = "objects", M.filterName = "collectChildren";
            var R = function (t, e, n, r) {
                    return t[n] === e[r]
                },
                C = function (t, e, n, r) {
                    var i = r || {},
                        o = function t(e, n, r, i, o, a) {
                            if (0 === i || 0 === o) return {
                                sequence: [],
                                indices1: [],
                                indices2: []
                            };
                            if (e.match(n, r, i - 1, o - 1, a)) {
                                var s = t(e, n, r, i - 1, o - 1, a);
                                return s.sequence.push(n[i - 1]), s.indices1.push(i - 1), s.indices2.push(o - 1), s
                            }
                            return e[i][o - 1] > e[i - 1][o] ? t(e, n, r, i, o - 1, a) : t(e, n, r, i - 1, o, a)
                        }(function (t, e, n, r) {
                            var i = t.length,
                                o = e.length,
                                a = void 0,
                                s = void 0,
                                f = [i + 1];
                            for (a = 0; a < i + 1; a++)
                                for (f[a] = [o + 1], s = 0; s < o + 1; s++) f[a][s] = 0;
                            for (f.match = n, a = 1; a < i + 1; a++)
                                for (s = 1; s < o + 1; s++) n(t, e, a - 1, s - 1, r) ? f[a][s] = f[a - 1][s - 1] + 1 : f[a][s] = Math.max(f[a - 1][s], f[a][s - 1]);
                            return f
                        }(t, e, n || R, i), t, e, t.length, e.length, i);
                    return "string" == typeof t && "string" == typeof e && (o.sequence = o.sequence.join("")), o
                },
                E = "function" == typeof Array.isArray ? Array.isArray : function (t) {
                    return t instanceof Array
                },
                P = "function" == typeof Array.prototype.indexOf ? function (t, e) {
                    return t.indexOf(e)
                } : function (t, e) {
                    for (var n = t.length, r = 0; r < n; r++)
                        if (t[r] === e) return r;
                    return -1
                };

            function D(t, e, n, r, i) {
                var o = t[n],
                    a = e[r];
                if (o === a) return !0;
                if ("object" !== (void 0 === o ? "undefined" : h(o)) || "object" !== (void 0 === a ? "undefined" : h(a))) return !1;
                var s = i.objectHash;
                if (!s) return i.matchByPosition && n === r;
                var f = void 0,
                    l = void 0;
                return "number" == typeof n ? (i.hashCache1 = i.hashCache1 || [], void 0 === (f = i.hashCache1[n]) && (i.hashCache1[n] = f = s(o, n))) : f = s(o), void 0 !== f && ("number" == typeof r ? (i.hashCache2 = i.hashCache2 || [], void 0 === (l = i.hashCache2[r]) && (i.hashCache2[r] = l = s(a, r))) : l = s(a), void 0 !== l && f === l)
            }

            var T = function (t) {
                    if (t.leftIsArray) {
                        var e = {
                                objectHash: t.options && t.options.objectHash,
                                matchByPosition: t.options && t.options.matchByPosition
                            },
                            n = 0,
                            r = 0,
                            i = void 0,
                            o = void 0,
                            a = void 0,
                            s = t.left,
                            f = t.right,
                            l = s.length,
                            h = f.length,
                            u = void 0;
                        for (0 < l && 0 < h && !e.objectHash && "boolean" != typeof e.matchByPosition && (e.matchByPosition = !function (t, e, n, r) {
                            for (var i = 0; i < n; i++)
                                for (var o = t[i], a = 0; a < r; a++) {
                                    var s = e[a];
                                    if (i !== a && o === s) return !0
                                }
                        }(s, f, l, h)); n < l && n < h && D(s, f, n, n, e);) i = n, u = new k(t.left[i], t.right[i]), t.push(u, i), n++;
                        for (; r + n < l && r + n < h && D(s, f, l - 1 - r, h - 1 - r, e);) o = l - 1 - r, a = h - 1 - r, u = new k(t.left[o], t.right[a]), t.push(u, a), r++;
                        var c = void 0;
                        if (n + r !== l)
                            if (n + r !== h) {
                                delete e.hashCache1, delete e.hashCache2;
                                var d = s.slice(n, l - r),
                                    p = f.slice(n, h - r),
                                    v = C(d, p, D, e),
                                    g = [];
                                for (c = c || {
                                    _t: "a"
                                }, i = n; i < l - r; i++) P(v.indices1, i - n) < 0 && (c["_" + i] = [s[i], 0, 0], g.push(i));
                                var y = !0;
                                t.options && t.options.arrays && !1 === t.options.arrays.detectMove && (y = !1);
                                var m = !1;
                                t.options && t.options.arrays && t.options.arrays.includeValueOnMove && (m = !0);
                                var _ = g.length;
                                for (i = n; i < h - r; i++) {
                                    var b = P(v.indices2, i - n);
                                    if (b < 0) {
                                        var x = !1;
                                        if (y && 0 < _)
                                            for (var w = 0; w < _; w++)
                                                if (D(d, p, (o = g[w]) - n, i - n, e)) {
                                                    c["_" + o].splice(1, 2, i, 3), m || (c["_" + o][0] = ""), a = i, u = new k(t.left[o], t.right[a]), t.push(u, a), g.splice(w, 1), x = !0;
                                                    break
                                                }
                                        x || (c[i] = [f[i]])
                                    } else o = v.indices1[b] + n, a = v.indices2[b] + n, u = new k(t.left[o], t.right[a]), t.push(u, a)
                                }
                                t.setResult(c).exit()
                            } else {
                                for (c = c || {
                                    _t: "a"
                                }, i = n; i < l - r; i++) c["_" + i] = [s[i], 0, 0];
                                t.setResult(c).exit()
                            }
                        else {
                            if (l === h) return void t.setResult(void 0).exit();
                            for (c = c || {
                                _t: "a"
                            }, i = n; i < h - r; i++) c[i] = [f[i]];
                            t.setResult(c).exit()
                        }
                    }
                },
                N = function (t, e) {
                    return t - e
                },
                I = function (n) {
                    return function (t, e) {
                        return t[n] - e[n]
                    }
                },
                S = function (t) {
                    if (t.nested && "a" === t.delta._t) {
                        var e = void 0,
                            n = void 0,
                            r = t.delta,
                            i = t.left,
                            o = [],
                            a = [],
                            s = [];
                        for (e in r)
                            if ("_t" !== e)
                                if ("_" === e[0]) {
                                    if (0 !== r[e][2] && 3 !== r[e][2]) throw new Error("only removal or move can be applied at original array indices, invalid diff type: " + r[e][2]);
                                    o.push(parseInt(e.slice(1), 10))
                                } else 1 === r[e].length ? a.push({
                                    index: parseInt(e, 10),
                                    value: r[e][0]
                                }) : s.push({
                                    index: parseInt(e, 10),
                                    delta: r[e]
                                });
                        for (e = (o = o.sort(N)).length - 1; 0 <= e; e--) {
                            var f = r["_" + (n = o[e])],
                                l = i.splice(n, 1)[0];
                            3 === f[2] && a.push({
                                index: f[1],
                                value: l
                            })
                        }
                        var h = (a = a.sort(I("index"))).length;
                        for (e = 0; e < h; e++) {
                            var u = a[e];
                            i.splice(u.index, 0, u.value)
                        }
                        var c = s.length,
                            d = void 0;
                        if (0 < c)
                            for (e = 0; e < c; e++) {
                                var p = s[e];
                                d = new v(t.left[p.index], p.delta), t.push(d, p.index)
                            }
                        t.children ? t.exit() : t.setResult(t.left).exit()
                    }
                };
            S.filterName = T.filterName = "arrays";
            var B = function (t) {
                if (t && t.children && "a" === t.delta._t) {
                    for (var e = t.children.length, n = void 0, r = 0; r < e; r++) n = t.children[r], t.left[n.childName] = n.result;
                    t.setResult(t.left).exit()
                }
            };
            B.filterName = "arraysCollectChildren";
            var F = function (t) {
                if (t.nested) {
                    if ("a" === t.delta._t) {
                        var e = void 0,
                            n = void 0;
                        for (e in t.delta) "_t" !== e && (n = new g(t.delta[e]), t.push(n, e));
                        t.exit()
                    }
                } else 3 === t.delta[2] && (t.newName = "_" + t.delta[1], t.setResult([t.delta[0], parseInt(t.childName.substr(1), 10), 3]).exit())
            };
            F.filterName = "arrays";
            var L = function (t, e, n) {
                if ("string" == typeof e && "_" === e[0]) return parseInt(e.substr(1), 10);
                if (E(n) && 0 === n[2]) return "_" + e;
                var r = +e;
                for (var i in t) {
                    var o = t[i];
                    if (E(o))
                        if (3 === o[2]) {
                            var a = parseInt(i.substr(1), 10),
                                s = o[1];
                            if (s === +e) return a;
                            a <= r && r < s ? r++ : r <= a && s < r && r--
                        } else if (0 === o[2]) {
                            parseInt(i.substr(1), 10) <= r && r++
                        } else 1 === o.length && i <= r && r--
                }
                return r
            };

            function V(t) {
                if (t && t.children && "a" === t.delta._t) {
                    for (var e = t.children.length, n = void 0, r = {
                        _t: "a"
                    }, i = 0; i < e; i++) {
                        var o = (n = t.children[i]).newName;
                        void 0 === o && (o = L(t.delta, n.childName, n.result)), r[o] !== n.result && (r[o] = n.result)
                    }
                    t.setResult(r).exit()
                }
            }

            V.filterName = "arraysCollectChildren";
            var q = function (t) {
                t.left instanceof Date ? (t.right instanceof Date ? t.left.getTime() !== t.right.getTime() ? t.setResult([t.left, t.right]) : t.setResult(void 0) : t.setResult([t.left, t.right]), t.exit()) : t.right instanceof Date && t.setResult([t.left, t.right]).exit()
            };
            q.filterName = "dates";
            var U, H = (function (t) {
                    function v() {
                        this.Diff_Timeout = 1, this.Diff_EditCost = 4, this.Match_Threshold = .5, this.Match_Distance = 1e3, this.Patch_DeleteThreshold = .5, this.Patch_Margin = 4, this.Match_MaxBits = 32
                    }

                    v.prototype.diff_main = function (t, e, n, r) {
                        void 0 === r && (r = this.Diff_Timeout <= 0 ? Number.MAX_VALUE : (new Date).getTime() + 1e3 * this.Diff_Timeout);
                        var i = r;
                        if (null == t || null == e) throw new Error("Null input. (diff_main)");
                        if (t == e) return t ? [
                            [0, t]
                        ] : [];
                        void 0 === n && (n = !0);
                        var o = n,
                            a = this.diff_commonPrefix(t, e),
                            s = t.substring(0, a);
                        t = t.substring(a), e = e.substring(a), a = this.diff_commonSuffix(t, e);
                        var f = t.substring(t.length - a);
                        t = t.substring(0, t.length - a), e = e.substring(0, e.length - a);
                        var l = this.diff_compute_(t, e, o, i);
                        return s && l.unshift([0, s]), f && l.push([0, f]), this.diff_cleanupMerge(l), l
                    }, v.prototype.diff_compute_ = function (t, e, n, r) {
                        var i;
                        if (!t) return [
                            [1, e]
                        ];
                        if (!e) return [
                            [-1, t]
                        ];
                        var o = t.length > e.length ? t : e,
                            a = t.length > e.length ? e : t,
                            s = o.indexOf(a);
                        if (-1 != s) return i = [
                            [1, o.substring(0, s)],
                            [0, a],
                            [1, o.substring(s + a.length)]
                        ], t.length > e.length && (i[0][0] = i[2][0] = -1), i;
                        if (1 == a.length) return [
                            [-1, t],
                            [1, e]
                        ];
                        var f = this.diff_halfMatch_(t, e);
                        if (f) {
                            var l = f[0],
                                h = f[1],
                                u = f[2],
                                c = f[3],
                                d = f[4],
                                p = this.diff_main(l, u, n, r),
                                v = this.diff_main(h, c, n, r);
                            return p.concat([
                                [0, d]
                            ], v)
                        }
                        return n && 100 < t.length && 100 < e.length ? this.diff_lineMode_(t, e, r) : this.diff_bisect_(t, e, r)
                    }, v.prototype.diff_lineMode_ = function (t, e, n) {
                        t = (h = this.diff_linesToChars_(t, e)).chars1, e = h.chars2;
                        var r = h.lineArray,
                            i = this.diff_main(t, e, !1, n);
                        this.diff_charsToLines_(i, r), this.diff_cleanupSemantic(i), i.push([0, ""]);
                        for (var o = 0, a = 0, s = 0, f = "", l = ""; o < i.length;) {
                            switch (i[o][0]) {
                                case 1:
                                    s++, l += i[o][1];
                                    break;
                                case -1:
                                    a++, f += i[o][1];
                                    break;
                                case 0:
                                    if (1 <= a && 1 <= s) {
                                        i.splice(o - a - s, a + s), o = o - a - s;
                                        for (var h, u = (h = this.diff_main(f, l, !1, n)).length - 1; 0 <= u; u--) i.splice(o, 0, h[u]);
                                        o += h.length
                                    }
                                    a = s = 0, l = f = ""
                            }
                            o++
                        }
                        return i.pop(), i
                    }, v.prototype.diff_bisect_ = function (t, e, n) {
                        for (var r = t.length, i = e.length, o = Math.ceil((r + i) / 2), a = o, s = 2 * o, f = new Array(s), l = new Array(s), h = 0; h < s; h++) f[h] = -1, l[h] = -1;
                        f[a + 1] = 0;
                        for (var u = r - i, c = u % 2 != (l[a + 1] = 0), d = 0, p = 0, v = 0, g = 0, y = 0; y < o && !((new Date).getTime() > n); y++) {
                            for (var m = -y + d; m <= y - p; m += 2) {
                                for (var _ = a + m, b = (A = m == -y || m != y && f[_ - 1] < f[_ + 1] ? f[_ + 1] : f[_ - 1] + 1) - m; A < r && b < i && t.charAt(A) == e.charAt(b);) A++, b++;
                                if (r < (f[_] = A)) p += 2;
                                else if (i < b) d += 2;
                                else if (c) {
                                    if (0 <= (k = a + u - m) && k < s && -1 != l[k])
                                        if ((w = r - l[k]) <= A) return this.diff_bisectSplit_(t, e, A, b, n)
                                }
                            }
                            for (var x = -y + v; x <= y - g; x += 2) {
                                for (var w, k = a + x, j = (w = x == -y || x != y && l[k - 1] < l[k + 1] ? l[k + 1] : l[k - 1] + 1) - x; w < r && j < i && t.charAt(r - w - 1) == e.charAt(i - j - 1);) w++, j++;
                                if (r < (l[k] = w)) g += 2;
                                else if (i < j) v += 2;
                                else if (!c) {
                                    if (0 <= (_ = a + u - x) && _ < s && -1 != f[_]) {
                                        var A;
                                        b = a + (A = f[_]) - _;
                                        if ((w = r - w) <= A) return this.diff_bisectSplit_(t, e, A, b, n)
                                    }
                                }
                            }
                        }
                        return [
                            [-1, t],
                            [1, e]
                        ]
                    }, v.prototype.diff_bisectSplit_ = function (t, e, n, r, i) {
                        var o = t.substring(0, n),
                            a = e.substring(0, r),
                            s = t.substring(n),
                            f = e.substring(r),
                            l = this.diff_main(o, a, !1, i),
                            h = this.diff_main(s, f, !1, i);
                        return l.concat(h)
                    }, v.prototype.diff_linesToChars_ = function (t, e) {
                        var a = [],
                            s = {};

                        function n(t) {
                            for (var e = "", n = 0, r = -1, i = a.length; r < t.length - 1;) {
                                -1 == (r = t.indexOf("\n", n)) && (r = t.length - 1);
                                var o = t.substring(n, r + 1);
                                n = r + 1, (s.hasOwnProperty ? s.hasOwnProperty(o) : void 0 !== s[o]) ? e += String.fromCharCode(s[o]) : (e += String.fromCharCode(i), s[o] = i, a[i++] = o)
                            }
                            return e
                        }

                        return a[0] = "", {
                            chars1: n(t),
                            chars2: n(e),
                            lineArray: a
                        }
                    }, v.prototype.diff_charsToLines_ = function (t, e) {
                        for (var n = 0; n < t.length; n++) {
                            for (var r = t[n][1], i = [], o = 0; o < r.length; o++) i[o] = e[r.charCodeAt(o)];
                            t[n][1] = i.join("")
                        }
                    }, v.prototype.diff_commonPrefix = function (t, e) {
                        if (!t || !e || t.charAt(0) != e.charAt(0)) return 0;
                        for (var n = 0, r = Math.min(t.length, e.length), i = r, o = 0; n < i;) t.substring(o, i) == e.substring(o, i) ? o = n = i : r = i, i = Math.floor((r - n) / 2 + n);
                        return i
                    }, v.prototype.diff_commonSuffix = function (t, e) {
                        if (!t || !e || t.charAt(t.length - 1) != e.charAt(e.length - 1)) return 0;
                        for (var n = 0, r = Math.min(t.length, e.length), i = r, o = 0; n < i;) t.substring(t.length - i, t.length - o) == e.substring(e.length - i, e.length - o) ? o = n = i : r = i, i = Math.floor((r - n) / 2 + n);
                        return i
                    }, v.prototype.diff_commonOverlap_ = function (t, e) {
                        var n = t.length,
                            r = e.length;
                        if (0 == n || 0 == r) return 0;
                        r < n ? t = t.substring(n - r) : n < r && (e = e.substring(0, n));
                        var i = Math.min(n, r);
                        if (t == e) return i;
                        for (var o = 0, a = 1; ;) {
                            var s = t.substring(i - a),
                                f = e.indexOf(s);
                            if (-1 == f) return o;
                            a += f, 0 != f && t.substring(i - a) != e.substring(0, a) || (o = a, a++)
                        }
                    }, v.prototype.diff_halfMatch_ = function (t, e) {
                        if (this.Diff_Timeout <= 0) return null;
                        var n = t.length > e.length ? t : e,
                            r = t.length > e.length ? e : t;
                        if (n.length < 4 || 2 * r.length < n.length) return null;
                        var c = this;

                        function i(t, e, n) {
                            for (var r, i, o, a, s = t.substring(n, n + Math.floor(t.length / 4)), f = -1, l = ""; -1 != (f = e.indexOf(s, f + 1));) {
                                var h = c.diff_commonPrefix(t.substring(n), e.substring(f)),
                                    u = c.diff_commonSuffix(t.substring(0, n), e.substring(0, f));
                                l.length < u + h && (l = e.substring(f - u, f) + e.substring(f, f + h), r = t.substring(0, n - u), i = t.substring(n + h), o = e.substring(0, f - u), a = e.substring(f + h))
                            }
                            return 2 * l.length >= t.length ? [r, i, o, a, l] : null
                        }

                        var o, a, s, f, l, h = i(n, r, Math.ceil(n.length / 4)),
                            u = i(n, r, Math.ceil(n.length / 2));
                        return h || u ? (o = u ? h && h[4].length > u[4].length ? h : u : h, t.length > e.length ? (a = o[0], s = o[1], f = o[2], l = o[3]) : (f = o[0], l = o[1], a = o[2], s = o[3]), [a, s, f, l, o[4]]) : null
                    }, v.prototype.diff_cleanupSemantic = function (t) {
                        for (var e = !1, n = [], r = 0, i = null, o = 0, a = 0, s = 0, f = 0, l = 0; o < t.length;) 0 == t[o][0] ? (a = f, s = l, l = f = 0, i = t[n[r++] = o][1]) : (1 == t[o][0] ? f += t[o][1].length : l += t[o][1].length, i && i.length <= Math.max(a, s) && i.length <= Math.max(f, l) && (t.splice(n[r - 1], 0, [-1, i]), t[n[r - 1] + 1][0] = 1, r--, o = 0 < --r ? n[r - 1] : -1, l = f = s = a = 0, e = !(i = null))), o++;
                        for (e && this.diff_cleanupMerge(t), this.diff_cleanupSemanticLossless(t), o = 1; o < t.length;) {
                            if (-1 == t[o - 1][0] && 1 == t[o][0]) {
                                var h = t[o - 1][1],
                                    u = t[o][1],
                                    c = this.diff_commonOverlap_(h, u),
                                    d = this.diff_commonOverlap_(u, h);
                                d <= c ? (c >= h.length / 2 || c >= u.length / 2) && (t.splice(o, 0, [0, u.substring(0, c)]), t[o - 1][1] = h.substring(0, h.length - c), t[o + 1][1] = u.substring(c), o++) : (d >= h.length / 2 || d >= u.length / 2) && (t.splice(o, 0, [0, h.substring(0, d)]), t[o - 1][0] = 1, t[o - 1][1] = u.substring(0, u.length - d), t[o + 1][0] = -1, t[o + 1][1] = h.substring(d), o++), o++
                            }
                            o++
                        }
                    }, v.prototype.diff_cleanupSemanticLossless = function (t) {
                        function e(t, e) {
                            if (!t || !e) return 6;
                            var n = t.charAt(t.length - 1),
                                r = e.charAt(0),
                                i = n.match(v.nonAlphaNumericRegex_),
                                o = r.match(v.nonAlphaNumericRegex_),
                                a = i && n.match(v.whitespaceRegex_),
                                s = o && r.match(v.whitespaceRegex_),
                                f = a && n.match(v.linebreakRegex_),
                                l = s && r.match(v.linebreakRegex_),
                                h = f && t.match(v.blanklineEndRegex_),
                                u = l && e.match(v.blanklineStartRegex_);
                            return h || u ? 5 : f || l ? 4 : i && !a && s ? 3 : a || s ? 2 : i || o ? 1 : 0
                        }

                        for (var n = 1; n < t.length - 1;) {
                            if (0 == t[n - 1][0] && 0 == t[n + 1][0]) {
                                var r = t[n - 1][1],
                                    i = t[n][1],
                                    o = t[n + 1][1],
                                    a = this.diff_commonSuffix(r, i);
                                if (a) {
                                    var s = i.substring(i.length - a);
                                    r = r.substring(0, r.length - a), i = s + i.substring(0, i.length - a), o = s + o
                                }
                                for (var f = r, l = i, h = o, u = e(r, i) + e(i, o); i.charAt(0) === o.charAt(0);) {
                                    r += i.charAt(0), i = i.substring(1) + o.charAt(0), o = o.substring(1);
                                    var c = e(r, i) + e(i, o);
                                    u <= c && (u = c, f = r, l = i, h = o)
                                }
                                t[n - 1][1] != f && (f ? t[n - 1][1] = f : (t.splice(n - 1, 1), n--), t[n][1] = l, h ? t[n + 1][1] = h : (t.splice(n + 1, 1), n--))
                            }
                            n++
                        }
                    }, v.nonAlphaNumericRegex_ = /[^a-zA-Z0-9]/, v.whitespaceRegex_ = /\s/, v.linebreakRegex_ = /[\r\n]/, v.blanklineEndRegex_ = /\n\r?\n$/, v.blanklineStartRegex_ = /^\r?\n\r?\n/, v.prototype.diff_cleanupEfficiency = function (t) {
                        for (var e = !1, n = [], r = 0, i = null, o = 0, a = !1, s = !1, f = !1, l = !1; o < t.length;) 0 == t[o][0] ? (t[o][1].length < this.Diff_EditCost && (f || l) ? (a = f, s = l, i = t[n[r++] = o][1]) : (r = 0, i = null), f = l = !1) : (-1 == t[o][0] ? l = !0 : f = !0, i && (a && s && f && l || i.length < this.Diff_EditCost / 2 && a + s + f + l == 3) && (t.splice(n[r - 1], 0, [-1, i]), t[n[r - 1] + 1][0] = 1, r--, i = null, a && s ? (f = l = !0, r = 0) : (o = 0 < --r ? n[r - 1] : -1, f = l = !1), e = !0)), o++;
                        e && this.diff_cleanupMerge(t)
                    }, v.prototype.diff_cleanupMerge = function (t) {
                        t.push([0, ""]);
                        for (var e, n = 0, r = 0, i = 0, o = "", a = ""; n < t.length;) switch (t[n][0]) {
                            case 1:
                                i++, a += t[n][1], n++;
                                break;
                            case -1:
                                r++, o += t[n][1], n++;
                                break;
                            case 0:
                                1 < r + i ? (0 !== r && 0 !== i && (0 !== (e = this.diff_commonPrefix(a, o)) && (0 < n - r - i && 0 == t[n - r - i - 1][0] ? t[n - r - i - 1][1] += a.substring(0, e) : (t.splice(0, 0, [0, a.substring(0, e)]), n++), a = a.substring(e), o = o.substring(e)), 0 !== (e = this.diff_commonSuffix(a, o)) && (t[n][1] = a.substring(a.length - e) + t[n][1], a = a.substring(0, a.length - e), o = o.substring(0, o.length - e))), 0 === r ? t.splice(n - i, r + i, [1, a]) : 0 === i ? t.splice(n - r, r + i, [-1, o]) : t.splice(n - r - i, r + i, [-1, o], [1, a]), n = n - r - i + (r ? 1 : 0) + (i ? 1 : 0) + 1) : 0 !== n && 0 == t[n - 1][0] ? (t[n - 1][1] += t[n][1], t.splice(n, 1)) : n++, r = i = 0, a = o = ""
                        }
                        "" === t[t.length - 1][1] && t.pop();
                        var s = !1;
                        for (n = 1; n < t.length - 1;) 0 == t[n - 1][0] && 0 == t[n + 1][0] && (t[n][1].substring(t[n][1].length - t[n - 1][1].length) == t[n - 1][1] ? (t[n][1] = t[n - 1][1] + t[n][1].substring(0, t[n][1].length - t[n - 1][1].length), t[n + 1][1] = t[n - 1][1] + t[n + 1][1], t.splice(n - 1, 1), s = !0) : t[n][1].substring(0, t[n + 1][1].length) == t[n + 1][1] && (t[n - 1][1] += t[n + 1][1], t[n][1] = t[n][1].substring(t[n + 1][1].length) + t[n + 1][1], t.splice(n + 1, 1), s = !0)), n++;
                        s && this.diff_cleanupMerge(t)
                    }, v.prototype.diff_xIndex = function (t, e) {
                        var n, r = 0,
                            i = 0,
                            o = 0,
                            a = 0;
                        for (n = 0; n < t.length && (1 !== t[n][0] && (r += t[n][1].length), -1 !== t[n][0] && (i += t[n][1].length), !(e < r)); n++) o = r, a = i;
                        return t.length != n && -1 === t[n][0] ? a : a + (e - o)
                    }, v.prototype.diff_prettyHtml = function (t) {
                        for (var e = [], n = /&/g, r = /</g, i = />/g, o = /\n/g, a = 0; a < t.length; a++) {
                            var s = t[a][0],
                                f = t[a][1].replace(n, "&amp;").replace(r, "&lt;").replace(i, "&gt;").replace(o, "&para;<br>");
                            switch (s) {
                                case 1:
                                    e[a] = '<ins style="background:#e6ffe6;">' + f + "</ins>";
                                    break;
                                case -1:
                                    e[a] = '<del style="background:#ffe6e6;">' + f + "</del>";
                                    break;
                                case 0:
                                    e[a] = "<span>" + f + "</span>"
                            }
                        }
                        return e.join("")
                    }, v.prototype.diff_text1 = function (t) {
                        for (var e = [], n = 0; n < t.length; n++) 1 !== t[n][0] && (e[n] = t[n][1]);
                        return e.join("")
                    }, v.prototype.diff_text2 = function (t) {
                        for (var e = [], n = 0; n < t.length; n++) -1 !== t[n][0] && (e[n] = t[n][1]);
                        return e.join("")
                    }, v.prototype.diff_levenshtein = function (t) {
                        for (var e = 0, n = 0, r = 0, i = 0; i < t.length; i++) {
                            var o = t[i][0],
                                a = t[i][1];
                            switch (o) {
                                case 1:
                                    n += a.length;
                                    break;
                                case -1:
                                    r += a.length;
                                    break;
                                case 0:
                                    e += Math.max(n, r), r = n = 0
                            }
                        }
                        return e += Math.max(n, r)
                    }, v.prototype.diff_toDelta = function (t) {
                        for (var e = [], n = 0; n < t.length; n++) switch (t[n][0]) {
                            case 1:
                                e[n] = "+" + encodeURI(t[n][1]);
                                break;
                            case -1:
                                e[n] = "-" + t[n][1].length;
                                break;
                            case 0:
                                e[n] = "=" + t[n][1].length
                        }
                        return e.join("\t").replace(/%20/g, " ")
                    }, v.prototype.diff_fromDelta = function (t, e) {
                        for (var n = [], r = 0, i = 0, o = e.split(/\t/g), a = 0; a < o.length; a++) {
                            var s = o[a].substring(1);
                            switch (o[a].charAt(0)) {
                                case "+":
                                    try {
                                        n[r++] = [1, decodeURI(s)]
                                    } catch (t) {
                                        throw new Error("Illegal escape in diff_fromDelta: " + s)
                                    }
                                    break;
                                case "-":
                                case "=":
                                    var f = parseInt(s, 10);
                                    if (isNaN(f) || f < 0) throw new Error("Invalid number in diff_fromDelta: " + s);
                                    var l = t.substring(i, i += f);
                                    "=" == o[a].charAt(0) ? n[r++] = [0, l] : n[r++] = [-1, l];
                                    break;
                                default:
                                    if (o[a]) throw new Error("Invalid diff operation in diff_fromDelta: " + o[a])
                            }
                        }
                        if (i != t.length) throw new Error("Delta length (" + i + ") does not equal source text length (" + t.length + ").");
                        return n
                    }, v.prototype.match_main = function (t, e, n) {
                        if (null == t || null == e || null == n) throw new Error("Null input. (match_main)");
                        return n = Math.max(0, Math.min(n, t.length)), t == e ? 0 : t.length ? t.substring(n, n + e.length) == e ? n : this.match_bitap_(t, e, n) : -1
                    }, v.prototype.match_bitap_ = function (t, i, o) {
                        if (i.length > this.Match_MaxBits) throw new Error("Pattern too long for this browser.");
                        var e = this.match_alphabet_(i),
                            a = this;

                        function n(t, e) {
                            var n = t / i.length,
                                r = Math.abs(o - e);
                            return a.Match_Distance ? n + r / a.Match_Distance : r ? 1 : n
                        }

                        var r = this.Match_Threshold,
                            s = t.indexOf(i, o);
                        -1 != s && (r = Math.min(n(0, s), r), -1 != (s = t.lastIndexOf(i, o + i.length)) && (r = Math.min(n(0, s), r)));
                        var f, l, h = 1 << i.length - 1;
                        s = -1;
                        for (var u, c = i.length + t.length, d = 0; d < i.length; d++) {
                            for (f = 0, l = c; f < l;) n(d, o + l) <= r ? f = l : c = l, l = Math.floor((c - f) / 2 + f);
                            c = l;
                            var p = Math.max(1, o - l + 1),
                                v = Math.min(o + l, t.length) + i.length,
                                g = Array(v + 2);
                            g[v + 1] = (1 << d) - 1;
                            for (var y = v; p <= y; y--) {
                                var m = e[t.charAt(y - 1)];
                                if (g[y] = 0 === d ? (g[y + 1] << 1 | 1) & m : (g[y + 1] << 1 | 1) & m | (u[y + 1] | u[y]) << 1 | 1 | u[y + 1], g[y] & h) {
                                    var _ = n(d, y - 1);
                                    if (_ <= r) {
                                        if (r = _, !(o < (s = y - 1))) break;
                                        p = Math.max(1, 2 * o - s)
                                    }
                                }
                            }
                            if (n(d + 1, o) > r) break;
                            u = g
                        }
                        return s
                    }, v.prototype.match_alphabet_ = function (t) {
                        for (var e = {}, n = 0; n < t.length; n++) e[t.charAt(n)] = 0;
                        for (n = 0; n < t.length; n++) e[t.charAt(n)] |= 1 << t.length - n - 1;
                        return e
                    }, v.prototype.patch_addContext_ = function (t, e) {
                        if (0 != e.length) {
                            for (var n = e.substring(t.start2, t.start2 + t.length1), r = 0; e.indexOf(n) != e.lastIndexOf(n) && n.length < this.Match_MaxBits - this.Patch_Margin - this.Patch_Margin;) r += this.Patch_Margin, n = e.substring(t.start2 - r, t.start2 + t.length1 + r);
                            r += this.Patch_Margin;
                            var i = e.substring(t.start2 - r, t.start2);
                            i && t.diffs.unshift([0, i]);
                            var o = e.substring(t.start2 + t.length1, t.start2 + t.length1 + r);
                            o && t.diffs.push([0, o]), t.start1 -= i.length, t.start2 -= i.length, t.length1 += i.length + o.length, t.length2 += i.length + o.length
                        }
                    }, v.prototype.patch_make = function (t, e, n) {
                        var r, i;
                        if ("string" == typeof t && "string" == typeof e && void 0 === n) r = t, 2 < (i = this.diff_main(r, e, !0)).length && (this.diff_cleanupSemantic(i), this.diff_cleanupEfficiency(i));
                        else if (t && "object" == typeof t && void 0 === e && void 0 === n) i = t, r = this.diff_text1(i);
                        else if ("string" == typeof t && e && "object" == typeof e && void 0 === n) r = t, i = e;
                        else {
                            if ("string" != typeof t || "string" != typeof e || !n || "object" != typeof n) throw new Error("Unknown call format to patch_make.");
                            r = t, i = n
                        }
                        if (0 === i.length) return [];
                        for (var o = [], a = new v.patch_obj, s = 0, f = 0, l = 0, h = r, u = r, c = 0; c < i.length; c++) {
                            var d = i[c][0],
                                p = i[c][1];
                            switch (s || 0 === d || (a.start1 = f, a.start2 = l), d) {
                                case 1:
                                    a.diffs[s++] = i[c], a.length2 += p.length, u = u.substring(0, l) + p + u.substring(l);
                                    break;
                                case -1:
                                    a.length1 += p.length, a.diffs[s++] = i[c], u = u.substring(0, l) + u.substring(l + p.length);
                                    break;
                                case 0:
                                    p.length <= 2 * this.Patch_Margin && s && i.length != c + 1 ? (a.diffs[s++] = i[c], a.length1 += p.length, a.length2 += p.length) : p.length >= 2 * this.Patch_Margin && s && (this.patch_addContext_(a, h), o.push(a), a = new v.patch_obj, s = 0, h = u, f = l)
                            }
                            1 !== d && (f += p.length), -1 !== d && (l += p.length)
                        }
                        return s && (this.patch_addContext_(a, h), o.push(a)), o
                    }, v.prototype.patch_deepCopy = function (t) {
                        for (var e = [], n = 0; n < t.length; n++) {
                            var r = t[n],
                                i = new v.patch_obj;
                            i.diffs = [];
                            for (var o = 0; o < r.diffs.length; o++) i.diffs[o] = r.diffs[o].slice();
                            i.start1 = r.start1, i.start2 = r.start2, i.length1 = r.length1, i.length2 = r.length2, e[n] = i
                        }
                        return e
                    }, v.prototype.patch_apply = function (t, e) {
                        if (0 == t.length) return [e, []];
                        t = this.patch_deepCopy(t);
                        var n = this.patch_addPadding(t);
                        e = n + e + n, this.patch_splitMax(t);
                        for (var r = 0, i = [], o = 0; o < t.length; o++) {
                            var a, s, f = t[o].start2 + r,
                                l = this.diff_text1(t[o].diffs),
                                h = -1;
                            if (l.length > this.Match_MaxBits ? -1 != (a = this.match_main(e, l.substring(0, this.Match_MaxBits), f)) && (-1 == (h = this.match_main(e, l.substring(l.length - this.Match_MaxBits), f + l.length - this.Match_MaxBits)) || h <= a) && (a = -1) : a = this.match_main(e, l, f), -1 == a) i[o] = !1, r -= t[o].length2 - t[o].length1;
                            else if (i[o] = !0, r = a - f, l == (s = -1 == h ? e.substring(a, a + l.length) : e.substring(a, h + this.Match_MaxBits))) e = e.substring(0, a) + this.diff_text2(t[o].diffs) + e.substring(a + l.length);
                            else {
                                var u = this.diff_main(l, s, !1);
                                if (l.length > this.Match_MaxBits && this.diff_levenshtein(u) / l.length > this.Patch_DeleteThreshold) i[o] = !1;
                                else {
                                    this.diff_cleanupSemanticLossless(u);
                                    for (var c, d = 0, p = 0; p < t[o].diffs.length; p++) {
                                        var v = t[o].diffs[p];
                                        0 !== v[0] && (c = this.diff_xIndex(u, d)), 1 === v[0] ? e = e.substring(0, a + c) + v[1] + e.substring(a + c) : -1 === v[0] && (e = e.substring(0, a + c) + e.substring(a + this.diff_xIndex(u, d + v[1].length))), -1 !== v[0] && (d += v[1].length)
                                    }
                                }
                            }
                        }
                        return [e = e.substring(n.length, e.length - n.length), i]
                    }, v.prototype.patch_addPadding = function (t) {
                        for (var e = this.Patch_Margin, n = "", r = 1; r <= e; r++) n += String.fromCharCode(r);
                        for (r = 0; r < t.length; r++) t[r].start1 += e, t[r].start2 += e;
                        var i = t[0],
                            o = i.diffs;
                        if (0 == o.length || 0 != o[0][0]) o.unshift([0, n]), i.start1 -= e, i.start2 -= e, i.length1 += e, i.length2 += e;
                        else if (e > o[0][1].length) {
                            var a = e - o[0][1].length;
                            o[0][1] = n.substring(o[0][1].length) + o[0][1], i.start1 -= a, i.start2 -= a, i.length1 += a, i.length2 += a
                        }
                        if (0 == (o = (i = t[t.length - 1]).diffs).length || 0 != o[o.length - 1][0]) o.push([0, n]), i.length1 += e, i.length2 += e;
                        else if (e > o[o.length - 1][1].length) {
                            a = e - o[o.length - 1][1].length;
                            o[o.length - 1][1] += n.substring(0, a), i.length1 += a, i.length2 += a
                        }
                        return n
                    }, v.prototype.patch_splitMax = function (t) {
                        for (var e = this.Match_MaxBits, n = 0; n < t.length; n++)
                            if (!(t[n].length1 <= e)) {
                                var r = t[n];
                                t.splice(n--, 1);
                                for (var i = r.start1, o = r.start2, a = ""; 0 !== r.diffs.length;) {
                                    var s = new v.patch_obj,
                                        f = !0;
                                    for (s.start1 = i - a.length, s.start2 = o - a.length, "" !== a && (s.length1 = s.length2 = a.length, s.diffs.push([0, a])); 0 !== r.diffs.length && s.length1 < e - this.Patch_Margin;) {
                                        var l = r.diffs[0][0],
                                            h = r.diffs[0][1];
                                        1 === l ? (s.length2 += h.length, o += h.length, s.diffs.push(r.diffs.shift()), f = !1) : -1 === l && 1 == s.diffs.length && 0 == s.diffs[0][0] && h.length > 2 * e ? (s.length1 += h.length, i += h.length, f = !1, s.diffs.push([l, h]), r.diffs.shift()) : (h = h.substring(0, e - s.length1 - this.Patch_Margin), s.length1 += h.length, i += h.length, 0 === l ? (s.length2 += h.length, o += h.length) : f = !1, s.diffs.push([l, h]), h == r.diffs[0][1] ? r.diffs.shift() : r.diffs[0][1] = r.diffs[0][1].substring(h.length))
                                    }
                                    a = (a = this.diff_text2(s.diffs)).substring(a.length - this.Patch_Margin);
                                    var u = this.diff_text1(r.diffs).substring(0, this.Patch_Margin);
                                    "" !== u && (s.length1 += u.length, s.length2 += u.length, 0 !== s.diffs.length && 0 === s.diffs[s.diffs.length - 1][0] ? s.diffs[s.diffs.length - 1][1] += u : s.diffs.push([0, u])), f || t.splice(++n, 0, s)
                                }
                            }
                    }, v.prototype.patch_toText = function (t) {
                        for (var e = [], n = 0; n < t.length; n++) e[n] = t[n];
                        return e.join("")
                    }, v.prototype.patch_fromText = function (t) {
                        var e = [];
                        if (!t) return e;
                        for (var n = t.split("\n"), r = 0, i = /^@@ -(\d+),?(\d*) \+(\d+),?(\d*) @@$/; r < n.length;) {
                            var o = n[r].match(i);
                            if (!o) throw new Error("Invalid patch string: " + n[r]);
                            var a = new v.patch_obj;
                            for (e.push(a), a.start1 = parseInt(o[1], 10), "" === o[2] ? (a.start1--, a.length1 = 1) : "0" == o[2] ? a.length1 = 0 : (a.start1--, a.length1 = parseInt(o[2], 10)), a.start2 = parseInt(o[3], 10), "" === o[4] ? (a.start2--, a.length2 = 1) : "0" == o[4] ? a.length2 = 0 : (a.start2--, a.length2 = parseInt(o[4], 10)), r++; r < n.length;) {
                                var s = n[r].charAt(0);
                                try {
                                    var f = decodeURI(n[r].substring(1))
                                } catch (t) {
                                    throw new Error("Illegal escape in patch_fromText: " + f)
                                }
                                if ("-" == s) a.diffs.push([-1, f]);
                                else if ("+" == s) a.diffs.push([1, f]);
                                else if (" " == s) a.diffs.push([0, f]);
                                else {
                                    if ("@" == s) break;
                                    if ("" !== s) throw new Error('Invalid patch mode "' + s + '" in: ' + f)
                                }
                                r++
                            }
                        }
                        return e
                    }, (v.patch_obj = function () {
                        this.diffs = [], this.start1 = null, this.start2 = null, this.length1 = 0, this.length2 = 0
                    }).prototype.toString = function () {
                        for (var t, e = ["@@ -" + (0 === this.length1 ? this.start1 + ",0" : 1 == this.length1 ? this.start1 + 1 : this.start1 + 1 + "," + this.length1) + " +" + (0 === this.length2 ? this.start2 + ",0" : 1 == this.length2 ? this.start2 + 1 : this.start2 + 1 + "," + this.length2) + " @@\n"], n = 0; n < this.diffs.length; n++) {
                            switch (this.diffs[n][0]) {
                                case 1:
                                    t = "+";
                                    break;
                                case -1:
                                    t = "-";
                                    break;
                                case 0:
                                    t = " "
                            }
                            e[n + 1] = t + encodeURI(this.diffs[n][1]) + "\n"
                        }
                        return e.join("").replace(/%20/g, " ")
                    }, t.exports = v, t.exports.diff_match_patch = v, t.exports.DIFF_DELETE = -1, t.exports.DIFF_INSERT = 1, t.exports.DIFF_EQUAL = 0
                }(U = {
                    exports: {}
                }, U.exports), U.exports),
                z = null,
                $ = function (t) {
                    if (!z) {
                        var i = void 0;
                        if ("undefined" != typeof diff_match_patch) i = "function" == typeof diff_match_patch ? new diff_match_patch : new diff_match_patch.diff_match_patch;
                        else if (H) try {
                            i = H && new H
                        } catch (t) {
                            i = null
                        }
                        if (!i) {
                            if (!t) return null;
                            var e = new Error("text diff_match_patch library not found");
                            throw e.diff_match_patch_not_found = !0, e
                        }
                        z = {
                            diff: function (t, e) {
                                return i.patch_toText(i.patch_make(t, e))
                            },
                            patch: function (t, e) {
                                for (var n = i.patch_apply(i.patch_fromText(e), t), r = 0; r < n[1].length; r++) {
                                    if (!n[1][r]) new Error("text patch failed").textPatchFailed = !0
                                }
                                return n[0]
                            }
                        }
                    }
                    return z
                },
                Q = function (t) {
                    if ("string" === t.leftType) {
                        var e = t.options && t.options.textDiff && t.options.textDiff.minLength || 60;
                        if (t.left.length < e || t.right.length < e) t.setResult([t.left, t.right]).exit();
                        else {
                            var n = $();
                            if (n) {
                                var r = n.diff;
                                t.setResult([r(t.left, t.right), 0, 2]).exit()
                            } else t.setResult([t.left, t.right]).exit()
                        }
                    }
                },
                J = function (t) {
                    if (!t.nested && 2 === t.delta[2]) {
                        var e = $(!0).patch;
                        t.setResult(e(t.left, t.delta[0])).exit()
                    }
                },
                K = function (t) {
                    t.nested || 2 === t.delta[2] && t.setResult([function (t) {
                        var e, n = void 0,
                            r = void 0,
                            i = void 0,
                            o = void 0,
                            a = null,
                            s = /^@@ +-(\d+),(\d+) +\+(\d+),(\d+) +@@$/;
                        for (n = 0, e = (r = t.split("\n")).length; n < e; n++) {
                            var f = (i = r[n]).slice(0, 1);
                            "@" === f ? (a = s.exec(i), r[n] = "@@ -" + a[3] + "," + a[4] + " +" + a[1] + "," + a[2] + " @@") : "+" === f ? (r[n] = "-" + r[n].slice(1), "+" === r[n - 1].slice(0, 1) && (o = r[n], r[n] = r[n - 1], r[n - 1] = o)) : "-" === f && (r[n] = "+" + r[n].slice(1))
                        }
                        return r.join("\n")
                    }(t.delta[0]), 0, 2]).exit()
                };
            K.filterName = J.filterName = Q.filterName = "texts";
            var Z = function () {
                    function e(t) {
                        i(this, e), this.processor = new s(t), this.processor.pipe(new f("diff").append(x, m, q, Q, w, T).shouldHaveResult()), this.processor.pipe(new f("patch").append(A, B, _, J, j, S).shouldHaveResult()), this.processor.pipe(new f("reverse").append(M, V, b, K, O, F).shouldHaveResult())
                    }

                    return n(e, [{
                        key: "options",
                        value: function () {
                            var t;
                            return (t = this.processor).options.apply(t, arguments)
                        }
                    }, {
                        key: "diff",
                        value: function (t, e) {
                            return this.processor.process(new k(t, e))
                        }
                    }, {
                        key: "patch",
                        value: function (t, e) {
                            return this.processor.process(new v(t, e))
                        }
                    }, {
                        key: "reverse",
                        value: function (t) {
                            return this.processor.process(new g(t))
                        }
                    }, {
                        key: "unpatch",
                        value: function (t, e) {
                            return this.patch(t, this.reverse(e))
                        }
                    }, {
                        key: "clone",
                        value: function (t) {
                            return p(t)
                        }
                    }]), e
                }(),
                W = "function" == typeof Array.isArray ? Array.isArray : function (t) {
                    return t instanceof Array
                },
                X = "function" == typeof Object.keys ? function (t) {
                    return Object.keys(t)
                } : function (t) {
                    var e = [];
                    for (var n in t) Object.prototype.hasOwnProperty.call(t, n) && e.push(n);
                    return e
                },
                G = function (t) {
                    return "_t" === t ? -1 : "_" === t.substr(0, 1) ? parseInt(t.slice(1), 10) : parseInt(t, 10) + .1
                },
                Y = function (t, e) {
                    return G(t) - G(e)
                },
                tt = function () {
                    function t() {
                        i(this, t)
                    }

                    return n(t, [{
                        key: "format",
                        value: function (t, e) {
                            var n = {};
                            return this.prepareContext(n), this.recurse(n, t, e), this.finalize(n)
                        }
                    }, {
                        key: "prepareContext",
                        value: function (t) {
                            t.buffer = [], t.out = function () {
                                var t;
                                (t = this.buffer).push.apply(t, arguments)
                            }
                        }
                    }, {
                        key: "typeFormattterNotFound",
                        value: function (t, e) {
                            throw new Error("cannot format delta type: " + e)
                        }
                    }, {
                        key: "typeFormattterErrorFormatter",
                        value: function (t, e) {
                            return e.toString()
                        }
                    }, {
                        key: "finalize",
                        value: function (t) {
                            var e = t.buffer;
                            if (W(e)) return e.join("")
                        }
                    }, {
                        key: "recurse",
                        value: function (e, n, t, r, i, o, a) {
                            var s = n && o ? o.value : t;
                            if (void 0 !== n || void 0 !== r) {
                                var f = this.getDeltaType(n, o),
                                    l = "node" === f ? "a" === n._t ? "array" : "object" : "";
                                void 0 !== r ? this.nodeBegin(e, r, i, f, l, a) : this.rootBegin(e, f, l);
                                try {
                                    (this["format_" + f] || this.typeFormattterNotFound(e, f)).call(this, e, n, s, r, i, o)
                                } catch (t) {
                                    this.typeFormattterErrorFormatter(e, t, n, s, r, i, o), "undefined" != typeof console && console.error && console.error(t.stack)
                                }
                                void 0 !== r ? this.nodeEnd(e, r, i, f, l, a) : this.rootEnd(e, f, l)
                            }
                        }
                    }, {
                        key: "formatDeltaChildren",
                        value: function (i, o, a) {
                            var s = this;
                            this.forEachDeltaKey(o, a, function (t, e, n, r) {
                                s.recurse(i, o[t], a ? a[e] : void 0, t, e, n, r)
                            })
                        }
                    }, {
                        key: "forEachDeltaKey",
                        value: function (t, e, n) {
                            var r, i = X(t),
                                o = "a" === t._t,
                                a = {},
                                s = void 0;
                            if (void 0 !== e)
                                for (s in e) Object.prototype.hasOwnProperty.call(e, s) && (void 0 !== t[s] || o && void 0 !== t["_" + s] || i.push(s));
                            for (s in t)
                                if (Object.prototype.hasOwnProperty.call(t, s)) {
                                    var f = t[s];
                                    W(f) && 3 === f[2] && !(a[f[1].toString()] = {
                                        key: s,
                                        value: e && e[parseInt(s.substr(1))]
                                    }) !== this.includeMoveDestinations && void 0 === e && void 0 === t[f[1]] && i.push(f[1].toString())
                                }
                            o ? i.sort(Y) : i.sort();
                            for (var l = 0, h = i.length; l < h; l++) {
                                var u = i[l];
                                if (!o || "_t" !== u) {
                                    var c = o ? "number" == typeof u ? u : parseInt("_" === (r = u).substr(0, 1) ? r.slice(1) : r, 10) : u,
                                        d = l === h - 1;
                                    n(u, c, a[c], d)
                                }
                            }
                        }
                    }, {
                        key: "getDeltaType",
                        value: function (t, e) {
                            if (void 0 === t) return void 0 !== e ? "movedestination" : "unchanged";
                            if (W(t)) {
                                if (1 === t.length) return "added";
                                if (2 === t.length) return "modified";
                                if (3 === t.length && 0 === t[2]) return "deleted";
                                if (3 === t.length && 2 === t[2]) return "textdiff";
                                if (3 === t.length && 3 === t[2]) return "moved"
                            } else if ("object" === (void 0 === t ? "undefined" : h(t))) return "node";
                            return "unknown"
                        }
                    }, {
                        key: "parseTextDiff",
                        value: function (t) {
                            for (var e = [], n = t.split("\n@@ "), r = 0, i = n.length; r < i; r++) {
                                var o = n[r],
                                    a = {
                                        pieces: []
                                    },
                                    s = /^(?:@@ )?[-+]?(\d+),(\d+)/.exec(o).slice(1);
                                a.location = {
                                    line: s[0],
                                    chr: s[1]
                                };
                                for (var f = o.split("\n").slice(1), l = 0, h = f.length; l < h; l++) {
                                    var u = f[l];
                                    if (u.length) {
                                        var c = {
                                            type: "context"
                                        };
                                        "+" === u.substr(0, 1) ? c.type = "added" : "-" === u.substr(0, 1) && (c.type = "deleted"), c.text = u.slice(1), a.pieces.push(c)
                                    }
                                }
                                e.push(a)
                            }
                            return e
                        }
                    }]), t
                }(),
                et = Object.freeze({
                    default: tt
                }),
                nt = function (t) {
                    function e() {
                        return i(this, e), a(this, (e.__proto__ || Object.getPrototypeOf(e)).apply(this, arguments))
                    }

                    return o(e, tt), n(e, [{
                        key: "typeFormattterErrorFormatter",
                        value: function (t, e) {
                            t.out('<pre class="jsondiffpatch-error">' + e + "</pre>")
                        }
                    }, {
                        key: "formatValue",
                        value: function (t, e) {
                            t.out("<pre>" + rt(JSON.stringify(e, null, 2)) + "</pre>")
                        }
                    }, {
                        key: "formatTextDiffString",
                        value: function (t, e) {
                            var n = this.parseTextDiff(e);
                            t.out('<ul class="jsondiffpatch-textdiff">');
                            for (var r = 0, i = n.length; r < i; r++) {
                                var o = n[r];
                                t.out('<li><div class="jsondiffpatch-textdiff-location"><span class="jsondiffpatch-textdiff-line-number">' + o.location.line + '</span><span class="jsondiffpatch-textdiff-char">' + o.location.chr + '</span></div><div class="jsondiffpatch-textdiff-line">');
                                for (var a = o.pieces, s = 0, f = a.length; s < f; s++) {
                                    var l = a[s];
                                    t.out('<span class="jsondiffpatch-textdiff-' + l.type + '">' + rt(decodeURI(l.text)) + "</span>")
                                }
                                t.out("</div></li>")
                            }
                            t.out("</ul>")
                        }
                    }, {
                        key: "rootBegin",
                        value: function (t, e, n) {
                            var r = "jsondiffpatch-" + e + (n ? " jsondiffpatch-child-node-type-" + n : "");
                            t.out('<div class="jsondiffpatch-delta ' + r + '">')
                        }
                    }, {
                        key: "rootEnd",
                        value: function (t) {
                            t.out("</div>" + (t.hasArrows ? '<script type="text/javascript">setTimeout(' + it.toString() + ",10);<\/script>" : ""))
                        }
                    }, {
                        key: "nodeBegin",
                        value: function (t, e, n, r, i) {
                            var o = "jsondiffpatch-" + r + (i ? " jsondiffpatch-child-node-type-" + i : "");
                            t.out('<li class="' + o + '" data-key="' + n + '"><div class="jsondiffpatch-property-name">' + n + "</div>")
                        }
                    }, {
                        key: "nodeEnd",
                        value: function (t) {
                            t.out("</li>")
                        }
                    }, {
                        key: "format_unchanged",
                        value: function (t, e, n) {
                            void 0 !== n && (t.out('<div class="jsondiffpatch-value">'), this.formatValue(t, n), t.out("</div>"))
                        }
                    }, {
                        key: "format_movedestination",
                        value: function (t, e, n) {
                            void 0 !== n && (t.out('<div class="jsondiffpatch-value">'), this.formatValue(t, n), t.out("</div>"))
                        }
                    }, {
                        key: "format_node",
                        value: function (t, e, n) {
                            var r = "a" === e._t ? "array" : "object";
                            t.out('<ul class="jsondiffpatch-node jsondiffpatch-node-type-' + r + '">'), this.formatDeltaChildren(t, e, n), t.out("</ul>")
                        }
                    }, {
                        key: "format_added",
                        value: function (t, e) {
                            t.out('<div class="jsondiffpatch-value">'), this.formatValue(t, e[0]), t.out("</div>")
                        }
                    }, {
                        key: "format_modified",
                        value: function (t, e) {
                            t.out('<br/><div class="jsondiffpatch-value jsondiffpatch-left-value">'), this.formatValue(t, e[0]), t.out('</div><br/><div class="jsondiffpatch-value jsondiffpatch-right-value">'), this.formatValue(t, e[1]), t.out("</div>")
                        }
                    }, {
                        key: "format_deleted",
                        value: function (t, e) {
                            t.out('<div class="jsondiffpatch-value">'), this.formatValue(t, e[0]), t.out("</div>")
                        }
                    }, {
                        key: "format_moved",
                        value: function (t, e) {
                            t.out('<div class="jsondiffpatch-value">'), this.formatValue(t, e[0]), t.out('</div><div class="jsondiffpatch-moved-destination">' + e[1] + "</div>"), t.out('<div class="jsondiffpatch-arrow" style="position: relative; left: -34px;">\n          <svg width="30" height="60" style="position: absolute; display: none;">\n          <defs>\n              <marker id="markerArrow" markerWidth="8" markerHeight="8"\n                 refx="2" refy="4"\n                     orient="auto" markerUnits="userSpaceOnUse">\n                  <path d="M1,1 L1,7 L7,4 L1,1" style="fill: #339;" />\n              </marker>\n          </defs>\n          <path d="M30,0 Q-10,25 26,50"\n            style="stroke: #88f; stroke-width: 2px; fill: none; stroke-opacity: 0.5; marker-end: url(#markerArrow);"\n          ></path>\n          </svg>\n      </div>'), t.hasArrows = !0
                        }
                    }, {
                        key: "format_textdiff",
                        value: function (t, e) {
                            t.out('<div class="jsondiffpatch-value">'), this.formatTextDiffString(t, e[0]), t.out("</div>")
                        }
                    }]), e
                }();

            function rt(t) {
                for (var e = t, n = [
                    [/&/g, "&amp;"],
                    [/</g, "&lt;"],
                    [/>/g, "&gt;"],
                    [/'/g, "&apos;"],
                    [/"/g, "&quot;"]
                ], r = 0; r < n.length; r++) e = e.replace(n[r][0], n[r][1]);
                return e
            }

            var it = function (t) {
                    var e = t || document;
                    !function (t, e, n) {
                        for (var r = t.querySelectorAll(e), i = 0, o = r.length; i < o; i++) n(r[i])
                    }(e, ".jsondiffpatch-arrow", function (t) {
                        var e = t.parentNode,
                            n = t.children,
                            r = t.style,
                            i = e,
                            o = n[0],
                            a = o.children[1];
                        o.style.display = "none";
                        var s, f, l,
                            h = (s = i.querySelector(".jsondiffpatch-moved-destination"), f = s.textContent, l = s.innerText, f || l),
                            u = i.parentNode,
                            c = void 0;
                        if (function (t, e) {
                            for (var n = t.children, r = 0, i = n.length; r < i; r++) e(n[r], r)
                        }(u, function (t) {
                            t.getAttribute("data-key") === h && (c = t)
                        }), c) try {
                            var d = c.offsetTop - i.offsetTop;
                            o.setAttribute("height", Math.abs(d) + 6), r.top = -8 + (0 < d ? 0 : d) + "px";
                            var p = 0 < d ? "M30,0 Q-10," + Math.round(d / 2) + " 26," + (d - 4) : "M30," + -d + " Q-10," + Math.round(-d / 2) + " 26,4";
                            a.setAttribute("d", p), o.style.display = ""
                        } catch (t) {
                        }
                    })
                },
                ot = function (t, e, n) {
                    var r = e || document.body,
                        i = "jsondiffpatch-unchanged-",
                        o = {
                            showing: i + "showing",
                            hiding: i + "hiding",
                            visible: i + "visible",
                            hidden: i + "hidden"
                        },
                        a = r.classList;
                    if (a) {
                        if (!n) return a.remove(o.showing), a.remove(o.hiding), a.remove(o.visible), a.remove(o.hidden), void (!1 === t && a.add(o.hidden));
                        !1 === t ? (a.remove(o.showing), a.add(o.visible), setTimeout(function () {
                            a.add(o.hiding)
                        }, 10)) : (a.remove(o.hiding), a.add(o.showing), a.remove(o.hidden));
                        var s = setInterval(function () {
                            it(r)
                        }, 100);
                        setTimeout(function () {
                            a.remove(o.showing), a.remove(o.hiding), !1 === t ? (a.add(o.hidden), a.remove(o.visible)) : (a.add(o.visible), a.remove(o.hidden)), setTimeout(function () {
                                a.remove(o.visible), clearInterval(s)
                            }, n + 400)
                        }, n)
                    }
                },
                at = void 0;
            var st = Object.freeze({
                    showUnchanged: ot,
                    hideUnchanged: function (t, e) {
                        return ot(!1, t, e)
                    },
                    default: nt,
                    format: function (t, e) {
                        return at || (at = new nt), at.format(t, e)
                    }
                }),
                ft = function (t) {
                    function e() {
                        i(this, e);
                        var t = a(this, (e.__proto__ || Object.getPrototypeOf(e)).call(this));
                        return t.includeMoveDestinations = !1, t
                    }

                    return o(e, tt), n(e, [{
                        key: "prepareContext",
                        value: function (n) {
                            r(e.prototype.__proto__ || Object.getPrototypeOf(e.prototype), "prepareContext", this).call(this, n), n.indent = function (t) {
                                this.indentLevel = (this.indentLevel || 0) + (void 0 === t ? 1 : t), this.indentPad = new Array(this.indentLevel + 1).join("&nbsp;&nbsp;")
                            }, n.row = function (t, e) {
                                n.out('<tr><td style="white-space: normal;"><pre class="jsondiffpatch-annotated-indent" style="display: inline-block">'), n.out(n.indentPad), n.out('</pre><pre style="display: inline-block">'), n.out(t), n.out('</pre></td><td class="jsondiffpatch-delta-note"><div>'), n.out(e), n.out("</div></td></tr>")
                            }
                        }
                    }, {
                        key: "typeFormattterErrorFormatter",
                        value: function (t, e) {
                            t.row("", '<pre class="jsondiffpatch-error">' + e + "</pre>")
                        }
                    }, {
                        key: "formatTextDiffString",
                        value: function (t, e) {
                            var n = this.parseTextDiff(e);
                            t.out('<ul class="jsondiffpatch-textdiff">');
                            for (var r = 0, i = n.length; r < i; r++) {
                                var o = n[r];
                                t.out('<li><div class="jsondiffpatch-textdiff-location"><span class="jsondiffpatch-textdiff-line-number">' + o.location.line + '</span><span class="jsondiffpatch-textdiff-char">' + o.location.chr + '</span></div><div class="jsondiffpatch-textdiff-line">');
                                for (var a = o.pieces, s = 0, f = a.length; s < f; s++) {
                                    var l = a[s];
                                    t.out('<span class="jsondiffpatch-textdiff-' + l.type + '">' + l.text + "</span>")
                                }
                                t.out("</div></li>")
                            }
                            t.out("</ul>")
                        }
                    }, {
                        key: "rootBegin",
                        value: function (t, e, n) {
                            t.out('<table class="jsondiffpatch-annotated-delta">'), "node" === e && (t.row("{"), t.indent()), "array" === n && t.row('"_t": "a",', "Array delta (member names indicate array indices)")
                        }
                    }, {
                        key: "rootEnd",
                        value: function (t, e) {
                            "node" === e && (t.indent(-1), t.row("}")), t.out("</table>")
                        }
                    }, {
                        key: "nodeBegin",
                        value: function (t, e, n, r, i) {
                            t.row("&quot;" + e + "&quot;: {"), "node" === r && t.indent(), "array" === i && t.row('"_t": "a",', "Array delta (member names indicate array indices)")
                        }
                    }, {
                        key: "nodeEnd",
                        value: function (t, e, n, r, i, o) {
                            "node" === r && t.indent(-1), t.row("}" + (o ? "" : ","))
                        }
                    }, {
                        key: "format_unchanged",
                        value: function () {
                        }
                    }, {
                        key: "format_movedestination",
                        value: function () {
                        }
                    }, {
                        key: "format_node",
                        value: function (t, e, n) {
                            this.formatDeltaChildren(t, e, n)
                        }
                    }]), e
                }(),
                lt = function (t) {
                    return '<pre style="display:inline-block">&quot;' + t + "&quot;</pre>"
                },
                ht = {
                    added: function (t, e, n, r) {
                        var i = " <pre>([newValue])</pre>";
                        return void 0 === r ? "new value" + i : "number" == typeof r ? "insert at index " + r + i : "add property " + lt(r) + i
                    },
                    modified: function (t, e, n, r) {
                        var i = " <pre>([previousValue, newValue])</pre>";
                        return void 0 === r ? "modify value" + i : "number" == typeof r ? "modify at index " + r + i : "modify property " + lt(r) + i
                    },
                    deleted: function (t, e, n, r) {
                        var i = " <pre>([previousValue, 0, 0])</pre>";
                        return void 0 === r ? "delete value" + i : "number" == typeof r ? "remove index " + r + i : "delete property " + lt(r) + i
                    },
                    moved: function (t, e, n, r) {
                        return 'move from <span title="(position to remove at original state)">index ' + r + '</span> to <span title="(position to insert at final state)">index ' + t[1] + "</span>"
                    },
                    textdiff: function (t, e, n, r) {
                        return "text diff" + (void 0 === r ? "" : "number" == typeof r ? " at index " + r : " at property " + lt(r)) + ', format is <a href="https://code.google.com/p/google-diff-match-patch/wiki/Unidiff">a variation of Unidiff</a>'
                    }
                },
                ut = function (t, e) {
                    var n = this.getDeltaType(e),
                        r = ht[n],
                        i = r && r.apply(r, Array.prototype.slice.call(arguments, 1)),
                        o = JSON.stringify(e, null, 2);
                    "textdiff" === n && (o = o.split("\\n").join('\\n"+\n   "')), t.indent(), t.row(o, i), t.indent(-1)
                };
            ft.prototype.format_added = ut, ft.prototype.format_modified = ut, ft.prototype.format_deleted = ut, ft.prototype.format_moved = ut, ft.prototype.format_textdiff = ut;
            var ct = void 0;
            var dt = Object.freeze({
                    default: ft,
                    format: function (t, e) {
                        return ct || (ct = new ft), ct.format(t, e)
                    }
                }),
                pt = "add",
                vt = "remove",
                gt = "replace",
                yt = "move",
                mt = function (t) {
                    function e() {
                        i(this, e);
                        var t = a(this, (e.__proto__ || Object.getPrototypeOf(e)).call(this));
                        return t.includeMoveDestinations = !0, t
                    }

                    return o(e, tt), n(e, [{
                        key: "prepareContext",
                        value: function (t) {
                            r(e.prototype.__proto__ || Object.getPrototypeOf(e.prototype), "prepareContext", this).call(this, t), t.result = [], t.path = [], t.pushCurrentOp = function (t) {
                                var e = t.op,
                                    n = t.value,
                                    r = {
                                        op: e,
                                        path: this.currentPath()
                                    };
                                void 0 !== n && (r.value = n), this.result.push(r)
                            }, t.pushMoveOp = function (t) {
                                var e = this.currentPath();
                                this.result.push({
                                    op: yt,
                                    from: e,
                                    path: this.toPath(t)
                                })
                            }, t.currentPath = function () {
                                return "/" + this.path.join("/")
                            }, t.toPath = function (t) {
                                var e = this.path.slice();
                                return e[e.length - 1] = t, "/" + e.join("/")
                            }
                        }
                    }, {
                        key: "typeFormattterErrorFormatter",
                        value: function (t, e) {
                            t.out("[ERROR] " + e)
                        }
                    }, {
                        key: "rootBegin",
                        value: function () {
                        }
                    }, {
                        key: "rootEnd",
                        value: function () {
                        }
                    }, {
                        key: "nodeBegin",
                        value: function (t, e, n) {
                            t.path.push(n)
                        }
                    }, {
                        key: "nodeEnd",
                        value: function (t) {
                            t.path.pop()
                        }
                    }, {
                        key: "format_unchanged",
                        value: function () {
                        }
                    }, {
                        key: "format_movedestination",
                        value: function () {
                        }
                    }, {
                        key: "format_node",
                        value: function (t, e, n) {
                            this.formatDeltaChildren(t, e, n)
                        }
                    }, {
                        key: "format_added",
                        value: function (t, e) {
                            t.pushCurrentOp({
                                op: pt,
                                value: e[0]
                            })
                        }
                    }, {
                        key: "format_modified",
                        value: function (t, e) {
                            t.pushCurrentOp({
                                op: gt,
                                value: e[1]
                            })
                        }
                    }, {
                        key: "format_deleted",
                        value: function (t) {
                            t.pushCurrentOp({
                                op: vt
                            })
                        }
                    }, {
                        key: "format_moved",
                        value: function (t, e) {
                            var n = e[1];
                            t.pushMoveOp(n)
                        }
                    }, {
                        key: "format_textdiff",
                        value: function () {
                            throw new Error("Not implemented")
                        }
                    }, {
                        key: "format",
                        value: function (t, e) {
                            var n = {};
                            return this.prepareContext(n), this.recurse(n, t, e), n.result
                        }
                    }]), e
                }(),
                _t = function (t) {
                    return t[t.length - 1]
                },
                bt = function (t) {
                    return n = function (t, e) {
                        var n, r, i, o, a = t.path.split("/"),
                            s = e.path.split("/");
                        return a.length !== s.length ? a.length - s.length : (n = _t(a), r = _t(s), i = parseInt(n, 10), o = parseInt(r, 10), isNaN(i) || isNaN(o) ? 0 : o - i)
                    }, (e = t).sort(n), e;
                    var e, n
                },
                xt = function (t, n) {
                    var e = Array(n.length + 1).fill().map(function () {
                        return []
                    });
                    return t.map(function (e) {
                        var t = n.map(function (t) {
                            return t(e)
                        }).indexOf(!0);
                        return t < 0 && (t = n.length), {
                            item: e,
                            position: t
                        }
                    }).reduce(function (t, e) {
                        return t[e.position].push(e.item), t
                    }, e)
                },
                wt = function (t) {
                    return "move" === t.op
                },
                kt = function (t) {
                    return "remove" === t.op
                },
                jt = void 0,
                At = function (t, e) {
                    return jt || (jt = new mt), n = jt.format(t, e), r = xt(n, [wt, kt]), i = l(r, 3), o = i[0], a = i[1], s = i[2], f = bt(a), [].concat(u(f), u(o), u(s));
                    var n, r, i, o, a, s, f
                },
                Ot = Object.freeze({
                    default: mt,
                    partitionOps: xt,
                    format: At,
                    log: function (t, e) {
                        console.log(At(t, e))
                    }
                });

            function Mt(t) {
                return e && e[t] || function () {
                    for (var t = arguments.length, e = Array(t), n = 0; n < t; n++) e[n] = arguments[n];
                    return e
                }
            }

            var Rt = {
                    added: Mt("green"),
                    deleted: Mt("red"),
                    movedestination: Mt("gray"),
                    moved: Mt("yellow"),
                    unchanged: Mt("gray"),
                    error: Mt("white.bgRed"),
                    textDiffLine: Mt("gray")
                },
                Ct = function (t) {
                    function e() {
                        i(this, e);
                        var t = a(this, (e.__proto__ || Object.getPrototypeOf(e)).call(this));
                        return t.includeMoveDestinations = !1, t
                    }

                    return o(e, tt), n(e, [{
                        key: "prepareContext",
                        value: function (t) {
                            r(e.prototype.__proto__ || Object.getPrototypeOf(e.prototype), "prepareContext", this).call(this, t), t.indent = function (t) {
                                this.indentLevel = (this.indentLevel || 0) + (void 0 === t ? 1 : t), this.indentPad = new Array(this.indentLevel + 1).join("  "), this.outLine()
                            }, t.outLine = function () {
                                this.buffer.push("\n" + (this.indentPad || ""))
                            }, t.out = function () {
                                for (var t = arguments.length, e = Array(t), n = 0; n < t; n++) e[n] = arguments[n];
                                for (var r = 0, i = e.length; r < i; r++) {
                                    var o = e[r].split("\n").join("\n" + (this.indentPad || ""));
                                    this.color && this.color[0] && (o = this.color[0](o)), this.buffer.push(o)
                                }
                            }, t.pushColor = function (t) {
                                this.color = this.color || [], this.color.unshift(t)
                            }, t.popColor = function () {
                                this.color = this.color || [], this.color.shift()
                            }
                        }
                    }, {
                        key: "typeFormattterErrorFormatter",
                        value: function (t, e) {
                            t.pushColor(Rt.error), t.out("[ERROR]" + e), t.popColor()
                        }
                    }, {
                        key: "formatValue",
                        value: function (t, e) {
                            t.out(JSON.stringify(e, null, 2))
                        }
                    }, {
                        key: "formatTextDiffString",
                        value: function (t, e) {
                            var n = this.parseTextDiff(e);
                            t.indent();
                            for (var r = 0, i = n.length; r < i; r++) {
                                var o = n[r];
                                t.pushColor(Rt.textDiffLine), t.out(o.location.line + "," + o.location.chr + " "), t.popColor();
                                for (var a = o.pieces, s = 0, f = a.length; s < f; s++) {
                                    var l = a[s];
                                    t.pushColor(Rt[l.type]), t.out(l.text), t.popColor()
                                }
                                r < i - 1 && t.outLine()
                            }
                            t.indent(-1)
                        }
                    }, {
                        key: "rootBegin",
                        value: function (t, e, n) {
                            t.pushColor(Rt[e]), "node" === e && (t.out("array" === n ? "[" : "{"), t.indent())
                        }
                    }, {
                        key: "rootEnd",
                        value: function (t, e, n) {
                            "node" === e && (t.indent(-1), t.out("array" === n ? "]" : "}")), t.popColor()
                        }
                    }, {
                        key: "nodeBegin",
                        value: function (t, e, n, r, i) {
                            t.pushColor(Rt[r]), t.out(n + ": "), "node" === r && (t.out("array" === i ? "[" : "{"), t.indent())
                        }
                    }, {
                        key: "nodeEnd",
                        value: function (t, e, n, r, i, o) {
                            "node" === r && (t.indent(-1), t.out("array" === i ? "]" : "}" + (o ? "" : ","))), o || t.outLine(), t.popColor()
                        }
                    }, {
                        key: "format_unchanged",
                        value: function (t, e, n) {
                            void 0 !== n && this.formatValue(t, n)
                        }
                    }, {
                        key: "format_movedestination",
                        value: function (t, e, n) {
                            void 0 !== n && this.formatValue(t, n)
                        }
                    }, {
                        key: "format_node",
                        value: function (t, e, n) {
                            this.formatDeltaChildren(t, e, n)
                        }
                    }, {
                        key: "format_added",
                        value: function (t, e) {
                            this.formatValue(t, e[0])
                        }
                    }, {
                        key: "format_modified",
                        value: function (t, e) {
                            t.pushColor(Rt.deleted), this.formatValue(t, e[0]), t.popColor(), t.out(" => "), t.pushColor(Rt.added), this.formatValue(t, e[1]), t.popColor()
                        }
                    }, {
                        key: "format_deleted",
                        value: function (t, e) {
                            this.formatValue(t, e[0])
                        }
                    }, {
                        key: "format_moved",
                        value: function (t, e) {
                            t.out("==> " + e[1])
                        }
                    }, {
                        key: "format_textdiff",
                        value: function (t, e) {
                            this.formatTextDiffString(t, e[0])
                        }
                    }]), e
                }(),
                Et = void 0,
                Pt = function (t, e) {
                    return Et || (Et = new Ct), Et.format(t, e)
                };
            var Dt = Object.freeze({
                    default: Ct,
                    format: Pt,
                    log: function (t, e) {
                        console.log(Pt(t, e))
                    }
                }),
                Tt = Object.freeze({
                    base: et,
                    html: st,
                    annotated: dt,
                    jsonpatch: Ot,
                    console: Dt
                });
            var Nt = void 0;
            t.DiffPatcher = Z, t.formatters = Tt, t.console = Dt, t.create = function (t) {
                return new Z(t)
            }, t.dateReviver = function (t, e) {
                var n = void 0;
                return "string" == typeof e && (n = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(?:\.(\d*))?(Z|([+-])(\d{2}):(\d{2}))$/.exec(e)) ? new Date(Date.UTC(+n[1], +n[2] - 1, +n[3], +n[4], +n[5], +n[6], +(n[7] || 0))) : e
            }, t.diff = function () {
                return Nt || (Nt = new Z), Nt.diff.apply(Nt, arguments)
            }, t.patch = function () {
                return Nt || (Nt = new Z), Nt.patch.apply(Nt, arguments)
            }, t.unpatch = function () {
                return Nt || (Nt = new Z), Nt.unpatch.apply(Nt, arguments)
            }, t.reverse = function () {
                return Nt || (Nt = new Z), Nt.reverse.apply(Nt, arguments)
            }, t.clone = function () {
                return Nt || (Nt = new Z), Nt.clone.apply(Nt, arguments)
            }, Object.defineProperty(t, "__esModule", {
                value: !0
            })
        });
    </script>
</head>
<#--https://github.com/benjamine/jsondiffpatch/blob/master/docs/formatters-styles/html.css-->
<style type="text/css">
    .jsondiffpatch-delta {
        font-family: 'Bitstream Vera Sans Mono', 'DejaVu Sans Mono', Monaco, Courier, monospace;
        font-size: 12px;
        margin: 0;
        padding: 0 0 0 12px;
        display: inline-block;
    }

    .jsondiffpatch-delta pre {
        font-family: 'Bitstream Vera Sans Mono', 'DejaVu Sans Mono', Monaco, Courier, monospace;
        font-size: 12px;
        margin: 0;
        padding: 0;
        display: inline-block;
    }

    ul.jsondiffpatch-delta {
        list-style-type: none;
        padding: 0 0 0 20px;
        margin: 0;
    }

    .jsondiffpatch-delta ul {
        list-style-type: none;
        padding: 0 0 0 20px;
        margin: 0;
    }

    .jsondiffpatch-added .jsondiffpatch-property-name,
    .jsondiffpatch-added .jsondiffpatch-value pre,
    .jsondiffpatch-modified .jsondiffpatch-right-value pre,
    .jsondiffpatch-textdiff-added {
        background: #bbffbb;
    }

    .jsondiffpatch-deleted .jsondiffpatch-property-name,
    .jsondiffpatch-deleted pre,
    .jsondiffpatch-modified .jsondiffpatch-left-value pre,
    .jsondiffpatch-textdiff-deleted {
        background: #ffbbbb;
    }

    .jsondiffpatch-unchanged,
    .jsondiffpatch-movedestination {
        color: gray;
    }

    .jsondiffpatch-unchanged,
    .jsondiffpatch-movedestination > .jsondiffpatch-value {
        transition: all 0.5s;
        -webkit-transition: all 0.5s;
        overflow-y: hidden;
    }

    .jsondiffpatch-unchanged-showing .jsondiffpatch-unchanged,
    .jsondiffpatch-unchanged-showing .jsondiffpatch-movedestination > .jsondiffpatch-value {
        max-height: 100px;
    }

    .jsondiffpatch-unchanged-hidden .jsondiffpatch-unchanged,
    .jsondiffpatch-unchanged-hidden .jsondiffpatch-movedestination > .jsondiffpatch-value {
        max-height: 0;
    }

    .jsondiffpatch-unchanged-hiding .jsondiffpatch-movedestination > .jsondiffpatch-value,
    .jsondiffpatch-unchanged-hidden .jsondiffpatch-movedestination > .jsondiffpatch-value {
        display: block;
    }

    .jsondiffpatch-unchanged-visible .jsondiffpatch-unchanged,
    .jsondiffpatch-unchanged-visible .jsondiffpatch-movedestination > .jsondiffpatch-value {
        max-height: 100px;
    }

    .jsondiffpatch-unchanged-hiding .jsondiffpatch-unchanged,
    .jsondiffpatch-unchanged-hiding .jsondiffpatch-movedestination > .jsondiffpatch-value {
        max-height: 0;
    }

    .jsondiffpatch-unchanged-showing .jsondiffpatch-arrow,
    .jsondiffpatch-unchanged-hiding .jsondiffpatch-arrow {
        display: none;
    }

    .jsondiffpatch-value {
        display: inline-block;
    }

    .jsondiffpatch-property-name {
        display: inline-block;
        padding-right: 5px;
        vertical-align: top;
    }

    .jsondiffpatch-property-name:after {
        content: ': ';
    }

    .jsondiffpatch-child-node-type-array > .jsondiffpatch-property-name:after {
        content: ': [';
    }

    .jsondiffpatch-child-node-type-array:after {
        content: '],';
    }

    div.jsondiffpatch-child-node-type-array:before {
        content: '[';
    }

    div.jsondiffpatch-child-node-type-array:after {
        content: ']';
    }

    .jsondiffpatch-child-node-type-object > .jsondiffpatch-property-name:after {
        content: ': {';
    }

    .jsondiffpatch-child-node-type-object:after {
        content: '},';
    }

    div.jsondiffpatch-child-node-type-object:before {
        content: '{';
    }

    div.jsondiffpatch-child-node-type-object:after {
        content: '}';
    }

    .jsondiffpatch-value pre:after {
        content: ',';
    }

    li:last-child > .jsondiffpatch-value pre:after,
    .jsondiffpatch-modified > .jsondiffpatch-left-value pre:after {
        content: '';
    }

    .jsondiffpatch-modified .jsondiffpatch-value {
        display: inline-block;
    }

    .jsondiffpatch-modified .jsondiffpatch-right-value {
        margin-left: 0px;
    }

    .jsondiffpatch-moved .jsondiffpatch-value {
        display: none;
    }

    .jsondiffpatch-moved .jsondiffpatch-moved-destination {
        display: inline-block;
        background: #ffffbb;
        color: #888;
    }

    .jsondiffpatch-moved .jsondiffpatch-moved-destination:before {
        content: ' => ';
    }

    ul.jsondiffpatch-textdiff {
        padding: 0;
    }

    .jsondiffpatch-textdiff-location {
        color: #bbb;
        display: inline-block;
        min-width: 60px;
    }

    .jsondiffpatch-textdiff-line {
        display: inline-block;
    }

    .jsondiffpatch-textdiff-line-number:after {
        content: ',';
    }

    .jsondiffpatch-error {
        background: red;
        color: white;
        font-weight: bold;
    }

</style>
<body>
<div id="visual"></div>
<script>
    var left = ${data.actual};
    var right = ${data.expected};
    var delta = ${data.patch};
    document.getElementById('visual').innerHTML = jsondiffpatch.formatters.html.format(delta, left);

</script>
</body>
</html>
