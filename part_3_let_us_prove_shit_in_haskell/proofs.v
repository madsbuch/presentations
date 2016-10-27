Require Arith.

Lemma add_is_commutative:
  forall m n : nat,
    m + n = n + m.
Proof.
  intros m n.
  induction m.
  auto.
  unfold plus. fold plus.
  rewrite IHm.
  auto.
Qed.  