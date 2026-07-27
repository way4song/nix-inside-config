return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#26211c',
				base01 = '#26211c',
				base02 = '#8e8a7d',
				base03 = '#8e8a7d',
				base04 = '#e5e0d0',
				base05 = '#fffcf4',
				base06 = '#fffcf4',
				base07 = '#fffcf4',
				base08 = '#ff7567',
				base09 = '#ff7567',
				base0A = '#f0cb4e',
				base0B = '#85ff71',
				base0C = '#ffeaa3',
				base0D = '#f0cb4e',
				base0E = '#ffde71',
				base0F = '#ffde71',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8e8a7d',
				fg = '#fffcf4',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#f0cb4e',
				fg = '#26211c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8e8a7d' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffeaa3', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffde71',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#f0cb4e',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#f0cb4e',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffeaa3',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#85ff71',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#e5e0d0' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e5e0d0' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8e8a7d',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
