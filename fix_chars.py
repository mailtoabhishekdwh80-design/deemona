import os
import re

src_dir = r"C:\Deemona\Deemona_Frontend\deemona-frontend\src"

# Map of corrupted sequences to correct replacements
replacements = {
    # Emojis that get corrupted
    b'\xf0\x9f\x93\xa6': b'[Box]',      # Package emoji
    b'\xf0\x9f\x9b\x92': b'[Cart]',     # Cart emoji
    b'\xf0\x9f\x92\xb3': b'[Card]',     # Credit card
    b'\xf0\x9f\x94\x8d': b'[Search]',   # Search emoji
    b'\xe2\x98\x85': b'*',               # Star
    b'\xf0\x9f\x91\xa4': b'[User]',     # User
    b'\xf0\x9f\x8f\xa0': b'[Home]',     # House
    b'\xf0\x9f\x93\x8b': b'[Orders]',   # Clipboard
    b'\xe2\x9c\x93': b'OK',             # Checkmark
    b'\xf0\x9f\x93\x8d': b'[Pin]',      # Pin
    b'\xf0\x9f\x92\xaa': b'[Strong]',   # Muscle
    b'\xe2\x9a\xbd': b'[Ball]',         # Football
    b'\xf0\x9f\x92\x8a': b'[Med]',      # Medicine
    b'\xf0\x9f\x93\x9a': b'[Books]',    # Books
    b'\xf0\x9f\x8e\x81': b'[Gift]',     # Gift
    b'\xf0\x9f\x9a\x80': b'[Rocket]',   # Rocket
    b'\xf0\x9f\x94\x92': b'[Lock]',     # Lock
    b'\xe2\x86\xa9': b'[Return]',        # Return arrow
    b'\xf0\x9f\x93\xb1': b'[Phone]',    # Phone
    b'\xf0\x9f\x92\xbb': b'[Laptop]',   # Laptop
    b'\xf0\x9f\x91\x95': b'[Shirt]',    # Shirt
    b'\xf0\x9f\xaa\xb4': b'[Plant]',    # Plant
    b'\xf0\x9f\x8f\x8b': b'[Gym]',      # Gym
    b'\xf0\x9f\x92\x8d': b'[Ring]',     # Ring
    b'\xe2\x9a\xa1': b'[Power]',         # Lightning
    b'\xf0\x9f\x8e\x89': b'[Party]',    # Party
    b'\xf0\x9f\x93\x84': b'[Doc]',      # Document
    b'\xf0\x9f\x94\x84': b'[Refresh]',  # Refresh
    b'\xe2\x9d\xa4': b'[Heart]',         # Heart
    b'\xf0\x9f\x98\x8a': b'[Smile]',    # Smile
}

files_fixed = []
for root, dirs, files in os.walk(src_dir):
    for fname in files:
        if not fname.endswith('.jsx'):
            continue
        fpath = os.path.join(root, fname)
        with open(fpath, 'rb') as f:
            content = f.read()
        
        original = content
        for bad, good in replacements.items():
            content = content.replace(bad, good)
        
        # Also remove any remaining non-ASCII chars above 0x7F 
        # that are not valid UTF-8 continuations of known sequences
        try:
            content.decode('utf-8')
        except:
            # If still invalid, replace remaining bad bytes
            content = content.decode('utf-8', errors='replace').encode('utf-8')
        
        if content != original:
            with open(fpath, 'wb') as f:
                f.write(content)
            files_fixed.append(fname)

print("Fixed files:", files_fixed)
