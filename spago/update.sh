#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix curl jq

# prelude
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

# config
owner="purescript"
repo="spago"

last_release_version=$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest | jq --raw-output .tag_name)

linux_url="https://github.com/$owner/$repo/releases/download/$last_release_version/linux.tar.gz"
echo "linux_url=$linux_url"
mac_url="https://github.com/$owner/$repo/releases/download/$last_release_version/macOS.tar.gz"
echo "mac_url=$mac_url"

cat > "$script_dir/revision.json" <<EOF
{
  "version": "$last_release_version",
  "linux": {
    "url": "$linux_url",
    "sha256": "$(nix-prefetch-url --quiet $linux_url)"
  },
  "mac": {
    "url": "$mac_url",
    "sha256": "$(nix-prefetch-url --quiet $mac_url)"
  }
}
EOF
