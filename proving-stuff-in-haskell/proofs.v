Require Arith.

Inductive t : Set := c : t -> t.

Fixpoint tf (m n : t) : t :=
  match m with
      c r => c (tf r n)
  end.

Lemma test_t :
  forall a b c : t,
    tf a (tf b c) = tf (tf a b) c.
Proof.
  intros a b c.

  induction a.
  
  unfold tf.
  fold tf.

  
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