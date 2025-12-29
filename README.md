# Dotfiles

### Tailscale:

> Client

```sh
sudo tailscale up --login-server https://headscale.compromyse.xyz
```

> Server
```sh
sudo headscale users create USER
sudo headscale nodes register --key KEY --user USER
```
