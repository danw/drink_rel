shell:
	drink_devel/bin/drink attach

start:
	drink_devel/bin/drink start

stop:
	drink_devel/bin/drink stop

test:
	drink_devel/bin/drink console

logs:
	erl -boot start_sasl -sasl sasl_error_logger false -noshell -eval 'rb:start([{report_dir, "data/log/sasl"}]), rb:show(), init:stop().' | less

status:
	@echo "--- drink_rel ---"
	@git status -s
	@sh -c 'for i in `ls src`; do cd src/$$i; echo "--- $$i ---"; git status -s; cd ../..; done'

unpushed:
	@echo "--- drink_rel ---"
	@git log --oneline origin/master..HEAD
	@sh -c 'for i in `ls -1 src`; do cd src/$$i; echo "--- $$i ---"; git log --oneline origin/master..HEAD; cd ../..; done'

push:
	@echo "--- drink_rel ---"
	@git push origin master
	@sh -c 'for i in `ls -1 src`; do cd src/$$i; echo "--- $$i ---"; git push origin master; cd ../..; done'

rebase:
	@echo "--- drink_rel ---"
	@(git fetch origin; git rebase origin/master)
	@sh -c 'for i in `ls -1 src`; do cd src/$$i; echo "--- $$i ---"; git fetch origin; git rebase origin/master; cd ../..; done'

regen:
	@rebar compile
	@rebar generate force=1
	@mkdir -p data/mnesia_data data/log/sasl data/log/web
