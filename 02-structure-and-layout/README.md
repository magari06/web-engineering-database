# 02. Struktura i układ / Структура, семантика и сетка макета

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy nagłówki tworzą hierarchię H1, H2, H3?»* — **Образуют ли заголовки строгую иерархию H1, H2, H3?**

---

## 1. Обзор категории и инженерная роль

Структура документа и модульная сетка определяют как машинную читаемость страницы (для поисковых роботов, скринридеров и LLM-парсеров через семантический DOM и оглавление `H1–H6`), так и визуальную стабильность и адаптивность интерфейса (`CSS Grid`, `@container` Container Queries, нулевой сдвиг макета `CLS <= 0.1`).

---

## 2. Пять контрольных вопросов аудита (10/40) и технические метрики

### Q2.1. Строгая иерархия заголовков (`Document Outline & Heading Hierarchy H1–H6`)
* **Вопрос (PL / RU):** *Czy nagłówki tworzą hierarchię H1, H2, H3?* / Образуют ли заголовки страницы строгую логическую иерархию `H1 -> H2 -> H3` без пропусков уровней и выбора тегов ради визуального размера?
* **Инженерные критерии проверки:**
  * Ровно **один тег `<h1>` на страницу**, отражающий главную тему документа и согласованный с `<title>`.
  * Отсутствуют скачки уровней вниз (запрещен переход `<h2>` $\rightarrow$ `<h4>` без промежуточного `<h3>`); размер текста управляется CSS-токенами, а уровень тега — исключительно смысловой структурой.

### Q2.2. Семантические ориентиры страницы (`HTML5 Landmark Regions & DOM Semantics`)
* **Вопрос (PL / RU):** *Czy struktura strony wykorzystuje semantyczne znaczniki HTML5 (`<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>`)?* / Разделена ли страница на семантические регионы (landmarks), позволяющие скринридерам и парсерам мгновенно ориентироваться в документе?
* **Инженерные критерии проверки:**
  * Весь видимый контент размещен внутри семантических ориентиров: `<header>`, `<nav>`, единственного видимого `<main id="main-content">`, `<aside>` и `<footer>`.
  * Однотипные регионы (например, несколько `<nav>` или `<section>`) снабжены уникальными `aria-label` или `aria-labelledby`.

### Q2.3. Визуальная иерархия, модульная сетка и воздух (`Visual Hierarchy, Grid Alignment & Whitespace`)
* **Вопрос (PL / RU):** *Czy układ strony ma czytelną hierarchię wizualną, konsekwentną siatkę (Grid) i odpowiednie odstępy (whitespace)?* / Подчиняется ли макет модульной сетке, правилу внутреннего и внешнего (закон близости Гештальта) и легко ли сканируется взглядом?
* **Инженерные критерии проверки:**
  * Раскладка построена на `CSS Grid` / `Flexbox` с единой шкалой дизайн-токенов отступов (шаг `4px`/`8px` или флюидная шкала `clamp()`).
  * Строго соблюдается **правило внутреннего и внешнего**: внутренние отступы (`padding` и `gap` внутри карточки) всегда меньше внешних отступов между секциями ($d_{\text{internal}} < d_{\text{external}}$).

### Q2.4. Адаптивность, Container Queries и защита от горизонтального скролла (`Intrinsic Responsiveness & Reflow`)
* **Вопрос (PL / RU):** *Czy układ płynnie dopasowuje się do każdej rozdzielczości ekranu (od 320px do 4K) oraz powiększenia 200–400% bez poziomego przewijania?* / Адаптируется ли макет без поломок и горизонтальной прокрутки на любых ширинах экрана (от `320px` до 4K) и при зуме браузера до 400%?
* **Инженерные критерии проверки:**
  * На ширинах от `320 CSS px` до `2560+ CSS px` (и при 400% масштабировании по **WCAG 1.4.10 Reflow**) отсутствует горизонтальный overflow (`document.documentElement.scrollWidth <= document.documentElement.clientWidth`).
  * Компоненты используют `@container` (`container-type: inline-size`) и intrinsic-сетки `grid-template-columns: repeat(auto-fit, minmax(min(100%, 280px), 1fr))`.

### Q2.5. Визуальная стабильность макета при загрузке (`Layout Stability & Zero CLS`)
* **Вопрос (PL / RU):** *Czy elementy strony nie przesuwają się samoistnie podczas ładowania (brak skoków układu / CLS)?* / Защищен ли макет от самопроизвольных скачков контента во время загрузки изображений, шрифтов, баннеров и динамических виджетов?
* **Инженерные критерии проверки:**
  * Показатель **CLS (Cumulative Layout Shift) $\le 0.1$** (целевой эталон $\le 0.02$).
  * Все `<img>`, `<video>`, `<iframe>` и рекламные/динамические контейнеры имеют явно заданные `width`/`height` или CSS `aspect-ratio`, а веб-шрифты настроены с `size-adjust` и `ascent-override`.

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/02-structure-and-layout/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[thedaviddias/Front-End-Checklist](https://github.com/thedaviddias/Front-End-Checklist)** | **David Dias & Community (70k+ ★)** | Главный мировой инженерный чек-лист проверки HTML5-семантики, структуры `<head>`/`<body>`, иерархии заголовков и CSS-архитектуры. | Локальный клон (`./front-end-checklist`) |
| 2 | **[argyleink/open-props](https://github.com/argyleink/open-props)** | **Adam Argyle (Google Chrome CSS Lead)** | Система атомарных CSS Custom Properties: выверенные шкалы модульной сетки, адаптивных отступов, пропорций (`aspect-ratio`) и контейнеров. | Локальный клон (`./open-props`) |
| 3 | **[trys/utopia-core](https://github.com/trys/utopia-core)** | **Utopia (Trys Mudford & James Gilyead)** | Математическое ядро для расчета флюидных (резиновых) шкал отступов, сеток и типографики через `clamp()`. | Локальный клон (`./utopia-core`) |
| 4 | **[h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate)** | **H5BP Organization (56k+ ★)** | Классический эталон структуры HTML5-документа, мета-тегов и кроссбраузерного каркаса страницы. | Внешний эталон |
| 5 | **[validator/validator](https://github.com/validator/validator)** | **W3C / Nu Html Checker** | Официальный валидатор W3C (`validator.w3.org`) для проверки соответствия DOM спецификации WHATWG HTML Living Standard и Outline заголовков. | Внешний эталон |
| 6 | **[html-validate/html-validate](https://github.com/html-validate/html-validate)** | **HTML-Validate** | Статический анализатор HTML-шаблонов с правилом `heading-level` (запрет пропуска уровней `h1 -> h3`) и проверкой ARIA-landmarks. | Внешний эталон |
| 7 | **[5t3ph/smolcss](https://github.com/5t3ph/smolcss)** | **Stephanie Eckles (W3C CSS WG)** | Справочник минималистичных паттернов современной раскладки на CSS Grid, Flexbox и `@container` queries. | Внешний эталон |
| 8 | **[GoogleChrome/web-vitals](https://github.com/GoogleChrome/web-vitals)** | **Google Chrome Team** | Официальная библиотека Google для измерения `CLS` (Cumulative Layout Shift) и поиска DOM-элементов, вызывающих сдвиги макета. | В категории `05-functionality-and-performance` |

---

## 4. Локальные руководства в этой категории

- [`guides/01-ux-laws-and-modern-ui.md`](./guides/01-ux-laws-and-modern-ui.md) — Когнитивные законы UX (Фиттса, Хика, Якоба, Миллера), Intrinsic Web Design (`@container`), Bento Grid и флюидные сетки.
