with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Add ImageURLs to EMPTY form
code = code.replace(
    "const EMPTY = { Name: '', Description: '', SKU: '', Brand: '', CategoryID: '', Price: '', MRP: '', CostPrice: '', StockQuantity: '', ReorderLevel: 10, Tags: '', Weight: '', IsFeatured: false };",
    "const EMPTY = { Name: '', Description: '', SKU: '', Brand: '', CategoryID: '', Price: '', MRP: '', CostPrice: '', StockQuantity: '', ReorderLevel: 10, Tags: '', Weight: '', IsFeatured: false, ImageURL: '' };"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Step 1 done")
