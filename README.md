# telescope-cscope.nvim

This is an extension picker for [cscope_maps](https://github.com/dhananjaylatkar/cscope_maps.nvim).

## Requirements

Select the "telescope" picker for cscope, e.g. (Lazy.nvim):

```lua
return {
	"dhananjaylatkar/cscope_maps.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("cscope_maps").setup({
			disable_maps = true,
			cscope = {
				picker = "telescope",
			},
		})
	end,
}
```

Load the extension after calling telescope.setup():

```lua
telescope.load_extension("cscope")
```

Use it with `:Telescope cscope`.
