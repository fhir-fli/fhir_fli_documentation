((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,F,D,H,A={
bI(d){var x=$.np.k(0,d)
if(x==null){x=new A.f8(d,B.f([],y.C))
$.np.i(0,d,x)}return x},
f9:function f9(d,e){this.a=d
this.b=e},
dn:function dn(d,e){this.c=d
this.a=e},
ht:function ht(d,e,f,g,h,i,j){var _=this
_.d$=d
_.e$=e
_.f$=f
_.cy=null
_.db=g
_.c=_.b=_.a=null
_.d=h
_.e=null
_.f=i
_.w=_.r=null
_.x=j
_.Q=_.z=_.y=null
_.as=!1
_.at=!0
_.ax=!1
_.CW=null
_.cx=!1},
bc:function bc(d,e,f){var _=this
_.w=d
_.x=e
_.y=null
_.z=f
_.d=$
_.c=_.b=_.a=null},
f8:function f8(d,e){var _=this
_.a=d
_.e=_.d=_.c=_.b=$
_.f=e
_.r=!0},
iE:function iE(){},
ih:function ih(d,e,f,g,h){var _=this
_.c=d
_.d=e
_.e=f
_.at=g
_.a=h},
iW:function iW(d,e){this.a=d
this.b=e},
fD:function fD(d,e){this.c=d
this.a=e},
hd:function hd(d,e){this.c=d
this.a=e},
es:function es(d,e,f){this.c=d
this.d=e
this.a=f},
rg(){return new A.bx(null)},
bx:function bx(d){this.a=d},
hg:function hg(){this.d=!1
this.c=this.a=null},
kd:function kd(d){this.a=d},
kc:function kc(d){this.a=d},
qN(d){var x,w,v=y.w,u=B.O(v,v)
for(x=0;x<B.V(d.length);++x){w=B.y(d.item(x))
u.i(0,B.w(w.name),B.w(w.value))}return u}},E,G,I,K,L
B=c[0]
C=c[2]
F=c[11]
D=c[12]
H=c[13]
A=a.updateHolder(c[7],A)
E=c[23]
G=c[16]
I=c[15]
K=c[17]
L=c[19]
A.f9.prototype={
aA(){return"AttachTarget."+this.b}}
A.dn.prototype={
aa(){var x=B.cc(y.b),w=($.W+1)%16777215
$.W=w
return new A.ht(null,!1,!1,x,w,this,C.f)}}
A.ht.prototype={
aM(){var x=this.f
x.toString
y.h.a(x)
return L.o},
ah(){var x,w,v=this.f
v.toString
y.h.a(v)
x=this.e
x.toString
x=new A.bc(B.f([],y.k),E.u,x)
x.bC("")
w=A.bI(x.x)
C.b.m(w.f,x)
w.r=!0
x.se5(v.c)
return x},
ac(d){var x
y.n.a(d)
x=this.f
x.toString
y.h.a(x)
d.si0(E.u)
d.se5(x.c)},
ba(){var x,w
this.da()
x=this.d$
x.toString
y.n.a(x)
w=this.e
w.toString
x.shf(w)},
aC(){var x,w
this.eV()
x=this.d$
x.toString
y.n.a(x)
w=A.bI(x.x)
C.b.F(w.f,x)
w.aW()}}
A.bc.prototype={
si0(d){var x=this,w=x.x
if(w===d)return
w=A.bI(w)
C.b.F(w.f,x)
w.aW()
x.x=d
w=A.bI(d)
C.b.m(w.f,x)
w.r=!0
A.bI(x.x).aW()},
se5(d){y.f.a(d)
if(this.y===d)return
this.y=d
A.bI(this.x).aW()},
shf(d){if(this.z===d)return
this.z=d
A.bI(this.x).ex(!0)},
aq(d,e){var x,w,v,u,t=this
d.a=t
try{x=d.gN()
w=e==null?null:e.gN()
if(w==null&&C.b.I(t.w,x))return
if(w!=null&&!C.b.I(t.w,w))w=null
v=t.w
C.b.F(v,x)
u=w!=null?C.b.aj(v,w)+1:0
C.b.ee(v,u,x)
A.bI(t.x).aW()}finally{d.ai()}},
F(d,e){C.b.F(this.w,e.gN())
e.a=null
A.bI(this.x).aW()}}
A.f8.prototype={
ge9(){var x,w=this,v=w.b
if(v===$){x=B.y(B.j(b.G.document).querySelector(w.a.b))
x.toString
w.b!==$&&B.f0()
w.b=x
v=x}return v},
ex(d){var x,w,v,u,t,s,r,q,p,o,n,m=this
if(d||m.r){C.b.ao(m.f,new A.iE())
m.r=!1}x=m.c
if(x===$){w=A.qN(B.j(m.ge9().attributes))
m.c!==$&&B.f0()
m.c=w
x=w}for(v=m.f,u=v.length,t=0;t<v.length;v.length===u||(0,B.ay)(v),++t){s=v[t].y
if(s!=null)x.M(0,s)}r=B.mC(y.w)
for(q=0;v=m.ge9(),q<B.V(B.j(v.attributes).length);++q)r.m(0,B.w(B.y(B.j(v.attributes).item(q)).name))
if(x.a!==0)for(u=new B.aC(x,B.h(x).h("aC<1,2>")).gA(0);u.n();){p=u.d
o=p.a
B.fa(v,o,p.b)
r.F(0,o)}if(r.a!==0)for(u=B.o8(r,r.r,r.$ti.c),o=u.$ti.c;u.n();){n=u.d
if(n==null)n=o.a(n)
v.removeAttribute(n)}},
aW(){return this.ex(!1)}}
A.ih.prototype={
J(d){var x=this,w=null,v=y.w
v=B.O(v,v)
v.i(0,"cx",x.c)
v.i(0,"cy",x.d)
v.i(0,"r",x.e)
return new B.ad("circle",w,w,w,v,w,x.at,w)}}
A.iW.prototype={
aA(){return"Display."+this.b}}
A.fD.prototype={
J(d){var x=y.F
return new A.es(this.c,B.f([D.bH(B.f([],x),"M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z")],x),null)}}
A.hd.prototype={
J(d){var x=y.F
return new A.es(this.c,B.f([new A.ih("12","12","4",B.f([],x),null),D.bH(B.f([],x),"M12 4h.01"),D.bH(B.f([],x),"M20 12h.01"),D.bH(B.f([],x),"M12 20h.01"),D.bH(B.f([],x),"M4 12h.01"),D.bH(B.f([],x),"M17.657 6.343h.01"),D.bH(B.f([],x),"M17.657 17.657h.01"),D.bH(B.f([],x),"M6.343 17.657h.01"),D.bH(B.f([],x),"M6.343 6.343h.01")],x),null)}}
A.es.prototype={
J(d){var x=this.c,w=y.w
return D.po(this.d,B.bs(["fill","none","stroke","currentColor","stroke-width","2","stroke-linecap","round","stroke-linejoin","round"],w,w),new F.aG("px",x),"0 0 24 24",new F.aG("px",x))}}
A.bx.prototype={
bb(){return new A.hg()}}
A.hg.prototype={
bf(){this.ci()
this.d=B.aT(B.y(B.j(b.G.document).documentElement).getAttribute("data-theme"))==="dark"},
J(d){var x,w=this,v=null,u=y.F,t=B.f([],u),s=w.d?"dark":"light",r=y.w
t.push(new A.dn(B.bs(["data-theme",s],r,r),v))
r=B.bs(["aria-label","Theme Toggle"],r,r)
s=F.l3(w.d?E.z:v,v,v,v,v,v,v)
s=D.di(B.f([new A.fD(20,v)],u),s)
x=F.l3(w.d?v:E.z,v,v,v,v,v,v)
t.push(I.n3(B.f([s,D.di(B.f([new A.hd(20,v)],u),x)],u),r,"theme-toggle",v,new A.kd(w),v))
return new H.cb(t,v)}}
var z=a.updateTypes(["d(bc,bc)"])
A.iE.prototype={
$2(d,e){var x=y.n
x.a(d)
x.a(e)
return d.z-e.z},
$S:z+0}
A.kd.prototype={
$0(){var x,w=this.a
w.an(new A.kc(w))
x=B.j(B.j(b.G.window).localStorage)
w=w.d?"dark":"light"
x.setItem("jaspr:theme",w)},
$S:0}
A.kc.prototype={
$0(){var x=this.a
x.d=!x.d},
$S:0};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.cp,[A.f9,A.iW])
w(A.dn,B.m)
w(A.ht,B.bQ)
w(A.bc,B.dy)
w(A.f8,B.i)
w(A.iE,B.bJ)
x(K.E,[A.ih,A.fD,A.hd,A.es])
w(A.bx,G.aj)
w(A.hg,G.a5)
x(B.bd,[A.kd,A.kc])})()
B.aH(b.typeUniverse,JSON.parse('{"bc":{"as":[],"mG":[],"bR":[]},"dn":{"m":[]},"ht":{"ai":[],"l":[],"a1":[]},"ih":{"E":[],"m":[]},"fD":{"E":[],"m":[]},"hd":{"E":[],"m":[]},"es":{"E":[],"m":[]},"bx":{"aj":[],"m":[]},"hg":{"a5":["bx"],"a5.T":"bx"}}'))
var y={h:B.r("dn"),n:B.r("bc"),b:B.r("l"),C:B.r("t<bc>"),F:B.r("t<m>"),k:B.r("t<p>"),w:B.r("b"),f:B.r("u<b,b>?")};(function constants(){E.u=new A.f9(0,"html")
E.z=new A.iW(0,"none")})();(function staticFields(){$.np=B.O(B.r("f9"),B.r("f8"))})()};
(a=>{a["8LCUwf4+lhVpfs2EAuedPCL2ozY="]=a.current})($__dart_deferred_initializers__);
//# sourceMappingURL=main.client.dart.js_18.part.js.map
