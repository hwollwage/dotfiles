-- snacks git colors
local function set_snacks_git_colors()
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#e5c07b" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#a8d687" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded", { fg = "#61afef" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted", { fg = "#e06c75" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusRenamed", { fg = "#c678dd" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusCopied", { fg = "#56b6c2" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUnmerged", { fg = "#be5046" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { fg = "#5c6370" })
  vim.api.nvim_set_hl(0, "SnacksPickerGitStatusStaged", { fg = "#98c379" })
end

set_snacks_git_colors()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_snacks_git_colors,
})

local function set_snacks_colors()
  local file_color = "#FFFFFF"
  vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = file_color })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = file_color })
end

set_snacks_colors()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_snacks_colors,
})

-- dragndrop
local orig_paste = vim.paste
rawset(vim, "paste", function(lines, phase)
  if vim.fn.mode() == "n" and #lines == 1 then
    local raw_text = table.concat(lines, "")
    local path = vim.trim(raw_text)
    path = path:gsub("^['\"](.*)['\"]$", "%1")
    local src_path = path:gsub("\\ ", " ")

    if vim.fn.filereadable(src_path) == 1 then
      local target_dir = vim.fn.getcwd()
      local snacks = rawget(_G, "Snacks")

      if snacks and snacks.picker then
        local ok, pickers = pcall(snacks.picker.get, { source = "explorer" })
        if ok and type(pickers) == "table" then
          local _, explorer = next(pickers)
          if explorer and type(explorer.current) == "function" then
            local item = explorer:current()
            if item and item.file then
              if vim.fn.isdirectory(item.file) == 1 then
                target_dir = item.file
              else
                target_dir = vim.fn.fnamemodify(item.file, ":h")
              end
            end
          end
        end
      end

      local filename = vim.fn.fnamemodify(src_path, ":t")
      local dest_path = target_dir .. "/" .. filename

      if vim.fn.fnamemodify(src_path, ":p") ~= vim.fn.fnamemodify(dest_path, ":p") then
        local ok, err = vim.uv.fs_copyfile(src_path, dest_path)
        if not ok then
          vim.notify("failed to copy file: " .. tostring(err), vim.log.levels.ERROR)
          return true
        end
        local rel_dir = vim.fn.fnamemodify(target_dir, ":.")
        vim.notify("file copied to: " .. rel_dir .. "/" .. filename, vim.log.levels.INFO)
      end

      vim.cmd("edit " .. vim.fn.fnameescape(dest_path))
      if snacks and snacks.explorer then
        pcall(snacks.explorer.reveal)
      end
      return true
    end
  end

  return orig_paste(lines, phase)
end)

-- reset & re-render buffer img clean
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.bmp", "*.ico" },
  callback = function(ev)
    local snacks = rawget(_G, "Snacks")
    if snacks and snacks.image and snacks.image.placement then
      pcall(snacks.image.placement.clean, ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.bmp", "*.ico" },
  callback = function(ev)
    local snacks = rawget(_G, "Snacks")
    if snacks and snacks.image then
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(ev.buf) and vim.api.nvim_get_current_buf() == ev.buf then
          vim.b[ev.buf].snacks_image_attached = nil
          pcall(snacks.image.buf.attach, ev.buf)
        end
      end, 80)
    end
  end,
})

-- conceallevel markdown
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md", "markdown", "text", "gitcommit" },
  callback = function()
    vim.schedule(function()
      vim.opt_local.conceallevel = 0
      vim.opt_local.concealcursor = ""
      vim.opt_local.spell = false
    end)
  end,
})
