with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Find export default function Dashboard
for i, l in enumerate(lines):
    if "export default function Dashboard" in l:
        print(f"Dashboard function at line {i+1}")
        # Find its return
        for j in range(i, len(lines)):
            if "return (" in lines[j]:
                print(f"Return at line {j+1}")
                for k in range(j, min(j+15, len(lines))):
                    print(f"{k+1}: {lines[k].rstrip()}")
                break
        break
