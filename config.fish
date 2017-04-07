# because the fish_vi_key_bindings __fish_cursor_xterm prints extra characters, we rewrite the function without that echo line.
function __fish_cursor_xterm --description 'Set cursor (xterm)'
    set -l shape $argv[1]

    switch "$shape"
        case block
            set shape 2
        case underscore
            set shape 4
        case line
            set shape 6
    end
    if contains blink $argv
        set shape (math $shape - 1)
    end
end


function fish_prompt --description 'Write out the prompt'
    # Just calculate this once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    set -l color_cwd
    set -l suffix
    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    set_color FC9
    echo -s "$USER" @ "$__fish_prompt_hostname" ' ' (prompt_pwd) ' $ '
end
