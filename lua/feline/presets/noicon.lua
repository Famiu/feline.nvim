local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local b = vim.b
local fn = vim.fn

local M = {
    properties = {
        force_inactive = {
            filetypes = {
                'NvimTree',
                'packer',
                'startify',
                'fugitive',
                'fugitiveblame',
                'qf',
                'help'
            },
            buftypes = {
                'terminal'
            },
            bufnames = {}
        }
    },
    components = {
        active = {},
        inactive = {}
    }
}

M.components.active[1] = {
    {
        provider = '▊ ',
        hl = {
            fg = 'skyblue'
        }
    },
    {
        provider = 'vi_mode',
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold'
            }
        end,
        right_sep = ' ',
        icon = ''
    },
    {
        provider = 'file_info',
        hl = {
            fg = 'white',
            bg = 'oceanblue',
            style = 'bold'
        },
        left_sep = '',
        right_sep = ' ',
        icon = ''
    },
    {
        provider = 'file_size',
        enabled = function() return fn.getfsize(fn.expand('%:p')) > 0 end,
        right_sep = {
            ' ',
            {
                str = 'vertical_bar_thin',
                hl = {
                    fg = 'fg',
                    bg = 'bg'
                }
            },
        }
    },
    {
        provider = 'position',
        left_sep = ' ',
        right_sep = {
            ' ',
            {
                str = 'vertical_bar_thin',
                hl = {
                    fg = 'fg',
                    bg = 'bg'
                }
            }
        }
    },
    {
        provider = 'diagnostic_errors',
        enabled = function() return lsp.diagnostics_exist('Error') end,
        hl = { fg = 'red' },
        icon = ' E-'
    },
    {
        provider = 'diagnostic_warnings',
        enabled = function() return lsp.diagnostics_exist('Warning') end,
        hl = { fg = 'yellow' },
        icon = ' W-'
    },
    {
        provider = 'diagnostic_hints',
        enabled = function() return lsp.diagnostics_exist('Hint') end,
        hl = { fg = 'cyan' },
        icon = ' H-'
    },
    {
        provider = 'diagnostic_info',
        enabled = function() return lsp.diagnostics_exist('Information') end,
        hl = { fg = 'skyblue' },
        icon = ' I-'
    }
}

M.components.active[2] = {
    {
        provider = 'git_branch',
        hl = {
            fg = 'white',
            bg = 'black',
            style = 'bold'
        },
        right_sep = function()
            local val = {hl = {fg = 'NONE', bg = 'black'}}
            if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
            return val
        end,
        icon = ' '
    },
    {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'black'
        },
        icon = ' +'
    },
    {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'black'
        },
        icon = ' ~'
    },
    {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'black'
        },
        right_sep = function()
            local val = {hl = {fg = 'NONE', bg = 'black'}}
            if b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
            return val
        end,
        icon = ' -'
    },
    {
        provider = 'line_percentage',
        hl = {
            style = 'bold'
        },
        left_sep = '  ',
        right_sep = ' '
    },
    {
        provider = 'scroll_bar',
        hl = {
            fg = 'skyblue',
            style = 'bold'
        }
    }
}

M.components.inactive[1] = {
    {
        provider = 'file_type',
        hl = {
            fg = 'white',
            bg = 'oceanblue',
            style = 'bold'
        },
        left_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'oceanblue'
            }
        },
        right_sep = {
            {
                str = ' ',
                hl = {
                    fg = 'NONE',
                    bg = 'oceanblue'
                }
            },
            ' '
        }
    }
}

return M
