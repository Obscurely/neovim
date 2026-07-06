return {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        chainingHints = { enable = true },
        typeHints = { enable = true },
        parameterHints = { enable = true },
      },
    },
  },
}
