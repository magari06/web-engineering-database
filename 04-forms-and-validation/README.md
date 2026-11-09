# 04. Formularze / Формы, инпуты и валидация в реальном времени

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy walidacja działa w czasie rzeczywistym?»* — **Работает ли валидация в реальном времени?**

---

## 1. Обзор категории и инженерная роль

Формы (регистрация, лид-формы, поиск, чекаут) — главная точка конверсии любого сайта. Согласно исследованиям **Baymard Institute** (130 000+ часов юзабилити-тестов), оптимизация количества полей и правильная валидация в реальном времени повышают конверсию чекаута на **+35.26%**. На инженерном уровне эталонная форма сочетает паттерн **«Reward Early, Punish Late»**, строгую схемную валидацию (`Standard Schema` / `Zod` / `Valibot`), прогрессивное улучшение (`Conform`) и безупречную семантику доступности (`<label>`, `inputmode`, `autocomplete`, `aria-invalid`, `aria-describedby`).

---

## 2. Пять контрольных вопросов аудита (20/40) и технические метрики

### Q4.1. Валидация в реальном времени по принципу «Reward Early, Punish Late» (`Inline Real-Time Validation`)
* **Вопрос (PL / RU):** *Czy walidacja działa w czasie rzeczywistym?* / Работает ли валидация в реальном времени без преждевременного наказания пользователя во время набора текста?
* **Инженерные критерии проверки:**
  * **Punish Late:** Первичная проверка поля срабатывает только при потере фокуса (`onBlur`) или отправке формы (`onSubmit`), не показывая красную ошибку на первой введенной букве.
  * **Reward Early:** Как только поле помечено невалидным (`aria-invalid="true"`), повторная проверка переключается в режим реального времени (`onChange` / `onInput`), мгновенно снимая ошибку после исправления опечатки.
  * Асинхронная проверка (уникальность email/логина, промокод) использует `debounce` **300–500 мс** и `AbortController`.

### Q4.2. Постоянные видимые метки и программная связь ошибок (`Persistent Labels & ARIA Associations`)
* **Вопрос (PL / RU):** *Czy każde pole posiada stale widoczną etykietę i dostępne powiązania ARIA?* / Имеет ли каждое поле постоянный видимый `<label>` и программную привязку подсказок и ошибок?
* **Инженерные критерии проверки:**
  * Каждое поле (`<input>`, `<select>`, `<textarea>`) явно связано с `<label for="id">`. Атрибут `placeholder` **никогда не заменяет** `<label>` (WCAG 2.2 SC 3.3.2).
  * При ошибке полю выставляется `aria-invalid="true"`, а описание ошибки и подсказка привязываются через `aria-describedby="hint-id error-id"` с `role="alert"` или `aria-live="polite"`.

### Q4.3. Мобильные клавиатуры, автозаполнение и разблокированная вставка (`Inputmode, Autocomplete & Paste`)
* **Вопрос (PL / RU):** *Czy formularz wspiera autouzupełnianie i dopasowuje klawiaturę na urządzeniach mobilnych?* / Вызывают ли поля правильную мобильную клавиатуру и работают ли автозаполнение и менеджеры паролей?
* **Инженерные критерии проверки:**
  * Настроены точные атрибуты `type` и `inputmode`: для телефонов `type="tel" inputmode="tel"`, для email `type="email" inputmode="email"`, для цифровых кодов/карт/индексов `type="text" inputmode="numeric" pattern="[0-9]*"` (по стандарту GOV.UK вместо проблемного `type="number"`).
  * Проставлены токены WHATWG `autocomplete` (`name`, `email`, `tel`, `street-address`, `cc-number`, `one-time-code`, `current-password`) по **WCAG 2.2 SC 1.3.5**.
  * Строго запрещена блокировка `onPaste` в полях паролей и кодов (**WCAG 2.2 SC 3.3.8 Accessible Authentication**).

### Q4.4. Конструктивные сообщения об ошибках и сохранность данных (`Error Recovery & State Persistence`)
* **Вопрос (PL / RU):** *Czy komunikaty o błędach są zrozumiałe, konstruktywne i nie kasują wpisanych danych?* / Помогают ли сообщения об ошибках быстро исправить ввод без сброса уже заполненных полей?
* **Инженерные критерии проверки:**
  * При ошибке валидации форма **никогда не очищает** введенные пользователем данные.
  * Текст ошибки объясняет причину и дает пример правильного формата (*«Укажите телефон в формате +7 999 123-45-67»* вместо *«Неверное значение»*); применён толерантный парсинг (автоматическая очистка пробелов и дефисов через `zod.transform()`).
  * При сабмите с ошибками фокус автоматически переводится на первое проблемное поле (`shouldFocusError: true`) или блок сводки ошибок (`Error Summary`).

### Q4.5. Минимизация полей и защита от двойной отправки (`Field Minimization & Idempotent Submit`)
* **Вопрос (PL / RU):** *Czy formularz zawiera tylko niezbędne pola i minimalizuje wysiłek użytkownika?* / Сведено ли число полей к минимуму и защищена ли форма от случайной повторной отправки?
* **Инженерные критерии проверки:**
  * Чекаут содержит не более **7–8 полей** (лид-форма B2B — 3–4 поля), доступен **Guest Checkout** без принудительной регистрации, «Имя и Фамилия» объединены в одно поле `Full Name`.
  * Во время отправки кнопка переводится в состояние `aria-busy="true"` / `disabled` со спиннером, исключая дублирование заказов и списаний.

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/04-forms-and-validation/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[standard-schema/standard-schema](https://github.com/standard-schema/standard-schema)** | **Standard Schema (Zod, Valibot, ArkType)** | Единая спецификация интерфейса схем валидации TypeScript/JavaScript для совместимости всех библиотек форм и валидаторов. | Локальный клон (`./standard-schema`) |
| 2 | **[edmundhung/conform](https://github.com/edmundhung/conform)** | **Edmund Hung (Conform)** | Эталон прогрессивно улучшаемых веб-форм на базе нативного `FormData`, Constraint Validation API и автоматической ARIA-разметки. | Локальный клон (`./conform`) |
| 3 | **[colinhacks/zod](https://github.com/colinhacks/zod)** | **Colin McDonnell (Zod)** | Главный индустриальный стандарт декларативной валидации и трансформации данных форм на клиенте и сервере. | Внешний эталон |
| 4 | **[fabian-hiller/valibot](https://github.com/fabian-hiller/valibot)** | **Fabian Hiller** | Сверхлегковесная (`< 1 КБ`) модульная библиотека схемной валидации для мгновенной real-time проверки без нагрузки на INP. | Внешний эталон |
| 5 | **[react-hook-form/react-hook-form](https://github.com/react-hook-form/react-hook-form)** | **React Hook Form** | Стандарт производительных форм без лишних ререндеров с нативной поддержкой паттерна `mode: 'onTouched'` (`Reward Early, Punish Late`). | Внешний эталон |
| 6 | **[TanStack/form](https://github.com/TanStack/form)** | **TanStack** | Фреймворк-агностичный движок форм с встроенным `debounce` для асинхронной real-time валидации и поддержкой Standard Schema. | Внешний эталон |
| 7 | **[alphagov/govuk-frontend](https://github.com/alphagov/govuk-frontend)** | **UK Government Digital Service** | Мировой эталон доступных государственных форм (`Error Summary`, `inputmode="numeric"`, отказ от `placeholder`). | Внешний эталон |
| 8 | **[uswds/uswds](https://github.com/uswds/uswds)** | **U.S. General Services Administration** | Стандарты проектирования форм и валидации правительственных сервисов США (`usa-form`, `usa-error-message`). | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/03-cro-forms-and-trust.md`](./guides/03-cro-forms-and-trust.md) — Исследования Baymard Institute и NN/g, правила верстки идеальных форм, валидация `onBlur`, психология доверия и запрет Dark Patterns (EU DSA Art. 25, FTC Click-to-Cancel).
