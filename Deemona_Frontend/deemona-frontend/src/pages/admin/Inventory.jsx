// pages/admin/Inventory.jsx — Full Inventory Management UI
import React, { useState, useEffect, useCallback } from "react";

import axios from "axios";
const api = axios.create({ baseURL: "/api" });
api.interceptors.request.use(c => { c.headers.Authorization = "Bearer " + (localStorage.getItem("access_token")||""); return c; });
const req = async (method, path, body) => {
  try {
    const r = method === "GET"
      ? await api.get(path)
      : method === "POST"
      ? await api.post(path, body)
      : method === "PATCH"
      ? await api.patch(path, body)
      : method === "PUT"
      ? await api.put(path, body)
      : await api.delete(path);
    return r;
  } catch(e) {
    return e.response || { data: {} };
  }
};

const C = {
  bg:"#0f172a",bg2:"#1e293b",bg3:"#141923",card:"#1a2035",
  border:"rgba(255,255,255,0.07)",text:"#e8eaf0",muted:"#7a8299",
  blue:"#5b8df6",teal:"#38d9a9",gold:"#f9a825",rose:"#ff6b8a",green:"#34d399",
};

const statusConfig = {
  in_stock:{label:"In Stock",color:C.teal},
  low_stock:{label:"Low Stock",color:C.gold},
  out_of_stock:{label:"Out of Stock",color:C.rose},
  overstock:{label:"Overstock",color:C.blue},
};

const Badge = ({text,color}) => (
  <span style={{padding:"2px 9px",borderRadius:20,fontSize:11,fontWeight:700,
    background:color+"18",color,border:`1px solid ${color}30`}}>{text}</span>
);

const Card = ({title,sub,children,action,style={}}) => (
  <div style={{background:C.card,borderRadius:14,padding:"18px 22px",border:`1px solid ${C.border}`,...style}}>
    {(title||action)&&<div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:14}}>
      <div>
        {title&&<div style={{fontSize:14,fontWeight:700,color:C.text}}>{title}</div>}
        {sub&&<div style={{fontSize:12,color:C.muted,marginTop:2}}>{sub}</div>}
      </div>
      {action}
    </div>}
    {children}
  </div>
);

const Input = ({label,value,onChange,type="text",placeholder,required}) => (
  <div style={{marginBottom:14}}>
    {label&&<div style={{fontSize:11,fontWeight:700,color:C.muted,marginBottom:5,
      textTransform:"uppercase",letterSpacing:".06em"}}>{label}{required&&" *"}</div>}
    <input type={type} value={value} onChange={e=>onChange(e.target.value)} placeholder={placeholder}
      style={{width:"100%",background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,
        padding:"9px 12px",fontSize:13,color:C.text,outline:"none"}}
      onFocus={e=>e.target.style.borderColor=C.blue}
      onBlur={e=>e.target.style.borderColor=C.border}/>
  </div>
);

const SelectInput = ({label,value,onChange,options}) => (
  <div style={{marginBottom:14}}>
    {label&&<div style={{fontSize:11,fontWeight:700,color:C.muted,marginBottom:5,
      textTransform:"uppercase",letterSpacing:".06em"}}>{label}</div>}
    <select value={value} onChange={e=>onChange(e.target.value)}
      style={{width:"100%",background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,
        padding:"9px 12px",fontSize:13,color:C.text,outline:"none",cursor:"pointer"}}>
      {options.map(o=><option key={o.value} value={o.value}>{o.label}</option>)}
    </select>
  </div>
);

const Btn = ({onClick,children,color=C.blue,outline,disabled,small}) => (
  <button onClick={onClick} disabled={disabled} style={{
    padding:small?"6px 14px":"9px 20px",borderRadius:8,
    cursor:disabled?"not-allowed":"pointer",fontSize:small?11:13,fontWeight:700,
    background:outline?"transparent":color,color:outline?color:"#fff",
    border:`1px solid ${color}`,opacity:disabled?0.5:1,
    boxShadow:outline?"none":`0 4px 12px ${color}30`,transition:"all .15s",
  }}>{children}</button>
);

const Modal = ({title,onClose,children,wide}) => (
  <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,.7)",zIndex:1000,
    display:"flex",alignItems:"center",justifyContent:"center",padding:20}}
    onClick={e=>e.target===e.currentTarget&&onClose()}>
    <div style={{background:C.bg2,borderRadius:16,padding:24,width:"100%",
      maxWidth:wide?720:480,maxHeight:"90vh",overflowY:"auto",border:`1px solid ${C.border}`}}>
      <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:20}}>
        <div style={{fontSize:16,fontWeight:700,color:C.text}}>{title}</div>
        <button onClick={onClose} style={{background:"transparent",border:"none",
          color:C.muted,cursor:"pointer",fontSize:20}}>x</button>
      </div>
      {children}
    </div>
  </div>
);

const StatCard = ({label,value,color}) => (
  <div style={{background:C.card,borderRadius:12,padding:"16px 18px",border:`1px solid ${color}25`,position:"relative",overflow:"hidden"}}>
    <div style={{position:"absolute",top:0,right:0,width:60,height:60,
      background:`radial-gradient(circle at 80% 20%,${color}20 0%,transparent 70%)`}}/>
    <div style={{fontSize:10,fontWeight:700,color:C.muted,textTransform:"uppercase",letterSpacing:".08em",marginBottom:6}}>{label}</div>
    <div style={{fontSize:22,fontWeight:800,color,lineHeight:1}}>{value}</div>
  </div>
);

const TH = ({children}) => (
  <th style={{padding:"10px 12px",textAlign:"left",fontSize:10,fontWeight:700,
    color:C.muted,textTransform:"uppercase",letterSpacing:".06em",whiteSpace:"nowrap"}}>{children}</th>
);

const TR = ({children}) => (
  <tr style={{borderBottom:"1px solid rgba(255,255,255,0.03)"}}
    onMouseEnter={e=>e.currentTarget.style.background="rgba(255,255,255,0.02)"}
    onMouseLeave={e=>e.currentTarget.style.background="transparent"}>{children}</tr>
);

const TD = ({children,color,bold,mono}) => (
  <td style={{padding:"11px 12px",color:color||C.muted,fontWeight:bold?700:400,
    fontFamily:mono?"monospace":"inherit",fontSize:mono?12:13}}>{children}</td>
);

export default function Inventory() {
  const [tab, setTab] = useState("stock");
  const [inventory, setInventory] = useState([]);
  const [summary, setSummary] = useState(null);
  const [alerts, setAlerts] = useState([]);
  const [suppliers, setSuppliers] = useState([]);
  const [purchaseOrders, setPurchaseOrders] = useState([]);
  const [suggestions, setSuggestions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState("");
  const [sortBy, setSortBy] = useState("stock_asc");
  const [adjustModal, setAdjustModal] = useState(null);
  const [supplierModal, setSupplierModal] = useState(false);
  const [poModal, setPoModal] = useState(false);
  const [adjustForm, setAdjustForm] = useState({action:"add",quantity:"",reason:""});
  const [supplierForm, setSupplierForm] = useState({companyName:"",contactEmail:"",city:"",gstNumber:"",leadTimeDays:"7"});
  const [poForm, setPoForm] = useState({supplierID:"",items:[{productID:"",orderedQty:"",unitCost:""}],notes:""});

  const loadAll = useCallback(async () => {
    setLoading(true);
    try {
      const [inv,sum,alr,sup,pos,sug] = await Promise.all([
        req("GET",`/inventory?sort=${sortBy}&status=${statusFilter}&search=${encodeURIComponent(search)}`),
        req("GET","/inventory/summary"),
        req("GET","/inventory/alerts"),
        req("GET","/inventory/suppliers/all"),
        req("GET","/inventory/purchase-orders"),
        req("GET","/inventory/reorder-suggestions"),
      ]);
      setInventory(inv.data?.data?.inventory||[]);
      setSummary(sum.data?.data?.summary||{});
      setAlerts(alr.data?.data||[]);
      setSuppliers(sup.data?.data||[]);
      setPurchaseOrders(pos.data?.data?.purchaseOrders||[]);
      setSuggestions(sug.data?.data?.suggestions||[]);
    } catch(e){console.error(e);}
    setLoading(false);
  },[search,statusFilter,sortBy]);

  useEffect(()=>{loadAll();},[loadAll]);

  const handleAdjust = async () => {
    if(!adjustModal||!adjustForm.quantity) return;
    await req("PATCH",`/inventory/${adjustModal.ProductID}/stock`,{
      action:adjustForm.action,quantity:parseInt(adjustForm.quantity),reason:adjustForm.reason,
    });
    setAdjustModal(null);
    setAdjustForm({action:"add",quantity:"",reason:""});
    loadAll();
  };

  const handleCreateSupplier = async () => {
    await req("POST","/inventory/suppliers",{...supplierForm,leadTimeDays:parseInt(supplierForm.leadTimeDays)||7});
    setSupplierModal(false);
    setSupplierForm({companyName:"",contactEmail:"",city:"",gstNumber:"",leadTimeDays:"7"});
    loadAll();
  };

  const handleCreatePO = async () => {
    const items = poForm.items.filter(i=>i.productID&&i.orderedQty&&i.unitCost).map(i=>({
      productID:parseInt(i.productID),orderedQty:parseInt(i.orderedQty),unitCost:parseFloat(i.unitCost),
    }));
    if(!poForm.supplierID||!items.length) return;
    await req("POST","/inventory/purchase-orders",{supplierID:parseInt(poForm.supplierID),items,notes:poForm.notes});
    setPoModal(false);
    setPoForm({supplierID:"",items:[{productID:"",orderedQty:"",unitCost:""}],notes:""});
    loadAll();
  };

  const s = summary||{};

  return (
    <div style={{padding:"24px 28px",background:C.bg,minHeight:"100vh",color:C.text,fontFamily:"system-ui,-apple-system,sans-serif"}}>

      <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",marginBottom:24}}>
        <div>
          <div style={{fontSize:10,fontWeight:700,color:C.blue,textTransform:"uppercase",letterSpacing:".12em",fontFamily:"monospace",marginBottom:6}}>Inventory Management</div>
          <h1 style={{margin:0,fontSize:22,fontWeight:800,color:C.text}}>Stock Control Center</h1>
          <p style={{margin:"4px 0 0",fontSize:13,color:C.muted}}>Manage stock, suppliers and purchase orders</p>
        </div>
        <div style={{display:"flex",gap:10}}>
          <Btn onClick={()=>setSupplierModal(true)} outline color={C.teal}>+ Supplier</Btn>
          <Btn onClick={()=>setPoModal(true)} color={C.blue}>+ Purchase Order</Btn>
        </div>
      </div>

      <div style={{display:"grid",gridTemplateColumns:"repeat(6,1fr)",gap:12,marginBottom:24}}>
        <StatCard label="Total SKUs" value={s.totalSKUs||0} color={C.blue}/>
        <StatCard label="Total Units" value={Number(s.totalUnits||0).toLocaleString("en-IN")} color={C.teal}/>
        <StatCard label="In Stock" value={s.inStock||0} color={C.green}/>
        <StatCard label="Low Stock" value={s.lowStock||0} color={C.gold}/>
        <StatCard label="Out of Stock" value={s.outOfStock||0} color={C.rose}/>
        <StatCard label="Stock Value" value={"Rs."+Number(s.totalStockValue||0).toLocaleString("en-IN")} color={C.blue}/>
      </div>

      <div style={{display:"flex",gap:4,background:C.bg2,padding:4,borderRadius:10,border:`1px solid ${C.border}`,marginBottom:20,width:"fit-content"}}>
        {[
          {id:"stock",label:"Stock"},
          {id:"alerts",label:`Alerts${alerts.length>0?" ("+alerts.length+")":""}`},
          {id:"suppliers",label:"Suppliers"},
          {id:"purchase-orders",label:"Purchase Orders"},
          {id:"suggestions",label:"Reorder Suggestions"},
        ].map(t=>(
          <button key={t.id} onClick={()=>setTab(t.id)} style={{
            padding:"7px 16px",borderRadius:7,border:"none",cursor:"pointer",
            fontSize:12,fontWeight:600,transition:"all .15s",
            background:tab===t.id?C.blue:"transparent",
            color:tab===t.id?"#fff":C.muted,
          }}>{t.label}</button>
        ))}
      </div>

      {tab==="stock"&&(
        <Card title="Stock Inventory" sub={inventory.length+" products"} action={
          <div style={{display:"flex",gap:8}}>
            <input value={search} onChange={e=>setSearch(e.target.value)} placeholder="Search..."
              style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,
                padding:"7px 12px",fontSize:12,color:C.text,outline:"none",width:180}}/>
            <select value={statusFilter} onChange={e=>setStatusFilter(e.target.value)}
              style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,
                padding:"7px 10px",fontSize:12,color:C.text,outline:"none"}}>
              <option value="">All Status</option>
              <option value="in_stock">In Stock</option>
              <option value="low_stock">Low Stock</option>
              <option value="out_of_stock">Out of Stock</option>
              <option value="overstock">Overstock</option>
            </select>
            <select value={sortBy} onChange={e=>setSortBy(e.target.value)}
              style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,
                padding:"7px 10px",fontSize:12,color:C.text,outline:"none"}}>
              <option value="stock_asc">Stock: Low to High</option>
              <option value="stock_desc">Stock: High to Low</option>
              <option value="value_desc">Value: High to Low</option>
              <option value="name">Name A-Z</option>
            </select>
          </div>
        }>
          <div style={{overflowX:"auto"}}>
            <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
              <thead><tr style={{borderBottom:`1px solid ${C.border}`}}>
                <TH>Product</TH><TH>SKU</TH><TH>Category</TH><TH>Stock</TH>
                <TH>Available</TH><TH>Reorder At</TH><TH>Status</TH><TH>Stock Value</TH><TH>Action</TH>
              </tr></thead>
              <tbody>
                {inventory.map((p,i)=>{
                  const sc=statusConfig[p.StockStatus]||{label:p.StockStatus,color:C.muted};
                  return(
                    <TR key={i}>
                      <td style={{padding:"11px 12px"}}>
                        <div style={{fontWeight:600,color:C.text,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",maxWidth:160}}>{p.Name}</div>
                        <div style={{fontSize:11,color:C.muted}}>{p.Brand}</div>
                      </td>
                      <TD mono color={C.blue}>{p.SKU}</TD>
                      <TD>{p.CategoryName}</TD>
                      <td style={{padding:"11px 12px",fontWeight:700,
                        color:p.StockQuantity===0?C.rose:p.StockQuantity<=p.ReorderLevel?C.gold:C.text}}>
                        {p.StockQuantity}
                      </td>
                      <TD bold color={C.teal}>{p.AvailableQty}</TD>
                      <TD>{p.ReorderLevel}</TD>
                      <td style={{padding:"11px 12px"}}><Badge text={sc.label} color={sc.color}/></td>
                      <td style={{padding:"11px 12px",fontWeight:600,color:C.text}}>
                        {"Rs."+Number(p.StockValue||0).toLocaleString("en-IN")}
                      </td>
                      <td style={{padding:"11px 12px"}}>
                        <Btn small color={C.blue} onClick={()=>setAdjustModal(p)}>Adjust</Btn>
                      </td>
                    </TR>
                  );
                })}
                {!inventory.length&&<tr><td colSpan={9} style={{padding:32,textAlign:"center",color:C.muted}}>
                  {loading?"Loading...":"No products found"}
                </td></tr>}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {tab==="alerts"&&(
        <Card title="Stock Alerts" sub="Products requiring immediate attention">
          {alerts.length===0?(
            <div style={{padding:40,textAlign:"center",color:C.teal}}>All products are well stocked!</div>
          ):(
            <div style={{overflowX:"auto"}}>
              <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
                <thead><tr style={{borderBottom:`1px solid ${C.border}`}}>
                  <TH>Product</TH><TH>SKU</TH><TH>Supplier</TH><TH>Stock</TH>
                  <TH>Reorder At</TH><TH>Alert</TH><TH>Suggested Order</TH><TH>Est. Cost</TH>
                </tr></thead>
                <tbody>
                  {alerts.map((a,i)=>(
                    <TR key={i}>
                      <TD bold color={C.text}>{a.Name}</TD>
                      <TD mono color={C.blue}>{a.SKU}</TD>
                      <TD>{a.SupplierName||"—"}</TD>
                      <td style={{padding:"11px 12px",fontWeight:700,
                        color:a.StockQuantity===0?C.rose:C.gold}}>{a.StockQuantity}</td>
                      <TD>{a.ReorderLevel}</TD>
                      <td style={{padding:"11px 12px"}}>
                        <Badge text={a.AlertType==="out_of_stock"?"Out of Stock":"Low Stock"}
                          color={a.AlertType==="out_of_stock"?C.rose:C.gold}/>
                      </td>
                      <TD bold color={C.blue}>{a.SuggestedOrderQty} units</TD>
                      <TD color={C.text}>{"Rs."+Number(a.EstimatedCost||0).toLocaleString("en-IN")}</TD>
                    </TR>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </Card>
      )}

      {tab==="suppliers"&&(
        <Card title="Suppliers" sub={suppliers.length+" active suppliers"}>
          <div style={{overflowX:"auto"}}>
            <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
              <thead><tr style={{borderBottom:`1px solid ${C.border}`}}>
                <TH>Supplier</TH><TH>City</TH><TH>Email</TH><TH>Products</TH>
                <TH>Total Stock</TH><TH>Stock Value</TH><TH>Lead Time</TH>
              </tr></thead>
              <tbody>
                {suppliers.map((s,i)=>(
                  <TR key={i}>
                    <TD bold color={C.text}>{s.CompanyName}</TD>
                    <TD>{s.City||"—"}</TD>
                    <TD color={C.blue}>{s.ContactEmail||"—"}</TD>
                    <TD>{s.ProductCount||0}</TD>
                    <TD>{Number(s.TotalStock||0).toLocaleString("en-IN")}</TD>
                    <TD color={C.teal} bold>{"Rs."+Number(s.TotalStockValue||0).toLocaleString("en-IN")}</TD>
                    <TD>{(s.LeadTimeDays||7)+" days"}</TD>
                  </TR>
                ))}
                {!suppliers.length&&<tr><td colSpan={7} style={{padding:32,textAlign:"center",color:C.muted}}>No suppliers yet</td></tr>}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {tab==="purchase-orders"&&(
        <Card title="Purchase Orders" sub="Track all goods procurement">
          <div style={{overflowX:"auto"}}>
            <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
              <thead><tr style={{borderBottom:`1px solid ${C.border}`}}>
                <TH>PO Number</TH><TH>Supplier</TH><TH>Items</TH>
                <TH>Total Amount</TH><TH>Status</TH><TH>Expected</TH><TH>Created</TH>
              </tr></thead>
              <tbody>
                {purchaseOrders.map((po,i)=>{
                  const sc={pending:C.gold,partial:C.blue,received:C.teal,cancelled:C.rose};
                  return(
                    <TR key={i}>
                      <TD mono color={C.blue} bold>{po.PONumber}</TD>
                      <TD color={C.text}>{po.SupplierName||"—"}</TD>
                      <TD>{po.ItemCount||0}</TD>
                      <TD bold color={C.text}>{"Rs."+Number(po.TotalAmount||0).toLocaleString("en-IN")}</TD>
                      <td style={{padding:"11px 12px"}}><Badge text={po.Status} color={sc[po.Status]||C.muted}/></td>
                      <TD>{po.ExpectedDeliveryDate?new Date(po.ExpectedDeliveryDate).toLocaleDateString("en-IN"):"—"}</TD>
                      <TD>{new Date(po.CreatedAt).toLocaleDateString("en-IN")}</TD>
                    </TR>
                  );
                })}
                {!purchaseOrders.length&&<tr><td colSpan={7} style={{padding:32,textAlign:"center",color:C.muted}}>No purchase orders yet</td></tr>}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {tab==="suggestions"&&(
        <Card title="Reorder Suggestions" sub="Based on sales velocity and stock levels">
          <div style={{overflowX:"auto"}}>
            <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
              <thead><tr style={{borderBottom:`1px solid ${C.border}`}}>
                <TH>Product</TH><TH>SKU</TH><TH>Current Stock</TH><TH>Days Left</TH>
                <TH>Daily Sales</TH><TH>Suggested Qty</TH><TH>Est. Cost</TH><TH>Supplier</TH>
              </tr></thead>
              <tbody>
                {suggestions.map((s,i)=>(
                  <TR key={i}>
                    <TD bold color={C.text}>{s.Name}</TD>
                    <TD mono color={C.blue}>{s.SKU}</TD>
                    <td style={{padding:"11px 12px",fontWeight:700,
                      color:s.CurrentStock===0?C.rose:s.CurrentStock<=s.ReorderLevel?C.gold:C.text}}>
                      {s.CurrentStock}
                    </td>
                    <td style={{padding:"11px 12px",fontWeight:700,
                      color:(s.DaysOfStockLeft||999)<7?C.rose:(s.DaysOfStockLeft||999)<14?C.gold:C.teal}}>
                      {s.DaysOfStockLeft===999?"No sales":s.DaysOfStockLeft+"d"}
                    </td>
                    <TD>{(s.DailyVelocity||0)+"/day"}</TD>
                    <TD bold color={C.blue}>{s.SuggestedOrderQty+" units"}</TD>
                    <TD color={C.text}>{"Rs."+Number(s.EstimatedCost||0).toLocaleString("en-IN")}</TD>
                    <TD>{s.SupplierName||"—"}</TD>
                  </TR>
                ))}
                {!suggestions.length&&<tr><td colSpan={8} style={{padding:32,textAlign:"center",color:C.teal}}>All stock levels are healthy!</td></tr>}
              </tbody>
            </table>
          </div>
        </Card>
      )}

      {adjustModal&&(
        <Modal title={"Adjust Stock — "+adjustModal.Name} onClose={()=>setAdjustModal(null)}>
          <div style={{background:C.bg3,borderRadius:10,padding:"12px 16px",marginBottom:16,border:`1px solid ${C.border}`}}>
            <div style={{display:"grid",gridTemplateColumns:"1fr 1fr 1fr",gap:12}}>
              {[{label:"Current Stock",value:adjustModal.StockQuantity},{label:"Reserved",value:adjustModal.ReservedQty||0},{label:"Available",value:adjustModal.AvailableQty}].map(s=>(
                <div key={s.label}>
                  <div style={{fontSize:10,color:C.muted,textTransform:"uppercase",letterSpacing:".06em"}}>{s.label}</div>
                  <div style={{fontSize:20,fontWeight:800,color:C.text}}>{s.value}</div>
                </div>
              ))}
            </div>
          </div>
          <SelectInput label="Action" value={adjustForm.action} onChange={v=>setAdjustForm(p=>({...p,action:v}))}
            options={[
              {value:"add",label:"Add Stock (Goods Received)"},
              {value:"remove",label:"Remove Stock (Damaged/Lost)"},
              {value:"set",label:"Set Exact Quantity (Stock Take)"},
              {value:"reserve",label:"Reserve Stock"},
              {value:"unreserve",label:"Unreserve Stock"},
            ]}/>
          <Input label="Quantity" type="number" value={adjustForm.quantity}
            onChange={v=>setAdjustForm(p=>({...p,quantity:v}))} placeholder="Enter quantity"/>
          <Input label="Reason" value={adjustForm.reason}
            onChange={v=>setAdjustForm(p=>({...p,reason:v}))} placeholder="Reason for adjustment"/>
          <div style={{display:"flex",gap:10,justifyContent:"flex-end",marginTop:8}}>
            <Btn outline color={C.muted} onClick={()=>setAdjustModal(null)}>Cancel</Btn>
            <Btn color={C.blue} onClick={handleAdjust} disabled={!adjustForm.quantity}>Confirm</Btn>
          </div>
        </Modal>
      )}

      {supplierModal&&(
        <Modal title="Add New Supplier" onClose={()=>setSupplierModal(false)}>
          <Input label="Company Name" value={supplierForm.companyName} required
            onChange={v=>setSupplierForm(p=>({...p,companyName:v}))} placeholder="e.g. TechVision Pvt Ltd"/>
          <Input label="Contact Email" type="email" value={supplierForm.contactEmail}
            onChange={v=>setSupplierForm(p=>({...p,contactEmail:v}))} placeholder="supplier@company.com"/>
          <Input label="City" value={supplierForm.city}
            onChange={v=>setSupplierForm(p=>({...p,city:v}))} placeholder="e.g. Mumbai"/>
          <Input label="GST Number" value={supplierForm.gstNumber}
            onChange={v=>setSupplierForm(p=>({...p,gstNumber:v}))} placeholder="27XXXXX1234X1ZX"/>
          <Input label="Lead Time (days)" type="number" value={supplierForm.leadTimeDays}
            onChange={v=>setSupplierForm(p=>({...p,leadTimeDays:v}))} placeholder="7"/>
          <div style={{display:"flex",gap:10,justifyContent:"flex-end"}}>
            <Btn outline color={C.muted} onClick={()=>setSupplierModal(false)}>Cancel</Btn>
            <Btn color={C.teal} onClick={handleCreateSupplier} disabled={!supplierForm.companyName}>Create Supplier</Btn>
          </div>
        </Modal>
      )}

      {poModal&&(
        <Modal title="Create Purchase Order" onClose={()=>setPoModal(false)} wide>
          <SelectInput label="Supplier" value={poForm.supplierID} onChange={v=>setPoForm(p=>({...p,supplierID:v}))}
            options={[{value:"",label:"Select supplier..."},...suppliers.map(s=>({value:s.SupplierID,label:s.CompanyName}))]}/>
          <div style={{fontSize:11,fontWeight:700,color:C.muted,textTransform:"uppercase",letterSpacing:".06em",marginBottom:8}}>Order Items</div>
          {poForm.items.map((item,i)=>(
            <div key={i} style={{display:"grid",gridTemplateColumns:"2fr 1fr 1fr auto",gap:8,marginBottom:8}}>
              <input value={item.productID} onChange={e=>{const items=[...poForm.items];items[i].productID=e.target.value;setPoForm(p=>({...p,items}));}}
                placeholder="Product ID" style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,padding:"8px 12px",fontSize:12,color:C.text,outline:"none"}}/>
              <input value={item.orderedQty} onChange={e=>{const items=[...poForm.items];items[i].orderedQty=e.target.value;setPoForm(p=>({...p,items}));}}
                placeholder="Qty" type="number" style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,padding:"8px 12px",fontSize:12,color:C.text,outline:"none"}}/>
              <input value={item.unitCost} onChange={e=>{const items=[...poForm.items];items[i].unitCost=e.target.value;setPoForm(p=>({...p,items}));}}
                placeholder="Unit Cost" type="number" style={{background:C.bg3,border:`1px solid ${C.border}`,borderRadius:8,padding:"8px 12px",fontSize:12,color:C.text,outline:"none"}}/>
              <button onClick={()=>{const items=poForm.items.filter((_,j)=>j!==i);setPoForm(p=>({...p,items:items.length?items:[{productID:"",orderedQty:"",unitCost:""}]}));}}
                style={{background:C.rose+"18",border:`1px solid ${C.rose}30`,borderRadius:8,color:C.rose,cursor:"pointer",padding:"0 12px",fontSize:16}}>x</button>
            </div>
          ))}
          <button onClick={()=>setPoForm(p=>({...p,items:[...p.items,{productID:"",orderedQty:"",unitCost:""}]}))}
            style={{background:C.blue+"15",border:`1px solid ${C.blue}30`,borderRadius:8,color:C.blue,
              cursor:"pointer",padding:"8px 16px",fontSize:12,fontWeight:600,width:"100%",marginBottom:14}}>+ Add Item</button>
          <Input label="Notes" value={poForm.notes} onChange={v=>setPoForm(p=>({...p,notes:v}))} placeholder="Optional notes"/>
          <div style={{display:"flex",gap:10,justifyContent:"flex-end"}}>
            <Btn outline color={C.muted} onClick={()=>setPoModal(false)}>Cancel</Btn>
            <Btn color={C.blue} onClick={handleCreatePO} disabled={!poForm.supplierID}>Create Purchase Order</Btn>
          </div>
        </Modal>
      )}
    </div>
  );
}
