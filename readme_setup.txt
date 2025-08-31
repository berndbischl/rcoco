General:
1) we use .editorconfig for general editor setup
https://editorconfig.org
2) make sure this is aligned with overriding other config tools for R and C/C++


R:
1) formatting: we use the "air" plugin, configured by air.toml
https://posit-dev.github.io/air/
use  # fmt: skip or # fmt: skip file to disable it locally
2) we use an .Rprofile for persistent history and auto-loading of devel packages, etc



