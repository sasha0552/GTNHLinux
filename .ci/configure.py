#!/usr/bin/env python3

import glob
import jinja2
import os
import sys

def render_template(filepath, **options):
  if filepath.endswith(".jinja2"):
    # read input file
    with open(filepath, "r") as file:
      template = jinja2.Template(file.read(), lstrip_blocks=True, trim_blocks=True)

    # render template
    rendered = template.render(**options)

    # write output file
    with open(filepath[:-7], "w") as file:
      file.write(rendered)

def main():
  # by default, use x86_64
  arch = "x86_64"

  # set platform
  if len(sys.argv) >= 2:
    arch = sys.argv[1]

  # list of rendered files
  rendered = []

  # render every file
  for filepath in glob.glob("**/*.jinja2", recursive=True) + [".gitignore.jinja2"]:
    # sort rendered list
    rendered.sort()

    # render file
    render_template(filepath, ARCH=arch, CWD=os.getcwd(), rendered=rendered)

    # add output file to rendered list
    rendered.append(filepath[:-7].replace("\\", "/"))

    # print status
    print(f"File '{filepath}' rendered successfully")

if __name__ == "__main__":
  main()
