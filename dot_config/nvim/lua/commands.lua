vim.api.nvim_create_user_command("TypstPreview", function()
  vim.lsp.buf_request(0, "workspace/executeCommand", {
    command = "tinymist.startDefaultPreview",
    arguments = {},
  }, function(err, _, result)
    if err then
      vim.notify("Failed to start preview: " .. err.message, vim.log.levels.ERROR)
    else
      vim.notify("Typst preview started.", vim.log.levels.INFO)
    end
  end)
end, {})

