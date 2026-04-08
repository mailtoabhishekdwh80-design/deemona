with open(r"C:\Deemona\idx2.js", "r", encoding="utf-8", errors="replace") as f:
    code = f.read()
print("Starts with:", repr(code[:50]))
print("Length:", len(code))
print("cityRef count:", code.count("cityRef"))
