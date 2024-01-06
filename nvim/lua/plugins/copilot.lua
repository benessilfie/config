return {
    {
        "zbirenbaum/copilot.lua",
        -- enabled = true,
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_next = "<A-j>",
                        jump_prev = "<A-k>",
                        accept = "<A-l>",
                        refresh = "r",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<A-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<A-j>",
                        prev = "<A-k>",
                        dismiss = "<C-e>",
                    },
                },
            })
        end
    },
    
    {
        "zbirenbaum/copilot-cmp",
        -- after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    }
}
