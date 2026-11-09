# 04. Formularze i Walidacja w Czasie Rzeczywistym

> **Pytanie główne z listy kontrolnej («Osiem obszarów, czterdzieści pytań»):**
> *«Czy walidacja działa w czasie rzeczywistym?»*

---

## 1. Rola kategorii w architekturze strony

Formularze (rejestracja, kontakt, wyszukiwanie, proces zakupowy *Checkout*) to bezpośredni punkt konwersji. Według badań **Baymard Institute** (ponad 130 000 godzin testów użyteczności), redukcja liczby pól oraz prawidłowa walidacja inline w czasie rzeczywistym podnoszą konwersję koszyka o **+35,26%**. Wzorcowy formularz łączy strategię **„Reward Early, Punish Late”**, walidację schematów (`Standard Schema` / `Zod` / `Valibot`), progresywne ulepszanie (`Conform`) oraz pełną dostępność (`<label>`, `inputmode`, `autocomplete`, `aria-invalid`, `aria-describedby`).

---

## 2. Pięć pytań kontrolnych audytu (16–20 z 40) i kryteria inżynieryjne

### Q4.1. Walidacja w czasie rzeczywistym wg wzorca „Reward Early, Punish Late” (`Inline Validation`)
* **Pytanie:** *Czy walidacja działa w czasie rzeczywistym?*
* **Kryteria weryfikacji:**
  * **Punish Late:** Pierwsze sprawdzenie poprawności pola następuje dopiero po opuszczeniu pola (`onBlur`) lub przy próbie wysłania (`onSubmit`) — formularz nie wyświetla czerwonego błędu po wpisaniu pierwszej litery adresu e-mail.
  * **Reward Early:** Gdy pole ma już status błędnego (`aria-invalid="true"`), walidacja przełącza się w tryb natychmiastowy (`onChange` / `onInput`), usuwając komunikat błędu od razu po poprawieniu wartości.
  * Walidacja asynchroniczna (np. sprawdzanie dostępności loginu lub kodu rabatowego) stosuje `debounce` **300–500 ms** oraz `AbortController`.

### Q4.2. Stale widoczne etykiety i powiązania ARIA (`Persistent Labels & ARIA Associations`)
* **Pytanie:** *Czy każde pole posiada stale widoczną etykietę i dostępne powiązania ARIA?*
* **Kryteria weryfikacji:**
  * Każde pole (`<input>`, `<select>`, `<textarea>`) posiada jawnie powiązany znacznik `<label for="id">`. Atrybut `placeholder` **nigdy nie zastępuje** etykiety `<label>` (WCAG 2.2 SC 3.3.2).
  * W przypadku błędu pole otrzymuje `aria-invalid="true"`, a komunikat błędu i podpowiedź formatu są połączone przez `aria-describedby="hint-id error-id"` z `role="alert"` lub `aria-live="polite"`.

### Q4.3. Klawiatury mobilne, autouzupełnianie i odblokowane wklejanie (`Inputmode, Autocomplete & Paste`)
* **Pytanie:** *Czy formularz wspiera autouzupełnianie i dopasowuje klawiaturę na urządzeniach mobilnych?*
* **Kryteria weryfikacji:**
  * Prawidłowe atrybuty `type` oraz `inputmode`: dla telefonu `type="tel" inputmode="tel"`, dla e-maila `type="email" inputmode="email"`, dla kodów SMS/kart/kodów pocztowych `type="text" inputmode="numeric" pattern="[0-9]*"` (wg standardu GOV.UK zamiast problematycznego `type="number"`).
  * Zdefiniowane tokeny WHATWG `autocomplete` (`name`, `email`, `tel`, `street-address`, `cc-number`, `one-time-code`, `current-password`) zgodnie z **WCAG 2.2 SC 1.3.5**.
  * Całkowity zakaz blokowania wklejania (`onPaste`) w polach haseł i kodów (**WCAG 2.2 SC 3.3.8 Accessible Authentication**).

### Q4.4. Konstruktywne komunikaty błędów i zachowanie wpisanych danych (`Error Recovery & State Persistence`)
* **Pytanie:** *Czy komunikaty o błędach są zrozumiałe, konstruktywne i nie kasują wpisanych danych?*
* **Kryteria weryfikacji:**
  * Po wystąpieniu błędu walidacji formularz **nigdy nie czyści** wpisanych już przez użytkownika danych.
  * Komunikat wyjaśnia przyczynę i podaje przykład prawidłowego formatu (np. *„Wpisz kod pocztowy w formacie 00-950”* zamiast *„Nieprawidłowa wartość”*); spacje i myślniki w numerach telefonów/kart są normalizowane automatycznie.

### Q4.5. Minimalizacja liczby pól i ochrona przed podwójnym wysłaniem (`Field Minimization & Idempotency`)
* **Pytanie:** *Czy formularz zawiera tylko niezbędne pola i minimalizuje wysiłek użytkownika?*
* **Kryteria weryfikacji:**
  * Proces zakupowy (*Checkout*) zawiera maksymalnie **7–8 pól** (formularz kontaktowy B2B — 3–4 pola), oferuje zakupy bez rejestracji (**Guest Checkout**) oraz łączy „Imię i Nazwisko” w jedno pole.
  * Podczas wysyłania przycisk otrzymuje stan `aria-busy="true"` / `disabled`, co zapobiega wielokrotnemu wysłaniu zamówienia lub podwójnej płatności.

---

## 3. Źródła i Zweryfikowane Repozytoria Korporacyjne

| Nr | Repozytorium i link źródłowy | Właściciel / Organizacja | Opis i zastosowanie | Status w `database/04-forms-and-validation/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[standard-schema/standard-schema](https://github.com/standard-schema/standard-schema)** | **Standard Schema (Zod, Valibot, ArkType)** | Wspólna specyfikacja interfejsu schematów walidacji TypeScript/JavaScript. | Sklonowano lokalnie (`./standard-schema`) |
| 2 | **[edmundhung/conform](https://github.com/edmundhung/conform)** | **Edmund Hung (Conform)** | Wzorcowa biblioteka progresywnej walidacji formularzy oparta na natywnym `FormData`, Constraint Validation API i ARIA. | Sklonowano lokalnie (`./conform`) |
| 3 | **[colinhacks/zod](https://github.com/colinhacks/zod)** | **Colin McDonnell (Zod)** | Najpopularniejszy standard deklaratywnej walidacji i transformacji danych formularzy (klient + serwer). | Źródło referencyjne |
| 4 | **[fabian-hiller/valibot](https://github.com/fabian-hiller/valibot)** | **Fabian Hiller** | Ultralekka (`< 1 KB`), modułowa biblioteka walidacji schematów zapewniająca zerowy narzut na metrykę INP. | Źródło referencyjne |
| 5 | **[react-hook-form/react-hook-form](https://github.com/react-hook-form/react-hook-form)** | **React Hook Form** | Standard wydajnych formularzy bez zbędnych rerenderów z natywną obsługą trybu `mode: 'onTouched'`. | Źródło referencyjne |
| 6 | **[TanStack/form](https://github.com/TanStack/form)** | **TanStack** | Niezależny od frameworka silnik formularzy z wbudowanym `debounce` dla asynchronicznej walidacji w czasie rzeczywistym. | Źródło referencyjne |
| 7 | **[alphagov/govuk-frontend](https://github.com/alphagov/govuk-frontend)** | **UK Government Digital Service** | Światowy wzorzec dostępnych formularzy rządowych (`Error Summary`, `inputmode="numeric"`, brak `placeholder`). | Źródło referencyjne |
| 8 | **[uswds/uswds](https://github.com/uswds/uswds)** | **U.S. General Services Administration** | Federalne standardy formularzy i walidacji USA (`usa-form`, `usa-error-message`). | Źródło referencyjne |

---

## 4. Przewodniki inżynieryjne w tej kategorii

- [`guides/03-cro-forms-and-trust.md`](./guides/03-cro-forms-and-trust.md) — Badania Baymard Institute i NN/g, zasady budowy formularzy o wysokiej konwersji, walidacja `onBlur`, psychologia zaufania oraz zakaz stosowania *Dark Patterns* (EU DSA Art. 25, FTC Click-to-Cancel).
