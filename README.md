# zsh loveliness from Fergus

## installation
Use the project install file.  
The installer will backup old settings with a date stamp and create symliks as necessary

```
cd vim 
./install
```
or
```
cd .vim
./install
```
cd [or] cd ~/

### init submodules (not needed with installer)
```
cd ~/.zsh/
git submodule init
git submodule update
```

### add extras
```
cd ~/.zsh/
git submodule add https://github.com/zsh-users/zsh-foo.git extras/zsh-foo
git submodule update
```

### update extras
```
cd ~/.zsh/
git submodule foreach git pull origin master
git submodule update
```

To update completions, do:
```
rm -f ~/.zcompdump; compinit
```

## Python environment
```
sudo pip install virtualenv virtualenvwrapper
mkdir ~/.virtualenvwrapper
```

" vim:ft=mkd
