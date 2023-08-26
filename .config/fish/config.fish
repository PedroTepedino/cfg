if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Title options

set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_disply_user yes
set -g theme_title_use_abreviated_path yes

# Enable Vi mode
# fish_vi_key_bindings
# Disable Vi mode
fish_default_key_bindings

set -x GPG_TTY \$(tty)