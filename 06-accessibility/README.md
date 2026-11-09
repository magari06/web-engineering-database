# 06. Dostępność / Цифровая доступность, клавиатурная навигация и WCAG 2.2

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy po stronie da się poruszać samą klawiaturą?»* — **Можно ли перемещаться по сайту исключительно с помощью клавиатуры?**

---

## 1. Обзор категории и инженерная роль

Со вступлением в силу **Европейского акта о доступности (European Accessibility Act — EAA 2025, стандарт EN 301 549)** соответствие критериям **W3C WCAG 2.2 Level AA** стало обязательным юридическим и инженерным требованием. Доступный сайт на 100% управляется с одной клавиатуры (`Tab`, `Shift+Tab`, `Enter`, `Space`, `Escape`, стрелки), никогда не скрывает и не перекрывает фокус (`Focus Not Obscured`), имеет достаточную площадь нажатия ($\ge 24\times24\text{ px}$) и корректно озвучивает изменения состояния скринридерам (`NVDA`, `VoiceOver`, `JAWS`).

---

## 2. Пять контрольных вопросов аудита (30/40) и технические метрики

### Q6.1. Полная клавиатурная управляемость и отсутствие ловушек фокуса (`100% Keyboard Operability & Zero Traps`)
* **Вопрос (PL / RU):** *Czy po stronie da się poruszać samą klawiaturą?* / Доступны ли 100% функций сайта исключительно с клавиатуры в логическом порядке и без «ловушек фокуса»?
* **Инженерные критерии проверки:**
  * Все интерактивные элементы сверстаны нативными `<button>`, `<a href>`, `<input>` и достижимы по `Tab` / `Shift+Tab` в порядке визуального чтения (запрет `tabindex > 0`).
  * В модальных окнах (`<dialog>`) фокус удерживается внутри цикла (`focus-trap`), окно закрывается по `Escape`, а фокус возвращается на кнопку-триггер (WCAG 2.1.1, 2.1.2, 2.4.3).

### Q6.2. Видимый и неперекрытый индикатор фокуса (`Focus Visible & Focus Not Obscured`)
* **Вопрос (PL / RU):** *Czy aktualnie sfokusowany element jest zawsze wyraźnie widoczny i nie jest zasłaniany przez pływające nagłówki lub banery?* / Всегда ли элемент в фокусе четко выделен визуально и не перекрывается ли он липкими шапками или баннерами?
* **Инженерные критерии проверки:**
  * Строгий запрет `outline: none` без высококонтрастной замены `:focus-visible` (`outline: 2px solid`, `outline-offset: 2px`, контраст контура $\ge 3:1$ по WCAG 2.4.7 / 2.4.13).
  * Выполнение критерия **WCAG 2.2 SC 2.4.11 (`Focus Not Obscured`)**: сфокусированный элемент не уходит под `position: fixed/sticky` шапки или cookie-баннеры (настроен `scroll-padding-top`).

### Q6.3. Семантика для скринридеров и живые оповещения (`Screen Reader Semantics & ARIA Live Regions`)
* **Вопрос (PL / RU):** *Czy strona posiada poprawną strukturę semantyczną, etykiety kontrolek oraz komunikaty `aria-live` dla czytników ekranu?* / Обладает ли страница корректными доступными именами контролов, осмысленными `alt` и живыми оповещениями `aria-live`?
* **Инженерные критерии проверки:**
  * Указан `<html lang="...">`; все иконочные кнопки снабжены `aria-label`; информативные изображения имеют точный `alt`, декоративные — `alt=""` или `aria-hidden="true"`.
  * Динамические уведомления (добавление в корзину, результаты фильтрации, тосты) озвучиваются через `aria-live="polite"` (`role="status"`) или `aria-live="assertive"` (`role="alert"`) по **WCAG 4.1.3**.

### Q6.4. Размер мишеней нажатия и альтернатива перетаскиванию (`Target Size >= 24px & No Dragging Dependency`)
* **Вопрос (PL / RU):** *Czy wszystkie przyciski i elementy interaktywne mają odpowiedni rozmiar obszaru kliknięcia i nie wymagają skomplikowanych gestów?* / Имеют ли все интерактивные элементы достаточную площадь клика и дублируются ли жесты перетаскивания простыми кликами?
* **Инженерные критерии проверки:**
  * Выполнение **WCAG 2.2 SC 2.5.8 (`Target Size Minimum`)**: размер мишени минимум **$24 \times 24\text{ CSS px}$** (рекомендуемый эталон тач-зон — **$44 \times 44\text{ CSS px}$**).
  * Выполнение **WCAG 2.2 SC 2.5.7 (`Dragging Movements`)**: любые ползунки цен, карусели и drag-and-drop списки имеют альтернативное управление кнопками или полями ввода.

### Q6.5. Безопасность анимаций, масштабирование и мультимедиа (`Reduced Motion, Zoom 400% & Captions`)
* **Вопрос (PL / RU):** *Czy interfejs zachowuje czytelny kontrast, działa przy powiększeniu 200–400% i respektuje systemowe wyłączenie animacji?* / Работает ли сайт при масштабировании до 400%, учитывает ли системное отключение анимаций и снабжены ли видео субтитрами?
* **Инженерные критерии проверки:**
  * При `@media (prefers-reduced-motion: reduce)` отключаются параллаксы, автопрокрутка и резкие переходы (WCAG 2.3.3).
  * Все видеоролики со звуком имеют синхронные субтитры `<track kind="captions">`, а фоновые видео — кнопку паузы (WCAG 1.2.2, 2.2.2).

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/06-accessibility/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[dequelabs/axe-core](https://github.com/dequelabs/axe-core)** | **Deque Systems** | Главный мировой движок автоматизированного тестирования доступности WCAG 2.0/2.1/2.2 (используется внутри Google Lighthouse и Microsoft Accessibility Insights). | Локальный клон (`./axe-core`) |
| 2 | **[a11yproject/a11yproject.com](https://github.com/a11yproject/a11yproject.com)** | **The A11Y Project** | Практическая база знаний и структурированный чек-лист ручного и автоматического аудита доступности по стандарту WCAG. | Локальный клон (`./a11yproject`) |
| 3 | **[w3c/aria-practices](https://github.com/w3c/aria-practices)** | **W3C WAI** | Официальное руководство **WAI-ARIA Authoring Practices Guide (APG)** с таблицами клавиш и кодом 30+ доступных виджетов. | Локальный клон в `01-navigation/w3c-aria-practices` |
| 4 | **[w3c/wcag](https://github.com/w3c/wcag)** | **W3C AGWG** | Официальный нормативный репозиторий спецификации **WCAG 2.2**, *Understanding WCAG* и каталога техник (*Techniques*). | Внешний эталон |
| 5 | **[adobe/react-spectrum](https://github.com/adobe/react-spectrum)** | **Adobe Inc.** | Корпоративная библиотека `React Aria` с эталонным управлением фокусом (`FocusScope`), скринридерами и клавиатурной навигацией. | Внешний эталон |
| 6 | **[IBMa/equal-access](https://github.com/IBMa/equal-access)** | **IBM Accessibility** | Корпоративный инструментарий и база правил IBM Equal Access Accessibility Checker для комплаенса по WCAG 2.2. | Внешний эталон |
| 7 | **[focus-trap/focus-trap](https://github.com/focus-trap/focus-trap)** | **Focus Trap Org** | Стандартная библиотека удержания и возврата клавиатурного фокуса в модальных окнах и боковых меню. | Внешний эталон |
| 8 | **[pa11y/pa11y](https://github.com/pa11y/pa11y)** | **Pa11y Organization** | CLI-инструмент автоматизированного сканирования доступности страниц в CI/CD пайплайнах (`axe-core` + `HTML_CodeSniffer`). | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/02-accessibility-wcag-2.2.md`](./guides/02-accessibility-wcag-2.2.md) — Полное руководство по требованиям **WCAG 2.2 Level AA** и **European Accessibility Act (EAA 2025)**, статистика WebAIM Million, нативные `<dialog>` и `popover`, контрастность APCA ($L_c$) и автотесты `@axe-core/playwright`.
