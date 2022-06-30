(* 
      
     implementation beta-reduction of lambda calculus

   please see Paulson's (https://www.cl.cam.ac.uk/~lp15/) 
   lecture:
   
   Foundations of Functional Programming

   in src/Founds-FP.pdf of netdisk for the introduction
   of lambda calculus

  *)

(* Turing' master Church 1930: 

   1/ every thing is function.
   2/ every function must be anonymous.
 *)

(* Syntax:

   1/ x, y, z, plus, ... VAR 
   2/ M N : application (not  M (N) !)
      left associativity: M N P == (M N) P
   3/ λx.M : abstraction (define function) anonymous
 *)

(* coq uses type λ-terms with extensions
   cst, fix, match, type, ... 
   λ x. M <=> fun x:T => M:T 
 *)

Require Export List.
Import ListNotations.

Require Export String.

(* Examples of lambda in coq *)

(* (λx.x+2)2 *)
Compute (fun x => x + 2) 2.
Compute (fun x => plus x 2) 2.

(* let expression https://en.wikipedia.org/wiki/Let_expression *)

Compute let plus2 := fun x => plus x 2 in plus2 2.

(* so the name is syntactic sugar *)

Compute (fun plus2 => plus2) (fun x => x + 2) 2.

(* high order functions *)

(* the composition is function: λf.λg.λx.g (f x) *)

(* type annotation: (t : type) *)
Definition compose := fun (f: nat -> nat)
                     => fun (g : _ -> nat)
                       => fun x => g (f x).

Check compose.

Compute compose S S 0.

Compute compose (plus 2) (plus 3) 3.

Compute compose (fun x => x + 3) (plus 2) 4.

(* sugar : λx move to the left *)
Definition compose' (f: nat -> nat) (g: nat -> nat) x := g (f x).

Compute compose' S S 3.

(* coq: type can be argument *)

Definition compose'' {A B C : Set} (f: A -> B) (g : B ->C)
           (x:A) :=
   g ( f x).

Check compose''.

Compute compose'' S S 2. 

Open Scope string_scope.

(* Definition of lambda term *)

Inductive lambda : Set :=
| Var : string -> lambda
| App : lambda -> lambda -> lambda
| Abs : string -> lambda -> lambda
.

(* Church Numerals ZERO : λfx.x *)
Definition ZERO := Abs "f" (Abs "x" (Var "x")).

(* 
   (require Coq 3.12)

   To make lambda terms easier to read and write, we introduce some
   notations and implicit coercions. You do not need to understand
   exactly what these declarations do.  Briefly, though:
   
   - The [Coercion] declaration stipulates that a function (or
     constructor) can be implicitly used by the type system to
     coerce a value of the input type to a value of the output
     type. For instance, the coercion declaration for [Var]
     allows us to use plain strings when a lambda term is expected;
     the string will implicitly be wrapped with [Var].

   - [Declare Custom Entry lambda] tells Coq to create a new
     "custom grammar" for parsing lambda terms. 
     The first notation declaration after this tells Coq
     that anything between [<] and [>] should be parsed using
     the lambda grammar.
*)

Declare Custom Entry lambda.
Notation "< e >" := e (e custom lambda at level 99).
Notation "( x )" := x (in custom lambda, x at level 99).
Notation "x" := x (in custom lambda at level 0, x constr at level 0).
Notation "x y" := (App x y)
                    (in custom lambda at level 1, left associativity).
Notation "\ x : y" :=
  (Abs x  y) (in custom lambda at level 90, x at level 99,
                     y custom lambda at level 99,
                     left associativity).
Coercion Var : string >-> lambda.

Print ZERO.
(*
   ZERO = < \ "f" : \ "x" : "x" > : lambda
 *)
Set Printing Coercions.

Print ZERO.
(* ZERO = < \ "f" : \ "x" : (Var "x") > : lambda *)

Unset Printing Notations.

Print ZERO.
(* 
   ZERO = Abs (String (Ascii.Ascii false true true false 
                      false true true false) EmptyString)
              (Abs (String (Ascii.Ascii false false false 
                       true true true true false) EmptyString)
                   (Var (String (Ascii.Ascii false false
                         false true true true true false) EmptyString)))
     : lambda
 *)
Set Printing Notations.
Unset Printing Coercions.

(* Church encoding : see
   https://en.wikipedia.org/wiki/Church_encoding *)

(* define the variable used in Church Numerals *)

Definition x := "x".
Definition y := "y".
Definition z := "z".
Definition a := "a".
Definition b := "b".
Definition c := "c".
Definition m := "m".
Definition n := "n".
Definition f := "f".
Definition p := "p".

(* SUCC : λn.λfx.f(nfx) *)
Definition SUCC := <\n:\f:\x: f (n f x)>.

Fixpoint bound term : list string:=
  match term with 
  | Var _ => []
  | <\x : t1> => x :: bound t1
  | <t1 t2> =>  (bound t1) ++ (bound t2)
  end.

Fixpoint fv term : list string:=
  match term with 
  | Var x => [x]
  | Abs x t1 => remove string_dec x (fv t1)
  | App t1  t2 =>  (fv t1) ++ (fv t2)
  end.

Compute fv <\x : x y>.
Compute bound SUCC.
Compute fv SUCC.
(* so SUCC is closed term *)

(* substitution *)
(* s is free for x in t:  t[s/x] *)

Definition find_x l x :=
  let f y := if (string_dec x y) then true else false in
           find f l.

(* for the substitution (λx.(...y...))[s/y], to avoid
   side effect, s must have no free occurrence of x *)

Definition s_is_free_for_x s x :=
  let fv_in_s := fv s in  
  if find_x fv_in_s x then true else false.

Compute s_is_free_for_x  <\x : x y> "y".

(* substition t[s/x] : no occurrence check! *)

Fixpoint substitution t x s : lambda:=
  match t with 
  | Var v => if string_dec v x then s else t 
  | Abs v  t1 => if string_dec v x then t
             else (* if s_is_free_for_x s v then
                     # "side effect: must do alpha conversion"
                   else *)
                    Abs v  (substitution t1 x s)
  | App t1  t2 => App (substitution t1 x s)  (substitution t2 x s)
  end.

(* with catpure check *)
Fixpoint substitution' t x s :=
  match t with 
  | Var v => if string_dec v x then s else t 
  | <\v : t1> => if string_dec v x then t
             else if s_is_free_for_x s v then
                     Var "side effect: must do alpha conversion"
                  else
                    Abs v  (substitution' t1 x s)
  | <t1  t2> => App (substitution' t1 x s)  (substitution' t2 x s)
  end.
  
Compute substitution <\y : x y> x <\x: x> .


(* ..... ((λx.M) N)...  redex *)
(* .......M[N/x].....  beta-reduction *)

(* strategy : how find redex: 
   https://en.wikipedia.org/wiki/Evaluation_strategy *)

(* reduction Innermost rightmost *)

Fixpoint inright_step t :=
  match t with
  | Var v => None
  | <\v : t1> => let t1' := inright_step t1 in
             match t1' with
             | None => None
             | Some t1'' => Some  <\v : t1''> 
             end
  | <t1  t2> => let t2' := inright_step t2 in
              match t2' with
              | None => let t1' := inright_step t1 in
                       (* high risk of capture error *)
                       match t1' with
                       | None => match t1 with
                                | <\x : t1''> => Some (substitution' t1'' x t2)
                                | _ => None
                                end
                       | Some t1'' => Some <t1'' t2>
                       end
              | Some t2'' => Some <t1 t2''>
              end
  end.

(* reduction call_by_value *)
Fixpoint cbv t :=
  match t with
  | Var v => None
  | <\v : t1> => let t1' := cbv t1 in
             match t1' with
             | None => None
             | Some t1'' => Some  <\v : t1''> 
             end
  | <t1  t2> => let t2' := cbv t2 in
              match t2' with
              | None => match t1 with
                       | <\v : t1'> =>  Some (substitution t1' v t2)
                       | _ => match cbv t1 with
                             | None  => None
                             | Some t1'  => Some <t1' t2>
                             end
                       end
              | Some t2'' => Some <t1 t2''>
              end
  end.

(* TODO : normal reduction: Outmost leftmost (call by name) 

   the search the subterm of form ...((λx.M) ; N)... 
   (called a redex), then do the substitution M[N/x], 
   so called beta-reduction, then returns
   Some (...(M[N/x]...); if no redex, returns None.

   Outmost leftmost strategy is:

   recursive call normal_step t with:

   if term t is of form
   1/ (λx.M) N: return Some (M[N/y])
   2/ M N : M is not an abstraction
            if normal_step M return Some M', 
            then return Some (M' N) 
            else if normal_step N return Some N'
                 then return Some (M N') 
                 else return None  
   3/ (λx.M) : if normal_step M return Some M'            
               then return Some (λx.M')
               else return None
   3/ x : return None
   
 *)

Fixpoint normal_step t :=  
  match t with
  | Var v => None
  | <\v : t1> => let t1' := normal_step t1 in
             match t1' with
             | None => None
             | Some t1'' => Some  <\v : t1''> 
             end
  | <t1  t2> => match t1 with
              | <\x : t1'> => Some (substitution t1' x t2)
              | _ => let t1' := normal_step t1 in
                    match t1' with
                    | None => let t2' := normal_step t2 in
                             match t2' with
                             | None => None
                             | Some t2'' => Some <t1  t2''>
                             end
                    | Some t1'' => Some <t1''  t2>
                    end
              end
  end.



Fixpoint steps (strategy: lambda -> option lambda) n count t :=
  match n with
  | 0 => (t, count) 
  | S n' => let t' := strategy t in
           match t' with
           | None => (t, count)
           | Some t'' => steps strategy n' (S count) t''
           end
  end.

Definition normal_steps n t := steps normal_step n 0 t.

Definition inright_steps n t := steps inright_step n 0 t. 

Definition cbv_steps n t := steps cbv n 0 t.

Compute cbv_steps 10  <SUCC ZERO>.

Theorem  church_rosser_ex01 : fst (cbv_steps 10 <SUCC ZERO>)
                              = fst (normal_steps 10 <SUCC ZERO>).
Proof.
  simpl.
  reflexivity.
Qed.  

Definition ONE := <SUCC ZERO>.

Definition TWO := <SUCC ONE>.

Definition THREE := <SUCC TWO>.

Definition FOUR := <SUCC THREE>.

Definition FIVE := <SUCC FOUR>.

(* ADD = λab.a SUCC b *) 
Definition ADD := <\a: \b: (a SUCC) b>.

(* ADD' = λab.λfx.af(bfx) *)
Definition ADD' := <\a: \b: \f :\x: a f (b f x)>.

(* MULT = λab.a (ADD b) ZERO *)
Definition MULT := <\a: \b: a (ADD b) ZERO>.

Theorem  church_rosser_ex02 :
   fst (cbv_steps 100 <MULT TWO TWO>)
 = fst (normal_steps 150 <MULT TWO TWO>).
Proof.
  simpl.
  reflexivity.
Qed.  

Compute (cbv_steps 200 <MULT FOUR FOUR>).
(* 53 steps *)

Compute steps inright_step 200 0 <MULT FOUR FOUR>.
(* side effect occurs *)

(* TRUE = λxy.x *)
Definition TRUE := <\x: \y: x>.

(* FALSE = λxy.y *)
Definition FALSE := <\x: \y: y>.

(* LIF = λabc.abc *)
Definition LIF := <\a:\b:\c: a b c>.

(* OR = λab.LIF a TRUE b *)
Definition OR := <\a: \b: LIF a TRUE b>.

(* AND = λab.LIF a b FALSE *)
Definition AND := <\a: \b: LIF a FALSE b>.

(* NOT = λa.LIF a FALSE TRUE *)
Definition NOT := <\a: \b: LIF a FALSE TRUE>.

(* PAIR = λab.λx.IF x a b *)
Definition PAIR := <\a:\b:\x: LIF x a b>.

(* FST = λa.a TRUE *)
Definition FST := <\a:a TRUE>.

(* SND = λa.a FALSE *)
Definition SND := <\a: a FALSE>.

(* PRED = λnfx.SND (n(λp.PAIR (f (FST p)) (FST p)) (PAIR x x))" *)
Definition PRED := <\n:\f:\x: SND (n
                   (\p: PAIR (f (FST p)) (FST p))
                   (PAIR x x))>.

(* ISZERO = λn.n (λx.FALSE) TRUE *)
Definition ISZERO := <\n: n (\x: FALSE) TRUE>.

(* Y combinator:
   https://en.wikipedia.org/wiki/Fixed-point_combinator *)

(* FIX = λf.(λx.f(xx))(λx.f(xx)) *)
Definition FIX := <\f: (\x: f (x x))  (\x: f (x x))>.

Compute normal_steps 10 FIX.
Compute normal_steps 20 FIX.

(* diverge *)

(* SUM = FIX (λfn.LIF (ISZERO n) ZERO (ADD n (f (PRED n)))) *)
Definition SUM := <FIX (\f:\n: LIF (ISZERO n) ZERO
                          (ADD n (f (PRED n))))>.
   

Compute normal_steps 1000  <SUM FOUR>.
(* 786 steps to converge *)

(* FACT = FIX (λfn.LIF (ISZERO n) ONE (MULT n (f (PRED n)))) *)
Definition FACT := <FIX (\f: \n: LIF (ISZERO n) ONE
                           (MULT n (f (PRED n))))>.

Compute normal_steps 3000  <FACT THREE>.
(* 2109 to converge *)

(* cbv will diverge! *)
Compute cbv_steps 10  <SUM ZERO>.
Compute cbv_steps 100  <SUM ZERO>.

Compute normal_steps 20  <SUM ZERO>.
(* converge in 12 steps *)


(* from https://softwarefoundations.cis.upenn.edu/lf-current/Poly.html *)
Module Church.

(** In this exercise, we will explore an alternative way of defining
    natural numbers, using the so-called _Church numerals_, named
    after mathematician Alonzo Church. We can represent a natural
    number [n] as a function that takes a function [f] as a parameter
    and returns [f] iterated [n] times. More formally, *)

Definition nat := forall X : Type, (X -> X) -> X -> X.

(** Let's see how to write some numbers with this notation. Any
    function [f] iterated once shouldn't change. Thus, *)

Definition one : nat := 
  fun (X : Type) (f : X -> X) (x : X) => f x.


(** [two] should apply [f] twice to its argument: *)

Definition two : nat :=
  fun (X : Type) (f : X -> X) (x : X) => f (f x).

(** [zero] is somewhat trickier: how can we apply a function zero
    times? The answer is simple: just leave the argument untouched. *)

Definition zero : nat :=
  fun (X : Type) (f : X -> X) (x : X) => x.


(** More generally, a number [n] will be written as [fun X f x => f (f
    ... (f x) ...)], with [n] occurrences of [f]. Notice in particular
    how the [doit3times] function we've defined previously is actually
    just the representation of [3]. *)

Definition doit3times {X:Type} (f:X -> X) (n:X) : X :=
  f (f (f n)).

Definition three : nat := @doit3times.
(* @ expose the implicit argument *)



(** Complete the definitions of the following functions. Make sure
    that the corresponding unit tests pass by proving them with
    [reflexivity]. *)    

(** Successor of a natural number *)

Definition succ (n : nat) : nat :=
  fun (X : Type) (f : X -> X) (x : X) => f (n X f x).
(* type X is function argument *)

(* from Church Numerals to natural *)
Compute zero Datatypes.nat S 0.
Compute succ zero Datatypes.nat S 0.

Example succ_1 : succ zero = one.
Proof.
  cbv delta.
  reflexivity.
Qed.

Example succ_2 : succ one = two.
Proof. (* FILL IN HERE *) Admitted.

Example succ_3 : succ two = three.
Proof. (* FILL IN HERE *) Admitted.

(** Addition of two natural numbers *)

Definition plus (n m : nat) : nat :=
 fun (X : Type) (f : X -> X) (x : X) => m X f (n X f x).

Example plus_1 : plus zero one = one.
Proof. (* FILL IN HERE *) reflexivity.
Qed.

Example plus_2 : plus two three = plus three two.
Proof. (* FILL IN HERE *) Admitted.

Example plus_3 :
  plus (plus two two) three = plus one (plus three three).
Proof. (* FILL IN HERE *) Admitted.

(** Multiplication *)

Definition mult (n m : nat) : nat := 
  fun (X : Type) (f : X -> X) => m X (n X f).

  (* FILL IN HERE *) 

Example mult_1 : mult one one = one.
Proof. 
  reflexivity.
Qed.
(* FILL IN HERE *)

Example mult_2 : mult zero (plus three three) = zero.
Proof. (* FILL IN HERE *) Admitted.

Example mult_3 : mult two three = plus three three.
Proof. (* FILL IN HERE *) Admitted.

(** Exponentiation *)

(** Hint: Polymorphism plays a crucial role here. However, choosing
    the right type to iterate over can be tricky. If you hit a
    "Universe inconsistency" error, try iterating over a different
    type: [nat] itself is usually problematic. *)

Definition exp (n m : nat) : nat :=
  fun (X : Type) => m (X -> X) (n X).

  (* FILL IN HERE *) 

Example exp_1 : exp two two = plus two two.
Proof. 
  reflexivity.
Qed.
(* FILL IN HERE *)

Compute exp three two Datatypes.nat S 0.

Example exp_2 : exp three two = plus (mult two (mult two two)) one.
Proof. (* FILL IN HERE *) Admitted.

Example exp_3 : exp three zero = one.
Proof. (* FILL IN HERE *) Admitted.

End Church.

