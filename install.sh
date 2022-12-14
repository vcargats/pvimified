#!/usr/env sh

INSTALLDIR=${INSTALLDIR:-"$PWD/pvimified"}
create_symlinks () {
    if [ ! -f ~/.vim ]; then
        echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
        ln -sfn $INSTALLDIR ~/.vim
    fi

    if [ ! -f ~/.vimrc ]; then
        ln -sfn $INSTALLDIR/vimrc ~/.vimrc
    fi
  }

echo "Welcome friend!"
echo "You are about to be pvimified. Ready? Let us do the stuff for you."

which git > /dev/null
if [ "$?" != "0" ]; then
  echo "You need git installed to install pvimified."
  exit 1
fi

which vim > /dev/null
if [ "$?" != "0" ]; then
  echo "You need vim installed to install pvimified."
  exit 1
fi

if [ ! -d "$INSTALLDIR" ]; then
    echo "As we can't find PVimified in the current directory, we will create it."
    git clone https://github.com/vcargats/pvimified.git $INSTALLDIR
    create_symlinks
    cd $INSTALLDIR

else
    echo "Seems like you already are one of ours, so let's update PVimified to be as awesome as possible."
    cd $INSTALLDIR
    git pull origin master
    create_symlinks
fi

echo "Now, we will create a separate directories for backup, swap and undo."
mkdir -p tmp/backup tmp/swap tmp/undo

if [ ! -f "autoload/plug.vim" ]; then
    echo "Then, we install vim-plug (https://github.com/junegunn/vim-plug)."
    curl -fLo autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Enjoy!"

vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

