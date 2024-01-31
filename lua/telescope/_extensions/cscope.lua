local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
	error("This extension requires 'telescope.nvim'. (https://github.com/nvim-telescope/telescope.nvim)")
end

return telescope.register_extension({
	exports = {
		cscope = require("telescope._extensions.cscope.picker").find,
	},
})
