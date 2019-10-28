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

# TODO: dont depend on npm
# TODO: fix pscid update
# TODO: use github actions shedule to update and make prs
# https://github.com/marketplace/actions/create-pull-request#example-workflow-to-automate-periodic-dependency-updates
# https://github.com/cachix/install-nix-action/blob/master/src/main.ts
update_all:
	npm install -g concurrently
	./spago2nix/update.sh # pscid depends on spago2nix
	concurrently \
		"./easy-dhall/update.sh" \
		"./psc-package-simple/update.sh" \
		"./psc-package2nix/update.sh" \
		"./pscid/update.sh" \
		"./purp/update.sh" \
		"./purs/update.sh" \
		"./spago/update.sh" \
		"./zephyr/update.sh"
