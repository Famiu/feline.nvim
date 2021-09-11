local api = vim.api

local M = {}

function M.position()
    return "%3l:%-2c"
end

function M.line_percentage(_, winid)
    local curr_line = api.nvim_win_get_cursor(winid)[1]
    local lines = api.nvim_buf_line_count(api.nvim_win_get_buf(winid))

    if curr_line == 1 then
        return "Top"
    elseif curr_line == lines then
        return "Bot"
    else
        return string.format('%2d%%%%', math.ceil(curr_line / lines * 99))
    end
end

function M.scroll_bar(_, winid)
    local blocks =  {'▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'}
    local width = 2

    local curr_line = api.nvim_win_get_cursor(winid)[1]
    local lines = api.nvim_buf_line_count(api.nvim_win_get_buf(winid))

    local index = math.floor(curr_line / lines * (#blocks - 1)) + 1

    return string.rep(blocks[index], width)
end

return M
