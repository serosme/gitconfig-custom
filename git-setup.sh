#!/bin/bash

# Configuration
REPO_URL="git@github.com:serosme/git-setup.git"
REPO_PATH="$HOME/workspace/personal/git-setup"
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

# Function to add a Git configuration
add_git_config() {
    echo "Adding new Git configuration:"
    read -p "  Configuration name (e.g., personal, professional): " config_name
    read -p "  Your name: " user_name
    read -p "  Your email: " user_email
    read -p "  Directory path (e.g., ~/workspace/personal, ~/workspace/professional): " directory_path
    echo

    # Validate input
    if [[ -z "$config_name" || -z "$user_name" || -z "$user_email" || -z "$directory_path" ]]; then
        echo "Error: All fields are required."
        return 1
    fi

    # Expand ~ in directory path
    directory_path="${directory_path/#\~/$HOME}"

    # Create configuration file in repository
    config_file="$REPO_PATH/.gitconfig-$config_name"
    cat > "$config_file" << EOF
[user]
    name = $user_name
    email = $user_email
EOF

    # Add includeIf rule to main .gitconfig in home directory
    cat >> "$HOME/.gitconfig" << EOF
[includeIf "gitdir:$directory_path/"]
    path = $REPO_PATH/.gitconfig-$config_name
EOF

    # Create directory
    mkdir -p "$directory_path"

    echo "Created configuration: $config_name"
    echo "  Config file: $config_file"
    echo "  Directory: $directory_path"
    echo
}

# Function to generate SSH key
generate_ssh_key() {
    clear
    if [[ ! -f "$SSH_KEY_PATH" ]]; then
        echo "Generating SSH key..."
        ssh-keygen -t ed25519 -f "$SSH_KEY_PATH" -N ""
    fi
}

# Function to confirm SSH key setup
confirm_ssh_setup() {
    clear
    cat "$SSH_KEY_PATH.pub"
    echo
    read -p "Please make sure your SSH public key has been added to GitHub. (y/N): " -r response
    echo
}

# Function to clone repository
clone_repository() {
    if [ -d "$REPO_PATH" ]; then
        echo "$REPO_PATH already exists."
    else
        echo "Cloning repository..."
        git clone "$REPO_URL" "$REPO_PATH"
    fi
    echo
}

# Function to copy configuration files
copy_configuration_files() {
    echo "source $REPO_PATH/.gitconfig"
    echo
    cat "$REPO_PATH/.gitconfig"
    echo

    if [[ -f "$HOME/.gitconfig" ]]; then
        echo "Existing .gitconfig found at $HOME/.gitconfig"
        echo
        cat "$HOME/.gitconfig"
        echo
    else
        echo "No existing .gitconfig found, copying default configuration..."
        cp "$REPO_PATH/.gitconfig" "$HOME/.gitconfig"
        echo
        cat "$HOME/.gitconfig"
        echo
    fi

    echo "source $REPO_PATH/.gitconfig"
    echo
    cat "$REPO_PATH/config"
    echo
    if [[ -f "$HOME/.ssh/config" ]]; then
        echo "Existing SSH config found at $HOME/.ssh/config"
        echo
        cat "$HOME/.ssh/config"
        echo
    else
        echo "No existing SSH config found, copying default configuration..."
        cp "$REPO_PATH/config" "$HOME/.ssh/config"
        echo
        cat "$HOME/.ssh/config"
        echo
    fi
}

# Function to setup Git configurations interactively
setup_git_configurations() {
    while true; do
        read -p "Do you want to add a Git configuration? (y/N): " -r add_config
        echo
        case ${add_config,,} in
            y)
                add_git_config
                ;;
            *)
                break
                ;;
        esac
    done
}

# Main execution
main() {
    generate_ssh_key
    confirm_ssh_setup
    clone_repository
    copy_configuration_files
    setup_git_configurations
}

# Execute main function
main
