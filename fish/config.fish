alias neofetch="neofetch --source ~/.config/neofetch/logo"
neofetch
if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
starship init fish | source
