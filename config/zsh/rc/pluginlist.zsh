#==============================================================#
## Setup zinit                                                ##
#==============================================================#
# cSpell:disable
if [ -z "$ZPLG_HOME" ]; then
	ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
	mkdir -p "$ZPLG_HOME"
	chmod g-rwX "$ZPLG_HOME"
	git clone --depth 10 https://github.com/zdharma-continuum/zinit.git ${ZPLG_HOME}/bin
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# zinit extension
#--------------------------------#
zinit light-mode for \
	@zdharma-continuum/zinit-annex-readurl


#--------------------------------#
# completion
#--------------------------------#
zinit wait'0b' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autosuggestions_atload.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

zinit wait'0a' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atinit.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atload.zsh" \
	light-mode for @marlonrichert/zsh-autocomplete

zinit wait'0b' lucid as"completion" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh; zicompinit; zicdreplay" \
	light-mode for @zsh-users/zsh-completions


#--------------------------------#
# prompt
#--------------------------------#

zinit wait'0a' lucid \
	if"(( ${ZSH_VERSION%%.*} > 4.4))" \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fast-syntax-highlighting.zsh" \
	light-mode for @zdharma-continuum/fast-syntax-highlighting
#
# PROMPT="%~"$'\n'"> "
# zinit wait'!0b' lucid depth=1 \
# 	atload"source $ZHOMEDIR/rc/pluginconfig/powerlevel10k_atload.zsh" \
# 	light-mode for @romkatv/powerlevel10k
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

#--------------------------------#
# history
#--------------------------------#
zinit wait'1' lucid \
	if"(( ${ZSH_VERSION%%.*} > 4.4))" \
	light-mode for @zsh-users/zsh-history-substring-search


zinit wait'2' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/per-directory-history_atinit.zsh" \
	atload"_per-directory-history-set-global-history" \
	light-mode for @CyberShadow/per-directory-history

#--------------------------------#
# alias
#--------------------------------#
zinit wait'0' lucid \
	light-mode for @unixorn/git-extra-commands

zinit wait'0a' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh" \
	light-mode for @momo-lab/zsh-abbrev-alias


#--------------------------------#
# environment variable
#--------------------------------#
zinit wait'0' lucid \
	light-mode for @Tarrasch/zsh-autoenv


#--------------------------------#
# improve cd
#--------------------------------#

zinit wait'1' lucid \
	from"gh-r" as"program" pick"zoxide-*/zoxide" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zoxide_atload.zsh" \
	light-mode for @ajeetdsouza/zoxide

zinit wait'1' lucid \
	light-mode for @mollifier/cd-gitroot

zinit wait'1' lucid \
	light-mode for @peterhurford/up.zsh

zinit wait'1' lucid \
	light-mode for @Tarrasch/zsh-bd

zinit wait'1' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zshmarks_atinit.zsh" \
	light-mode for @jocelynmallon/zshmarks


#--------------------------------#
# git
#--------------------------------#
zinit wait'2' lucid \
	light-mode for @caarlos0/zsh-git-sync


#--------------------------------#
# fzf
#--------------------------------#
zinit wait'0b' lucid \
	from"gh-r" as"program" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fzf_atload.zsh" \
	for @junegunn/fzf
zinit ice wait'0a' lucid
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit ice wait'1a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/fzf_completion.zsh_atload.zsh"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit ice wait'0a' lucid as"program"
zinit snippet https://github.com/junegunn/fzf/blob/master/bin/fzf-tmux

zinit wait'1' lucid \
	pick"fzf-extras.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fzf-extras_atload.zsh" \
	light-mode for @atweiden/fzf-extras # fzf


zinit wait'0c' lucid \
	pick"fzf-finder.plugin.zsh" \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-plugin-fzf-finder_atinit.zsh" \
	light-mode for @leophys/zsh-plugin-fzf-finder

zinit wait'0c' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-mark_atinit.zsh" \
	light-mode for @urbainvaes/fzf-marks

zinit wait'1c' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-zsh-completions_atinit.zsh" \
	light-mode for @chitoku-k/fzf-zsh-completions

zinit wait'2' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-fzf-widgets_atinit.zsh" \
	light-mode for @amaya382/zsh-fzf-widgets

#--------------------------------#
# extension
#--------------------------------#
# zinit wait'1' lucid \
# 	atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh" \
# 	light-mode for @b4b4r07/emoji-cli

zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async

zinit wait'0' lucid \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-completion-generator_atinit.zsh" \
	light-mode for @RobSis/zsh-completion-generator

zinit wait'2' lucid \
	light-mode for @hlissner/zsh-autopair



#--------------------------------#
# enhancive command
#--------------------------------#
zinit wait'1' lucid \
	from"gh-r" as"program" pick"eza" \
	atload"source $ZHOMEDIR/rc/pluginconfig/eza_atload.zsh" \
	light-mode for @eza-community/eza

zinit wait'1' lucid blockf nocompletions \
	from"gh-r" as'program' pick'ripgrep*/rg' \
	cp"ripgrep-*/complete/_rg -> _rg" \
	atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q BurntSushi/ripgrep' \
	atpull'%atclone' \
	light-mode for @BurntSushi/ripgrep

zinit wait'1' lucid blockf nocompletions \
	from"gh-r" as'program' cp"fd-*/autocomplete/_fd -> _fd" pick'fd*/fd' \
	atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q sharkdp/fd' \
	atpull'%atclone' \
	light-mode for @sharkdp/fd

zinit wait'1' lucid \
	from"gh-r" as"program" cp"bat/autocomplete/bat.zsh -> _bat" pick"bat*/bat" \
	atload"export BAT_THEME='base16';alias cat=bat" \
	light-mode for @sharkdp/bat

zinit wait'1' lucid \
	from"gh-r" as"program" \
	atload"alias rm='trash put'" \
	light-mode for @oberblastmeister/trashy

zinit wait'1' lucid \
	from"gh-r" as"program" mv'tealdeer* -> tldr' \
	light-mode for @dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/main/completion/zsh_tealdeer
#
# zinit wait'1' lucid \
# 	from"gh-r" as"program" bpick'*linux*' \
# 	light-mode for @dalance/procs

# zinit wait'1' lucid \
# 	from"gh-r" as"program" pick"delta*/delta" \
# 	atload"compdef _gnu_generic delta" \
# 	light-mode for @dandavison/delta
#


#--------------------------------#
# program
#--------------------------------#
# zsh
if [[ "${ZSH_INSTALL}" == "true" ]]; then
	# zinit pack for zsh
	if builtin command -v make > /dev/null 2>&1; then
		zinit id-as=zsh as"null" lucid depth=1 \
			atclone"./.preconfig; m {hi}Building Zsh...{rst}; \
			CPPFLAGS='-I/usr/include -I/usr/local/include' CFLAGS='-g -O2 -Wall' LDFLAGS='-L/usr/libs -L/usr/local/libs' \
			./configure --prefix=\"$ZPFX\" \
			--enable-multibyte \
			--enable-function-subdirs \
			--with-tcsetpgrp \
			--enable-pcre \
			--enable-cap \
			--enable-zsh-secure-free \
			>/dev/null && \
			{ type yodl &>/dev/null || \
				{ m -u2 {warn}WARNING{ehi}:{rst}{warn} No {cmd}yodl{warn}, manual pages will not be built.{rst}; ((0)); } && \
			{ make install; ((1)); } || make install.bin install.fns install.modules } >/dev/null && \
			{ type sudo &>/dev/null && sudo cp -vf Src/zsh /usr/local/bin/zsh; ((1)); } && \
			m {success}The build succeeded.{rst} || m {failure}The build failed.{rst}" \
			atpull"%atclone" nocompile countdown git \
			for @zsh-users/zsh
	fi
fi


# env #
zinit wait'1' lucid \
	from"gh-r" as"program" pick"direnv" \
	atclone'./direnv hook zsh > zhook.zsh' \
	atpull'%atclone' \
	light-mode for @direnv/direnv


zinit wait'1' lucid \
	from"gh-r" as'program' bpick'*linux_*.tar.gz' pick'gh*/**/gh' \
	atload"source $ZHOMEDIR/rc/pluginconfig/gh_atload.zsh" \
	light-mode for @cli/cli


# # etc #
# zinit wait'1' lucid \
# 	as"program" pick"emojify" \
# 	light-mode for @mrowa44/emojify
#
