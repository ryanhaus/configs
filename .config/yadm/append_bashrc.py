import pathlib

# appends 'source ~/.config/bashrc-extra.sh' to .bashrc
def append_bashrc():
    bashrc_path = pathlib.Path.home() / ".bashrc"
    append_line = "source ~/.config/bashrc-extra.sh"

    if bashrc_path.exists():
        content = bashrc_path.read_text()
        
        # if line not already there, put it in .bashrc
        if append_line not in content:
            with bashrc_path.open("a") as f:
                f.write(f"\n{append_line}\n")
            print("Added source line to .bashrc")
