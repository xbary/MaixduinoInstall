import sys

file_name = sys.argv[1]
old = sys.argv[2]
new = sys.argv[3]

with open(file_name,encoding="utf8") as file:
    file_data = file.read()
    file_data = file_data.replace(old, new)
 
with open(file_name, 'w',encoding="utf8") as file:
    file.write(file_data)
 
