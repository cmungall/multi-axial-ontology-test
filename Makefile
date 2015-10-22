
all: eq-reasoned.owl


%.ids: %.obo
	blip-findall -i $< class/1 -no_pred | perl -npe 's@.*/@@' > $@.tmp && (echo $* && cat $@.tmp) > $@

eq.owl: quality.ids entity.ids
	apply-pattern.py -b http://example.org/test/ -p eq-pattern.yaml -x $^ > $@

eq-reasoned.owl: eq.owl quality.owl entity.owl
	owltools $^  --add-imports-from-supports --assert-inferred-subclass-axioms --remove-imports-declarations -o $@

%.obo: %.owl
	owltools $<  --remove-dangling -o -f obo $@
