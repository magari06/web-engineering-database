# 03. Treść i czytelność / Контент, типографика и читаемость

> **Базовый вопрос чек-листа («Osiem obszarów, czterdzieści pytań»):**
> *«Czy rozmiar i kontrast tekstu ułatwiają czytanie?»* — **Облегчают ли размер и контраст текста чтение?**

---

## 1. Обзор категории и инженерная роль

Читаемость (Readability) и разборчивость (Legibility) определяют, насколько быстро и без зрительного утомления пользователь усваивает информацию. На инженерном уровне это обеспечивается флюидной типографикой (`clamp()`), перцептивным контрастом (WCAG 2.2 AA и **W3C APCA / WCAG 3** в пространстве `OKLCH`), выверенной длиной строки (`50–75ch`), алгоритмической чистотой DOM-текста (`Mozilla Readability`) и редакционной дисциплиной (`BLUF`, Plain Language).

---

## 2. Пять контрольных вопросов аудита (15/40) и технические метрики

### Q3.1. Базовый кегль и флюидная шкала (`Fluid Typography & Text Resize`)
* **Вопрос (PL / RU):** *Czy rozmiar tekstu głównego jest wystarczająco duży i responsywny?* / Обеспечивают ли базовый кегль и флюидная шкала комфортное чтение на любом экране без необходимости зума?
* **Инженерные критерии проверки:**
  * Базовый кегль основного текста (`body`, `<p>`, `<li>`) составляет **$\ge 16\text{ px}$ (`1rem`)**, вспомогательных подписей — строго **$\ge 12\text{ px}$ (`0.75rem`)**, оптимально `14px`.
  * Все размеры шрифтов заданы в относительных единицах (`rem` + `clamp(min, val + vw, max)`), выдерживая **WCAG 2.2 SC 1.4.4 (Resize Text 200%)** без обрезания текста (`overflow: hidden`).

### Q3.2. Цветовой и перцептивный контраст во всех темах (`WCAG 2.2 & APCA Perceptual Contrast`)
* **Вопрос (PL / RU):** *Czy kontrast tekstu względem tła ułatwia czytanie w każdych warunkach oświetleniowych?* / Достаточен ли цветовой и перцептивный контраст текста относительно фона в светлой и темной темах?
* **Инженерные критерии проверки:**
  * **WCAG 2.2 AA (SC 1.4.3):** обычный текст ($< 24\text{ px}$) имеет контраст **$\ge 4.5:1$** (уровень AAA — $\ge 7:1$); крупный текст ($\ge 24\text{ px}$ или $\ge 18.66\text{ px bold}$) — **$\ge 3.0:1$**.
  * **W3C APCA (WCAG 3 / `Myndex/apca-w3`):** основной наборный текст имеет перцептивный светлотный контраст **$|L_c| \ge 75$** (минимум $|L_c| \ge 60$ для контентных блоков), крупные заголовки — **$|L_c| \ge 45$**.
  * В **Dark Mode** исключен гало-эффект (halation) чисто белого `#FFFFFF` на черном `#000000` — используется мягкий светлый текст (`#E2E8F0` / `oklch(0.92 0.01 250)`) на темно-сланцевом фоне (`#0F172A`).

### Q3.3. Длина строки, интерлиньяж и вертикальный ритм (`Measure, Leading & Vertical Rhythm`)
* **Вопрос (PL / RU):** *Czy szerokość kolumny tekstu, interlinia i odstępy wspierają płynne czytanie?* / Оптимизированы ли длина строки, межстрочный интервал и отступы между абзацами?
* **Инженерные критерии проверки:**
  * Длина строки основного текста ограничена диапазоном **`50ch–75ch`** (эталон `max-width: 65ch` по `@tailwindcss/typography` и WCAG 1.4.8).
  * Межстрочный интервал (`line-height`): **`1.5–1.65`** для основного текста и **`1.1–1.25`** для крупных заголовков (`text-wrap: balance` для заголовков, `text-wrap: pretty` для абзацев, запрет `text-align: justify`).
  * Выполняется **WCAG 2.2 SC 1.4.12 (Text Spacing)**: верстка не ломается при пользовательском переопределении `line-height: 1.5`, `letter-spacing: 0.12em`, `word-spacing: 0.16em`.

### Q3.4. Сканируемость и модульная подача (`Scannability, BLUF & Chunking`)
* **Вопрос (PL / RU):** *Czy struktura tekstu (nagłówki, wypunktowania, wyróżnienia) pozwala na szybkie skanowanie strony?* / Структурирован ли контент для быстрого сканирования взглядом (Layer-Cake / F-Pattern)?
* **Инженерные критерии проверки:**
  * Применяется принцип **BLUF (Bottom Line Up Front)**: ключевой вывод вынесен в лид-абзац (`TL;DR`) и информативные подзаголовки `H2`/`H3` каждые 200–350 слов.
  * Абзацы содержат не более 3–5 предложений; однородные перечисления из 3+ элементов оформлены маркированными списками `<ul>`/`<ol>` или семантическими таблицами `<table>`.

### Q3.5. Чистота языка и понятный микрокопирайтинг (`Plain Language & Actionable Microcopy`)
* **Вопрос (PL / RU):** *Czy język komunikatów jest prosty, zrozumiały i wolny od żargonu?* / Написан ли контент и интерфейсный микрокопирайтинг простым языком без канцелярита и двусмысленности?
* **Инженерные критерии проверки:**
  * Средняя длина предложения — **15–20 слов**, доля страдательного залога $< 10\%$ (проверяется линтером `Vale` по правилам Google / Microsoft Style Guide).
  * Все интерактивные элементы (кнопки, ссылки) называют конкретное действие и результат (*«Скачать презентацию PDF (2.4 МБ)»* вместо *«Нажмите здесь»* или *«Подробнее»*).

---

## 3. Верифицированные репозитории и базы данных корпораций

| № | Репозиторий | Владелец / Организация | Описание и ценность | Статус в `database/03-content-and-readability/` |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **[Myndex/apca-w3](https://github.com/Myndex/apca-w3)** | **W3C AGWG / Myndex** | Официальная имплементация алгоритма **APCA (Accessible Perceptual Contrast Algorithm)** для WCAG 3 с таблицами контраста для шрифтов. | Локальный клон (`./apca-w3`) |
| 2 | **[mailchimp/content-style-guide](https://github.com/mailchimp/content-style-guide)** | **Mailchimp (Intuit)** | Открытая база правил корпоративного UX-райтинга, Plain Language, Voice & Tone и микрокопирайтинга интерфейсов в Markdown. | Локальный клон (`./mailchimp-style-guide`) |
| 3 | **[mozilla/readability](https://github.com/mozilla/readability)** | **Mozilla Corporation** | Официальный движок **Firefox Reader View** для оценки чистоты текстовой разметки и извлечения основного контента страницы. | Локальный клон (`./mozilla-readability`) |
| 4 | **[color-js/color.js](https://github.com/color-js/color.js)** | **W3C CSS WG Editors (Lea Verou & Chris Lilley)** | Научно-инженерная библиотека работы с цветом (`OKLCH`, `Display-P3`) и расчета контраста (`WCAG21`, `APCA`, `Michelson`). | Внешний эталон |
| 5 | **[adobe/leonardo](https://github.com/adobe/leonardo)** | **Adobe Inc.** | Корпоративный генератор адаптивных цветовых палитр на основе целевых коэффициентов контрастности WCAG 2.2 и APCA. | Внешний эталон |
| 6 | **[tailwindlabs/tailwindcss-typography](https://github.com/tailwindlabs/tailwindcss-typography)** | **Tailwind Labs** | Индустриальный эталон пропорций веб-типографики (`.prose`, `max-width: 65ch`, вертикальный ритм заголовков, списков и таблиц). | Внешний эталон |
| 7 | **[vale-cli/packages](https://github.com/vale-cli/packages)** | **Vale CLI / Errata AI** | Официальные машиночитаемые пакеты правил проверки текста по стандартам **Google** и **Microsoft Developer Style Guide**. | Внешний эталон |
| 8 | **[fontsource/fontsource](https://github.com/fontsource/fontsource)** | **Fontsource** | База self-hosted веб-шрифтов (`WOFF2`, Variable Fonts) для быстрой загрузки без внешних запросов к Google Fonts. | Внешний эталон |

---

## 4. Локальные руководства в этой категории

- [`guides/02-content-eeat-and-clusters.md`](./guides/02-content-eeat-and-clusters.md) — Инженерный подход к E-E-A-T, патент Google Information Gain, анатомия страницы по принципу BLUF и топик-кластеры.
