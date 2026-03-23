# ==================================================
# @file .cshrc
# @brief C shell settings
# ==================================================

# --------------------------------------------------
# base paths
# --------------------------------------------------
set lpath     = ( /usr/local/bin /usr/local/mh /usr/openwin/bin )
set xpath     = ( /usr/local/X11/bin /usr/lib/X11 )
set P2libpath = ( /work/cad/p2lib/bin )

setenv HOST `hostname`

# --------------------------------------------------
# OS / architecture detection
# --------------------------------------------------
if ( -e /bin/uname ) then
	set OS     = `/bin/uname`
	set ARCH   = `/bin/uname -m`
	set OS_VER = `/bin/uname -r`
else if ( -e /usr/bin/uname ) then
	set OS     = `/usr/bin/uname`
	set ARCH   = `/usr/bin/uname -m`
	set OS_VER = `/usr/bin/uname -r`
else
	set OS = Unknown
endif

# --------------------------------------------------
# PATH
# --------------------------------------------------
if ( "$OS" == "SunOS" ) then
	set path = ( . ~/bin ~/bin/sun4 $xpath $lpath \
		/usr/ucb /usr/bin /usr/etc \
		/usr/dt/bin /usr/ccs/bin \
		/usr/local/mtools $P2libpath $gamspath )
else if ( "$OS" == "FreeBSD" ) then
	set path = ( . ~/bin ~/bin/freebsd \
		/usr/bin /sbin /bin /usr/sbin /usr/bin /usr/local/bin \
		/usr/X11R6/bin )
else
	if ( "$ARCH" == "sparc" ) then
		set mybin = ~/bin/sun4linux
	else
		set mybin = ~/bin/linux
	endif

	set path = ( . ~/bin $mybin \
		/usr/bin /sbin /bin /usr/sbin /usr/bin /usr/local/bin \
		/usr/X11R6/bin )
endif

unset ARCH

# --------------------------------------------------
# locale / terminal / pager
# --------------------------------------------------
unsetenv LANG

setenv TERMCAP         /etc/termcap
setenv MORE            '-c'
setenv PRINTER         brother
setenv PAGER           less
setenv LESS            x4
setenv LD_LIBRARY_PATH /usr/local/X11/lib:/usr/openwin/lib:/usr/dt/lib

if ( "$OS" == "SunOS" || "$OS" == "Linux" ) then
	setenv MANPATH /usr/man:/usr/local/man:/usr/local/X11/man:$home/lib/man
endif

setenv XAPPLRESDIR $home/lib/X11/app-defaults
setenv XAUTHORITY  $home/.Xauthority

# --------------------------------------------------
# host detection
# --------------------------------------------------
if ( "$OS" == "SunOS" ) then
	set host = `hostname`
else
	set host = `hostname -s`
endif

# --------------------------------------------------
# CAD tool settings
# --------------------------------------------------
if ( "$host" == "cad1" || "$host" == "cad2" || "$host" == "cad3" || "$host" == "cad4" ) then
	source /home/vega/CAD/settings.for.cadence
	source /home/vega/CAD/settings.for.synopsys
	source /home/vega/CAD/settings.for.mentor
endif

# --------------------------------------------------
# shell safety / behavior
# --------------------------------------------------
set noclobber

if ( $?USER == 0 || $?prompt == 0 ) exit

if ( "$OS" == "SunOS" && \
	"$OS_VER" == "5.6" || "$OS_VER" == "5.8" || "$OS_VER" == "5.9" ) then
	unsetenv LANG
endif

# --------------------------------------------------
# switch to zsh if available
# --------------------------------------------------
set zsh_bin = $HOME/miniconda3/envs/cli/bin/zsh

if ( -x "$zsh_bin" ) then
    if ( $?TERM_PROGRAM ) then
        if ( "$TERM_PROGRAM" == "vscode" ) then
            exec "$zsh_bin"
        endif
	else
		echo "Zsh is available at $zsh_bin."
		echo -n "Do you want to switch to zsh? [Y/n] "
		set answer = "$<"
		if ( "$answer" == "Y" || "$answer" == "y" || "$answer" == "" ) then
			exec "$zsh_bin"
		endif
	endif
endif

unset zsh_bin
unset answer

# --------------------------------------------------
# history / prompt
# --------------------------------------------------
set filec
set history   = 40
set ignoreeof
set savehist  = 40

if ( "$OS" != "SunOS" ) then
	set prompt = "`whoami`@`hostname -s`[\!] "
else
	set prompt = "`whoami`@`hostname`[\!] "
endif

# --------------------------------------------------
# terminal
# --------------------------------------------------
stty erase '^h'

# --------------------------------------------------
# aliases
# --------------------------------------------------
alias cd   'cd \!*; echo $cwd'
alias cp   'cp -i'
alias mv   'mv -i'
alias rm   'rm -i'
alias pwd  'echo $cwd'
alias zcat 'gzip -dc'
alias h 'history \!* | head -39 | less'
alias dir 'ls'
alias la  'ls -a'
alias ll  'ls -la'
alias ls  'ls -F --color=tty'
alias l   'ls -lF'
alias l.  'ls -lFd .[a-zA-Z0-9]*'
alias j 'jobs -l'
alias vi 'vim -N -u $HOME/.vimrc7'
