#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix curl jq

# prelude
script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")

# config
owner="joneshf"
repo="purty"

subject="joneshf"
repo="generic"
package="purty"

last_release_version=$(curl "https://api.bintray.com/packages/$subject/$repo/$package" | jq --raw-output .latest_version)

echo "last_release_version=$last_release_version"

linux_url="https://dl.bintray.com/$subject/$repo/$package-$last_release_version-linux.tar.gz"
echo "linux_url=$linux_url"
mac_url="https://dl.bintray.com/$subject/$repo/$package-$last_release_version-osx.tar.gz"
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
