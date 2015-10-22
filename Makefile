
all: eq-reasoned.owl

%.obo: %.owl
	owltools $< -o -f obo $@

# hacky way to get IDs from an ontology; requires obo
%.ids: %.obo
	blip-findall -i $< class/1 -no_pred | perl -npe 's@.*/@@' > $@.tmp && (echo $* && cat $@.tmp) > $@

# cross-product ontology is made using DOS design patterns
eq.owl: quality.ids entity.ids
	apply-pattern.py -b http://example.org/test/ -p eq-pattern.yaml -x $^ > $@

# as above but include imports
eq-with-imports.owl: eq.owl quality.owl entity.owl
	owltools $^  --add-imports-from-supports -o $@

eq-reasoned.owl: eq.owl quality.owl entity.owl
	owltools $^  --add-imports-from-supports --assert-inferred-subclass-axioms --remove-imports-declarations -o $@

# annotate each edge with a 'mini-explanation', which is essentially just the ontologies that justify the edge;
# e.g. for an edge that requires the entity ontology, it will be annotated requires=entity
eq-annotated.owl: eq-with-imports.owl
	owltools --use-catalog $< --annotate-with-reasoner -o $@

%-nd.obo: %.owl
	owltools $<  --remove-dangling -o -f obo $@

# Stripped down: just the nodes, no edges
eq-terms.owl: eq.owl
	owltools $< --remove-axioms -t EquivalentClasses -o $@
