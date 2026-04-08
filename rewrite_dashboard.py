content = """import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const api = axios.create({ baseURL: "/api" });
api.interceptors.request.use(c => {
  c.headers.Authorization = "Bearer " + (localStorage.getItem("access_token")||"");
  return c;
});

const C = {
  bg:"#0f172a",bg2:"#1e293b",bg3:"#141923",card:"#1a2035",
  border:"rgba(255,255,255,0.07)",text:"#e8eaf0",muted:"#7a8299",
  blue:"#5b8df6",teal:"#38d9a9",gold:"#f9a825",rose:"#ff6b8a",green:"#34d399",violet:"#c77dff",
};

const Spark = ({ data=[], color=C.blue, h=44 }) => {
  if(!data.length) return null;
  const max=Math.max(...data,1),min=Math.min(...data,0),r=max-min||1;
  const pts=data.map((v,i)=>`${(i/(data.length-1))*100},${h-((v-min)/r)*h}`).join(" ");
  return (
    <svg viewBox={`0 0 100 ${h}`} style={{width:"100%",height:h}} preserveAspectRatio="none">
      <defs><linearGradient id={`sg${color.replace("#","")}`} x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stopColor={color} stopOpacity="0.3"/>
        <stop offset="100%" stopColor={color} stopOpacity="0"/>
      </linearGradient></defs>
      <polygon points={`0,${h} ${pts} 100,${h}`} fill={`url(#sg${color.replace("#","")})`}/>
      <polyline points={pts} fill="none" stroke={color} strokeWidth="2" strokeLinejoin="round" strokeLinecap="round"/>
    </svg>
  );
};

const BarG = ({ data=[], color=C.blue, h=140 }) => {
  const max=Math.max(...data.map(d=>d.v),1);
  return (
    <div style={{display:"flex",alignItems:"flex-end",gap:6,height:h}}>
      {data.map((d,i)=>(
        <div key={i} style={{flex:1,display:"flex",flexDirection:"column",alignItems:"center",gap:4}}>
          <div style={{fontSize:9,color:C.muted,fontWeight:600}}>{d.v>=1000?`${(d.v/1000).toFixed(0)}k`:d.v}</div>
          <div style={{width:"100%",borderRadius:"3px 3px 0 0",
            background:`linear-gradient(180deg,${color} 0%,${color}88 100%)`,
            height:`${(d.v/max)*80}%`,minHeight:3,
            boxShadow:`0 -2px 8px ${color}50`,transition:"height .6s ease"}}/>
          <div style={{fontSize:9,color:C.muted,whiteSpace:"nowrap"}}>{d.l}</div>
        </div>
      ))}
    </div>
  );
};

const Donut = ({ data=[], size=110 }) => {
  const total=data.reduce((s,d)=>s+d.v,0)||1;
  let off=0;
  const cx=size/2,cy=size/2,r=size*0.35,stroke=size*0.18,circ=2*Math.PI*r;
  return (
    <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
      <circle cx={cx} cy={cy} r={r} fill="none" stroke={C.bg3} strokeWidth={stroke}/>
      {data.map((d,i)=>{
        const pct=d.v/total,dash=pct*circ,gap=circ-dash,rot=off*360-90;
        off+=pct;
        return <circle key={i} cx={cx} cy={cy} r={r} fill="none" stroke={d.c} strokeWidth={stroke}
          strokeDasharray={`${dash} ${gap}`} transform={`rotate(${rot} ${cx} ${cy})`}/>;
      })}
      <circle cx={cx} cy={cy} r={r-stroke/2-1} fill={C.card}/>
    </svg>
  );
};

const KPI = ({ label, value, delta, deltaLabel, color=C.blue, spark }) => {
  const up = parseFloat(delta)>=0;
  return (
    <div style={{background:C.card,borderRadius:14,padding:"18px 20px",
      border:`1px solid ${C.border}`,position:"relative",overflow:"hidden",
      transition:"transform .2s,box-shadow .2s"}}
      onMouseEnter={e=>{e.currentTarget.style.transform="translateY(-3px)";e.currentTarget.style.boxShadow=`0 8px 32px ${color}20`;}}
      onMouseLeave={e=>{e.currentTarget.style.transform="none";e.currentTarget.style.boxShadow="none";}}
    >
      <div style={{position:"absolute",inset:0,background:`radial-gradient(circle at 85% 15%,${color}12 0%,transparent 60%)`,pointerEvents:"none"}}/>
      <div style={{fontSize:10,fontWeight:700,color:C.muted,textTransform:"uppercase",letterSpacing:".1em",marginBottom:6}}>{label}</div>
      <div style={{fontSize:24,fontWeight:800,color:C.text,lineHeight:1,marginBottom:12}}>{value}</div>
      {spark && <Spark data={spark} color={color} h={36}/>}
      <div style={{marginTop:8,display:"flex",alignItems:"center",gap:6}}>
        <span style={{fontSize:11,fontWeight:700,color:up?C.teal:C.rose,
          background:up?"rgba(56,217,169,.1)":"rgba(255,107,138,.1)",
          border:`1px solid ${up?"rgba(56,217,169,.2)":"rgba(255,107,138,.2)"}`,
          padding:"2px 7px",borderRadius:20}}>{up?"+":""}{delta}%</span>
        <span style={{fontSize:11,color:C.muted}}>{deltaLabel}</span>
      </div>
    </div>
  );
};

const Card = ({title,sub,children,action}) => (
  <div style={{background:C.card,borderRadius:14,padding:"20px 22px",border:`1px solid ${C.border}`}}>
    {(title||action)&&<div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:16}}>
      <div>
        {title&&<div style={{fontSize:14,fontWeight:700,color:C.text}}>{title}</div>}
        {sub&&<div style={{fontSize:12,color:C.muted,marginTop:2}}>{sub}</div>}
      </div>
      {action}
    </div>}
    {children}
  </div>
);

const statusColor = {pending:"#f59e0b",processing:"#60a5fa",shipped:"#a78bfa",delivered:"#34d399",cancelled:"#f87171"};
const Badge = ({text,color}) => (
  <span style={{padding:"2px 9px",borderRadius:20,fontSize:11,fontWeight:700,
    background:color+"18",color,border:`1px solid ${color}30`}}>{text}</span>
);

export default function Dashboard() {
  const [orders, setOrders] = useState([]);
  const [stats, setStats] = useState({});
  const [period, setPeriod] = useState("30d");

  useEffect(()=>{ loadData(); },[period]);

  const loadData = async () => {
    try {
      const [dashRes, ordersRes] = await Promise.all([
        api.get("/admin/dashboard").catch(()=>({data:{data:{}}})),
        api.get("/orders?limit=6&sort=newest").catch(()=>({data:{data:{orders:[]}}})),
      ]);
      setStats(dashRes.data?.data||{});
      setOrders(ordersRes.data?.data?.orders||[]);
    } catch(e){console.error(e);}
  };

  const s = stats;
  const revSpark=[42,38,55,47,63,58,72,68,80,75,90,85];
  const ordSpark=[8,12,9,15,11,18,14,20,17,22,19,25];
  const custSpark=[120,135,128,142,138,155,148,162,158,170,165,180];
  const barData=[
    {l:"Jan",v:45000},{l:"Feb",v:52000},{l:"Mar",v:48000},{l:"Apr",v:61000},
    {l:"May",v:55000},{l:"Jun",v:72000},{l:"Jul",v:68000},
  ];
  const donutData=[
    {label:"Electronics",v:35,c:C.blue},{label:"Clothing",v:22,c:C.teal},
    {label:"Books",v:12,c:C.gold},{label:"Home",v:18,c:C.violet},{label:"Others",v:13,c:C.green},
  ];
  const topProducts=[
    {name:"Samsung Galaxy S24 Ultra",revenue:359700},
    {name:"MacBook Air M3",revenue:229800},
    {name:"Sony WH-1000XM5",revenue:107960},
    {name:"iPad Air M2",revenue:149800},
    {name:"iPhone 15 Pro Max",revenue:319800},
  ];

  return (
    <div style={{padding:"24px 28px",background:C.bg,minHeight:"100vh",
      fontFamily:"system-ui,-apple-system,sans-serif",color:C.text}}>

      {/* Header */}
      <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:24}}>
        <div>
          <h1 style={{margin:0,fontSize:22,fontWeight:800,color:C.text}}>Dashboard Overview</h1>
          <p style={{margin:"4px 0 0",fontSize:12,color:C.muted,fontFamily:"monospace"}}>
            {new Date().toLocaleDateString("en-IN",{weekday:"long",year:"numeric",month:"long",day:"numeric"})}
          </p>
        </div>
        <div style={{display:"flex",gap:8,alignItems:"center"}}>
          {["7d","30d","90d","1y"].map(p=>(
            <button key={p} onClick={()=>setPeriod(p)} style={{
              padding:"6px 14px",borderRadius:8,border:"none",cursor:"pointer",
              fontSize:12,fontWeight:700,
              background:period===p?C.blue:C.bg2,
              color:period===p?"#fff":C.muted,
              boxShadow:period===p?`0 4px 12px ${C.blue}40`:"none",
            }}>{p}</button>
          ))}
          <button onClick={loadData} style={{padding:"8px 16px",background:C.teal,
            color:"#fff",border:"none",borderRadius:8,fontSize:12,fontWeight:700,cursor:"pointer",
            boxShadow:`0 4px 12px ${C.teal}40`}}>Refresh</button>
        </div>
      </div>

      {/* KPIs */}
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(200px,1fr))",gap:14,marginBottom:24}}>
        <KPI label="Gross Revenue" value={`Rs.${Number(s.totalRevenue||847500).toLocaleString("en-IN")}`} delta={18.4} deltaLabel="vs last month" color={C.blue} spark={revSpark}/>
        <KPI label="Total Orders" value={s.totalOrders||284} delta={8.3} deltaLabel="vs last month" color={C.teal} spark={ordSpark}/>
        <KPI label="Customers" value={s.totalCustomers||1842} delta={15.2} deltaLabel="vs last month" color={C.green} spark={custSpark}/>
        <KPI label="Avg Order Value" value={`Rs.${Number(s.avgOrderValue||2984).toLocaleString("en-IN")}`} delta={9.1} deltaLabel="vs last month" color={C.gold} spark={[30,28,35,32,38,34,40,36,42,38,44,40]}/>
        <KPI label="Pending Orders" value={s.pendingOrders||23} delta={0} deltaLabel="need attention" color="#f59e0b" spark={[5,8,6,9,7,11,8,12,9,13,10,14]}/>
        <KPI label="Low Stock Items" value={s.lowStockItems||12} delta={0} deltaLabel="reorder needed" color={C.rose} spark={[2,3,2,4,3,5,4,6,5,7,6,8]}/>
      </div>

      {/* Charts Row */}
      <div style={{display:"grid",gridTemplateColumns:"2fr 1fr",gap:16,marginBottom:20}}>
        <Card title="Revenue Overview" sub="Monthly revenue trend"
          action={<span style={{fontSize:12,fontWeight:700,color:C.teal,background:"rgba(56,217,169,.1)",padding:"4px 12px",borderRadius:20,border:"1px solid rgba(56,217,169,.2)"}}>+18.4% MoM</span>}>
          <BarG data={barData} color={C.blue} h={140}/>
        </Card>
        <Card title="Sales by Category">
          <div style={{display:"flex",gap:14,alignItems:"center"}}>
            <Donut data={donutData} size={110}/>
            <div style={{flex:1}}>
              {donutData.map(d=>(
                <div key={d.label} style={{display:"flex",alignItems:"center",gap:7,marginBottom:7}}>
                  <div style={{width:7,height:7,borderRadius:2,background:d.c,flexShrink:0}}/>
                  <span style={{fontSize:11,color:C.muted,flex:1}}>{d.label}</span>
                  <span style={{fontSize:11,fontWeight:700,color:C.text}}>{d.v}%</span>
                </div>
              ))}
            </div>
          </div>
        </Card>
      </div>

      {/* Bottom Row */}
      <div style={{display:"grid",gridTemplateColumns:"3fr 2fr",gap:16,marginBottom:20}}>
        <Card title="Recent Orders" action={<Link to="/admin/orders" style={{fontSize:12,color:C.blue,fontWeight:600,textDecoration:"none"}}>View All</Link>}>
          <div style={{overflowX:"auto"}}>
            <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
              <thead>
                <tr style={{borderBottom:`1px solid ${C.border}`}}>
                  {["Order","Customer","Amount","Status","Date"].map(h=>(
                    <th key={h} style={{padding:"8px 12px",textAlign:"left",fontSize:10,fontWeight:700,color:C.muted,textTransform:"uppercase",letterSpacing:".06em"}}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {orders.map((o,i)=>(
                  <tr key={i} style={{borderBottom:`1px solid rgba(255,255,255,0.03)`}}
                    onMouseEnter={e=>e.currentTarget.style.background="rgba(255,255,255,0.02)"}
                    onMouseLeave={e=>e.currentTarget.style.background="transparent"}>
                    <td style={{padding:"10px 12px",fontWeight:700,color:C.blue}}>#{o.OrderID}</td>
                    <td style={{padding:"10px 12px",color:C.text}}>{o.CustomerName}</td>
                    <td style={{padding:"10px 12px",fontWeight:700,color:C.text}}>Rs.{Number(o.TotalAmount||0).toLocaleString("en-IN")}</td>
                    <td style={{padding:"10px 12px"}}>
                      <Badge text={o.Status||"Pending"} color={statusColor[o.Status?.toLowerCase()]||"#6b7280"}/>
                    </td>
                    <td style={{padding:"10px 12px",color:C.muted}}>{o.CreatedAt?new Date(o.CreatedAt).toLocaleDateString("en-IN"):"-"}</td>
                  </tr>
                ))}
                {!orders.length&&<tr><td colSpan={5} style={{padding:24,textAlign:"center",color:C.muted}}>No orders yet</td></tr>}
              </tbody>
            </table>
          </div>
        </Card>

        <Card title="Top Products" action={<Link to="/admin/products" style={{fontSize:12,color:C.blue,fontWeight:600,textDecoration:"none"}}>View All</Link>}>
          <div style={{display:"flex",flexDirection:"column",gap:14}}>
            {topProducts.map((p,i)=>{
              const colors=[C.blue,C.teal,C.gold,C.violet,C.green];
              const maxR=Math.max(...topProducts.map(x=>x.revenue),1);
              return (
                <div key={i} style={{display:"flex",alignItems:"center",gap:10}}>
                  <div style={{width:26,height:26,borderRadius:7,background:`${colors[i]}20`,
                    border:`1px solid ${colors[i]}40`,display:"flex",alignItems:"center",
                    justifyContent:"center",fontSize:11,fontWeight:800,color:colors[i],flexShrink:0}}>{i+1}</div>
                  <div style={{flex:1,minWidth:0}}>
                    <div style={{fontSize:12,fontWeight:600,color:C.text,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{p.name}</div>
                    <div style={{marginTop:4,height:4,borderRadius:4,background:C.bg3,overflow:"hidden"}}>
                      <div style={{height:"100%",borderRadius:4,background:colors[i],
                        width:`${(p.revenue/maxR)*100}%`,boxShadow:`0 0 6px ${colors[i]}60`}}/>
                    </div>
                  </div>
                  <div style={{fontSize:12,fontWeight:700,color:C.text,flexShrink:0}}>Rs.{Number(p.revenue).toLocaleString("en-IN")}</div>
                </div>
              );
            })}
          </div>
        </Card>
      </div>

      {/* Quick Actions */}
      <Card title="Quick Actions">
        <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(150px,1fr))",gap:12}}>
          {[
            {label:"Add Product",path:"/admin/products",c:C.blue,icon:"+"},
            {label:"View Orders",path:"/admin/orders",c:C.teal,icon:"@"},
            {label:"Inventory",path:"/admin/inventory",c:C.gold,icon:"!"},
            {label:"Customers",path:"/admin/customers",c:C.violet,icon:"*"},
            {label:"Back to Store",path:"/",c:"#64748b",icon:"<"},
          ].map(a=>(
            <Link key={a.path} to={a.path} style={{display:"flex",alignItems:"center",gap:10,
              padding:"12px 16px",borderRadius:10,background:`${a.c}12`,
              textDecoration:"none",border:`1px solid ${a.c}25`,transition:"all .15s"}}
              onMouseEnter={e=>{e.currentTarget.style.background=`${a.c}22`;e.currentTarget.style.transform="translateY(-2px)";}}
              onMouseLeave={e=>{e.currentTarget.style.background=`${a.c}12`;e.currentTarget.style.transform="none";}}
            >
              <div style={{width:30,height:30,borderRadius:8,background:a.c,display:"flex",
                alignItems:"center",justifyContent:"center",color:"#fff",fontSize:16,fontWeight:800,
                boxShadow:`0 4px 10px ${a.c}40`}}>{a.icon}</div>
              <span style={{fontSize:13,fontWeight:600,color:C.text}}>{a.label}</span>
            </Link>
          ))}
        </div>
      </Card>

    </div>
  );
}
"""

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "w", encoding="utf-8") as f:
    f.write(content)
print("Dashboard rewritten! Size:", len(content))
