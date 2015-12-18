import subprocess

def call_command(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE)

    out, err = p.communicate()
    if p.returncode == 0:
        return [out.decode("utf8").strip(), True]
    else:
        return [err.decode("utf8").strip(), False]

def to_ascii(s):
    converted = ""
    for c in s:
        if ord(c) > 128:
            converted += "?"
        else:
            converted += c
    return converted
