import re
file = open("miscChars.txt", 'r+')

lines = file.readlines()

for line in lines:
    tokens = line.split()
    if len(tokens) > 0 and tokens[0] == 'var':
        line = line[line.find("{"):].rstrip() + " // " + re.findall("(\\w+\\[)", line)[0][:-1] + '\n'
    if "}" in line:
        line = line[:line.find('}') + 1] + ",\n"
    file.write(line)


file.close()
