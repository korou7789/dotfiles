local dpp_base = vim.fn.stdpath("cache")
local dpp_src = dpp_base .. "/repos/github.com/Shougo/dpp.vim"
local denops_src = dpp_base .. "/repos/github.com/vim-denops/denops.vim"
local dpp_config = vim.fn.stdpath("config") .. "/lua/config/dpp.ts"
vim.env.HOOKS_DIR = vim.fn.stdpath("config") .. "/hooks"

if not vim.uv.fs_stat(dpp_src) then
    vim.fn.system({"git", "clone", "https://github.com/Shougo/dpp.vim", dpp_src})
end

vim.opt.runtimepath:prepend(dpp_src)

local extension_urls = {
	"Shougo/dpp-ext-installer",
	"Shougo/dpp-ext-toml",
	"Shougo/dpp-protocol-git",
	"Shougo/dpp-ext-lazy",
}

if vim.fn["dpp#min#load_state"](dpp_base) == 1 then
    function ensure_repo_exists(url, dest_path)
        if not vim.uv.fs_stat(dest_path) then
            vim.fn.system({"git", "clone", "https://github.com/" .. url, dest_path})
        end
    end

    ensure_repo_exists("vim-denops/denops.vim", denops_src)
	vim.opt.runtimepath:prepend(denops_src)

    for _, url in ipairs(extension_urls) do
        local ext_path = dpp_base .. "/repos/github.com/" .. url
        ensure_repo_exists(url, ext_path)
        vim.opt.runtimepath:append(ext_path)
    end

	vim.api.nvim_create_autocmd("User", {
		pattern = "DenopsReady",
		callback = function()
            vim.notify("dpp load_state() is failed", vim.log.levels.WARN)
			require("dpp").make_state(dpp_base, dpp_config)
		end,
	})
end

vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    callback = function()
        vim.notify("dpp make_state() is done")
    end,
})

-- vim.g.denops_server_addr = "127.0.0.1:41979"

-- install
vim.api.nvim_create_user_command("DppInstall", "call dpp#async_ext_action('installer', 'install')", {})

-- update
vim.api.nvim_create_user_command("DppUpdate", function(opts)
	local args = opts.fargs
	vim.fn["dpp#async_ext_action"]("installer", "update", { names = args })
end, { nargs = "*" })

vim.api.nvim_create_user_command("DppMakeState", "call dpp#make_state()", {})
