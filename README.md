# B1 Twin-Prime Research / Badania liczb pierwszych bliźniaczych B1

## English

Research materials by Adam Berger on the signed B1 remainder, the Cross Rule, Chebyshev window control and localization with Newton weights. The collection includes finite identities and experiments, a conditional reduction, audit logs, source code and original illustrations. **These files do not prove the twin-prime conjecture.** The missing step is an asymptotic one-sided bound for the signed B1 remainder that makes the weighted balance positive on infinitely many scales.

**Reading order.** Start with [Cross Rule, Newton and Chebyshev (Polish PDF)](Berger_RK_Newton_Czybyszew_v1_PL.pdf), §1–2 for the last-digit matrix and square-divisibility reserve, and §3 onward for B1 and localization. The [B1 sign audit](Audyt_B1_znak_PL.pdf) explains the remaining sign condition. The [report on stages 191–209](Berger_Regula_Krzyza_B1_etapy191_209_PL.pdf) and its [release archive](https://github.com/ber34/dowod-blizniak-B1/releases/tag/audyt-b1) contain earlier work, code and data. The [stage-211 log](audyt_wynik.txt) reports 133 factorization samples, 22 direct model checks at the first scale and a rerun. The study treated 29,738,803 candidate pairs in 2,309 windows. The Lean file is a source artifact, not a machine-checked proof of the open statement.

**The prime 5.** The matrix counts cells: 9/4 total, 8/4 without the intersection. For candidate pairs 6m ± 1 with both arms larger than the prime q ≥ 5, a single sieve excludes two classes per period, or 2/q. Thus 5 alone removes 40%, versus about 28.57% for 7 and 18.18% for 11; overlaps matter when primes are combined. The 75% / 20% / 5% split in image 13 is a different measure: the valuation of n + 2 for prime n at a fixed modulus. None of these proportions gives the asymptotic sign.

## Polski

Materiały badawcze Adama Bergera o podpisanej reszcie B1, Regule Krzyża, kontroli okien metodą Czybyszewa i lokalizacji wagami Newtona. Obejmują tożsamości i doświadczenia skończone, redukcję warunkową, logi audytu, kod oraz oryginalne ilustracje. **Nie jest to dowód hipotezy liczb pierwszych bliźniaczych.** Brakuje jednostronnego oszacowania asymptotycznego podpisanej reszty B1, które dałoby dodatni ważony bilans na nieskończenie wielu skalach.

**Od czego zacząć.** [Reguła Krzyża, Newton i Czybyszew (PDF)](Berger_RK_Newton_Czybyszew_v1_PL.pdf), §1–2, pokazuje macierz końcówek i rezerwę wynikającą z podzielności przez kwadraty; od §3 omawia B1 i lokalizację. [Audyt znaku B1](Audyt_B1_znak_PL.pdf) objaśnia brakujący warunek. [Raport etapów 191–209](Berger_Regula_Krzyza_B1_etapy191_209_PL.pdf) i [paczka wydania](https://github.com/ber34/dowod-blizniak-B1/releases/tag/audyt-b1) zawierają wcześniejsze wyniki, kod i dane. [Log etapu 211](audyt_wynik.txt) podaje faktoryzację 133 próbek, 22 kontrole modelu na pierwszej skali i powtórkę. Badanie objęło 29 738 803 pary kandydackie w 2309 oknach. Plik Lean jest źródłem, nie maszynowym dowodem otwartego twierdzenia.

**Eliminator 5.** Macierz liczy pola: 9/4 ogółem, 8/4 po odłożeniu przecięcia. Dla par 6m ± 1 z ramionami większymi od pierwszego eliminatora q ≥ 5 odpadają dwie klasy na okres, czyli 2/q. Sama piątka skreśla 40%, siódemka około 28,57%, a jedenastka około 18,18%. Przy łączeniu eliminatorów trzeba uwzględnić wspólne trafienia. Podział 75% / 20% / 5% ze zrzutu 13 dotyczy innej miary: wartościowania n + 2 przy pierwszym n i ustalonym module. Żadna z tych proporcji nie rozstrzyga znaku asymptotycznego.

## Original gallery / Galeria oryginalnych zrzutów

All 18 original PNG files in capture order. The English caption comes first. / Wszystkie 18 oryginalnych zrzutów w kolejności wykonania. Każdy podpis zaczyna się po angielsku.


### 01. Cross Rule: nine fives / Reguła Krzyża: dziewięć piątek

![01. Cross Rule: nine fives](Screenshot%202026-11-27%20at%2009-58-31%20Kontynuacja%20analizy%20PPP.png)

**EN.** Rows are q modulo 10; columns are 3q, 5q, 7q, 9q and 11q. The marked row and column intersect once, so 5 + 5 − 1 = 9. The frequency bars for 1, 3, 5, 7 and 9 are 4, 4, 9, 4, 4. The ratio 9/4 counts cells, not distinct sieve eliminations.

**PL.** Wiersze to q modulo 10, a kolumny 3q, 5q, 7q, 9q i 11q. Zaznaczony wiersz i kolumna mają jedno wspólne pole: 5 + 5 − 1 = 9. Słupki dla 1, 3, 5, 7 i 9 pokazują 4, 4, 9, 4, 4. Stosunek 9/4 dotyczy pól, nie unikalnych skreśleń.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2009-58-31%20Kontynuacja%20analizy%20PPP.png)

### 02. Profile on the scale log₁₀ k / Profil na skali log₁₀ k

![02. Profile on the scale log₁₀ k](Screenshot%202026-11-27%20at%2010-01-53%20Kontynuacja%20analizy%20PPP.png)

**EN.** The shaded strip marks the rise from log₁₀ k = 7 to 8, i.e. k from 10⁷ to 10⁸. The curve peaks around the displayed height 1 beyond the strip. Neither the ordinate nor the formula is identified, so this is a schematic, not a B1 estimate.

**PL.** Pas na rosnącym odcinku obejmuje log₁₀ k od 7 do 8, czyli k od 10⁷ do 10⁸. Dalej krzywa osiąga około 1. Bez etykiety osi pionowej i wzoru to schemat, nie oszacowanie B1.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-01-53%20Kontynuacja%20analizy%20PPP.png)

### 03. Frequency profile near π / Profil częstotliwości wokół π

![03. Frequency profile near π](Screenshot%202026-11-27%20at%2010-02-24%20Kontynuacja%20analizy%20PPP.png)

**EN.** The axis runs from 0 to 2π. The displayed profile peaks near θ = π at height 1 and is small away from the peak. No transform is specified; this illustrates localization, not a proof of cancellation.

**PL.** Oś biegnie od 0 do 2π. Profil osiąga 1 przy θ = π, a poza maksimum jest bliski zera. Nie wskazano konkretnej transformaty: rysunek ilustruje skupienie, nie dowodzi kasowania.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-02-24%20Kontynuacja%20analizy%20PPP.png)

### 04. Scaling from F_L(s) to F_L(2s) / Przeskalowanie F_L(s) do F_L(2s)

![04. Scaling from F_L(s) to F_L(2s)](Screenshot%202026-11-27%20at%2010-02-39%20Kontynuacja%20analizy%20PPP.png)

**EN.** The upper k scale marks 1/2 and 1; the lower quadratic Q scale marks 1/4 and 1/2. The substitution halves the marked coordinates. It does not establish the position of zeros or analytical continuation.

**PL.** Górna oś k zaznacza 1/2 i 1, dolna skala kwadratowa Q — 1/4 i 1/2. Podstawienie dzieli współrzędne przez dwa. Nie ustala położenia zer ani przedłużenia analitycznego.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-02-39%20Kontynuacja%20analizy%20PPP.png)

### 05. Three profiles in v = u log k / Trzy profile w v = u log k

![05. Three profiles in v = u log k](Screenshot%202026-11-27%20at%2010-03-00%20Kontynuacja%20analizy%20PPP.png)

**EN.** The blue curve is greatest at the left endpoint, the green peaks early, and the orange peaks farther right. This illustrates changing where a weight concentrates; there are no formulas or normalization labels.

**PL.** Niebieska krzywa ma maksimum na początku, zielona wcześnie wewnątrz zakresu, a pomarańczowa dalej na prawo. Rysunek pokazuje zmianę miejsca koncentracji wagi, lecz nie podaje wzorów ani normalizacji.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-03-00%20Kontynuacja%20analizy%20PPP.png)

### 06. Newton orders: total through 10⁸ and contribution above 10⁷ / Rzędy Newtona: wynik do 10⁸ i wkład powyżej 10⁷

![06. Newton orders: total through 10⁸ and contribution above 10⁷](Screenshot%202026-11-27%20at%2010-03-50%20Kontynuacja%20analizy%20PPP.png)

**EN.** Both series are negative in all rows from 6/3 to 40/20. The most negative entries in the two columns are at 12/6 and 24/12, respectively. Here 8/4 names a polynomial order, not the Cross Rule ratio. The units are not specified.

**PL.** Obie serie są ujemne dla wszystkich rzędów od 6/3 do 40/20. Najbardziej ujemne wpisy wypadają przy 12/6 oraz 24/12. Tu 8/4 jest oznaczeniem rzędu, nie proporcją z krzyża. Nie podano jednostki.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-03-50%20Kontynuacja%20analizy%20PPP.png)

### 07. Modeled operator mass / Modelowa masa operatora

![07. Modeled operator mass](Screenshot%202026-11-27%20at%2010-04-14%20Kontynuacja%20analizy%20PPP.png)

**EN.** The bars separate early scales, the investigated block and the uncomputed tail for r = 10 to 5120. The displayed share of the investigated block rises from 13.3770% to 99.9996%. This is about model weights, not a bound on signed arithmetic contributions.

**PL.** Słupki rozdzielają skale początkowe, badany blok i nieobliczony ogon dla r od 10 do 5120. Pokazany udział badanego bloku wzrasta z 13,3770% do 99,9996%. To udział wag modelu, nie oszacowanie podpisanego wkładu arytmetycznego.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-04-14%20Kontynuacja%20analizy%20PPP.png)

### 08. B1 budget: threshold −C₂X/40 / Budżet B1: próg −C₂X/40

![08. B1 budget: threshold −C₂X/40](Screenshot%202026-11-27%20at%2010-05-21%20Kontynuacja%20analizy%20PPP.png)

**EN.** The starting reserve is approximately 0.06601618X. The hypothetical lower bound permits a loss of 0.01650405X, leaving about 0.04951214X. This illustrates the proposed criterion, not proof of its premise.

**PL.** Z początkowej rezerwy około 0,06601618X hipotetyczny warunek dopuszcza stratę 0,01650405X i zostawia około 0,04951214X. Jest to ilustracja kryterium, nie dowód jego przesłanki.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-05-21%20Kontynuacja%20analizy%20PPP.png)

### 09. B1 budget: threshold −C₂X/30 / Budżet B1: próg −C₂X/30

![09. B1 budget: threshold −C₂X/30](Screenshot%202026-11-27%20at%2010-05-30%20Kontynuacja%20analizy%20PPP.png)

**EN.** The permitted loss is approximately 0.02200539X, leaving about 0.04401079X. The green bar is a conditional remaining balance, not a measured bound on R(X).

**PL.** Dopuszczalna strata to około 0,02200539X, a pozostała rezerwa około 0,04401079X. Zielony słupek to bilans po przyjęciu warunku, nie zmierzone ograniczenie R(X).

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-05-30%20Kontynuacja%20analizy%20PPP.png)

### 10. B1 budget: threshold −C₂X/20 / Budżet B1: próg −C₂X/20

![10. B1 budget: threshold −C₂X/20](Screenshot%202026-11-27%20at%2010-05-49%20Kontynuacja%20analizy%20PPP.png)

**EN.** The permitted loss and remaining reserve are each approximately 0.03300809X. Like the /30 and /40 panels, this describes a sufficient condition only if the bound holds with the asymptotic scope required by the reduction.

**PL.** Dopuszczalna strata i pozostały zapas wynoszą po około 0,03300809X. Jak w panelach /30 i /40, to kryterium wystarczające tylko pod warunkiem dowodu oszacowania we właściwym zakresie asymptotycznym.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-05-49%20Kontynuacja%20analizy%20PPP.png)

### 11. Second capture of the Cross Rule / Drugi zrzut Reguły Krzyża

![11. Second capture of the Cross Rule](Screenshot%202026-11-27%20at%2010-06-02%20Kontynuacja%20analizy%20PPP.png)

**EN.** A separate original file with the same table and frequency bars as image 01. It is not a second experiment. Image 14 marks the intersection separately.

**PL.** Osobny plik z tą samą tabelą i słupkami co zrzut 01. Nie jest to drugi eksperyment. Rys. 14 wyróżnia przecięcie.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-06-02%20Kontynuacja%20analizy%20PPP.png)

### 12. Cross Rule with d factors / Reguła Krzyża dla d czynników

![12. Cross Rule with d factors](Screenshot%202026-11-27%20at%2010-06-23%20Kontynuacja%20analizy%20PPP.png)

**EN.** K₅(d) = 5ᵈ − 4ᵈ counts ordered tuples of odd endings with at least one 5. For a fixed other odd ending, K_c(d) = 4ᵈ⁻¹. At d = 10 the counts are 8,717,049 versus 262,144, a ratio of about 33.2529. These are arrangements of residue classes, not distinct eliminated numbers.

**PL.** K₅(d) = 5ᵈ − 4ᵈ liczy uporządkowane układy nieparzystych końcówek z co najmniej jedną 5. Dla innej ustalonej końcówki K_c(d) = 4ᵈ⁻¹. Dla d = 10 wartości wynoszą 8 717 049 wobec 262 144, czyli około 33,2529. To układy klas reszt, nie unikalne skreślenia.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-06-23%20Kontynuacja%20analizy%20PPP.png)

### 13. The 75%, 20%, 5% split for 5 / Podział 75%, 20%, 5% dla piątki

![13. The 75%, 20%, 5% split for 5](Screenshot%202026-11-27%20at%2010-06-38%20Kontynuacja%20analizy%20PPP.png)

**EN.** For n prime and the shifted integer n + 2, the fixed-modulus model distinguishes v₅(n + 2) = 0, 1, and ≥ 2. Exactly one factor 5 negates μ of the cofactor (zero stays zero); divisibility by 25 forces μ(n + 2) = 0. The proportions do not establish a signed sum.

**PL.** Dla n pierwszej i liczby n + 2 model o ustalonym module rozróżnia v₅(n + 2) = 0, 1 oraz ≥ 2. Dokładnie jeden czynnik 5 daje znak minus względem μ ilorazu (zero pozostaje zerem), a podzielność przez 25 wymusza μ(n + 2) = 0. Z proporcji nie wynika znak całej sumy.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-06-38%20Kontynuacja%20analizy%20PPP.png)

### 14. Eight cells, one intersection: 9 = 8 + 1 / Osiem pól, jedno przecięcie: 9 = 8 + 1

![14. Eight cells, one intersection: 9 = 8 + 1](Screenshot%202026-11-27%20at%2010-06-48%20Kontynuacja%20analizy%20PPP.png)

**EN.** Eight green cells have exactly one factor divisible by 5. The amber 5 × 5 = 25 is the only cell where both factors are divisible by 5. Counting all nine gives 9/4; setting aside the intersection gives 8/4. This is not deduplication of products.

**PL.** Osiem zielonych pól ma dokładnie jeden czynnik podzielny przez 5. Bursztynowe 5 × 5 = 25 to jedyne pole z oboma czynnikami podzielnymi przez 5. Licząc wszystkie pola mamy 9/4, a po odłożeniu przecięcia 8/4. To nie deduplikacja wyników mnożenia.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-06-48%20Kontynuacja%20analizy%20PPP.png)

### 15. Signed contributions by eliminator / Podpisane wkłady według eliminatora

![15. Signed contributions by eliminator](Screenshot%202026-11-27%20at%2010-07-06%20Kontynuacja%20analizy%20PPP.png)

**EN.** For primes 5, 7, 11, 13, 17, 19, 23 and 29 the chart gives +0.139, +0.090, −0.024, −0.115, +0.123, +0.090, −0.089 and −0.107 percent, respectively. The sample range is not shown; these are not removal rates or asymptotic estimates.

**PL.** Dla 5, 7, 11, 13, 17, 19, 23 i 29 wykres podaje odpowiednio +0,139, +0,090, −0,024, −0,115, +0,123, +0,090, −0,089 i −0,107 procent. Brakuje opisu zakresu próby. Nie są to odsetki skreśleń ani oszacowania asymptotyczne.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-07-06%20Kontynuacja%20analizy%20PPP.png)

### 16. Local Newton kernel and signed J₅ / Lokalne jądro Newtona i podpisany J₅

![16. Local Newton kernel and signed J₅](Screenshot%202026-11-27%20at%2010-07-40%20Kontynuacja%20analizy%20PPP.png)

**EN.** Pᵣ(t) = 4ʳtʳ(1 − t)ʳ reaches 1 at t = 1/2 and suppresses the endpoints for r > 0. Across six scales the displayed signed J₅ percentages are negative at 10⁷ and 10¹¹, positive at 10⁸, 10⁹ and 10¹⁰, and mixed at 10¹² (40/20 gives −0.036%). This is not the reserve-adjusted diagnostic in image 17.

**PL.** Pᵣ(t) = 4ʳtʳ(1 − t)ʳ ma maksimum 1 w t = 1/2 i dla r > 0 tłumi brzegi. Podpisany J₅ w procentach: wszystkie kolumny ujemne przy 10⁷ i 10¹¹, dodatnie przy 10⁸, 10⁹ i 10¹⁰; przy 10¹² wyniki są mieszane (40/20 daje −0,036%). To nie diagnostyka po dodaniu rezerwy z rys. 17.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-07-40%20Kontynuacja%20analizy%20PPP.png)

### 17. Stage 211: lower orders versus order 5120 / Etap 211: niskie rzędy wobec rzędu 5120

![17. Stage 211: lower orders versus order 5120](Screenshot%202026-11-27%20at%2010-08-07%20Kontynuacja%20analizy%20PPP.png)

**EN.** The reserve-adjusted diagnostic is positive at all six displayed scales for orders 6/3, 8/4, and 20/10. Order 5120 reaches −0.009546 at 10¹². The audit log identifies this as the only K_E + R exception among 30 tested combinations; it is not the separate finite lower bound.

**PL.** Diagnostyczny bilans z rezerwą jest dodatni na sześciu skalach dla 6/3, 8/4 i 20/10. Rząd 5120 daje −0,009546 przy 10¹². Log wskazuje to jako jedyny wyjątek dla K_E + R w 30 kombinacjach; nie chodzi o osobną dolną granicę skończoną.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-08-07%20Kontynuacja%20analizy%20PPP.png)

### 18. Audit and the open analytic target / Podsumowanie audytu i otwarty cel analityczny

![18. Audit and the open analytic target](Screenshot%202026-11-27%20at%2010-08-30%20Kontynuacja%20analizy%20PPP.png)

**EN.** The checklist includes the matrix, mod-25 counting, deduplication, Chebyshev control, Newton normalization, the B1 identity, 133 factorization samples, the rerun, and the stage-209 tail certificate. The asymptotic B1 sign is explicitly open. The displayed weighted limsup for u ↓ 0 is the common analytic target, not a conclusion of the finite checks.

**PL.** Lista obejmuje macierz, modulo 25, deduplikację, ograniczenie Czybyszewa, normalizację Newtona, tożsamość B1, faktoryzację 133 próbek, powtórzenie programu i certyfikat ogona etapu 209. Asymptotyczny znak B1 pozostaje otwarty. Pokazany ważony limsup dla u ↓ 0 jest celem, nie wnioskiem z testów skończonych.

[Original PNG / Oryginalny PNG](Screenshot%202026-11-27%20at%2010-08-30%20Kontynuacja%20analizy%20PPP.png)

## File guide / Przewodnik po plikach

Original file names are retained; the English names are guides only. Byte-identical copies retain their separate source names. / Zachowano nazwy źródłowe; angielskie nazwy służą orientacji. Kopie o identycznych bajtach zachowują osobne nazwy.

| Original filename / Oryginalna nazwa | English guide / Nazwa angielska (orientacyjnie) |
| --- | --- |
| [`analiza.py`](analiza.py) | `analysis.py` |
| [`Audyt_B1_znak_pakiet.zip`](Audyt_B1_znak_pakiet.zip) | `B1_Sign_Audit_Package.zip` |
| [`Audyt_B1_znak_PL.pdf`](Audyt_B1_znak_PL.pdf) | `B1_Sign_Audit_PL.pdf` |
| [`audyt_danych_wynik.txt`](audyt_danych_wynik.txt) | `data_audit_results.txt` |
| [`audyt_wynik-0.txt`](audyt_wynik-0.txt) | `audit_results-0.txt` |
| [`audyt_wynik.txt`](audyt_wynik.txt) | `audit_results.txt` |
| [`AudytRK.lean`](AudytRK.lean) | `CrossRuleAudit.lean` |
| [`Berger_Regula_Krzyza_B1_etapy191_209_PL.pdf`](Berger_Regula_Krzyza_B1_etapy191_209_PL.pdf) | `Berger_Cross_Rule_B1_Stages_191_209_PL.pdf` |
| [`Berger_Regula_Krzyza_B1_etapy191_209_PL.tex`](Berger_Regula_Krzyza_B1_etapy191_209_PL.tex) | `Berger_Cross_Rule_B1_Stages_191_209_PL.tex` |
| [`Berger_RK_Newton_Czybyszew_v1_pakiet (2).zip`](Berger_RK_Newton_Czybyszew_v1_pakiet%20%282%29.zip) | `Berger_Cross_Rule_Newton_Chebyshev_v1_Package (2).zip` |
| [`Berger_RK_Newton_Czybyszew_v1_pakiet.zip`](Berger_RK_Newton_Czybyszew_v1_pakiet.zip) | `Berger_Cross_Rule_Newton_Chebyshev_v1_Package.zip` |
| [`Berger_RK_Newton_Czybyszew_v1_PL (2).pdf`](Berger_RK_Newton_Czybyszew_v1_PL%20%282%29.pdf) | `Berger_Cross_Rule_Newton_Chebyshev_v1_PL (2).pdf` |
| [`Berger_RK_Newton_Czybyszew_v1_PL (2).tex`](Berger_RK_Newton_Czybyszew_v1_PL%20%282%29.tex) | `Berger_Cross_Rule_Newton_Chebyshev_v1_PL (2).tex` |
| [`Berger_RK_Newton_Czybyszew_v1_PL.pdf`](Berger_RK_Newton_Czybyszew_v1_PL.pdf) | `Berger_Cross_Rule_Newton_Chebyshev_v1_PL.pdf` |
| [`Berger_RK_Newton_Czybyszew_v1_PL.tex`](Berger_RK_Newton_Czybyszew_v1_PL.tex) | `Berger_Cross_Rule_Newton_Chebyshev_v1_PL.tex` |
| [`bilans211 (2).csv`](bilans211%20%282%29.csv) | `stage211_balance (2).csv` |
| [`bilans211.csv`](bilans211.csv) | `stage211_balance.csv` |
| [`certyfikat.py`](certyfikat.py) | `certificate.py` |
| [`lokalizacja.py`](lokalizacja.py) | `localization.py` |
| [`test (2).cpp`](test%20%282%29.cpp) | `test (2).cpp` |
| [`test.cpp`](test.cpp) | `test.cpp` |
| [`Berger_Regula_Krzyza_B1_Audyt_191_209_pakiet.zip`](https://github.com/ber34/dowod-blizniak-B1/releases/download/audyt-b1/Berger_Regula_Krzyza_B1_Audyt_191_209_pakiet.zip) | `Berger_Cross_Rule_B1_Audit_Stages_191_209_Package.zip` |
