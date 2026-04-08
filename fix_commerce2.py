with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

lines[105] = "  const [rows] = await pool.execute(\n"
lines[106] = "    `SELECT o.*, COUNT(oi.OrderItemID) AS ItemCount,\n"
lines[107] = "            (SELECT p.ImageURLs FROM OrderItems oi2 JOIN Products p ON p.ProductID=oi2.ProductID WHERE oi2.OrderID=o.OrderID LIMIT 1) AS FirstImageURLs,\n"
lines[108] = "            (SELECT p.Name FROM OrderItems oi2 JOIN Products p ON p.ProductID=oi2.ProductID WHERE oi2.OrderID=o.OrderID LIMIT 1) AS FirstProductName\n"
lines[109] = "     FROM Orders o LEFT JOIN OrderItems oi ON oi.OrderID=o.OrderID\n"
lines[110] = "     WHERE ${where.join(' AND ')} GROUP BY o.OrderID ORDER BY o.OrderDate DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n"
lines[111] = "    params\n"
lines[112] = "  );\n"
lines[113] = "  ok(res, { orders:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });\n"

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "w", encoding="utf-8") as f:
    f.writelines(lines)
print("Fixed!")
