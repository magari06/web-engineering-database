# Официальные спецификации W3C, WHATWG, IETF RFC и NIST (Конспект технической документации)

> [!IMPORTANT]
> **Статус документа:** Нормативный справочник технических спецификаций веб-платформы, сетевых протоколов и криптографии (редакция 2025–2026 гг.). Содержит выжимки из официальных стандартов **W3C Recommendations**, **WHATWG Living Standards**, **IETF RFC (Internet Standards)** и **NIST FIPS**, включая математические формулы, синтаксис заголовков и обязательные параметры соответствия (Conformance Requirements).

---

## Оглавление
1. [W3C WCAG 2.2 — Web Content Accessibility Guidelines](#1-w3c-wcag-22--web-content-accessibility-guidelines)
2. [W3C CSP Level 3 & Trusted Types — Безопасность клиентского кода](#2-w3c-csp-level-3--trusted-types--безопасность-клиентского-кода)
3. [W3C WebAuthn Level 3 — FIDO2 и беспарольная аутентификация (Passkeys)](#3-w3c-webauthn-level-3--fido2-и-беспарольная-аутентификация-passkeys)
4. [W3C CSS Container Queries & View Transitions — Современный Layout и переходы](#4-w3c-css-container-queries--view-transitions--современный-layout-и-переходы)
5. [WICG Speculation Rules API — Мгновенная предзагрузка и пререндеринг](#5-wicg-speculation-rules-api--мгновенная-предзагрузка-и-пререндеринг)
6. [IETF RFC 8446 (TLS 1.3), RFC 9000 (QUIC) и RFC 9114 (HTTP/3)](#6-ietf-rfc-8446-tls-13-rfc-9000-quic-и-rfc-9114-http3)
7. [IETF RFC 6797 (HSTS) и RFC 9577 (Privacy Pass / PAT)](#7-ietf-rfc-6797-hsts-и-rfc-9577-privacy-pass--pat)
8. [NIST FIPS 203 — Постквантовая криптография (ML-KEM)](#8-nist-fips-203--постквантовая-криптография-ml-kem)

---

## 1. W3C WCAG 2.2 — Web Content Accessibility Guidelines

* **Официальный статус:** W3C Recommendation (утвержден 5 октября 2023 г., стандарт ISO/IEC 40500:2025).
* **Редакторы / Рабочая группа:** Accessibility Guidelines Working Group (AG WG) — Alastair Campbell, Michael Cooper, Andrew Kirkpatrick.
* **Прямая ссылка:** [https://www.w3.org/TR/WCAG22/](https://www.w3.org/TR/WCAG22/)

### 1.1. Математическая формула контрастности (SC 1.4.3 Contrast Minimum & SC 1.4.6 Enhanced)
Коэффициент контрастности ($CR$) между текстом и фоном рассчитывается по формуле относительной яркости (Relative Luminance, $L$):

$$CR = \frac{L_1 + 0.05}{L_2 + 0.05}$$

Где:
* $L_1$ — относительная яркость более светлого цвета (от `0.0` для черного до `1.0` для белого).
* $L_2$ — относительная яркость более темного цвета.
* Относительная яркость в пространстве sRGB вычисляется как:
  $$L = 0.2126 \times R + 0.7152 \times G + 0.0722 \times B$$

| Категория элемента | Уровень AA (Норматив EAA / ADA) | Уровень AAA (Повышенный) |
| :--- | :--- | :--- |
| **Обычный текст** (`< 18pt` / `24px`, или `< 14pt` / `18.66px` bold) | **$\ge 4.5 : 1$** | **$\ge 7.0 : 1$** |
| **Крупный текст** ($\ge 18pt$ / `24px`, или $\ge 14pt$ / `18.66px` bold) | **$\ge 3.0 : 1$** | **$\ge 4.5 : 1$** |
| **Графические объекты и контуры UI-компонентов (SC 1.4.11)** | **$\ge 3.0 : 1$** | Не регламентируется отдельно |

### 1.2. Полная спецификация 9 новых критериев успеха WCAG 2.2 (и удаление 4.1.1)

> [!NOTE]
> В WCAG 2.2 критерий **4.1.1 Parsing (Синтаксический анализ)** официально **признан устаревшим и удален**, так как современный стандарт WHATWG HTML5 определяет строгие правила обработки синтаксических ошибок парсерами браузеров, а вспомогательные технологии (Screen Readers) работают напрямую с Accessibility Tree браузера, а не с сырым HTML-кодом.

| Код критерия | Название критерия | Уровень | Нормативные технические параметры спецификации |
| :--- | :--- | :--- | :--- |
| **SC 2.4.11** | **Focus Not Obscured (Minimum)** | **AA** | Когда любой элемент пользовательского интерфейса получает клавиатурный фокус (`:focus-visible`), этот элемент **не должен быть полностью перекрыт** (100% скрыт) контентом, созданным автором (липкими шапками `position: sticky/fixed`, баннерами cookie, плавающими чатами). |
| **SC 2.4.12** | **Focus Not Obscured (Enhanced)** | **AAA** | При получении фокуса **ни одна часть** элемента (даже на 1 пиксель) не должна перекрываться другим авторским контентом. |
| **SC 2.4.13** | **Focus Appearance** | **AAA** | Индикатор фокуса должен иметь: 1) площадь рамки не менее периметра компонента, умноженного на **`2 CSS px`**; 2) контрастность изменения пикселей между состоянием в фокусе и без фокуса не менее **`3:1`**. |
| **SC 2.5.7** | **Dragging Movements** | **AA** | Любая функциональность, использующая жест перетаскивания (Drag-and-Drop, слайдеры цен, сортировка карточек, карты), должна иметь альтернативу, управляемую **одиночным указателем (Single Pointer)** без удержания (например, кнопки «Вверх/Вниз», поле ввода числа или клик по точке шкалы). |
| **SC 2.5.8** | **Target Size (Minimum)** | **AA** | Размер интерактивной области (мишени клика/тапа) для указателя должен составлять не менее **`24 × 24 CSS-пикселей`**. Исключения: 1) **Spacing (Отступ):** если вокруг меньшей мишени можно описать окружность диаметром `24px`, не пересекающую другие мишени; 2) **Inline:** ссылки внутри абзаца текста; 3) браузерные контролы по умолчанию. *(Примечание: для мобильного UX Google и Apple рекомендуют 44×44 / 48×48px — соответствие SC 2.5.5 Target Size Enhanced AAA).* |
| **SC 3.2.6** | **Consistent Help** | **A** | Если на сайте присутствует механизм помощи (контакты, телефон, чат поддержки, ссылка на FAQ), он должен располагаться в **одном и том же относительном порядке в DOM** на всех страницах сайта. |
| **SC 3.3.7** | **Redundant Entry** | **A** | Информация, ранее введенная пользователем или предоставленная ему в рамках одного многошагового процесса (например, чекаут), **не должна запрашиваться повторно** (должна подставляться автоматически или выбираться в один клик, например, галочка «Адрес доставки совпадает с платежным адресом»). |
| **SC 3.3.8** | **Accessible Authentication (Minimum)** | **AA** | Вход в систему не должен требовать прохождения **когнитивного функционального теста** (запоминание пароля, решение головоломки/КАПЧИ), если не предоставлен один из механизмов: 1) беспарольный вход (**WebAuthn / Passkeys**, Magic Link, OAuth); 2) полная поддержка менеджеров паролей и **разрешение вставки из буфера обмена (`paste`)** без блокировки JS-события `onpaste`. Разрешается распознавание знакомых пользователю объектов на картинках. |
| **SC 3.3.9** | **Accessible Authentication (Enhanced)** | **AAA** | Запрещает любые когнитивные тесты при входе, включая тесты на распознавание объектов и пользовательских изображений. |

---

## 2. W3C CSP Level 3 & Trusted Types — Безопасность клиентского кода

* **Официальный статус:** W3C Working Draft / Candidate Recommendation Snapshot (активная реализация во всех движках 2025–2026).
* **Авторы:** Mike West (Google), Lukas Weichselbaum (Google), Krzysztof Kotowicz (Google).
* **Прямые ссылки:**
  * Content Security Policy Level 3: [https://www.w3.org/TR/CSP3/](https://www.w3.org/TR/CSP3/)
  * Trusted Types: [https://www.w3.org/TR/trusted-types/](https://www.w3.org/TR/trusted-types/)

### 2.1. Архитектура Strict CSP (`'strict-dynamic'`)
Устаревшие CSP на базе белых списков доменов (`script-src https://cdn.example.com`) признаны неэффективными, так как любой JSONP-эндпоинт или уязвимая библиотека на разрешенном CDN позволяет обойти защиту. Спецификация **CSP Level 3** вводит директиву `'strict-dynamic'`:
1. Каждому легитимному тегу `<script>` сервер при каждом HTTP-ответе генерирует криптографически стойкий одноразовый токен (`nonce-rAnd0m123`, минимум 128 бит энтропии в Base64).
2. Ключевое слово `'strict-dynamic'` указывает браузеру: *«Игнорируй белые списки доменов, `'unsafe-inline'` и `'self'`, но автоматически доверяй любым дочерним скриптам, которые были созданы программно через `document.createElement('script')` уже доверенным скриптом с валидным `nonce`»*.

### 2.2. Спецификация W3C Trusted Types (Защита от DOM-based XSS)
Более 50% современных XSS-уязвимостей происходят в клиентском JavaScript при передаче непроверенных строк в опасные приемники DOM (**Injection Sinks**): `Element.innerHTML`, `Element.outerHTML`, `document.write()`, `eval()`, `HTMLScriptElement.src`.
Спецификация **Trusted Types** блокирует передачу обычных строк (`DOMString`) в эти приемники на уровне движка браузера, требуя типизированных объектов (`TrustedHTML`, `TrustedScript`, `TrustedScriptURL`).

#### Нормативный HTTP-заголовок Strict CSP + Trusted Types:
```http
Content-Security-Policy:
  script-src 'nonce-9f86d081884c7d659a2feaa0c55ad015' 'strict-dynamic' 'unsafe-inline' https:;
  object-src 'none';
  base-uri 'none';
  require-trusted-types-for 'script';
  trusted-types dompurify default;
  report-to csp-endpoint;
```

#### Пример реализации политики Trusted Types в JS:
```javascript
if (window.trustedTypes && window.trustedTypes.createPolicy) {
  const sanitizerPolicy = window.trustedTypes.createPolicy('dompurify', {
    createHTML: (untrustedString) => DOMPurify.sanitize(untrustedString, { RETURN_TRUSTED_TYPE: false })
  });

  // Прямая запись строки вызовет TypeError и заблокируется браузером:
  // element.innerHTML = '<img src=x onerror=alert(1)>'; // ❌ TypeError!

  // Запись через политику TrustedHTML безопасна:
  element.innerHTML = sanitizerPolicy.createHTML(userInput); // ✅ Работает
}
```

---

## 3. W3C WebAuthn Level 3 — FIDO2 и беспарольная аутентификация (Passkeys)

* **Официальный статус:** W3C Candidate Recommendation / Working Draft (совместно с FIDO Alliance CTAP2).
* **Авторы:** Matthew Miller, Emil Lundberg (Yubico), Nina Satragno (Google), Shane Weeden (IBM).
* **Прямая ссылка:** [https://www.w3.org/TR/webauthn-3/](https://www.w3.org/TR/webauthn-3/)

### 3.1. Технический механизм работы
**Web Authentication API (WebAuthn)** использует асимметричную криптографию с открытым ключом вместо разделяемых секретов (паролей):
1. **Регистрация (`navigator.credentials.create`):** Устройство пользователя (встроенный TPM-чип, Apple Secure Enclave, Google Password Manager) генерирует пару ключей (приватный + публичный), привязанную строго к домену сайта (**Relying Party ID — `rpId`**). Приватный ключ никогда не покидает защищенное хранилище/связку ключей, а публичный ключ отправляется на сервер.
2. **Аутентификация (`navigator.credentials.get`):** Сервер отправляет случайный `challenge` (минимум 16 байт). Устройство после локальной проверки биометрии (FaceID / TouchID / Windows Hello, параметр `userVerification: "required"`) подписывает `challenge` и `rpId` приватным ключом.
3. **Защита от фишинга:** Так как браузер жестко вшивает текущий домен (`origin`) в подписываемые данные (`clientDataJSON`), фишинговый сайт на другом домене физически не может перехватить или воспроизвести аутентификацию.

### 3.2. Ключевые возможности WebAuthn Level 3 (2025–2026)
* **Conditional UI (`mediation: "conditional"`):** Позволяет отображать сохраненные Passkeys прямо в стандартном выпадающем списке автозаполнения поля логина (`<input autocomplete="username webauthn">`).
* **Signal API (`PublicKeyCredential.signalUnknownCredential` / `signalAllAcceptedCredentials`):** Позволяет серверу уведомлять менеджер ключей браузера о том, что ключ был удален на сервере, чтобы браузер не предлагал пользователю мертвые Passkeys.

---

## 4. W3C CSS Container Queries & View Transitions — Современный Layout и переходы

* **Официальный статус:** W3C CSS Containment Module Level 3 & CSS View Transitions Module Level 1/2.
* **Авторы:** Miriam Suzanne (OddBird), Tab Atkins-Bittner (Google), Jake Archibald, Khushal Sagar (Google).
* **Прямые ссылки:**
  * CSS Containment Level 3: [https://www.w3.org/TR/css-contain-3/](https://www.w3.org/TR/css-contain-3/)
  * CSS View Transitions Level 1: [https://www.w3.org/TR/css-view-transitions-1/](https://www.w3.org/TR/css-view-transitions-1/)
  * CSS View Transitions Level 2 (Cross-Document): [https://www.w3.org/TR/css-view-transitions-2/](https://www.w3.org/TR/css-view-transitions-2/)

### 4.1. CSS Container Queries (Модульная адаптивность без JS)
В отличие от `@media` (которая опирается только на ширину всего окна `viewport`), **Container Queries** позволяют компоненту (например, карточке товара) менять свою верстку в зависимости от ширины родительского блока, в который он помещен (сайдбар, сетка каталога или карусель):

```css
/* 1. Объявляем родительский блок контейнером измерения */
.product-slot {
  container-type: inline-size;
  container-name: card-container;
}

/* 2. Стилизуем карточку в зависимости от доступной ширины слота (используя единицы cqi) */
@container card-container (min-width: 420px) {
  .product-card {
    display: grid;
    grid-template-columns: 160px 1fr;
    gap: 1.5rem;
  }
  .product-card__title {
    font-size: clamp(1rem, 3.5cqi, 1.35rem);
  }
}
```

### 4.2. Cross-Document View Transitions (MPA переходы как в SPA)
Спецификация **View Transitions Level 2** позволяет классическим многостраничным сайтам (MPA) делать плавные морфинг-переходы между страницами при клике по обычной ссылке `<a href="...">` вообще без использования тяжелых SPA-роутеров:

```css
/* Включаем автоматический переход между страницами одного домена */
@view-transition {
  navigation: auto;
}

/* Привязываем миниатюру товара в каталоге к главному фото на карточке товара */
.catalog-item__img-42,
.pdp-hero__img-42 {
  view-transition-name: product-hero-42;
}
```

---

## 5. WICG Speculation Rules API — Мгновенная предзагрузка и пререндеринг

* **Официальный статус:** WICG Draft Community Group Report (стандарт мгновенной навигации в браузерах Chromium).
* **Автор:** Jeremy Roman (Google).
* **Прямая ссылка:** [https://wicg.github.io/nav-speculation/speculation-rules.html](https://wicg.github.io/nav-speculation/speculation-rules.html)

### 5.1. Замена устаревшего `<link rel="prerender">`
Декларативный JSON-синтаксис внутри `<script type="speculationrules">` позволяет браузеру предварительно скачивать (`prefetch`) или полностью рендерить в скрытой вкладке в памяти (`prerender`) страницы до клика пользователя, снижая **LCP следующей страницы до `0–50 мс`**.

### 5.2. Уровни готовности (`eagerness`) в спецификации
| Значение `eagerness` | Триггер срабатывания в браузере | Рекомендуемый сценарий применения |
| :--- | :--- | :--- |
| **`immediate`** | Сразу при парсинге скрипта на странице | Топ-1 самая вероятная следующая страница (например, шаг 2 чекаута из корзины). |
| **`eager`** | При малейшем признаке намерения (приближение курсора к ссылке) | Основные разделы навигации с высокой вероятностью перехода. |
| **`moderate`** | При наведении курсора (`hover`) в течение **`200 мс`** или начале скролла к ссылке на мобильных | Карточки товаров в каталоге и ссылки в статьях (оптимальный баланс трафика и скорости). |
| **`conservative`** | В момент нажатия кнопки мыши/пальца (`pointerdown` / `mousedown`) до отпускания (`click`) | Выигрывает `100–200 мс` форы при нулевом риске лишнего трафика. |

```html
<script type="speculationrules">
{
  "prerender": [
    {
      "where": {
        "and": [
          { "href_matches": "/catalog/*" },
          { "not": { "href_matches": "/logout" } },
          { "not": { "selector_matches": "[rel~=nofollow]" } }
        ]
      },
      "eagerness": "moderate"
    }
  ]
}
</script>
```

---

## 6. IETF RFC 8446 (TLS 1.3), RFC 9000 (QUIC) и RFC 9114 (HTTP/3)

* **Официальные статусы:** IETF Proposed Standards / Internet Standards.
* **Прямые ссылки:**
  * RFC 8446 (TLS 1.3): [https://datatracker.ietf.org/doc/html/rfc8446](https://datatracker.ietf.org/doc/html/rfc8446)
  * RFC 9000 (QUIC Transport Protocol): [https://datatracker.ietf.org/doc/html/rfc9000](https://datatracker.ietf.org/doc/html/rfc9000)
  * RFC 9114 (HTTP/3): [https://datatracker.ietf.org/doc/html/rfc9114](https://datatracker.ietf.org/doc/html/rfc9114)

### 6.1. Сравнительная таблица сетевых протоколов по спецификациям IETF

| Параметр спецификации | HTTP/1.1 + TLS 1.2 | HTTP/2 (RFC 9113) + TLS 1.3 (RFC 8446) | HTTP/3 (RFC 9114) поверх QUIC (RFC 9000) |
| :--- | :--- | :--- | :--- |
| **Транспортный уровень** | TCP | TCP | **UDP** (с надежной доставкой в пространстве пользователя) |
| **Рукопожатие (Handshake RTT)** | **3 RTT** (1 TCP + 2 TLS 1.2) | **2 RTT** (1 TCP + 1 TLS 1.3) | **1 RTT** (первое соединение) / **0-RTT** (повторное подключение) |
| **Head-of-Line (HoL) Blocking** | Блокировка на уровне HTTP и TCP | Устранена на уровне HTTP, но **сохраняется на уровне TCP** (потеря 1 пакета тормозит все потоки) | **Полностью устранена** (независимые потоки QUIC: потеря пакета влияет только на один ресурс) |
| **Сжатие заголовков** | Нет | **HPACK** (RFC 7541) | **QPACK** (RFC 9204 — внеочередная доставка заголовков) |
| **Connection Migration** | Нет (смена IP рвет соединение) | Нет | **Да (Connection ID)** — бесшовный переход со смартфона с Wi-Fi на 4G/5G без разрыва загрузки |

### 6.2. Нормативная конфигурация TLS 1.3 (RFC 8446)
* Полный отказ от уязвимых алгоритмов RSA key transport, CBC-режимов, SHA-1 и статического Diffie-Hellman.
* Обязательная поддержка **Perfect Forward Secrecy (PFS)** через эфемерные ключи (`ECDHE` на кривых `X25519` / `secp256r1`).
* Обязательные шифронаборы AEAD: `TLS_AES_128_GCM_SHA256`, `TLS_AES_256_GCM_SHA384`, `TLS_CHACHA20_POLY1305_SHA256`.
* Объявление поддержки HTTP/3 через заголовок `Alt-Svc: h3=":443"; ma=86400` и DNS-запись типа `HTTPS` (RFC 9460).

---

## 7. IETF RFC 6797 (HSTS) и RFC 9577 (Privacy Pass / PAT)

* **Прямые ссылки:**
  * RFC 6797 (HTTP Strict Transport Security): [https://datatracker.ietf.org/doc/html/rfc6797](https://datatracker.ietf.org/doc/html/rfc6797)
  * RFC 9576 / RFC 9577 / RFC 9578 (Privacy Pass Architecture & Issuance Protocol): [https://datatracker.ietf.org/doc/html/rfc9577](https://datatracker.ietf.org/doc/html/rfc9577)

### 7.1. Нормативы HSTS Preload (RFC 6797)
Чтобы исключить уязвимость первого HTTP-запроса к перехвату (SSL Stripping) и избавиться от задержки `301 Redirect` с `http://` на `https://`, сайт должен отдавать заголовок HSTS, соответствующий требованиям списка `hstspreload.org`:
```http
Strict-Transport-Security: max-age=63072000; includeSubDomains; preload
```
* `max-age`: минимум `31536000` секунд (1 год), рекомендуется `63072000` (2 года).
* `includeSubDomains`: обязательное применение ко всем поддоменам.
* `preload`: согласие на жесткое вшивание домена в исходный код браузеров Chrome, Firefox, Safari и Edge.

### 7.2. Архитектура Privacy Pass / Private Access Tokens (RFC 9577)
Стандарт **Privacy Pass** (реализованный Apple в iOS/macOS, Google в Android/Chrome, Cloudflare и Fastly как **Private Access Tokens — PAT**) заменяет визуальные КАПЧИ криптографическими токенами со слепой подписью (**Blind RSA Signatures / VOPRF**):
1. Сервер при подозрении на бота возвращает статус `401 Unauthorized` с заголовком `WWW-Authenticate: PrivateToken challenge="...", token-key="..."`.
2. Операционная система клиента обращается к доверенному **Attester** (например, серверу Apple iCloud или Google Play Integrity), который подтверждает, что устройство настоящее и не взломано, и получает слепо подписанный токен от **Issuer**.
3. Браузер мгновенно повторяет запрос с заголовком `Authorization: PrivateToken token="..."`.
4. **Результат:** Сервер на 100% уверен, что запрос идет от реального устройства человека, **но криптографически не может связать токен с личностью или Apple ID/Google-аккаунтом пользователя**, а пользователь не видит никаких КАПЧ.

---

## 8. NIST FIPS 203 — Постквантовая криптография (ML-KEM)

* **Официальный статус:** Federal Information Processing Standard (FIPS 203), утвержден Национальным институтом стандартов и технологий США (NIST) 13 августа 2024 г.
* **Полное название:** *Module-Lattice-Based Key-Encapsulation Mechanism Standard (ML-KEM)* (ранее известный как **CRYSTALS-Kyber**).
* **Прямая ссылка:** [https://csrc.nist.gov/pubs/fips/203/final](https://csrc.nist.gov/pubs/fips/203/final)

### 8.1. Защита от угрозы «Harvest Now, Decrypt Later» (HNDL)
Классические асимметричные алгоритмы обмена ключами (`RSA`, `ECDH`, `X25519`) уязвимы перед алгоритмом Шора на квантовых компьютерах. Злоумышленники могут записывать зашифрованный трафик сегодня, чтобы расшифровать его после появления криптоаналитически значимого квантового компьютера (CRQC).

### 8.2. Гибридный обмен ключами `X25519MLKEM768` в TLS 1.3
С 2024–2026 годов браузеры (Chrome 131+, Edge, Firefox) и веб-серверы (Cloudflare, Nginx с OpenSSL 3.5+ / BoringSSL) по умолчанию используют в TLS 1.3 гибридную схему согласования ключей **`X25519MLKEM768`** (IETF Draft `draft-kwiatkowski-tls-ecdhe-mlkem`):
* Объединяет проверенный классический эллиптический алгоритм **`X25519`** и постквантовый алгоритм на базе модульных решеток **`ML-KEM-768`** (NIST Security Category 3, эквивалент стойкости AES-192).
* Увеличивает размер пакета `ClientHello` / `ServerHello` всего на ~1.1 КБ, поэтому критически требует правильной настройки **TCP Initial Congestion Window (`initcwnd >= 10`)** и поддержки **QUIC / HTTP/3**, чтобы гибридный сертификат и ключи укладывались в первый раунд передачи без фрагментации.
