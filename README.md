A sample multi-axial ontology. Source includes recipe for creating a
lattice (EQ) from two (tree) ontologies E and Q.

The primary purpose of this repo is to explore visualization of
lattices by deconstructing the lattice back into trees, or something
approaching trees.

The idea is that when browsing EQ, you could choose to see one of two
axes: anatomical vs qualitative

In reality this will be messier and recursive. The anatomical ontology
will not be a tree but a lattice itself made from trees. For real
ontologies, the ultimate primatives are rarely true trees.

Two possible approaches:

 1. At time of reasoning annotate inferred superclass axioms with axis of classification
 2. Make browser reasoner-aware

1 is probably easiest and most robust to incomplete
axiomatization. Will need a bit of work on the OWLAPI pipeline though.

## Dumb Lattice

Lattice with dumb repetitive information:

![img](eq-reasoned.png)

## Notes

This repo currently only has a single example, a cross-product of two trees

I may later rearrange into subdirs of increasing complexity
