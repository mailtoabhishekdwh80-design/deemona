with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Inventory.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Replace custom fetch with axios api client
old = """const API_BASE = "/api";
const getToken = () => localStorage.getItem("access_token") || "";
const req = async (method, path, body) => {
  const r = await fetch(API_BASE + path, {
    method,
    headers: { "Content-Type": "application/json", Authorization: "Bearer " + getToken() },
    ...(body ? { body: JSON.stringify(body) } : {}),
  });
  return r.json();
};"""

new = """import { api } from "../../api/index.js";
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
};"""

code = code.replace(old, new)

# Fix data access - axios wraps in .data already
code = code.replace("inv.data?.inventory||[]", "inv.data?.data?.inventory||[]")
code = code.replace("sum.data?.summary||{}", "sum.data?.data?.summary||{}")
code = code.replace("alr.data||[]", "alr.data?.data||[]")
code = code.replace("sup.data||[]", "sup.data?.data||[]")
code = code.replace("pos.data?.purchaseOrders||[]", "pos.data?.data?.purchaseOrders||[]")
code = code.replace("sug.data?.suggestions||[]", "sug.data?.data?.suggestions||[]")

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Inventory.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
