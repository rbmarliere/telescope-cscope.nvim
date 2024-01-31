local M = {}

if not pcall(require, "cscope_maps") then
	error("This extension requires 'cscope_maps.nvim'. (https://github.com/dhananjaylatkar/cscope_maps.nvim)")
end

local helper = require("utils.maps_helper")
local cmds = {}
for cmd, op in pairs(helper.sym_map) do
	if string.match(op, "^Find") then
		table.insert(cmds, { cmd, op })
	end
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function M.find(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Cscope find",
			finder = finders.new_table({
				results = cmds,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry[2],
						ordinal = entry[2],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local word = vim.fn.expand("<cword>")
					vim.cmd("Cscope find " .. selection.value[1] .. " " .. word)
				end)
				return true
			end,
		})
		:find()
end

return M
