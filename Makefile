.DEFAULT_GOAL := release

release: 
	git submodule update --remote --merge
	git add .
	@read -p "Enter commit message: " msg; \
	git commit -am"release: `date +'%d.%m.%Y'` - $$msg"
	git push origin master
