shell:
	drink_devel/bin/drink console

logs:
	erl -boot start_sasl -sasl sasl_error_logger false -noshell -eval 'rb:start([{report_dir, "drink_devel/log/sasl"}]), rb:show(), init:stop().' | less

status:
	@echo "--- drink_rel ---"
	@git status -s
	@sh -c 'for i in `ls src`; do cd src/$$i; echo "--- $$i ---"; git status -s; cd ../..; done'

unpushed:
	@echo "--- drink_rel ---"
	@git log --oneline origin/csh..HEAD
	@echo "--- drink ---"
	@(cd src/drink; git log --oneline origin/dev..HEAD)
	@sh -c 'for i in `ls -1 src | grep -v "^drink$$"`; do cd src/$$i; echo "--- $$i ---"; git log --oneline origin/master..HEAD; cd ../..; done'

push:
	@echo "--- drink_rel ---"
	@git push origin csh
	@echo "--- drink ---"
	@(cd src/drink; git push origin dev)
	@sh -c 'for i in `ls -1 src | grep -v "^drink$$"`; do cd src/$$i; echo "--- $$i ---"; git push origin master; cd ../..; done'

rebase:
	@echo "--- drink_rel ---"
	@(git fetch origin; git rebase origin/master)
	@echo "--- drink ---"
	@(cd src/drink; git fetch origin; git rebase origin/dev)
	@sh -c 'for i in `ls -1 src | grep -v "^drink$$"`; do cd src/$$i; echo "--- $$i ---"; git fetch origin; git rebase origin/master; cd ../..; done'

regen:
	rm -rf drink_devel && rebar compile && rebar generate && make
