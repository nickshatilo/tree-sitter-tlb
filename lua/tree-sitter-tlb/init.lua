local M = {}

function M.setup()
    local plugin_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
    vim.filetype.add({
        extension = {
            tlb = "tlb",
        },
    })

    vim.treesitter.language.register("tlb", "tlb")

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.tlb = {
        install_info = {
            url = plugin_path,
            files = { plugin_path .. "../../src/parser.c" },
            branch = "main",
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
        },
        filetype = "tlb",
    }

    -- Add to runtime path for query detection
    vim.opt.runtimepath:append(plugin_path)
end

return M
