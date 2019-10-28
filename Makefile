default:
	nix-shell --run 'make test'

test:
	which purs
	purs --version

	which spago2nix
	spago2nix

	which psc-package
	psc-package --version

	which purp
	purp

	which dhall
	dhall version

	which dhall-to-json
	dhall-to-json --version

	which spacchetti
	spacchetti version

	which spago
	spago version

	which zephyr
	zephyr --version

	which psc-package2nix
	which pp2n
	pp2n

update_all:
	concurrently \
		"./easy-dhall/update.sh" \
		"./psc-package-simple/update.sh" \
		"./psc-package2nix/update.sh" \
		"./pscid/update.sh" \
		"./purp/update.sh" \
		"./purs/update.sh" \
		"./spago/update.sh" \
		"./zephyr/update.sh" \
		"./spago2nix/update.sh"
