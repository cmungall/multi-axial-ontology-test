
all: eq-merged-reasoned.owl


%.ids: %.obo
	blip-findall -i $< class/1 -no_pred | perl -npe 's@.*/@@' > $@.tmp && (echo $* && cat $@.tmp) > $@

eq.owl: quality.ids entity.ids
	apply-pattern.py -b http://example.org/test/ -p eq-pattern.yaml -x $^ > $@

eq-merged.owl: eq.owl quality.owl entity.owl
	robot merge $(patsubst %, -i %,$^) -o $@

%-reasoned.owl: %.owl
	robot reason -i $< -r elk -o $@


%.obo: %.owl
	owltools $< -o -f obo $@
