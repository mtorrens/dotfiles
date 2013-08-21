To use these, you need to:

### Install rbenv and Ruby 2

Arch:

    pacman -S ruby rbenv ruby-build
    rbenv install 2.0.0-pLatest
    rbenv default 2.0.0-pLatest

OS X:

    (install Homebrew)
    brew install ruby rbenv ruby-build
    rbenv install 2.0.0-pLatest
    rbenv default 2.0.0-pLatest

### Install Oh-My-Zsh

Arch:

    yaourt -S oh-my-zsh-git

OS X:

    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

### Install Homesick and link

    gem install homesick
    homesick clone cpence/dotfiles
    homesick symlink cpence/dotfiles

