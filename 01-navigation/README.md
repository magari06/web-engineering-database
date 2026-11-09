# 01. Nawigacja / Навигация и информационная архитектура

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy z każdej podstrony wrócisz na stronę główną?»* — **Можно ли с каждой подстраницы вернуться на главную страницу?**

---

## 1. Обзор категории и инженерная роль

Навигация и информационная архитектура (Information Architecture, IA) определяют способность пользователя и поискового/ИИ-агента ориентироваться в пространстве сайта, понимать свое текущее местоположение (`Wayfinding`), перемещаться между разделами без когнитивной перегрузки и выходить из тупиковых состояний (`404`, пустая выдача).

---

## 2. Пять контрольных вопросов аудита (5/40) и технические метрики

### Q1.1. Возврат на главную и глобальная точка опоры (`Home & Global Anchor`)
* **Вопрос (PL / RU):** *Czy z każdej podstrony wrócisz na stronę główną?* / Можно ли с любой вложенной подстраницы, страницы ошибки и шага воронки в один клик вернуться на главную страницу, а также пропустить сквозные блоки с клавиатуры?
* **Инженерные критерии проверки:**
  * В `<header>` присутствует кликабельный логотип `<a href="/">` с доступным именем (`aria-label="[Бренд] — Главная страница"` или информативный `alt` у `<img>`/`<svg>`).
  * Первым фокусируемым элементом в DOM (`body > a.skip-link:first-child`) идет ссылка **Skip to main content** (`href="#main-content"`), видимая при `:focus-visible`.

### Q1.2. Индикация текущего местоположения и «хлебные крошки» (`Wayfinding, Active State & Breadcrumbs`)
* **Вопрос (PL / RU):** *Czy użytkownik zawsze wie, gdzie aktualnie się znajduje w strukturze serwisu?* / Понимает ли пользователь свое текущее положение в иерархии сайта визуально, программно (для скринридеров) и на уровне структуры URL?
* **Инженерные критерии проверки:**
  * Активный пункт главного и бокового меню содержит атрибут `aria-current="page"` и визуально выделен не только цветом (линия, жирность шрифта, фон).
  * Для страниц уровня вложенности $\ge 2$ выводится навигационная цепочка `<nav aria-label="Breadcrumb"><ol>...</ol></nav>` с `aria-current="page"` на текущем элементе и микроразметкой `Schema.org/BreadcrumbList` (JSON-LD).

### Q1.3. Предсказуемость, таксономия и глубина навигации (`Information Architecture & Shallow Depth`)
* **Вопрос (PL / RU):** *Czy główne menu jest spójne, zrozumiałe i pozwala dotrzeć do kluczowych treści w maksymalnie 3 kliknięciach?* / Является ли глобальная навигация консистентной на всех страницах, свободной от перегруза (Закон Миллера / Закон Хика) и достигается ли целевой контент за $\le 3$ клика?
* **Инженерные критерии проверки:**
  * Верхний уровень главной навигации `<nav aria-label="Primary">` содержит **от 4 до 7 пунктов** (максимум 8 включая кнопку CTA).
  * Выпадающие мега-меню открываются по клику или с безопасной задержкой hover ($\ge 150\text{ мс}$ + safe polygon траектории курсора), закрываются по `Escape` и управляются клавишами `ArrowDown`/`ArrowUp`/`Tab`.

### Q1.4. Эргономика мобильной навигации и тач-зон (`Mobile Drawer, Bottom Bar & Touch Ergonomics`)
* **Вопрос (PL / RU):** *Czy nawigacja mobilna jest łatwo dostępna pod kciukiem i poprawnie zarządza fokusem?* / Удобна ли мобильная навигация для управления одной рукой (thumb zone) и соблюдены ли правила удержания фокуса в открытом меню?
* **Инженерные критерии проверки:**
  * Все интерактивные элементы навигации имеют размер зоны нажатия **$\ge 44 \times 44\text{ CSS px}$** (Apple HIG / WCAG 2.5.5) и минимум **$24 \times 24\text{ CSS px}$** (WCAG 2.2 AA 2.5.8).
  * Кнопка мобильного меню (`<button aria-expanded="false|true" aria-controls="mobile-drawer">`) переключает состояние, удерживает фокус внутри открытого drawer (`FocusTrap` / атрибут `inert` на основном контенте) и блокирует фоновый скролл.

### Q1.5. Внутренний поиск, палитра команд и обработка тупиков (`Search, Command Menu & Dead-End Recovery`)
* **Вопрос (PL / RU):** *Czy serwis oferuje szybką wyszukiwarkę oraz pomocne wyjście ze stron błędów (404 / brak wyników)?* / Предусмотрен ли быстрый поиск (или палитра команд `Cmd+K`) и помогают ли страницы пустой выдачи / 404 продолжить путь без потери пользователя?
* **Инженерные критерии проверки:**
  * Поисковая форма обернута в семантический тег `<search>` или `<form role="search">`, поддерживает автодополнение (`role="combobox"`, `aria-autocomplete="list"`) и быстрый вызов по `/` или `Cmd+K` (`Ctrl+K`).
  * Страница `404 Not Found` и экран «Ничего не найдено» содержат строку поиска, ссылки на ключевые разделы и кнопку возврата на главную.

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/01-navigation/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[w3c/aria-practices](https://github.com/w3c/aria-practices)** | **W3C (WAI-ARIA WG)** | Официальный **ARIA Authoring Practices Guide (APG)**: эталонные паттерны `Breadcrumb`, `Navigation Menubar`, `Disclosure Navigation`, `Tabs`, `Treeview` и `Landmarks`. | Локальный клон (`./w3c-aria-practices`) |
| 2 | **[pacocoursey/cmdk](https://github.com/pacocoursey/cmdk)** | **Paco Coursey / Vercel Ecosystem** | Индустриальный стандарт быстрой клавиатурной навигации и палитры команд (`⌘K`), используемый в Vercel, Linear и Shadcn UI. | Локальный клон (`./cmdk`) |
| 3 | **[uswds/uswds](https://github.com/uswds/uswds)** | **U.S. General Services Administration** | **U.S. Web Design System**: федеральный стандарт государственной навигации США (`usa-header`, `usa-nav`, `usa-breadcrumb`, `usa-in-page-navigation`, `usa-skipnav`). | Внешний эталон |
| 4 | **[alphagov/govuk-frontend](https://github.com/alphagov/govuk-frontend)** | **UK Government Digital Service** | **GOV.UK Frontend**: британский государственный эталон доступной навигации (`govuk-breadcrumbs`, `govuk-service-navigation`, `govuk-pagination`). | Внешний эталон |
| 5 | **[TanStack/router](https://github.com/TanStack/router)** | **TanStack** | Типобезопасная маршрутизация с URL Search Params как базой состояния, предзагрузкой по `intent` и восстановлением позиции скролла. | Внешний эталон |
| 6 | **[radix-ui/primitives](https://github.com/radix-ui/primitives)** | **WorkOS / Radix UI** | Headless-компоненты `NavigationMenu` и `DropdownMenu` с roving `tabindex` и защитой траектории курсора (safe polygon). | Внешний эталон |
| 7 | **[adobe/react-spectrum](https://github.com/adobe/react-spectrum)** | **Adobe** | Корпоративная библиотека хуков `React Aria` (`useMenu`, `useBreadcrumbs`, `useTabList`, `useLandmark`) с полной поддержкой скринридеров. | Внешний эталон |
| 8 | **[carbon-design-system/carbon](https://github.com/carbon-design-system/carbon)** | **IBM** | Эталон проектирования корпоративного каркаса `UI Shell` (Global Header, Side Nav, Switcher) по стандарту IBM Accessibility. | Внешний эталон |

---

## 4. Эталонная HTML/ARIA-разметка навигационного каркаса

```html
<!-- 1. Skip Link (первый элемент в <body>) -->
<a href="#main-content" class="skip-link">Перейти к основному содержимому</a>

<!-- 2. Global Header с возвратом на главную и основным меню -->
<header role="banner" class="site-header">
  <a href="/" class="brand-logo" aria-label="Название Компании — На главную">
    <img src="/logo.svg" alt="" width="140" height="36" />
  </a>

  <nav aria-label="Основная навигация">
    <ul class="nav-list">
      <li><a href="/catalog" aria-current="page">Каталог</a></li>
      <li><a href="/solutions">Решения</a></li>
      <li><a href="/pricing">Тарифы</a></li>
      <li><a href="/docs">Документация</a></li>
      <li><a href="/contact">Контакты</a></li>
    </ul>
  </nav>

  <search role="search" aria-label="Поиск по сайту">
    <button type="button" aria-keyshortcuts="Control+K Meta+K">
      Поиск <kbd>⌘K</kbd>
    </button>
  </search>
</header>

<!-- 3. Breadcrumbs (на всех вложенных страницах >= 2 уровня) -->
<nav aria-label="Хлебные крошки" class="breadcrumbs">
  <ol itemscope itemtype="https://schema.org/BreadcrumbList">
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="/"><span itemprop="name">Главная</span></a>
      <meta itemprop="position" content="1" />
    </li>
    <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a itemprop="item" href="/catalog" aria-current="page"><span itemprop="name">Каталог</span></a>
      <meta itemprop="position" content="2" />
    </li>
  </ol>
</nav>
```
