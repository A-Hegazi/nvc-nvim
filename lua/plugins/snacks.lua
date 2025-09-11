return {
    -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        -- NOTE: Options
        opts = {
            styles = {
                input = {
                    keys = {
                        n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    },
                }
            },
            -- Snacks Modules
            input = {
                enabled = true,
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            indent = {
            enable = true,
            },
            explorer = {
                enabled = true,
                finder = "explorer",
                hidden = true,
            },
             lazygit = {
                enabled = true,
                float = {
                    border = "rounded",
                },
            },

            -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = false,
                },
                hidden = true,
                formatters = {
                    file = {
                        filename_first = false,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                    -- override picker layout in keymaps function as a param below
                    preset = "telescope", -- defaults to this layout unless overidden
                    cycle = false,
                },
                layouts = {
                    select = {
                            preview = false,
                            layout = {
                                backdrop = false,
                                width = 0.6,
                                min_width = 80,
                                height = 0.4,
                                min_height = 10,
                                box = "vertical",
                                border = "rounded",
                                title = "{title}",
                                title_pos = "center",
                                { win = "input", height = 1, border = "bottom" },
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                        }
                    },
                    telescope = {
                        reverse = true, -- set to false for search bar to be on top 
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                }
            },
            -- image = {
            --     enabled = true,
            --     doc = {
            --         float = true, -- show image on cursor hover
            --         inline = false, -- show image inline
            --         max_width = 50,
            --         max_height = 30,
            --         wo = {
            --             wrap = false,
            --         },
            --     },
            --     convert = {
            --         notify = true,
            --         command = "magick"
            --     },
            --     img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments","Archives/All-Vault-Images/", "~/Library", "~/Downloads" },
            -- },
            -- dashboard = {
            --     enabled = true,
            --     sections = {
            --         { section = "header" },
            --         { section = "keys", gap = 1, padding = 1 },
            --         { section = "startup" },
            --         {
            --             section = "terminal",
            --             cmd = "ascii-image-converter ~/Desktop/Others/profiles.JPG -C -c",
            --             random = 15,
            --             pane = 2,
            --             indent = 15,
            --             height = 20,
            --         },
            --     },
            -- },
        },
        -- NOTE: Keymaps
        keys = {
            { "<leader>gll", function() require("snacks").lazygit() end, desc = "Lazygit" },
            { "<leader>glg", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
            { "<leader>sf", function() require("snacks").explorer() end, desc = "Open Snacks Explorer" },
            { "<leader>sr", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
            { "<leader>sd", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },
            
            -- Snacks Picker

            -- Top Pickers & Explorer
            { "<leader>p<space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>pn", function() Snacks.picker.notifications() end, desc = "Notification History" },

            -- find
            { "<leader>pfb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>pfc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>pff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>pfg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>pfp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>pfr", function() Snacks.picker.recent() end, desc = "Recent" },
            -- git
            { "<leader>pgb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>pgl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>pgL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>pgs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>pgS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>pgd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>pgf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            -- Grep
            { "<leader>prg", function() Snacks.picker.grep() end, desc = "Open Grep" },
            { "<leader>prb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>prw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>psr', function() Snacks.picker.registers() end, desc = "Registers" },
            { '<leader>psi', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>psa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            { "<leader>psb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>psc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>psC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>psd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>psD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>psh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>psH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>psI", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>psj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>psk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>psl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>psm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>psM", function() Snacks.picker.man() end, desc = "Man Pages" },
            { "<leader>psp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>psq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>psR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>psu", function() Snacks.picker.undo() end, desc = "Undo History" },
            { "<leader>psS", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
            -- LSP
            { "<leader>pld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "<leader>plD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "<leader>plr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "<leader>pli", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "<leader>plt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
            { "<leader>pls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>plS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        }
    },
    -- NOTE: todo comments w/ snacks
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            { "<leader>pst", function() require("snacks").picker.todo_comments() end, desc = "Snack find Todo" },
            { "<leader>psT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Snack find Todo/Fix/Fixme" },
        },
    }
}