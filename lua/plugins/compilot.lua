return {
	"zbirenbaum/copilot.lua",
	enabled = true,
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				accept = false, -- disable built-in keymapping
			},
		})

		-- hide copilot suggestions when cmp menu is open
		-- to prevent odd behavior/garbled up suggestions
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)
		end

		vim.keymap.set("i", "<C-f>", function()
			require("copilot.suggestion").accept()
		end)
	end,
}

-- return {
-- 	"zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   build = ":Copilot auth",
--   config = function()
--     require("copilot").setup({
--         panel = {
--           enabled = true,
--           auto_refresh = true,
--         },
--         -- suggestion = {
--         --   enabled = true,
--         --   auto_trigger = true,
--         --   accept = false, -- disable built-in keymapping
--         -- },
--       })
--   end
-- }
