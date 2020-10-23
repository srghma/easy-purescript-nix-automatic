test:
	nix-shell --run 'make test_implementation'

test_implementation:
	which purs
	purs --version

	which purty
	purty --help

	which spago2nix
	spago2nix

	# which psc-package
	# psc-package --version

	which purp
	purp

	which dhall
	dhall version

	which dhall-to-json
	dhall-to-json --version

	which spago
	spago version

	# which zephyr
	# zephyr --version

	which psc-package2nix
	which pp2n
	pp2n


# TODO: dont depend on npm

# TODO: fix pscid update, depends on https://github.com/justinwoo/spago2nix/issues/18 and https://github.com/spacchetti/spago/issues/472

# TODO: use github actions shedule to update and make prs
# https://github.com/marketplace/actions/create-pull-request#example-workflow-to-automate-periodic-dependency-updates
# https://github.com/cachix/install-nix-action/blob/master/src/main.ts

# TODO
# "./purty/update.sh"

update_all:
	npm install -g concurrently
	concurrently \
		"./spago2nix/update.sh" \
		"./easy-dhall/update.sh" \
		"./psc-package-simple/update.sh" \
		"./psc-package2nix/update.sh" \
		"./purp/update.sh" \
		"./purs/update.sh" \
		"./spago/update.sh" \
		"./zephyr/update.sh"
