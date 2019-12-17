# latexmk-and-release-action
An action to typeset latex source and release pdf.

## Workflow Example
```yml
name: Typeset and Release PDF

on:
  push:
    paths: main.tex
    tags: v*.*.*

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: Set up Git repository
        uses: actions/checkout@v1
      - name: Build docker image
        uses: spaspa/latexmk-and-release-action@v0.1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```
