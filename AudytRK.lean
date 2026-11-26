import Mathlib

/-!
# Reguła Krzyża, rytm 4–6–0, B1 i dodatnie jądra Newtona
Audyt etapów 191–209, 26 XI 2026.

Nie ma tu deklaracji `axiom` ani luk `sorry`. Warunki analityczne są
jawnie przekazywane jako hipotezy twierdzeń. Plik obejmuje rdzeń
algebraiczny, kombinatoryczny i logiczny redukcji. Nie formalizuje BV,
sita Selberga, sum Liouville'a ani obliczeń 100 mln współczynników.
W środowisku przygotowania pliku nie było Lean/Mathlib: wymaga kompilacji.
- enuncjaty: `barrierB1`, `negativeKernelForcesUnboundedTwins`.
-/

namespace AudytRK

set_option maxHeartbeats 1000000
set_option maxRecDepth 4096

-- 1. Fundament algebraiczny (bez obciętego odejmowania na ℕ).
def armL (m : ℤ) := 6*m-1
def armR (m : ℤ) := 6*m+1
def center (m : ℤ) := 12*m^2-1

theorem cross_rule (m : ℤ) : armL m * armR m = 3*center m+2 := by
  unfold armL armR center
  ring

theorem arm_sum (m : ℤ) : armL m + armR m = 12*m := by
  unfold armL armR
  ring

theorem arm_gap (m : ℤ) : armR m - armL m = 2 := by
  unfold armL armR
  ring

theorem rhythm4 (k : ℤ) : armL (5*k+2) + armR (5*k+2) = 6*(10*k+4) := by
  unfold armL armR
  ring

theorem rhythm6 (k : ℤ) : armL (5*k+3) + armR (5*k+3) = 6*(10*k+6) := by
  unfold armL armR
  ring

theorem rhythm0 (k : ℤ) : armL (5*k+5) + armR (5*k+5) = 6*(10*k+10) := by
  unfold armL armR
  ring

-- Klasy modulo 5 po odrzuceniu podzielności przez 5.
theorem allowed_mod5 (m : ℤ) :
    (armL m % 5 ≠ 0 ∧ armR m % 5 ≠ 0) ↔
    (m % 5 = 0 ∨ m % 5 = 2 ∨ m % 5 = 3) := by
  unfold armL armR
  omega

theorem center_symmetry (k : ℤ) : center (5*(-k-1)+2) = center (5*k+3) := by
  unfold center
  ring

theorem killed_tor0 (t : ℤ) :
    30*(77*t+3)+29 = 7*(330*t+17) ∧
    30*(77*t+3)+31 = 11*(210*t+11) := by
  constructor <;> ring

-- 2. Dokładna kombinatoryka trzeciego momentu, bez dzielenia całkowitego.
-- S3 = choose(K,3), H3 = x*y*z, 2D3 = suma wyrażeń poniżej.
def d3twice (x y z : ℤ) :=
  x*(x-1)*(y+z) + y*(y-1)*(x+z) + z*(z-1)*(x+y)

theorem third_moment (x y z : ℤ) :
    (x+y+z)*(x+y+z-1)*(x+y+z-2) =
    6*x*y*z + 3*d3twice x y z +
    x*(x-1)*(x-2) + y*(y-1)*(y-2) + z*(z-1)*(z-2) := by
  unfold d3twice
  ring

theorem third_moment_012 (x y z : ℤ)
    (hx : 0 ≤ x ∧ x ≤ 2) (hy : 0 ≤ y ∧ y ≤ 2) (hz : 0 ≤ z ∧ z ≤ 2) :
    (x+y+z)*(x+y+z-1)*(x+y+z-2) = 6*x*y*z + 3*d3twice x y z := by
  have h (t : ℤ) (ht : 0 ≤ t ∧ t ≤ 2) : t*(t-1)*(t-2) = 0 := by
    have ht' : t=0 ∨ t=1 ∨ t=2 := by omega
    rcases ht' with h0 | h1 | h2
    · simp [h0]
    · simp [h1]
    · simp [h2]
  have hmain := third_moment x y z
  rw [h x hx, h y hy, h z hz] at hmain
  linarith

-- Bez pełnego toru trzeci moment D3 znika.
theorem no_full_tor_no_D3 (x y z : ℤ)
    (hx : 0 ≤ x ∧ x ≤ 1) (hy : 0 ≤ y ∧ y ≤ 1) (hz : 0 ≤ z ∧ z ≤ 1) :
    d3twice x y z = 0 := by
  have h (t : ℤ) (ht : 0 ≤ t ∧ t ≤ 1) : t*(t-1) = 0 := by
    have ht' : t=0 ∨ t=1 := by omega
    rcases ht' with h0 | h1
    · simp [h0]
    · simp [h1]
  unfold d3twice
  rw [h x hx, h y hy, h z hz]
  ring

-- Dokładne masy z kolizji modulo 7 (liczby trójek wyliczone w tekście).
theorem crt_ratio : (10 + 2*(5/4 : ℚ)) / (6+2*(5/4 : ℚ)) = 25/17 := by
  norm_num

theorem crt_s3_ratio : (1 : ℚ) + 25/17 = 42/17 := by norm_num

theorem crt_period : (5*7*11*13*17*19 : ℕ) = 1616615 := by norm_num

theorem crt_survival : (80325 : ℚ)/126225 = 7/11 := by norm_num

-- 3. Moment podpisany. r_i = liczba rough ramion, x_i = liczba pierwszych.
def term (r x anchors : ℤ) : ℤ := if r=2 then (2-2*x)*anchors else 0

def rowMoment (r4 r6 r0 x4 x6 x0 : ℤ) : ℤ :=
  term r4 x4 (r6+r0) + term r6 x6 (r4+r0) + term r0 x0 (r4+r6)

theorem term_nonneg (r x b : ℤ) (hx : x ≤ 1) (hb : 0 ≤ b) : 0 ≤ term r x b := by
  unfold term
  split
  · exact mul_nonneg (by omega) hb
  · exact le_rfl

theorem row_nonneg_of_no_twin (r4 r6 r0 x4 x6 x0 : ℤ)
    (hr4 : 0 ≤ r4) (hr6 : 0 ≤ r6) (hr0 : 0 ≤ r0)
    (hx4 : x4 ≤ 1) (hx6 : x6 ≤ 1) (hx0 : x0 ≤ 1) :
    0 ≤ rowMoment r4 r6 r0 x4 x6 x0 := by
  unfold rowMoment
  exact add_nonneg (add_nonneg (term_nonneg _ _ _ hx4 (by omega))
    (term_nonneg _ _ _ hx6 (by omega))) (term_nonneg _ _ _ hx0 (by omega))

theorem term_lower (r x b : ℤ) (hx : x ≤ 2) (hb : 0 ≤ b ∧ b ≤ 4) :
    -8*(if x=2 then 1 else 0) ≤ term r x b := by
  by_cases h : x=2
  · subst x
    unfold term
    split <;> simp_all <;> omega
  · rw [if_neg h]
    have hx' : x ≤ 1 := by omega
    simpa using term_nonneg r x b hx' hb.1

theorem row_lower (r4 r6 r0 x4 x6 x0 : ℤ)
    (hr4 : 0 ≤ r4 ∧ r4 ≤ 2) (hr6 : 0 ≤ r6 ∧ r6 ≤ 2) (hr0 : 0 ≤ r0 ∧ r0 ≤ 2)
    (hx4 : x4 ≤ 2) (hx6 : x6 ≤ 2) (hx0 : x0 ≤ 2) :
    -8*((if x4=2 then 1 else 0)+(if x6=2 then 1 else 0)+(if x0=2 then 1 else 0))
      ≤ rowMoment r4 r6 r0 x4 x6 x0 := by
  have h4 := term_lower r4 x4 (r6+r0) hx4 (by omega)
  have h6 := term_lower r6 x6 (r4+r0) hx6 (by omega)
  have h0 := term_lower r0 x0 (r4+r6) hx0 (by omega)
  unfold rowMoment
  linarith

-- Na przesianych ramionach λ = 1-2p; p jest wskaźnikiem pierwszości.
-- Ten lemat nie zakłada niezależności znaków.
theorem two_sign_identity (p q : ℤ) :
    4*p*q = 1-((1-2*p)+(1-2*q))+(1-2*p)*(1-2*q) := by ring

theorem parity_lower (M L C J : ℝ) (h : 4*J=M-L+C) (hc : -M ≤ C) : -L/4 ≤ J := by
  linarith

-- Ograniczenie liczby czynników: 3 czynniki > z dają iloczyn > z^3.
theorem cube_excludes_three (z a b c N : ℕ)
    (ha : z < a) (hb : z < b) (hc : z < c) (hN : N ≤ z^3) : N < a*b*c := by
  have h1 : z*z ≤ a*b := Nat.mul_le_mul (Nat.le_of_lt ha) (Nat.le_of_lt hb)
  have hab : 0 < a*b := Nat.mul_pos (by omega) (by omega)
  have h2 : z*z*z ≤ a*b*z := Nat.mul_le_mul_right z h1
  have h3 : a*b*z < a*b*c := Nat.mul_lt_mul_of_pos_left hc hab
  have h4 : z^3 = z*z*z := by ring
  omega

-- Wersja dokładnie dla floor pierwiastka sześciennego.
theorem cube_floor_excludes_three (z a b c N : ℕ)
    (ha : z < a) (hb : z < b) (hc : z < c) (hN : N < (z+1)^3) : N < a*b*c := by
  have h1 : (z+1)*(z+1) ≤ a*b := Nat.mul_le_mul (by omega) (by omega)
  have h2 : (z+1)*(z+1)*(z+1) ≤ a*b*c := Nat.mul_le_mul h1 (by omega)
  have he : (z+1)^3 = (z+1)*(z+1)*(z+1) := by ring
  omega

-- 4. Rzeczywiste cykle i przesłanka braku bliźniaków.
def primeBit (n : ℕ) : ℤ := if n.Prime then 1 else 0

def TwinCycle (k : ℕ) : Prop :=
  ((30*k+11).Prime ∧ (30*k+13).Prime) ∨
  ((30*k+17).Prime ∧ (30*k+19).Prime) ∨
  ((30*k+29).Prime ∧ (30*k+31).Prime)

def UnboundedTwins : Prop := ∀ K : ℕ, ∃ k : ℕ, K ≤ k ∧ TwinCycle k

theorem primeBit_le_one (a b : ℕ) (h : ¬ (a.Prime ∧ b.Prime)) :
    primeBit a + primeBit b ≤ 1 := by
  unfold primeBit
  by_cases ha : a.Prime <;> by_cases hb : b.Prime <;> simp_all

-- R jest wskaźnikiem rough zależnym od całego cyklu (wyznacza go sito).
def bit (b : Bool) : ℤ := if b then 1 else 0

def rc (R : ℕ → ℕ → Bool) (k a b : ℕ) : ℤ :=
  bit (R k (30*k+a)) + bit (R k (30*k+b))

def pc (k a b : ℕ) : ℤ := primeBit (30*k+a) + primeBit (30*k+b)

def ell (R : ℕ → ℕ → Bool) (k : ℕ) : ℤ :=
  rowMoment (rc R k 11 13) (rc R k 17 19) (rc R k 29 31)
    (pc k 11 13) (pc k 17 19) (pc k 29 31)

theorem bit_nonneg (b : Bool) : 0 ≤ bit b := by cases b <;> decide

theorem rc_nonneg (R : ℕ → ℕ → Bool) (k a b : ℕ) : 0 ≤ rc R k a b := by
  unfold rc
  exact add_nonneg (bit_nonneg _) (bit_nonneg _)

theorem ell_nonneg_of_no_twin (R : ℕ → ℕ → Bool) (k : ℕ) (h : ¬ TwinCycle k) : 0 ≤ ell R k := by
  have h4 : ¬ ((30*k+11).Prime ∧ (30*k+13).Prime) := fun h' => h (Or.inl h')
  have h6 : ¬ ((30*k+17).Prime ∧ (30*k+19).Prime) := fun h' => h (Or.inr (Or.inl h'))
  have h0 : ¬ ((30*k+29).Prime ∧ (30*k+31).Prime) := fun h' => h (Or.inr (Or.inr h'))
  unfold ell pc
  exact row_nonneg_of_no_twin _ _ _ _ _ _ (rc_nonneg _ _ _ _) (rc_nonneg _ _ _ _)
    (rc_nonneg _ _ _ _) (primeBit_le_one _ _ h4) (primeBit_le_one _ _ h6) (primeBit_le_one _ _ h0)

theorem negative_row_forces_twin (R : ℕ → ℕ → Bool) (k : ℕ) (h : ell R k < 0) : TwinCycle k := by
  by_contra hn
  exact (not_lt_of_ge (ell_nonneg_of_no_twin R k hn)) h

-- 5. Teleskop CRT: n_{j+1}=(1-2/p)n_j-E_j oraz M analogicznie.
theorem normalized_step (n n' M M' p E : ℝ)
    (hM : M ≠ 0) (hM' : M' ≠ 0)
    (hn : n' = (1-2/p)*n-E) (hm : M' = (1-2/p)*M) :
    E/M' = n/M - n'/M' := by
  field_simp [hM,hM']
  rw [hn,hm]
  ring

theorem telescope (a : ℕ → ℝ) (N : ℕ) :
    (∑ j ∈ Finset.range N, (a j-a (j+1))) = a 0-a N := by
  induction N with
  | zero => simp
  | succ N ih => rw [Finset.sum_range_succ, ih]; ring

-- 6. B1: rachunek rezerwy (BV i asymptotyka modelu pozostają przesłankami).
theorem barrierB1 (X C2 J R T err : ℝ)
    (hX : 0 < X) (hC : 0 < C2)
    (hT : T = 4*C2*(X/2-J)+R+err)
    (hJ : J ≤ X/2-X/40)
    (hB : -(C2/20)*X ≤ R) (he : -(C2/40)*X ≤ err) : 0 < T := by
  have hp := mul_le_mul_of_nonneg_left hJ (show 0 ≤ 4*C2 by positivity)
  have hpos : 0 < C2*X := mul_pos hC hX
  nlinarith

-- Skończony ważony bilans B1--Newton. Przejście do granicy pozostaje
-- w tekście LaTeX; tu formalizujemy nierówność dla dowolnych wag >= 0.
theorem weighted_reserve (s : Finset ℕ) (w r e T : ℕ → ℝ) (δ : ℝ)
    (hw : ∀ j ∈ s, 0 ≤ w j) (h : ∀ j ∈ s, δ+r j+e j ≤ T j) :
    δ*(∑ j ∈ s, w j) + (∑ j ∈ s, w j*r j) + (∑ j ∈ s, w j*e j)
      ≤ ∑ j ∈ s, w j*T j := by
  calc
    δ*(∑ j ∈ s, w j) + (∑ j ∈ s, w j*r j) + (∑ j ∈ s, w j*e j)
        = ∑ j ∈ s, w j*(δ+r j+e j) := by
          rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
          apply Finset.sum_congr rfl
          intro j _
          ring
    _ ≤ ∑ j ∈ s, w j*T j := by
          apply Finset.sum_le_sum
          intro j hj
          exact mul_le_mul_of_nonneg_left (h j hj) (hw j hj)

theorem weighted_reserve_positive (s : Finset ℕ) (w r e T : ℕ → ℝ) (δ : ℝ)
    (hw : ∀ j ∈ s, 0 ≤ w j) (h : ∀ j ∈ s, δ+r j+e j ≤ T j)
    (hB : -δ*(∑ j ∈ s, w j) < (∑ j ∈ s, w j*r j)+(∑ j ∈ s, w j*e j)) :
    0 < ∑ j ∈ s, w j*T j := by
  have hh := weighted_reserve s w r e T δ hw h
  linarith

-- 7. Konkretne dwumiany; dowody przez pierścień i obliczenie skończone.
theorem binom_6_3 : Nat.choose 6 3 = 20 := by decide

theorem binom_8_4 : Nat.choose 8 4 = 70 := by decide

theorem binom_20_10 : Nat.choose 20 10 = 184756 := by decide

theorem energy3 : (1^2+3^2+3^2+1^2 : ℕ) = Nat.choose 6 3 := by decide

theorem energy4 : (1^2+4^2+6^2+4^2+1^2 : ℕ) = Nat.choose 8 4 := by decide

theorem energy10 : (1^2+10^2+45^2+120^2+210^2+252^2+210^2+120^2+45^2+10^2+1^2 : ℕ)
    = Nat.choose 20 10 := by decide

theorem kernel3 (t : ℝ) : (1-t)^3 = 1-3*t+3*t^2-t^3 := by ring

theorem kernel4 (t : ℝ) : (1-t)^4 = 1-4*t+6*t^2-4*t^3+t^4 := by ring

theorem kernel10 (t : ℝ) : (1-t)^10 = 1-10*t+45*t^2-120*t^3+210*t^4-252*t^5+
    210*t^6-120*t^7+45*t^8-10*t^9+t^10 := by ring

def kernel (a r : ℕ) (t : ℝ) := t^a*(1-t)^r

theorem kernel_nonneg (a r : ℕ) (t : ℝ) (ht : 0 ≤ t ∧ t ≤ 1) : 0 ≤ kernel a r t := by
  unfold kernel
  exact mul_nonneg (pow_nonneg ht.1 _) (pow_nonneg (sub_nonneg.mpr ht.2) _)

theorem kernel_bound (a r : ℕ) (t u c : ℝ) (ht : 0 ≤ t ∧ t ≤ 1)
    (hc : 0 ≤ c) (hu : 0 ≤ u) (hsmall : 1-t ≤ u*c) : kernel a r t ≤ (u*c)^r := by
  have hpow : ∀ j : ℕ, t^j ≤ 1 := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      rw [pow_succ]
      calc
        t^j*t ≤ 1*t := mul_le_mul_of_nonneg_right ih ht.1
        _ ≤ 1 := by simpa using ht.2
  have hrpow : ∀ j : ℕ, (1-t)^j ≤ (u*c)^j := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      rw [pow_succ,pow_succ]
      exact mul_le_mul ih hsmall (sub_nonneg.mpr ht.2) (pow_nonneg (mul_nonneg hu hc) _)
  unfold kernel
  calc
    t^a*(1-t)^r ≤ 1*(1-t)^r := mul_le_mul_of_nonneg_right (hpow a) (pow_nonneg (sub_nonneg.mpr ht.2) _)
    _ ≤ (u*c)^r := by simpa using hrpow r

-- 8. Abstrakcyjna wersja dodatniego jądra i skończonego ogona.
-- w(k,u) >= 0 oraz w(k,u) <= c(k)*u^r wynikają z jądra Newtona.
-- hApprox jest zwykłą aproksymacją sumą częściową; nie jest hipotezą znaku.
-- hNegative JEST brakującą przesłanką analityczną.

theorem finite_prefix_lower (f w c : ℕ → ℝ) (u : ℝ) (r K j : ℕ)
    (hu : 0 ≤ u) (hw : ∀ k, 0 ≤ w k) (hc : ∀ k, 0 ≤ c k)
    (hb : ∀ k, w k ≤ c k*u^r) (hTail : ∀ k, K ≤ k → 0 ≤ f k) :
    -(∑ k ∈ Finset.range K, |f k|*c k)*u^r ≤
      ∑ k ∈ Finset.range (K+j), f k*w k := by
  have hbase : -(∑ k ∈ Finset.range K, |f k|*c k)*u^r ≤ ∑ k ∈ Finset.range K, f k*w k := by
    calc
      -(∑ k ∈ Finset.range K, |f k|*c k)*u^r =
          ∑ k ∈ Finset.range K, -(|f k|*c k)*u^r := by
            rw [← Finset.sum_mul, Finset.sum_neg_distrib]
      _ ≤ ∑ k ∈ Finset.range K, f k*w k := ?_
    apply Finset.sum_le_sum
    intro k _
    have hp : -|f k| ≤ f k := neg_abs_le _
    calc
      -(|f k|*c k)*u^r = (-|f k|)*(c k*u^r) := by ring
      _ ≤ (-|f k|)*w k := mul_le_mul_of_nonpos_left (hb k) (neg_nonpos.mpr (abs_nonneg _))
      _ ≤ f k*w k := mul_le_mul_of_nonneg_right hp (hw k)
  induction j with
  | zero => simpa using hbase
  | succ j ih =>
    rw [Nat.add_succ, Finset.sum_range_succ]
    have hn : 0 ≤ f (K+j)*w (K+j) := mul_nonneg (hTail _ (by omega)) (hw _)
    linarith

theorem negativeKernelForcesUnboundedTwins
    (R : ℕ → ℕ → Bool) (w : ℕ → ℝ → ℝ) (c : ℕ → ℝ) (B : ℝ → ℝ) (r : ℕ)
    (hc : ∀ k, 0 ≤ c k)
    (hw : ∀ k u, 0 < u → 0 ≤ w k u)
    (hb : ∀ k u, 0 < u → w k u ≤ c k*u^r)
    (hApprox : ∀ u, 0 < u → ∀ K : ℕ, ∀ ε : ℝ, 0 < ε →
       ∃ j : ℕ, |B u - ∑ k ∈ Finset.range (K+j), (ell R k : ℝ)*w k u| < ε)
    (hNegative : ∀ C : ℝ, 0 ≤ C → ∃ u : ℝ, 0 < u ∧ B u < -C*u^r) :
    UnboundedTwins := by
  intro K
  by_contra hnone
  have htail : ∀ k : ℕ, K ≤ k → 0 ≤ (ell R k : ℝ) := by
    intro k hk
    have ht : ¬ TwinCycle k := fun h => hnone ⟨k,hk,h⟩
    exact_mod_cast ell_nonneg_of_no_twin R k ht
  let C : ℝ := ∑ k ∈ Finset.range K, |(ell R k : ℝ)|*c k
  have hC : 0 ≤ C := by
    unfold C
    exact Finset.sum_nonneg (fun k _ => mul_nonneg (abs_nonneg _) (hc k))
  obtain ⟨u,hu,hneg⟩ := hNegative C hC
  let ε : ℝ := -C*u^r-B u
  have he : 0 < ε := by dsimp [ε]; linarith
  obtain ⟨j,hj⟩ := hApprox u hu K ε he
  have hbound := finite_prefix_lower (fun k => (ell R k : ℝ)) (fun k => w k u) c u r K j
    hu.le (fun k => hw k u hu) hc (fun k => hb k u hu) htail
  change -C*u^r ≤ _ at hbound
  have hleft := (abs_lt.mp hj).1
  dsimp [ε] at hleft
  linarith

-- Ujemność rzędu u² na dowolnie małych skalach wystarcza do kryterium.
theorem quadratic_signal_implies_negativeCriterion (B : ℝ → ℝ) (r : ℕ)
    (hr : 3 ≤ r)
    (h : ∃ δ : ℝ, 0 < δ ∧ ∀ ε : ℝ, 0 < ε →
       ∃ u : ℝ, 0 < u ∧ u < ε ∧ B u ≤ -δ*u^2) :
    ∀ C : ℝ, 0 ≤ C → ∃ u : ℝ, 0 < u ∧ B u < -C*u^r := by
  obtain ⟨δ,hδ,hs⟩ := h
  intro C hC
  have hp : 0 < C+1 := by linarith
  obtain ⟨u,hu,huε,hB⟩ := hs (min 1 (δ/(C+1))) (lt_min (by norm_num) (div_pos hδ hp))
  have hu1 : u ≤ 1 := le_trans huε.le (min_le_left _ _)
  have hu2 : u < δ/(C+1) := lt_of_lt_of_le huε (min_le_right _ _)
  have hCu : C*u < δ := by
    have hh := (lt_div_iff₀ hp).mp hu2
    nlinarith
  have hpow : ∀ j : ℕ, u^j ≤ 1 := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      rw [pow_succ]
      calc
        u^j*u ≤ 1*u := mul_le_mul_of_nonneg_right ih hu.le
        _ ≤ 1 := by simpa using hu1
  have hr' : r=3+(r-3) := by omega
  have hru : u^r ≤ u^3 := by
    calc
      u^r = u^(3+(r-3)) := congrArg (fun j : ℕ => u^j) hr'
      _ = u^3*u^(r-3) := by rw [pow_add]
      _ ≤ u^3*1 := mul_le_mul_of_nonneg_left (hpow _) (pow_nonneg hu.le _)
      _ = u^3 := mul_one _
  have hle := mul_le_mul_of_nonneg_left hru hC
  have hlt : C*u^3 < δ*u^2 := by
    have hh := mul_lt_mul_of_pos_right hCu (pow_pos hu 2)
    nlinarith
  refine ⟨u,hu,?_⟩
  nlinarith

-- 9. Certyfikaty liczbowe w postaci nierówności wymiernych.
-- Nie są dowodem poprawności danych z zewnętrznego generatora.
theorem certificate_arithmetic : (-20.5147209 : ℚ)+0.0192070 < -20.49 := by norm_num

theorem reserve_ratio : (1/10 : ℚ)/(1/20 : ℚ) = 2 := by norm_num

#print axioms cross_rule
#print axioms third_moment_012
#print axioms row_lower
#print axioms negative_row_forces_twin
#print axioms barrierB1
#print axioms weighted_reserve_positive
#print axioms quadratic_signal_implies_negativeCriterion
#print axioms negativeKernelForcesUnboundedTwins

end AudytRK
