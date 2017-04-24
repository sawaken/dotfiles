# --------------------------------------------------
# .zshenvはどんな場合でも必ず最初に読み込まれる
# --------------------------------------------------
#
# zshenvで設定されるPATHが/etc/zshprofileで上書きされるのを防ぐ
# ※.zshenvの最初に書く
if [[ "$(uname)" == 'Darwin' ]]; then
  eval `/usr/libexec/path_helper -s`
  setopt no_global_rcs
fi

# anyenvのパスを通す
if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init - zsh)"
fi

# brewからインストールしたctagsを使う
if [[ "$(uname)" == 'Darwin' ]]; then
  alias ctags='`brew --prefix`/bin/ctags'
fi

# stackでインストールした実行ファイルのパスを通す
export PATH="$HOME/.local/bin:$PATH"

# xselをpbcopyとして使う
if [[ "$(uname)" == 'Linux' ]]; then
  alias pbcopy='xsel --clipboard --input'
fi

