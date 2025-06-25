--- use nvim treesitter for syntax highlighting in mdx too
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})
