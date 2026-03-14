return {
    {
        "kawre/neotab.nvim",
        event = "InsertEnter",
        opts = {
            tabkey = "<A-d>",
            reverse_key = "<A-a>",
            act_as_tab = false,
            behavior = "nested",
            pairs = {
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "<", close = ">" },
            },
            exclude = {},
            smart_punctuators = {
                enabled = true,
                semicolon = {
                    enabled = true,
                    ft = { "cs", "c", "cpp", "java", "rust" },
                },
                escape = {
                    enabled = false,
                    triggers = {},
                },
            },
        },
    },
}
