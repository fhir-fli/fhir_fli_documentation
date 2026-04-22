((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,E,B={fR:function fR(d,e){this.c=d
this.a=e},eB:function eB(d,e){this.b=d
this.a=e},hQ:function hQ(d,e,f,g,h,i){var _=this
_.d$=d
_.e$=e
_.f$=f
_.c=_.b=_.a=null
_.d=g
_.e=null
_.f=h
_.w=_.r=null
_.x=i
_.Q=_.z=_.y=null
_.as=!1
_.at=!0
_.ax=!1
_.CW=null
_.cx=!1},hD:function hD(d){var _=this
_.d=d
_.c=_.b=_.a=null},fz:function fz(){},e7:function e7(d,e){this.a=d
this.$ti=e},
qU(){return new B.ch(null)},
ch:function ch(d){this.a=d},
jT:function jT(){},
jU:function jU(d){this.a=d}},D,C,F,G
J=c[1]
A=c[0]
E=c[2]
B=a.updateHolder(c[5],B)
D=c[16]
C=c[11]
F=c[8]
G=c[13]
B.fR.prototype={
N(d){var x,w,v,u,t,s=A.j(A.j(b.G.document).createElement("template"))
s.innerHTML=this.c
x=A.f([],y.p)
for(w=A.jN(A.j(A.j(s.content).childNodes)),v=w.$ti,w=new A.bB(w.a(),v.h("bB<1>")),u=y.g,v=v.c;w.n();){t=w.b
if(t==null)t=v.a(t)
x.push(new B.eB(t,new B.e7(t,u)))}return new C.c9(x,null)}}
B.eB.prototype={
aa(){var x=($.W+1)%16777215
$.W=x
return new B.hQ(null,!1,!1,x,this,E.f)}}
B.hQ.prototype={
gt(){return y.k.a(A.l.prototype.gt.call(this))},
ab(d){this.eQ(y.k.a(d))},
ah(){var x,w=this.CW.d$
w.toString
x=new B.hD(y.k.a(A.l.prototype.gt.call(this)).b)
x.a=w
return x},
ac(d){}}
B.hD.prototype={
ap(d,e){throw A.a(A.K("Raw nodes cannot have children attached to them."))},
F(d,e){throw A.a(A.K("Text nodes cannot have children removed from them."))},
ai(){},
c0(d){y.b.a(d)
return null},
gL(){return this.d}}
B.fz.prototype={}
B.e7.prototype={
G(d,e){if(e==null)return!1
return J.mg(e)===A.aI(this)&&this.$ti.b(e)&&e.a===this.a},
gC(d){return A.nx([A.aI(this),this.a])},
j(d){var x=this.$ti,w=x.c,v=this.a,u=A.an(w)===D.aN?"<'"+A.m(v)+"'>":"<"+A.m(v)+">"
if(A.aI(this)===A.an(x))return"["+u+"]"
return"["+A.an(w).j(0)+" "+u+"]"}}
B.ch.prototype={
N(d){var x=null,w=y.p,v=A.f([],w)
v.push(C.oT(A.f([new B.fR('<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="4" x2="20" y1="12" y2="12"></line><line x1="4" x2="20" y1="6" y2="6"></line><line x1="4" x2="20" y1="18" y2="18"></line></svg>\n',x)],w),x,"sidebar-toggle-button",new B.jT(),x))
return new C.c9(v,x)}}
var z=a.updateTypes([])
B.jT.prototype={
$0(){var x,w,v,u,t,s,r={}
r.a=r.b=null
x=new B.jU(r)
w=b.G
v=A.y(A.j(A.j(w.window).document).querySelector(".sidebar-close"))
if(v==null)u=null
else{t=y.f
u=A.em(v,"click",t.h("~(1)?").a(x),!1,t.c)}r.b=u
v=A.y(A.j(A.j(w.window).document).querySelector(".sidebar-barrier"))
if(v==null)s=null
else{t=y.f
s=A.em(v,"click",t.h("~(1)?").a(x),!1,t.c)}r.a=s
r=A.y(A.j(A.j(w.window).document).querySelector(".sidebar-container"))
if(r!=null)A.j(r.classList).add("open")},
$S:0}
B.jU.prototype={
$1(d){var x=this.a,w=x.b
if(w!=null)w.aq()
x=x.a
if(x!=null)x.aq()
x=A.y(A.j(A.j(b.G.window).document).querySelector(".sidebar-container"))
if(x!=null)A.j(x.classList).remove("open")},
$S:57};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(G.J,[B.fR,B.ch])
w(B.eB,A.n)
w(B.hQ,A.cb)
w(B.hD,A.aq)
w(B.fz,F.aV)
w(B.e7,B.fz)
w(B.jT,A.bn)
w(B.jU,A.a4)})()
A.bm(b.typeUniverse,JSON.parse('{"fR":{"J":[],"n":[]},"eB":{"n":[]},"hQ":{"ai":[],"l":[],"a1":[]},"hD":{"aq":[],"bP":[]},"fz":{"aV":[]},"e7":{"aV":[]},"ch":{"J":[],"n":[]}}'))
var y={p:A.t("r<n>"),g:A.t("e7<p>"),f:A.t("ei<p>"),k:A.t("eB"),b:A.t("L(p)")};(function constants(){D.aN=A.ap("c")})()};
(a=>{a["wBOXKKA22UdIFnsPxZDGKKU4l+M="]=a.current})($__dart_deferred_initializers__);
//# sourceMappingURL=main.client.dart.js_10.part.js.map
