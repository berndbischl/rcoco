General:

  1) we use .editorconfig for general editor setup
  https://editorconfig.org
  make sure this is aligned with overrides from other config tools for R and C/C++
  for vscode: install the EditorConfig plugin


VSCode / cursor:

  1) vscode: there is a local .vscode/settings.json file.

  2) there is a global "rule" for for cursor to inform cursor/LLM about a static
  context for the project and what it should always respect

  3) recommended plugins:
  Minimally: EditorConfig, R (installs also R Syntax), Air, clangd
  Recommended: R Debugger, GitLens

R:

  1) formatting: we use the "air" plugin, configured by air.toml
  https://posit-dev.github.io/air/
  use  # fmt: skip or # fmt: skip file to disable it locally

  2) we use an .Rprofile for persistent history and auto-loading of devel packages, etc

  3) there is a .lintr file to control linting rules for the project
  https://lintr.r-lib.org/
  linting errors should go into the diagnostics panel in vscode automatically,
  or you can run manually: devtools::lint()

C:

  1) formatting: we use vscode-clangd
  it is configured via .clang-format
  https://clang.llvm.org/docs/ClangFormatStyleOptions.html
  auto-formatting is done on-save (see settings.json)




