# Up-to-date language versions on Linux distros


## Golang

### Ubuntu

```sh
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt install -y golang-1.24
sudo ln -s /usr/lib/go-1.24/bin/go /usr/lib/go-1.24/bin/gofmt /usr/local/bin/

echo 'export GOPATH="$HOME/.local/lib/go"' | tee -a ~/.zsh.after/env.zsh
source ~/.zsh.after/env.zsh
go env GOPATH
```

## Rust

```sh
cargo install rustup
rustup self update
rustup update
rustup show -v
```
