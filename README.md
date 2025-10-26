# gitconfig-custom

## Command

Generating a new SSH key

```shell
ssh-keygen -t ed25519
```

Copy the SSH configuration file

```shell
cp "~/workspace/personal/gitconfig-custom/config" "~/.ssh/config"
```

Copy the Git configuration file

```shell
cp "~/workspace/personal/gitconfig-custom/.gitconfig" "~/.gitconfig"
```

Copy the `.bash_profile` file"

```shell
cp "~/workspace/personal/gitconfig-custom/.bash_profile" "~/.bash_profile"
```

## Windows Terminal

```json
{
  "name": "Git Bash",
  "icon": "C:\\Users\\User\\scoop\\apps\\git\\current\\git-bash.exe",
  "commandline": "C:\\Users\\User\\scoop\\apps\\git\\current\\bin\\bash.exe --login -i",
  "startingDirectory": "%USERPROFILE%"
}
```
