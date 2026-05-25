# PlanPilot Local Roadmap

## 24. Theme 확장 정책

현재 상태:

- `AppSettings.theme`의 허용 값은 `"light"` 하나뿐이다.
- `SettingsView`는 theme 값을 읽기 전용으로 표시한다.
- 현재 구현은 실제 앱 색상이나 layout을 theme 값에 따라 바꾸지 않는다.
- `updateAppSettings`는 저장 시 `updatedAt`을 자동 갱신하지만, 현재 SettingsView에서는 직접 호출하지 않는다.

다중 테마를 추가하려면 필요한 작업:

- `src/types.ts`의 `AppSettings.theme` union을 예: `"light" | "dark"`처럼 확장한다.
- `src/db.ts`의 기본 설정 생성 값이 계속 안전한지 확인한다. 기본값은 기존 사용자 데이터와 충돌하지 않는 `light`를 우선 유지한다.
- 기존 IndexedDB 데이터에 이미 저장된 `light` 값이 그대로 유효한지 확인한다.
- `SettingsView`의 theme 선택지에 신규 값을 추가한다.
- 실제 앱 스타일 적용 방식을 결정한다. 예: root class, data attribute, CSS 변수 중 하나를 선택한다.
- `App.css`는 사용자가 직접 관리한다는 규칙이 있으므로, 색상 체계 변경은 사용자의 명시 요청 또는 별도 승인 후 진행한다.
- 다중 테마가 단순 저장 값인지, 실제 화면 색상 전환 기능인지 범위를 먼저 구분한다.

MVP 포함 여부:

- MVP에서는 다중 테마를 필수 기능으로 보지 않는다.
- 현재 MVP 범위에서는 `light` 단일 값 유지와 저장 경로 검증까지만 완료 기준으로 둔다.
- `dark` 같은 다중 테마는 1차 정식 버전 이후 개선 후보로 미루는 것을 기본 제안으로 한다.
- 사용자가 명시적으로 요청하면 별도 작은 작업으로 타입 확장, UI 선택지 추가, 스타일 적용 정책 문서화, 스타일 구현 순서로 진행한다.

App.css 규칙과 충돌하지 않는 구현 방식:

- 먼저 타입과 저장 정책을 확정하고, 실제 스타일 변경은 별도 작업으로 분리한다.
- `App.css` 수정이 필요한 경우 수정 범위와 색상 토큰 정책을 먼저 제안한다.
- `App.css` 대규모 재작성, 전체 색상 체계 재설계, layout 변경이 필요하면 구현을 중단하고 디자인/테마 계획 문서부터 작성한다.
- theme 값 저장만 필요한 작업에서는 `App.css`를 수정하지 않는다.

다중 테마 구현 전 중단 조건:

- `App.css` 대규모 변경이 필요하다.
- 기존 UI 색상 체계나 layout 재설계가 필요하다.
- `AppSettings` 타입 확장 외에 Dexie schema version 변경이 필요하다.
- 기존 IndexedDB 설정 데이터의 migration 기준이 불명확하다.
- theme 변경 과정에서 서버 API, `localStorage`, 로그인, cloud sync, 알림 권한 요청, Capacitor가 필요해진다.

향후 안전한 구현 순서:

1. 다중 테마가 MVP인지 1차 정식 버전 이후 개선인지 결정한다.
2. `AppSettings.theme` 허용 값 확장안을 문서화한다.
3. 기본 설정 값과 기존 IndexedDB 데이터 호환성을 확인한다.
4. `SettingsView` 선택지만 먼저 확장하고 `npm run build`로 확인한다.
5. 실제 스타일 적용 방식을 별도 문서로 정한다.
6. 사용자가 `App.css` 수정을 명시적으로 허용한 뒤 최소 스타일 변경을 진행한다.
7. 수동 테스트 체크리스트의 다중 테마 항목을 기준으로 새로고침 후 값 유지, `updatedAt` 갱신, 금지 기능 미추가를 확인한다.

## 25. Language 확장 정책과 다국어 리소스 구조

현재 상태:

- `AppSettings.language`의 허용 값은 `"ko"` 하나뿐이다.
- `SettingsView`는 현재 language 값을 표시하지만, language 선택 컨트롤이나 실제 다국어 전환 기능은 없다.
- 현재 화면 문구는 대부분 컴포넌트 내부에 한국어 문자열로 직접 작성되어 있다.
- 현재 language 값은 저장된 설정 상태를 보여주는 용도이며, 화면 문자열을 바꾸는 런타임 i18n 상태로 사용하지 않는다.

신규 언어를 추가하려면 필요한 작업:

- `src/types.ts`의 `AppSettings.language` union을 예: `"ko" | "en"`처럼 확장한다.
- `src/db.ts`와 `src/store.ts`의 기본 설정 값이 기존 사용자 데이터와 충돌하지 않는지 확인한다. 기본값은 `ko`를 유지하는 방향을 우선한다.
- 기존 IndexedDB 설정 데이터에 저장된 `ko` 값이 그대로 유효한지 확인한다.
- `SettingsView`에 language 선택지를 추가한다.
- 화면별 하드코딩 문구를 문자열 리소스로 옮길 범위를 정한다.
- README, ROADMAP, manual-test-checklist 같은 문서는 한국어 기준을 유지하되, 앱 UI 문자열 리소스와 문서 언어 정책을 분리한다.

다국어 문자열 리소스 후보 구조:

- 후보 1: `src/i18n/messages.ts`
  - `messages.ko`, `messages.en` 객체를 한 파일에서 관리한다.
  - MVP 이후 작은 앱 규모에서는 가장 단순하다.
- 후보 2: `src/locales/ko.ts`, `src/locales/en.ts`
  - 언어별 파일을 분리한다.
  - 화면 문구가 많아지거나 번역 검토가 필요해지면 더 적합하다.
- 메시지 key는 화면 구조를 반영해 `nav.today`, `settings.language`, `tasks.addTask`처럼 안정적으로 둔다.
- 화면 컴포넌트는 문자열을 직접 작성하지 않고 `t("settings.language")` 같은 helper 또는 props로 받은 labels를 참조한다.
- 초기 단계에서는 외부 i18n 라이브러리 없이 typed message object와 작은 `getMessage(language, key)` helper를 우선 검토한다.

MVP 포함 여부:

- MVP에서는 다국어 전환을 필수 기능으로 보지 않는다.
- 현재 MVP 범위에서는 `language: "ko"` 유지와 값 표시까지만 완료 기준으로 둔다.
- `en` 같은 신규 언어와 실제 문구 전환은 1차 정식 버전 이후 개선 후보로 미루는 것을 기본 제안으로 한다.
- 다국어를 구현하기 전에는 전체 화면 문구 목록과 수동 테스트 항목을 먼저 확정한다.

다국어 구현 전 중단 조건:

- 화면 문구 전체를 한 번에 교체해야 하는 대규모 작업이 된다.
- 문자열 길이 변화로 `App.css` 또는 layout 수정이 필요하다.
- `AppSettings.language` 타입 확장 외에 Dexie schema version 변경이 필요하다.
- 기존 IndexedDB 설정 데이터의 migration 기준이 불명확하다.
- 외부 번역 API, 서버 API, `localStorage`, 로그인, cloud sync가 필요해진다.
- 알림 권한 요청이나 Capacitor 변경이 함께 필요해진다.

향후 안전한 구현 순서:

1. 다국어 전환을 MVP에 포함할지 1차 정식 버전 이후로 미룰지 결정한다.
2. 현재 화면의 사용자-facing 문자열 목록을 문서화한다.
3. `AppSettings.language` 허용 값 확장안을 문서화한다.
4. 문자열 리소스 구조를 `src/i18n` 단일 파일 방식으로 시작할지, `src/locales` 언어별 파일 방식으로 시작할지 결정한다.
5. `SettingsView` 선택지만 먼저 확장하고 `npm run build`로 확인한다.
6. 작은 화면 하나부터 문자열 리소스를 적용하고 회귀 테스트한다.
7. 모든 화면으로 확장하기 전 모바일 폭과 긴 영어 문자열의 layout 영향을 확인한다.
8. 수동 테스트 체크리스트의 다국어 항목을 기준으로 language 값 유지, 화면 문구 전환, 금지 기능 미추가를 확인한다.

## 26. AI Provider 확장 정책

현재 상태:

- `AppSettings.aiProvider`의 허용 값은 `"rule_based"` 하나뿐이다.
- 현재 `RuleBasedAIProvider`는 서버 호출 없이 브라우저 안에서 업무 배열을 계산하는 로컬 rule-based provider다.
- 추천 업무, 지난 마감 업무, 예정 업무, 업무 요약 문자열은 모두 로컬 데이터만 사용한다.
- 현재 구현에는 외부 AI API 호출, API Key 입력, API Key 저장, 서버 API 계층이 없다.

MVP 정책:

- MVP에서는 `rule_based`만 유지한다.
- 사용자의 업무 데이터가 외부 서버로 나가지 않는 privacy-first 원칙을 우선한다.
- `aiProvider` 설정은 현재 provider 값을 표시하는 용도이며, provider 전환 UI나 네트워크 호출 기능을 의미하지 않는다.
- 외부 AI provider 또는 로컬 LLM provider는 1차 정식 버전 이후 확장 후보로 둔다.

외부 AI provider 추가 전 필요한 정책:

- 네트워크 호출을 허용할지 먼저 결정한다.
- 서버 API 없이 브라우저에서 직접 외부 AI API를 호출할지, 별도 proxy/server 계층을 둘지 결정한다.
- 브라우저 직접 호출은 API Key 노출, CORS, 요금 악용, 사용량 추적 문제를 만든다.
- API Key를 IndexedDB에 저장할지 여부는 별도 보안 정책이 필요하다.
- `localStorage` 사용 금지 원칙은 유지한다.
- 사용자가 직접 API Key를 입력하는 구조를 만들 경우, 저장 여부, 삭제 기능, 마스킹 표시, export/backup 포함 여부를 먼저 정한다.
- 외부 provider가 업무 제목, 메모, 마감일 같은 개인 데이터를 전송하는지 명확히 표시해야 한다.

로컬 LLM provider 추가 전 필요한 정책:

- 사용자가 로컬 endpoint URL을 직접 입력하는 방식을 검토할 수 있다.
- 로컬 endpoint도 브라우저 기준으로는 네트워크 접근이므로 CORS와 연결 실패 처리가 필요하다.
- 서버 없는 MVP 범위와 충돌하는지 먼저 결정한다.
- 로컬 LLM이 실행 중이지 않을 때 fallback을 `rule_based`로 유지할지 정한다.
- endpoint URL 저장 여부와 저장 위치는 API Key 정책과 분리해서 검토한다.

1차 정식 버전 이후 확장 후보:

- `rule_based`: 기본 provider. 서버 호출 없이 항상 동작해야 한다.
- `local_llm`: 사용자가 직접 입력한 로컬 endpoint를 호출하는 후보. 네트워크/CORS/장애 처리 정책이 필요하다.
- `external_api`: 외부 AI API를 호출하는 후보. API Key, 개인정보 전송, 요금, 보안 정책이 필요하다.

AI Provider 확장 전 중단 조건:

- API Key 입력 또는 저장이 필요하다.
- 외부 네트워크 호출이 필요하다.
- 서버/API 계층이 필요하다.
- API Key 보안, 개인정보 전송 범위, 사용량/요금 정책이 정해져 있지 않다.
- IndexedDB에 민감정보를 저장해야 하는데 암호화/삭제/백업 제외 정책이 없다.
- `localStorage`, 로그인, cloud sync, 알림 권한 요청, Capacitor 변경이 필요해진다.

향후 안전한 구현 순서:

1. `rule_based`, `local_llm`, `external_api` 중 MVP 이후에 실제로 필요한 provider 범위를 결정한다.
2. API Key와 endpoint 저장 정책을 문서화한다.
3. 개인정보가 provider로 전송되는 범위를 문서화한다.
4. `AppSettings.aiProvider` 타입 확장안을 문서화한다.
5. API Key 저장이 필요하면 IndexedDB 저장 위험과 삭제/초기화 흐름을 먼저 설계한다.
6. provider interface가 현재 `AIProvider`로 충분한지 검토한다.
7. `SettingsView` 선택지만 먼저 확장할지, 실제 provider 연결과 함께 진행할지 결정한다.
8. `rule_based` fallback을 유지한 상태로 작은 provider adapter를 추가한다.
9. 수동 테스트 체크리스트의 AI Provider 항목을 기준으로 금지 기능, 개인정보 전송, fallback 동작을 확인한다.

## 27. Notification 확장 정책

현재 상태:

- 설정 필드명은 `enableNotifications`다.
- `AppSettings.enableNotifications`의 허용 값은 `false` 하나뿐이다.
- `SettingsView`는 알림 상태를 표시하지만 편집 기능이나 권한 요청은 제공하지 않는다.
- 현재 구현에는 브라우저 `Notification` API, Android notification, Capacitor 알림 기능, 서버 push 알림이 없다.

MVP 정책:

- MVP에서는 알림 기능을 구현하지 않는다.
- 알림 권한 요청은 MVP에서 발생하지 않아야 한다.
- 설정 화면의 알림 항목은 현재 상태 표시용이며, 실제 알림 예약/발송 기능을 의미하지 않는다.
- `enableNotifications`는 현재 `false`로 유지한다.

알림 기능 추가 전 필요한 정책:

- 브라우저 `Notification` API를 사용할지 결정한다.
- Android/Capacitor 전환 이후 로컬 알림으로 구현할지 결정한다.
- 알림 권한 요청 시점을 정한다. 앱 시작 시 자동 요청하지 않고, 사용자의 명시적 동작 후 요청하는 방향을 우선한다.
- 권한 요청 전 사용자 고지 문구를 정한다.
- 로컬 알림, Android 로컬 알림, 서버 push 알림을 명확히 구분한다.
- 서버 push 알림은 서버 API, 사용자 식별, 토큰 저장, 개인정보 정책이 필요하므로 현재 범위에서 제외한다.
- 오프라인/백그라운드 동작 한계를 문서화한다.

권한 요청 없이 값만 토글할지 여부:

- 권한 요청 없이 `enableNotifications` 값만 토글하는 기능은 사용자가 실제 알림이 울린다고 오해할 수 있다.
- 값 토글만 허용한다면 "알림 기능은 아직 동작하지 않음" 같은 사용자-facing 문구가 필요하다.
- 값이 실제로 변경될 때만 `updatedAt`이 갱신되어야 한다.
- 값 토글은 실제 Notification API 호출, 권한 요청, 예약 작업과 분리되어야 한다.
- 현재 타입이 `false` 단일 값이므로 값 토글을 구현하려면 먼저 타입 확장 정책을 별도 작업으로 확정해야 한다.

알림 구현 전 중단 조건:

- 브라우저 권한 요청이 필요하다.
- Capacitor 또는 Android notification 권한이 필요하다.
- 서버 push, 사용자 계정, 로그인, cloud sync가 필요하다.
- 알림 UX 문구, 권한 요청 시점, 실패/거부 처리 기준이 정해져 있지 않다.
- `AppSettings.enableNotifications` 타입 확장 외에 Dexie schema version 변경이 필요하다.
- 백그라운드 동작이나 반복 알림을 보장해야 하는 요구가 생긴다.

향후 안전한 구현 순서:

1. 알림이 MVP 범위인지 1차 정식 버전 이후 개선인지 결정한다.
2. 브라우저 로컬 알림, Android 로컬 알림, 서버 push 중 구현 범위를 결정한다.
3. 권한 요청 시점과 사용자 고지 문구를 문서화한다.
4. `AppSettings.enableNotifications` 타입 확장안을 문서화한다.
5. 값 토글만 먼저 제공할지, 실제 알림 기능과 함께 제공할지 결정한다.
6. 값 토글만 제공한다면 실제 알림이 울리지 않는다는 문구를 SettingsView에 표시하는 계획을 세운다.
7. 실제 알림 기능은 별도 작업으로 분리하고, Notification API 또는 Capacitor 변경이 필요한 경우 사용자에게 명시적으로 승인받는다.
8. 수동 테스트 체크리스트의 알림 항목을 기준으로 권한 요청 미발생, 값 유지, 금지 기능 미추가를 확인한다.

## 28. First Launch 상태 UX 정책

현재 상태:

- `AppSettings.firstLaunchCompleted`는 boolean 값이다.
- 기본값은 `false`이며, `appSettings` 단일 레코드에 함께 저장된다.
- 현재 `SettingsView`에는 첫 실행 완료 상태가 읽기 전용으로 표시된다.
- 현재 SettingsView에서는 firstLaunchCompleted 변경을 위해 `updateAppSettings`를 호출하지 않는다.
- 현재 앱에는 별도 onboarding 화면이나 첫 실행 흐름이 구현되어 있지 않다.

사용자 설정으로 계속 노출할 때의 장점:

- 개발 중 첫 실행 상태를 쉽게 확인하고 바꿀 수 있다.
- IndexedDB 값을 직접 지우지 않고 onboarding 관련 상태를 수동으로 검증할 수 있다.
- 설정 저장 경로와 `updatedAt` 갱신을 확인하는 작은 테스트 항목으로 사용할 수 있다.

사용자 설정으로 계속 노출할 때의 단점:

- 일반 사용자는 "첫 실행 완료"가 어떤 효과를 갖는지 이해하기 어렵다.
- 값 변경이 실제 앱 동작에 즉시 보이는 효과를 만들지 않으면 설정 화면의 신뢰도가 떨어질 수 있다.
- 향후 onboarding 흐름이 생기면 사용자가 임의로 값을 바꿔 흐름을 건너뛰거나 다시 보게 만들 수 있다.
- 개발/디버그용 상태가 일반 설정과 섞인다.

내부 onboarding 상태로 숨길 때의 장점:

- 일반 설정 화면이 사용자가 이해하고 조작할 수 있는 항목 중심으로 정리된다.
- onboarding 흐름의 완료 여부를 앱 내부 로직이 일관되게 관리할 수 있다.
- 사용자가 실수로 초기 실행 상태를 바꿔 혼란을 겪는 일을 줄인다.

내부 onboarding 상태로 숨길 때의 단점:

- 개발 중 상태 확인과 수동 테스트가 불편해질 수 있다.
- onboarding 재실행이나 초기화 기능이 필요하면 별도 개발자 도구 또는 reset 정책이 필요하다.
- SettingsView에서 제거하기 전에 현재 수동 테스트 항목과 문서를 먼저 바꿔야 한다.

MVP 기준 권장안:

- MVP에서는 현재 값을 읽기 전용으로 표시하되, 일반 사용자 직접 토글은 제공하지 않는다.
- 일반 사용자용 1차 정식 버전에서는 `firstLaunchCompleted`를 내부 onboarding 상태로 숨기는 방향을 권장한다.
- 실제 onboarding 화면이 생기기 전까지는 이 값이 앱 동작에 미치는 효과를 과장하지 않는다.
- 사용자에게 계속 노출한다면 "개발용 상태" 또는 "초기 안내 완료 여부"처럼 효과가 분명한 문구가 필요하다.

사용자에게 노출한다면 필요한 기준:

- 값이 어떤 화면 또는 흐름에 영향을 주는지 설명해야 한다.
- 값 변경 후 새로고침해도 유지되는지 확인해야 한다.
- 값 변경 시 `updatedAt`이 갱신되고 `createdAt`이 유지되는지 확인해야 한다.
- 단순 상태 표시인지, onboarding 재실행/숨김에 직접 연결되는지 구분해야 한다.

숨긴다면 SettingsView에서 제거하기 전 필요한 기준:

- `firstLaunchCompleted`를 어떤 코드가 읽고 쓰는지 먼저 확인한다.
- onboarding 화면 또는 초기 안내 흐름이 실제로 존재하는지 확인한다.
- 숨긴 뒤에도 기본값 생성과 저장 데이터 호환성이 유지되는지 확인한다.
- 수동 테스트 체크리스트에서 "첫 실행 완료 상태 표시" 항목을 수정한다.
- 개발/디버그용 reset이 필요하면 별도 문서 또는 내부 도구 계획을 세운다.

`updatedAt`/`createdAt` 정책:

- `firstLaunchCompleted` 값이 실제로 바뀌면 `updatedAt`은 갱신된다.
- `createdAt`은 최초 설정 생성 시점 이후 변경하지 않는다.
- SettingsView에서 단순히 값을 표시하는 것만으로는 `updatedAt`이 바뀌면 안 된다.
- 값이 기존 값과 같으면 저장을 호출하지 않는 방향을 우선 검토한다.

향후 안전한 구현 순서:

1. `firstLaunchCompleted`를 일반 설정으로 유지할지 내부 onboarding 상태로 숨길지 결정한다.
2. 일반 설정으로 유지한다면 사용자-facing 문구와 실제 효과를 명확히 정한다.
3. 내부 상태로 숨긴다면 SettingsView 제거 계획과 수동 테스트 항목 변경을 먼저 문서화한다.
4. onboarding 화면 또는 초기 안내 흐름이 필요하면 별도 작업으로 설계한다.
5. 코드 변경 시 `SettingsView` 변경만 작은 범위로 진행하고 `npm run build`로 확인한다.
6. 새로고침 후 값 유지, `updatedAt` 갱신, `createdAt` 유지, 기존 설정 표시 회귀를 수동 확인한다.

이 문서는 PlanPilot Local의 현재 상태와 앞으로의 개발 순서를 정리한다.

## 1. 현재 MVP 상태

- React + Vite + TypeScript 기반 로컬 웹앱이 생성되어 있다.
- Zustand store와 Dexie.js + IndexedDB 기반 저장소가 구현되어 있다.
- 서버 없이 동작하는 privacy-first 개인 일정/업무 관리 앱 방향을 따른다.
- 로그인, 서버 API, 클라우드 동기화, 알림, Capacitor는 아직 도입하지 않는다.
- UI는 `src/views`, `src/components`, `src/utils`로 분리 중이며, `src/App.tsx`는 앱 초기화, 탭 상태, 주요 상태/핸들러 조립을 담당한다.

## 2. 현재 구현된 기능

- 하단 탭 기반 화면 전환
  - 오늘
  - 업무
  - 프로젝트
  - 설정
- 업무 기능
  - 업무 추가
  - 업무 수정
  - 업무 삭제
  - 완료/미완료 토글
  - 검색
  - 완료 업무 표시/숨김
  - 프로젝트 필터
  - 마감일 빠른 순 정렬
- 프로젝트 기능
  - 프로젝트 추가
  - 프로젝트 수정
  - 프로젝트 삭제
  - 기본 프로젝트 삭제 방지
  - 업무가 있는 프로젝트 삭제 방지
  - 프로젝트별 전체/완료/미완료 업무 수 표시
- 오늘 화면
  - 전체 업무 수 표시
  - 완료 업무 수 표시
  - 지난 마감 업무 수 표시
  - 7일 이내 마감 업무 수 표시
  - 추천 업무 표시
  - 지난 마감 업무 목록 표시
  - 7일 이내 마감 업무 목록 표시
- 설정 화면
  - 테마, 언어, AI Provider, 알림, 첫 실행 완료 상태 표시
- AI 기능
  - `RuleBasedAIProvider` 기반 추천 업무
  - 지난 마감 업무 찾기
  - 예정 업무 찾기
  - 업무 요약 문자열 생성

## 3. 현재 구조의 문제점

- `src/App.tsx`에서 화면 JSX와 반복 UI는 분리되었지만, 폼 상태, 편집 상태, CRUD 핸들러가 아직 많이 남아 있다.
- `useState`가 많아 기능 추가 시 상태 관리가 더 복잡해질 수 있다.
- 날짜 계산과 추천 기준은 `taskDates`와 `RuleBasedAIProvider` 사이에서 추가 정리가 필요하다.
- 문서는 리팩터링 진행 상태에 맞춰 계속 동기화해야 한다.
- DB schema migration 전략이 아직 없다.
- 에러/로딩 상태 처리가 부족하다.
- 테스트 파일과 자동 검증 흐름이 아직 정리되어 있지 않다.

## 4. 완성 기준

PlanPilot Local은 "서버 없이 로컬에서 개인 업무와 프로젝트를 안정적으로 관리할 수 있는 앱"이 되었을 때 완성으로 본다. 완성 여부는 기능 수가 아니라 데이터 보존, 반복 사용성, 오류 회복, 수동 검증 가능성을 기준으로 판단한다.

완성 기준:

- 앱을 새로 열어도 IndexedDB에 저장된 업무, 프로젝트, 설정이 유지된다.
- 사용자는 업무를 추가, 수정, 삭제, 완료/미완료 처리할 수 있다.
- 사용자는 프로젝트를 추가, 수정, 삭제할 수 있고, 업무가 있는 프로젝트는 실수로 삭제되지 않는다.
- 오늘 화면은 추천 업무, 지난 마감 업무, 7일 이내 마감 업무를 일관되게 표시한다.
- 전체 업무 화면은 검색, 프로젝트 필터, 완료 업무 표시/숨김, 마감일 정렬을 제공한다.
- 설정 화면은 현재 앱 설정을 읽기 전용으로 이해할 수 있게 표시하고, 정식 버전 전에는 필요한 설정 편집 범위를 별도로 결정한다.
- 로컬 저장은 IndexedDB + Dexie.js만 사용하며 `localStorage` fallback을 만들지 않는다.
- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor는 명시된 단계 전까지 포함하지 않는다.
- `npm run build`가 성공한다.
- 주요 사용자 시나리오를 수동으로 검증할 수 있는 체크리스트가 문서화되어 있다.
- 데이터 삭제나 schema 변경이 필요한 작업은 migration 또는 백업 기준을 먼저 갖춘다.

## 5. MVP 완료 조건

MVP는 "개인 업무 관리 앱으로 혼자 매일 써볼 수 있는 최소 안정 상태"를 목표로 한다.

MVP 완료 조건:

- 오늘, 업무, 프로젝트, 설정 화면이 모두 접근 가능하다.
- 업무 추가/수정/삭제/완료 토글이 정상 동작한다.
- 업무 제목, 메모, 마감일, 중요도, 프로젝트 연결이 저장되고 다시 표시된다.
- 프로젝트 추가/수정/삭제가 정상 동작한다.
- 기본 프로젝트는 삭제할 수 없다.
- 업무가 있는 프로젝트는 삭제할 수 없다.
- 업무 검색이 제목 기준으로 동작한다.
- 프로젝트 필터가 동작한다.
- 완료 업무 표시/숨김이 동작한다.
- 마감일 빠른 순 정렬이 동작한다.
- 오늘 화면의 추천 업무가 완료되지 않은 업무 중 우선순위와 마감일 기준으로 표시된다.
- 지난 마감 업무와 7일 이내 마감 업무가 완료된 업무를 제외하고 표시된다.
- 설정 화면은 theme, language, aiProvider, 알림 사용 여부, 첫 실행 여부를 표시한다.
- 새로고침 후에도 IndexedDB에 저장된 데이터가 유지된다.
- `npm run build`가 성공한다.
- `App.css` 수정 없이 기존 스타일 class 이름이 유지된다.

## 6. 1차 정식 버전 완료 조건

1차 정식 버전은 "로컬 우선 업무 관리 앱으로 안정적으로 배포할 수 있는 상태"를 목표로 한다.

1차 정식 버전 완료 조건:

- MVP 완료 조건을 모두 만족한다.
- `App.tsx`는 화면 조립, 탭 상태, 앱 초기화 중심으로 줄어들어 있다.
- 오늘, 업무, 프로젝트, 설정 화면은 별도 컴포넌트로 분리되어 있다.
- 반복 UI는 `TaskCard`, `ProjectCard` 등 작은 컴포넌트로 분리되어 있다.
- 날짜 계산, 프로젝트 통계, 라벨 매핑, 필터/정렬 로직은 유틸 또는 selector로 분리되어 있다.
- 업무 상태 `todo`, `in_progress`, `done`을 사용자가 이해하고 변경할 수 있는 UI 정책이 정해져 있다.
- 데이터 내보내기/가져오기 또는 최소한 백업 전 수동 절차가 문서화되어 있다.
- IndexedDB schema 변경 정책과 migration 기준이 문서화되어 있다.
- 핵심 수동 테스트 체크리스트를 완료한 상태에서만 배포 후보로 본다.
- 모바일 폭에서 주요 화면이 겹치거나 잘리지 않는다.
- 접근성 기본값을 지킨다. 주요 버튼에는 의미 있는 텍스트가 있고, form input에는 label이 있다.
- README, ROADMAP, memory-bank가 현재 구현 상태와 충돌하지 않는다.

## 7. 기능별 Definition of Done

업무 기능:

- 빈 제목 업무는 생성 또는 저장되지 않는다.
- 업무 추가 후 목록과 IndexedDB 상태가 일치한다.
- 업무 수정 후 `updatedAt`이 갱신된다.
- 완료 처리 시 `completedAt`이 설정되고, 미완료로 되돌리면 제거된다.
- 업무 삭제 전 확인 절차가 있다.
- 삭제된 업무는 오늘/전체/프로젝트 통계에 남지 않는다.

프로젝트 기능:

- 빈 이름 프로젝트는 생성 또는 저장되지 않는다.
- 기본 프로젝트는 삭제되지 않는다.
- 업무가 연결된 프로젝트는 삭제되지 않는다.
- 프로젝트 이름 변경 후 업무 목록의 프로젝트 표시가 함께 갱신된다.
- 프로젝트 설명이 없으면 "설명 없음" 같은 fallback이 표시된다.

오늘 화면:

- 전체 업무 수와 완료 업무 수가 실제 tasks 배열과 일치한다.
- 추천 업무는 완료된 업무를 제외한다.
- 지난 마감 업무는 오늘 0시 기준으로 지난 업무만 표시한다.
- 7일 이내 마감 업무는 오늘부터 7일 이내의 완료되지 않은 업무만 표시한다.
- 업무가 없을 때 empty message가 표시된다.

전체 업무 화면:

- 검색어가 비어 있으면 검색 조건을 적용하지 않는다.
- 검색은 업무 제목 기준으로 대소문자 영향을 받지 않는다.
- 프로젝트 필터는 전체 또는 단일 프로젝트 기준으로 동작한다.
- 완료 업무 숨김은 `done` 상태 업무를 제외한다.
- 마감일 빠른 순 정렬에서 마감일 없는 업무는 뒤로 간다.

설정 화면:

- 현재 설정 값을 표시한다.
- 설정 편집 기능을 추가할 경우 저장 방식, 기본값, `updatedAt` 갱신 기준을 먼저 정하고 별도 작업으로 진행한다.
- 알림 기능은 MVP에서 켜지지 않으며 권한 요청도 하지 않는다.

AI Provider:

- 서버 호출 없이 rule-based 로직만 사용한다.
- 추천 기준은 중요도와 마감일을 기반으로 한다.
- LLM 또는 온디바이스 AI 도입 전에도 현재 기능이 동작해야 한다.

## 8. 품질/안정성 기준

- 모든 작업 후 `npm run build`가 성공해야 한다.
- lint 실행은 사용자가 허용한 경우에만 수행한다.
- 빌드 실패 상태는 커밋하지 않는다.
- 기능 추가와 리팩터링을 같은 작업에 섞지 않는다.
- `src/App.tsx`에 새 기능을 계속 누적하지 않는다.
- 새 컴포넌트는 기존 class 이름을 유지해 `App.css` 수정 없이 동작하게 한다.
- 오류 처리가 필요한 IndexedDB 작업은 사용자에게 실패 상태를 설명할 수 있어야 한다.
- 삭제, schema 변경, 데이터 이전 작업은 백업 또는 migration 기준 없이 진행하지 않는다.
- 브라우저 자동 실행이나 `open dist/index.html`에 의존하지 않는다.

## 9. 데이터 보존/백업 기준

- 저장소는 IndexedDB + Dexie.js를 기준으로 한다.
- `localStorage` fallback은 만들지 않는다.
- schema 변경 전에는 새 version, 이전 데이터 처리, 기본값, 실패 시 대응을 문서화한다.
- 사용자 데이터 삭제 가능성이 있는 변경은 별도 작업으로 분리한다.
- 프로젝트 삭제 시 연결 업무 처리 정책을 명확히 유지한다.
- 업무가 있는 프로젝트 삭제 방지 정책은 UI와 store 수준에서 일관되게 다룬다.
- 정식 버전 전에는 데이터 내보내기/가져오기 또는 최소 수동 백업 절차를 결정한다.
- 날짜 값은 현재 `YYYY-MM-DD` 문자열 사용을 기준으로 하되, 변경 시 기존 데이터 호환성을 먼저 검토한다.

## 10. UI/UX 기준

- 첫 화면은 실제 앱 화면이어야 하며 landing page를 만들지 않는다.
- 하단 탭은 오늘, 업무, 프로젝트, 설정으로 명확히 구분한다.
- 주요 작업 버튼은 사용자가 결과를 예측할 수 있는 한국어 텍스트를 사용한다.
- 삭제처럼 되돌리기 어려운 작업은 확인 절차를 둔다.
- 업무/프로젝트가 없을 때는 빈 상태 메시지를 보여준다.
- 긴 텍스트가 버튼이나 카드 밖으로 튀어나오지 않아야 한다.
- 모바일 폭에서 입력 폼, 목록, 하단 탭이 겹치지 않아야 한다.
- 설정 화면은 현재 MVP에서 기능 설명이나 편집 UI가 아니라 현재 상태 확인 중심으로 구성한다.
- 색상과 layout 변경은 `App.css`를 사용자가 관리한다는 전제를 깨지 않는다.

## 11. 수동 테스트 체크리스트

상세 수동 테스트 문서는 [docs/manual-test-checklist.md](docs/manual-test-checklist.md)를 기준으로 한다. 아래 목록은 ROADMAP에서 추적할 핵심 요약이며, 실제 리팩터링 후 검증은 문서의 체크박스를 따라 수행한다.

기본 실행:

- 새 브라우저 프로필 또는 IndexedDB 초기 상태에서 앱을 열면 기본 프로젝트가 생성된다.
- 설정 기본값이 표시된다.
- 새로고침 후 기본 데이터가 유지된다.

업무:

- 제목만 입력해 업무를 추가할 수 있다.
- 메모, 마감일, 중요도, 프로젝트를 포함해 업무를 추가할 수 있다.
- 업무를 수정하면 목록에 즉시 반영된다.
- 업무를 완료 처리하면 완료 업무 수가 증가한다.
- 완료 업무를 미완료로 되돌리면 완료 업무 수가 감소한다.
- 업무 삭제 후 오늘 화면과 전체 업무 화면에서 사라진다.

필터/정렬:

- 검색어 입력 시 제목이 일치하는 업무만 표시된다.
- 프로젝트 필터 선택 시 해당 프로젝트 업무만 표시된다.
- 완료 업무 표시를 끄면 완료 업무가 숨겨진다.
- 마감일 빠른 순 정렬이 마감일 있는 업무를 날짜순으로 보여준다.

프로젝트:

- 프로젝트를 추가할 수 있다.
- 프로젝트 이름과 설명을 수정할 수 있다.
- 기본 프로젝트 삭제 버튼은 삭제 동작을 하지 않는다.
- 업무가 있는 프로젝트는 삭제되지 않는다.
- 업무가 없는 사용자 프로젝트는 확인 후 삭제된다.

오늘 화면:

- 오늘 이전 마감일의 미완료 업무가 지난 마감 업무에 표시된다.
- 오늘부터 7일 이내 마감일의 미완료 업무가 예정 업무에 표시된다.
- 완료된 업무는 지난 마감/예정 업무에서 제외된다.
- 추천 업무가 없을 때 빈 상태 메시지가 표시된다.

검증:

- 각 주요 변경 후 `npm run build`가 성공한다.
- 예기치 않은 파일 변경이 없는지 `git status`로 확인한다.
- 화면 분리 후 `TodayView`, `TasksView`, `ProjectsView`, `SettingsView`의 기존 동작이 유지되는지 확인한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화, 알림 권한 요청, Capacitor가 추가되지 않았는지 확인한다.

## 12. 배포 전 체크리스트

- `npm run build` 성공
- README가 현재 실행 방법과 제약사항을 반영
- ROADMAP이 현재 완료/미완료 상태를 반영
- memory-bank가 현재 구현 상태와 충돌하지 않음
- App.css 미수정 원칙 확인
- `package-lock.json` 불필요 변경 없음
- IndexedDB schema 변경 여부와 migration 필요 여부 확인
- 수동 테스트 체크리스트 완료
- 모바일 폭 화면 확인 계획 수립
- 데이터 백업/복구 정책 결정
- 서버 API, 로그인, 클라우드 동기화, 알림, Capacitor가 의도치 않게 추가되지 않았는지 확인

## 13. Non-goals

현재 단계에서 하지 않을 일:

- 서버 API 연동
- 로그인과 계정 시스템
- 클라우드 동기화
- 팀 협업 기능
- 알림 기능과 notification 권한 요청
- Capacitor/Android 패키징
- Google Play 등록 작업
- LLM 서버 호출 기반 AI
- `localStorage` fallback
- 자동 브라우저 실행에 의존하는 preview workflow
- 대규모 디자인 개편
- DB schema 변경이 필요한 기능을 migration 계획 없이 구현

## 14. 다음 리팩터링 진입 조건

다음 코드 리팩터링은 아래 조건을 만족할 때 진행한다.

- `git status`가 깨끗하다.
- `npm run build`가 성공한다.
- 수정 범위가 하나의 화면, 하나의 컴포넌트, 하나의 유틸로 제한된다.
- `App.css` 수정이 필요하지 않다.
- DB schema 변경이 필요하지 않다.
- 기능 추가가 아니라 동작 보존 리팩터링임을 확인한다.
- 기존 UI 문구와 class 이름을 유지할 수 있다.
- props가 과도하게 늘어나면 해당 작업에서 멈추고 분리 순서를 재검토한다.

## 15. 단기 개발 목표

1. 현재 구현 상태에 맞게 README와 내부 문서를 정리한다.
2. 남은 `src/App.tsx` 상태와 핸들러 책임을 줄일 순서를 정한다.
3. 기능 추가 전 현재 빌드 상태를 확인한다.
4. 화면 분리 이후 남은 props 과다 구간을 점검한다.
5. 업무/프로젝트 폼 컴포넌트 분리 결과를 유지하고, 중복 submit/reset 로직은 별도 작업으로 검토한다.
6. 날짜 계산과 추천 업무 계산의 중복을 정리한다.
7. 설정 화면을 단순 표시에서 실제 설정 편집 화면으로 확장할지 결정한다.

## 16. 중기 개발 목표

- 프로젝트별 업무 보기 개선
- 업무 상태를 `todo`, `in_progress`, `done` 전체로 자연스럽게 조작하는 UI 추가
- 태그 입력 및 필터 기능 추가
- 예상 소요 시간 입력/표시 기능 개선
- 업무 정렬 옵션 확장
- RuleBasedAIProvider 추천 기준 개선
- 데이터 내보내기/가져오기 기능 검토
- IndexedDB 데이터 백업 전략 검토
- 접근성 및 키보드 조작성 개선

## 17. 리팩터링 계획

리팩터링은 동작 변경 없이 작은 단위로 진행한다. 각 단계 후 `npm run build`로 확인하고, 실패하면 다음 단계로 넘어가지 않는다.

### 17.1 1차 목표: 화면 컴포넌트 분리 [완료]

- 우선 `src/App.tsx`에서 화면별 JSX를 분리한다. [x]
- CSS class 이름은 유지하고 `src/App.css`는 수정하지 않는다. [x]
- 첫 분리 후보는 상대적으로 의존성이 적은 `SettingsView`다. [x]
- 다음 후보는 `TodayView`다. [x]
- `TasksView`와 `ProjectsView`는 폼 상태와 CRUD 핸들러가 많으므로 후순위로 둔다. [x]

분리 완료 파일:

- [x] [SettingsView.tsx](file:///d:/ai-apps/planpilot-local/src/views/SettingsView.tsx)
- [x] [TodayView.tsx](file:///d:/ai-apps/planpilot-local/src/views/TodayView.tsx)
- [x] [TasksView.tsx](file:///d:/ai-apps/planpilot-local/src/views/TasksView.tsx)
- [x] [ProjectsView.tsx](file:///d:/ai-apps/planpilot-local/src/views/ProjectsView.tsx)

### 17.2 2차 목표: 표시 컴포넌트 분리 [진행 중]

- 업무 목록의 반복 JSX를 `TaskCard`로 분리한다. [x]
- 프로젝트 목록의 반복 JSX를 `ProjectCard`로 분리한다. [x]
- 오늘 화면의 요약 영역은 별도 summary 컴포넌트로 분리할 수 있다.

예상 파일 후보:

- `src/components/TaskCard.tsx` [x]
- `src/components/ProjectCard.tsx` [x]
- `src/components/SummaryBlock.tsx`

### 17.3 3차 목표: 폼 컴포넌트 분리 [완료]

- 업무 추가 폼과 업무 수정 폼의 중복을 줄인다. [x]
- 프로젝트 추가 폼과 프로젝트 수정 폼의 중복을 줄인다. [x]
- 처음부터 과도하게 일반화하지 말고, 실제 중복이 명확한 입력 필드부터 분리한다.

예상 파일 후보:

- `src/components/TaskForm.tsx` [x]
- `src/components/ProjectForm.tsx` [x]

### 17.3.1 TaskForm 분리 계획

`TaskForm`은 업무 추가 form과 업무 수정 form의 공통 입력 UI로 분리되었다. 다만 상태와 submit/reset 핸들러는 아직 `App.tsx`와 `TasksView` props에 남아 있으므로, 다음 단계에서는 동작 변경 없이 책임을 더 줄일 수 있는지 검토한다.

공통 필드 후보:

- 제목
- 메모
- 마감일
- 중요도
- 프로젝트 선택

추가 form 전용 동작:

- `newTaskTitle`, `newTaskMemo`, `newTaskDueDate`, `newTaskPriority`, `newTaskProjectId` 상태를 사용한다.
- 제출 후 추가 form을 닫는다.
- 제출 후 입력값을 기본값으로 초기화한다.
- submit label은 `업무 추가`다.

수정 form 전용 동작:

- `editTaskTitle`, `editTaskMemo`, `editTaskDueDate`, `editTaskPriority`, `editTaskProjectId` 상태를 사용한다.
- 저장 후 `editingTaskId`를 해제한다.
- 취소 버튼이 필요하다.
- submit label은 `저장`이다.

남은 위험 요소:

- 업무 추가 form은 `isTaskFormOpen` 상태와 연결되어 있다.
- 업무 수정 form은 `sortedTasks.map()` 내부에서 특정 업무와 함께 렌더링된다.
- 수정 form은 `task` 객체를 기반으로 `updateTask`를 호출하므로, submit handler의 closure를 유지해야 한다.
- 프로젝트 select options는 `projects` 배열을 필요로 한다.
- form class 이름과 기존 `li.task-card` 구조를 잘못 바꾸면 CSS가 달라질 수 있다.

다음 정리 순서:

1. `TasksView` props 중 상태 setter와 form 값을 분류한다.
2. submit/reset 로직을 훅 또는 작은 helper로 옮길 수 있는지 검토한다.
3. `TaskForm` UI는 이미 분리되었으므로 JSX를 다시 복제하지 않는다.
4. props가 더 늘어나는 방식이면 코드 수정 대신 계획을 먼저 문서화한다.
5. 각 단계 후 `npm run build`로 확인한다.

### 17.4 4차 목표: 파생 데이터 로직 분리 [진행 중]

- 날짜 계산과 필터/정렬 로직을 `App.tsx` 밖으로 옮긴다. [진행 중]
- `RuleBasedAIProvider`와 중복되는 overdue/upcoming 계산을 정리한다.
- DB schema는 이 단계에서 변경하지 않는다.

예상 파일 후보:

- `src/utils/taskFilters.ts` [x]
- `src/utils/taskDates.ts` [x]
- `src/utils/projectStats.ts` [x]

### 17.5 5차 목표: 라벨 매핑 분리

- priority/status/settings 표시 문자열을 별도 매핑으로 분리한다.
- 내부 enum 값은 영어로 유지한다.
- UI 표시만 한국어 라벨을 사용한다.

예상 파일 후보:

- `src/utils/labels.ts`

### 17.6 분리 작업 원칙

- 새 기능 추가와 리팩터링을 같은 작업에 섞지 않는다.
- 한 번에 하나의 화면 또는 하나의 컴포넌트만 분리한다.
- 기존 JSX를 복사해 중복 화면을 만들지 않는다.
- props가 너무 많아지는 경우 해당 단계에서 멈추고 store selector 또는 분리 순서를 재검토한다.
- `App.tsx`는 최종적으로 탭 상태, 앱 초기화, 화면 조립 중심으로 줄이는 것을 목표로 한다.

### 17.7 TodayView 분리 전 점검

`TodayView`는 `SettingsView` 다음 분리 후보지만, 추천 업무와 날짜 기반 목록을 함께 표시하므로 props와 계산 위치를 먼저 정리한다.

분리 시 props 후보:

- `tasks`
- `recommendedTasks`
- `overdueTasks`
- `upcomingTasks`
- `getProjectName`

`TodayView`가 받을 데이터 후보:

- 전체 업무 수
- 완료 업무 수
- 추천 업무 목록
- 지난 마감 업무 목록
- 7일 이내 마감 업무 목록
- 프로젝트 이름 조회 함수

`TodayView`에서 직접 계산하지 않는 편이 좋은 로직:

- 오늘 날짜 기준 계산
- 7일 이내 마감 기준 계산
- 완료 업무 수 계산
- 추천 업무 계산
- 프로젝트 통계 계산

안전한 분리 체크리스트:

1. `TodayView`는 표시 전용 컴포넌트로 시작한다.
2. `App.tsx`의 기존 overdue/upcoming/recommended 계산 결과를 props로 넘긴다.
3. UI 문구와 class 이름은 바꾸지 않는다.
4. `RuleBasedAIProvider` 로직은 건드리지 않는다.
5. 날짜 계산 유틸 분리는 TodayView 분리 이후 별도 작업으로 진행한다.
6. 분리 후 `npm run build`로 확인한다.
7. props가 과도하게 늘어나면 TodayView 분리만 완료하고 추가 리팩터링은 다음 작업으로 미룬다.

### 17.8 App.tsx 잔여 책임 정리 계획

화면, 카드, 폼, 일부 유틸은 분리되었지만 `App.tsx`에는 아직 form 상태와 CRUD 핸들러가 많이 남아 있다. 다음 리팩터링은 바로 코드를 옮기기보다, 책임을 아래처럼 분류한 뒤 작은 단위로 진행한다.

현재 `App.tsx`에 남은 책임:

- 탭 상태 관리
- 앱 초기화와 store 액션 연결
- `RuleBasedAIProvider` 생성과 추천 업무 상태 관리
- 오늘 화면용 파생 데이터 연결
- 프로젝트 이름 조회 함수
- 업무 추가 form 상태와 reset 로직
- 업무 수정 form 상태와 reset 로직
- 업무 완료/미완료 토글 핸들러
- 업무 삭제 확인 핸들러
- 프로젝트 추가 form 상태와 reset 로직
- 프로젝트 수정 form 상태와 reset 로직
- 프로젝트 삭제 가능 여부 확인과 삭제 확인 핸들러
- `TasksView`, `ProjectsView`에 전달하는 다수의 props 조립

우선 정리 후보:

1. 업무 form 상태 묶음 검토
   - `newTask*`, `editTask*`, `editingTaskId`, `isTaskFormOpen` 상태를 한 번에 옮기지 않는다.
   - 추가 form 상태와 수정 form 상태를 별도 단위로 볼 수 있는지 먼저 확인한다.
   - `TaskForm` JSX는 이미 분리되어 있으므로 중복 생성하지 않는다.

2. 프로젝트 form 상태 묶음 검토
   - `newProject*`, `editProject*`, `editingProjectId` 상태를 작은 단위로 정리한다.
   - 프로젝트 삭제 정책은 기본 프로젝트 삭제 방지와 업무 연결 프로젝트 삭제 방지를 유지한다.
   - `ProjectForm`과 `ProjectCard` 구조는 유지한다.

3. handler helper 또는 custom hook 후보 검토
   - 후보 이름은 `useTaskFormState`, `useProjectFormState`, `useTaskActions`, `useProjectActions`처럼 역할이 분명해야 한다.
   - hook으로 옮길 경우 store 액션, confirm 문구, reset 순서가 바뀌지 않아야 한다.
   - hook 도입이 props 수를 줄이지 못하면 진행하지 않는다.

4. 작은 유틸 후보 검토
   - `getProjectName(projects, projectId)`처럼 순수 조회 helper는 유틸로 분리할 수 있다.
   - 완료 업무 수 계산은 `TodayView` props로 넘기기 전에 selector 또는 helper로 분리할 수 있다.
   - 단, 유틸 분리만으로 가독성이 크게 좋아지지 않으면 보류한다.

진입 조건:

- `git status`가 깨끗하다.
- `npm run build`가 성공한다.
- `docs/manual-test-checklist.md`에서 업무 추가/수정/삭제, 프로젝트 추가/수정/삭제, TodayView 회귀 항목을 확인할 수 있다.
- 수정 범위가 한 종류의 상태 또는 한 종류의 handler로 제한된다.
- `App.css`, DB schema, store 타입, UI 문구 변경이 필요하지 않다.

중단 조건:

- `TasksView`나 `ProjectsView` props가 더 늘어난다.
- confirm 문구나 삭제 정책이 바뀔 가능성이 있다.
- form reset 순서가 바뀔 가능성이 있다.
- store 액션 시그니처 변경이 필요하다.
- 한 작업에서 업무와 프로젝트를 동시에 크게 바꿔야 한다.

### 17.9 날짜 계산 중복 점검 결과

`taskDates.ts`와 `RuleBasedAIProvider`는 모두 지난 마감 업무와 7일 이내 마감 업무를 계산한다. 다만 두 파일의 책임이 완전히 같지는 않으므로, 바로 통합하기 전에 기준 차이와 회귀 위험을 먼저 고정한다.

현재 역할 구분:

- `src/utils/taskDates.ts`
  - `getOverdueTasks(tasks, today)`를 제공한다.
  - `getUpcomingTasks(tasks, today, days)`를 제공한다.
  - 호출자가 기준일 `today`를 직접 넘긴다.
  - 완료된 업무는 제외한다.
  - 마감일이 없는 업무는 제외한다.
  - 현재 `App.tsx`가 오늘 화면의 지난 마감/7일 이내 마감 업무 목록을 만들 때 사용한다.

- `src/ai/RuleBasedAIProvider.ts`
  - 내부 `startOfToday()`로 오늘 0시 기준을 직접 만든다.
  - 내부 `parseDueDate()`로 날짜 문자열을 파싱하고 invalid date를 제외한다.
  - `findOverdueTasks(tasks)`와 `findUpcomingTasks(tasks, days)`를 제공한다.
  - `suggestTodayTasks(tasks, limit)`에서 우선순위와 마감일 점수를 합쳐 추천 업무를 정렬한다.
  - `summarizeTasks(tasks)`에서 총 업무 수, 완료 업무 수, 미완료 업무 수, 지난 마감 업무 수, 7일 이내 마감 업무 수를 문자열로 만든다.

중복되는 기준:

- 완료된 업무는 지난 마감/예정 업무에서 제외한다.
- 지난 마감 업무는 오늘 0시보다 이전 마감일을 기준으로 한다.
- 7일 이내 마감 업무는 오늘 0시부터 `days`일 이내 마감일을 기준으로 한다.
- 마감일 없는 업무는 날짜 기반 목록에서 제외한다.

현재 차이점:

- `taskDates.ts`는 기준일을 외부에서 받으므로 화면 테스트에서 기준일을 통제하기 쉽다.
- `RuleBasedAIProvider`는 기준일을 내부에서 생성하므로 추천/요약 실행 시점에 따라 기준일이 정해진다.
- `RuleBasedAIProvider`는 invalid date를 `parseDueDate()`에서 걸러내지만, `taskDates.ts`는 `new Date(task.dueDate)` 결과를 직접 비교한다.
- 추천 업무는 단순 overdue/upcoming 목록이 아니라 우선순위 점수, 지난 마감 가중치, 오늘 마감 가중치, 마감일 빠른 순 정렬을 함께 사용한다.

바로 통합하면 위험한 이유:

- 오늘 화면의 지난 마감/예정 업무 표시와 추천 업무 정렬이 동시에 바뀔 수 있다.
- invalid date 처리 방식이 바뀌면 기존 저장 데이터 중 이상한 마감일 문자열이 있을 때 표시 결과가 달라질 수 있다.
- `RuleBasedAIProvider.summarizeTasks()`의 문자열 결과가 바뀔 수 있다.
- 추천 점수는 사용자-facing 추천 순서에 영향을 주므로 단순 날짜 유틸 정리보다 회귀 범위가 넓다.
- 기준일 생성 위치를 잘못 바꾸면 자정 전후 동작이 달라질 수 있다.

추천 로직을 건드리기 전 수동 테스트 항목:

- 오늘 이전 마감일의 미완료 업무가 지난 마감 업무에 표시된다.
- 완료된 지난 마감 업무는 지난 마감 업무에 표시되지 않는다.
- 오늘부터 7일 이내 마감일의 미완료 업무가 7일 이내 마감 업무에 표시된다.
- 완료된 예정 업무는 7일 이내 마감 업무에 표시되지 않는다.
- 추천 업무가 우선순위와 마감일 기준으로 표시된다.
- 추천 업무가 없을 때 빈 상태 메시지가 유지된다.
- `npm run build`가 성공한다.
- 서버 API, `localStorage`, 로그인, 클라우드 동기화, 알림 권한 요청, Capacitor가 추가되지 않는다.

향후 안전한 정리 순서:

1. `taskDates.ts`에 invalid date 처리 방식을 추가할지 먼저 결정한다.
2. `startOfToday()`와 `parseDueDate()`를 공용 유틸로 빼기 전에 현재 표시 결과를 수동 테스트 체크리스트로 확인한다.
3. overdue/upcoming 계산만 먼저 공용 유틸로 맞추고, 추천 점수 계산은 분리된 상태로 둔다.
4. `RuleBasedAIProvider.findOverdueTasks()`와 `findUpcomingTasks()`가 공용 유틸을 사용하도록 바꾸는 작업은 별도 커밋으로 진행한다.
5. `suggestTodayTasks()`의 점수 계산은 마지막에 별도 계획을 세운 뒤 진행한다.
6. 각 단계 후 `npm run build`와 오늘 화면 수동 테스트 항목을 확인한다.

### 17.10 날짜 처리 정책

날짜 계산 로직을 실제 코드로 통합하기 전에 아래 정책을 표준으로 삼는다. 이 정책은 `taskDates.ts`, `RuleBasedAIProvider`, 오늘 화면, 향후 테스트 케이스가 같은 기준을 공유하기 위한 문서 기준이다.

기본 정책:

- `dueDate`가 비어 있는 업무는 날짜 기반 목록에서 제외한다.
- invalid `dueDate`는 날짜 기반 목록에서 제외한다.
- 날짜 기반 계산의 기준일은 오늘 0시로 한다.
- 오늘 0시는 사용자의 로컬 실행 환경에서 만든 `Date` 값을 기준으로 한다.
- `done` 상태 업무는 지난 마감 업무와 7일 이내 마감 업무에서 제외한다.
- 날짜 계산 정책을 바꿀 때는 추천 업무, 지난 마감 업무, 7일 이내 마감 업무를 함께 확인한다.

overdue 기준:

- `dueDate`가 있고 유효한 날짜로 파싱된다.
- 업무 상태가 `done`이 아니다.
- 마감일이 오늘 0시보다 이전이다.
- 오늘 마감 업무는 overdue로 보지 않는다.

upcoming 기준:

- `dueDate`가 있고 유효한 날짜로 파싱된다.
- 업무 상태가 `done`이 아니다.
- 마감일이 오늘 0시 이상이다.
- 마감일이 오늘 0시부터 지정한 `days`일 이내다.
- 현재 기본 upcoming 범위는 7일이다.

추천 업무와 날짜 목록의 역할 차이:

- 지난 마감/7일 이내 마감 목록은 날짜 조건을 만족하는 업무를 보여주는 목록이다.
- 추천 업무는 날짜 목록이 아니라 우선순위, 지난 마감 여부, 오늘 마감 여부, 마감일 빠른 순을 조합한 정렬 결과다.
- 추천 업무는 완료되지 않은 업무 전체를 후보로 보며, 마감일 없는 업무도 우선순위에 따라 후보가 될 수 있다.
- 따라서 overdue/upcoming 유틸을 정리하더라도 `suggestTodayTasks()`의 점수 계산은 별도로 검증한다.

공용 유틸 후보:

- `startOfToday()`
  - 로컬 환경 기준 오늘 0시 `Date`를 만든다.
  - App과 AI Provider가 같은 기준일을 쓰게 할 수 있다.

- `parseDueDate(dueDate?: string)`
  - 빈 값과 invalid date를 `null`로 처리한다.
  - 날짜 기반 목록과 추천 정렬의 invalid date 처리를 맞출 수 있다.

- `isOverdueTask(task, today)`
  - 유효한 마감일, 미완료 상태, 오늘 0시 이전 조건을 한곳에 모은다.
  - 오늘 화면과 AI Provider의 overdue 기준을 맞출 수 있다.

- `isUpcomingTask(task, today, days)`
  - 유효한 마감일, 미완료 상태, 오늘 0시 이상, 지정 기간 이내 조건을 한곳에 모은다.
  - 오늘 화면과 AI Provider의 upcoming 기준을 맞출 수 있다.

바로 통합하지 않는 이유:

- invalid date 처리 추가는 기존 화면 표시 결과를 바꿀 수 있다.
- `RuleBasedAIProvider`의 추천 정렬은 단순 날짜 목록보다 영향 범위가 넓다.
- 기준일 생성 위치를 바꾸면 자정 전후 동작이 달라질 수 있다.
- 공용 유틸을 잘못 설계하면 화면 로직과 AI Provider 로직이 서로 불필요하게 결합될 수 있다.
- 먼저 수동 테스트 기준을 고정한 뒤 작은 단계로 통합해야 한다.

코드 통합 시 안전 순서:

1. 수동 테스트 체크리스트의 날짜 정책 항목을 먼저 확인한다.
2. `parseDueDate()` 공용화 가능성을 검토한다.
3. `startOfToday()` 공용화 가능성을 검토한다.
4. `isOverdueTask()`와 `isUpcomingTask()`를 순수 함수로 분리한다.
5. `taskDates.ts`가 공용 유틸을 사용하도록 바꾼다.
6. 별도 작업에서 `RuleBasedAIProvider.findOverdueTasks()`와 `findUpcomingTasks()`가 공용 유틸을 사용하도록 바꾼다.
7. `suggestTodayTasks()` 점수 계산은 마지막에 별도 테스트 기준을 두고 검토한다.
8. 각 단계 후 `npm run build`와 오늘 화면/추천 업무 수동 테스트를 수행한다.

### 17.11 추천 점수 로직 분리 계획

`RuleBasedAIProvider.suggestTodayTasks()`는 현재 오늘 화면의 추천 업무 목록을 계산한다. 추천 결과는 사용자에게 직접 보이는 영역이므로, 점수 계산을 바로 유틸로 옮기기 전에 현재 기준과 회귀 테스트 기준을 먼저 고정한다.

현재 추천 업무 선택 기준:

- `done` 상태 업무는 추천 후보에서 제외한다.
- `todo`, `in_progress` 상태 업무만 추천 후보가 될 수 있다.
- 기본 추천 개수는 `limit = 3`이다.
- 후보 업무를 점수 내림차순으로 정렬한 뒤 상위 `limit`개를 반환한다.

현재 우선순위 점수 기준:

- `high`: 3점
- `medium`: 2점
- `low`: 1점
- 알 수 없는 priority 값: 0점

현재 마감일 점수 기준:

- `parseDueDate(task.dueDate)`가 유효한 날짜를 반환할 때만 마감일 점수를 계산한다.
- 오늘 0시 기준으로 `daysUntilDue`를 계산한다.
- 마감일이 오늘보다 이전이면 10점을 더한다.
- 마감일이 오늘이면 5점을 더한다.
- 미래 마감일은 추가 점수를 받지 않는다.
- 마감일이 없거나 invalid date이면 마감일 점수는 0점이다.

현재 정렬 기준:

- 1차 정렬은 `getTaskScore()` 결과의 내림차순이다.
- 점수가 다르면 높은 점수의 업무가 먼저 온다.
- 점수가 같고 두 업무 모두 유효한 마감일이 있으면 마감일이 빠른 업무가 먼저 온다.
- 점수가 같고 한 업무에만 유효한 마감일이 있으면 마감일이 있는 업무가 먼저 온다.
- 점수도 같고 두 업무 모두 유효한 마감일이 없으면 기존 배열 순서를 유지한다.

분리 후보:

- `priorityScore(priority)`
- `getTaskScore(task, today)`
- `compareRecommendedTasks(a, b, today)`
- 필요 시 `getRecommendedTasks(tasks, limit, today)` 형태의 순수 selector

바로 코드 분리하지 말아야 할 위험 요소:

- `suggestTodayTasks()`는 단순 날짜 목록이 아니라 사용자-facing 추천 순서를 만든다.
- `getTaskScore()`에서 사용하는 오늘 기준과 `parseDueDate()` 처리 방식이 바뀌면 추천 순서가 달라질 수 있다.
- 정렬 comparator를 옮길 때 동점 처리와 마감일 없는 업무의 순서가 바뀔 수 있다.
- `Array.prototype.sort()`는 원본 배열을 정렬하므로, 분리 과정에서 입력 배열 복사 여부를 바꾸면 호출부 기대 동작을 다시 확인해야 한다.
- 추천 개수 `limit` 기본값과 slice 위치가 바뀌면 오늘 화면 표시 개수가 달라질 수 있다.

향후 안전한 리팩터링 순서:

1. 수동 테스트 체크리스트의 추천 업무 항목을 먼저 확인한다.
2. `priorityScore()`를 그대로 유지한 채 별도 파일 이동 가능성을 검토한다.
3. `getTaskScore(task, today)`를 today 주입 가능한 순수 함수로 분리한다.
4. 동점 정렬 기준을 `compareRecommendedTasks(a, b, today)`로 분리하되 기존 comparator 결과와 비교한다.
5. 마지막에 `suggestTodayTasks()`가 필터, 정렬, slice 조립만 담당하도록 줄인다.
6. 각 단계마다 `npm run build`와 오늘 화면 추천 업무 수동 테스트를 수행한다.

### 17.12 추천 정렬 comparator 분리 계획

`RuleBasedAIProvider.suggestTodayTasks()` 안의 정렬 comparator는 추천 업무의 최종 표시 순서를 결정한다. `priorityScore()`와 `getTaskScore()`는 분리되었지만, comparator는 점수 동점 처리와 dueDate fallback을 함께 담당하므로 바로 옮기지 않고 기준을 먼저 고정한다.

현재 comparator 정렬 기준:

- `getTaskScore(a)`와 `getTaskScore(b)`를 비교한다.
- 두 점수가 다르면 높은 점수의 업무가 먼저 온다.
- 두 점수가 같으면 `parseDueDate(a.dueDate)`와 `parseDueDate(b.dueDate)`를 비교한다.
- 두 업무 모두 유효한 dueDate가 있으면 더 빠른 dueDate의 업무가 먼저 온다.
- 한 업무에만 유효한 dueDate가 있으면 dueDate가 있는 업무가 먼저 온다.
- 두 업무 모두 dueDate가 없거나 invalid dueDate이면 comparator는 `0`을 반환한다.
- 추천 후보 필터는 `task.status !== "done"` 조건을 유지한다.
- 정렬 후 반환은 기존처럼 `filteredTasks.slice(0, limit)`를 사용하며 기본 limit은 3이다.

dueDate 없음/invalid dueDate 처리 기준:

- `parseDueDate()`가 `null`을 반환하면 정렬상 유효한 dueDate가 없는 업무로 취급한다.
- 점수가 같은 업무끼리 비교할 때 dueDate가 없는 업무는 dueDate가 있는 업무보다 뒤에 온다.
- 두 업무 모두 dueDate가 없거나 invalid이면 기존 배열 순서가 유지되도록 comparator 결과를 `0`으로 둔다.
- invalid dueDate는 추천 후보 제외 조건이 아니며, 마감일 정렬과 마감일 점수에서만 제외된다.

`compareRecommendedTasks` 분리 후보:

- 함수 후보: `compareRecommendedTasks(a: Task, b: Task): number`
- 위치 후보: `src/ai/recommendationScore.ts`
- 내부에서 `getTaskScore()`와 `parseDueDate()`를 그대로 사용한다.
- 첫 단계에서는 today 주입이나 정렬 정책 변경을 추가하지 않는다.
- `suggestTodayTasks()`는 `filter`, `sort(compareRecommendedTasks)`, `slice(limit)` 조립만 담당하도록 줄인다.

comparator 분리 시 바뀌면 안 되는 동작:

- `done` 상태 업무 제외 조건
- 점수 내림차순 우선 정렬
- 점수 동점 시 dueDate 빠른 순 정렬
- 점수 동점 시 dueDate가 있는 업무를 dueDate 없는 업무보다 우선하는 동작
- 두 업무 모두 dueDate가 없거나 invalid일 때 comparator가 `0`을 반환하는 동작
- 추천 업무 기본 반환 개수 3개
- 지난 마감/7일 이내 마감 목록 계산과 추천 업무 정렬의 역할 구분

향후 안전한 코드 분리 순서:

1. 수동 테스트 체크리스트의 추천 정렬 항목을 먼저 확인한다.
2. `compareRecommendedTasks(a, b)`를 `recommendationScore.ts`에 추가하되 기존 comparator 코드를 그대로 옮긴다.
3. `RuleBasedAIProvider.suggestTodayTasks()`의 `.sort()`에 새 comparator만 연결한다.
4. `filter(task => task.status !== "done")`와 `slice(0, limit)`는 provider에 그대로 둔다.
5. `npm run build` 후 추천 업무 순서, 최대 3개 반환, dueDate 없음/invalid date 처리 항목을 수동 확인한다.
6. 문제가 없을 때만 다음 단계에서 today 주입 가능성이나 selector화 여부를 검토한다.

## 18. 데이터/DB 개선 계획

- Dexie schema 변경 전 migration 계획을 작성한다.
- `dueDate` 기반 조회가 많으므로 인덱스 추가가 필요한지 검토한다.
- 프로젝트 삭제 시 관련 업무 처리 정책을 명확히 한다.
- 업무가 없는 프로젝트만 삭제하는 현재 UI 정책을 store/문서에서도 명확히 유지한다.
- `updateAppSettings`는 `updatedAt`을 자동 갱신한다는 현재 정책을 유지한다.
- settings의 `firstLaunchCompleted`는 현재 읽기 전용 표시이며, 향후 내부 onboarding 상태로 숨길지 결정한다.
- 날짜 값은 `YYYY-MM-DD` 문자열로 유지할지, 별도 날짜 유틸을 둘지 결정한다.
- future schema version 추가 시 기존 IndexedDB 데이터 보존을 우선한다.

## 19. 테스트/검증 계획

- 변경 허용 시 기본 검증은 `npm run build`로 한다.
- lint 실행은 사용자 허용 후 `npm run lint`로 한다.
- 테스트 도구 도입 전까지는 핵심 시나리오를 수동 체크리스트로 관리한다.
- 우선 검증해야 할 시나리오
  - 앱 초기 실행 시 기본 프로젝트 생성
  - 업무 추가
  - 업무 수정
  - 업무 삭제
  - 완료/미완료 토글
  - 프로젝트 추가
  - 프로젝트 수정
  - 기본 프로젝트 삭제 방지
  - 업무가 있는 프로젝트 삭제 방지
  - 오늘 화면 추천/지난 마감/예정 업무 표시
- 추후 테스트 도입 시 우선 대상
  - `RuleBasedAIProvider`
  - 날짜 계산 유틸
  - store CRUD 로직
  - 필터/정렬 selector

## 20. Android/Capacitor 전환 전 체크리스트

- 웹 MVP 핵심 기능 안정화
- `App.tsx` 분리 완료
- IndexedDB 저장 정책 확인
- 데이터 백업/복구 전략 검토
- Android WebView에서 IndexedDB 동작 확인 계획 수립
- 알림 기능 도입 여부 재검토
- Android notification 권한 요청 정책 결정
- 개인정보 처리 방향 문서화
- 오프라인 동작 검증
- 화면 크기별 모바일 UI 검증
- Google Play 등록에 필요한 앱 이름, 아이콘, 설명, 개인정보처리방침 준비

## 21. 다음 작업 우선순위

1. 현재 문서와 코드 상태 동기화 [완료]
2. 현재 빌드 가능 여부 확인 [완료]
3. `App.tsx` 분리 설계 [완료]
4. `SettingsView`, `TodayView`, `TasksView`, `ProjectsView` 화면 컴포넌트 분리 [완료]
5. 업무/프로젝트 폼 컴포넌트 분리 및 중복 축소 [완료]
6. 업무 필터/정렬 유틸 분리 [완료]
7. 날짜 계산 로직 중복 제거 (TodayView 및 RuleBasedAIProvider 등)
8. `App.tsx`에 남은 CRUD 핸들러와 form 상태 정리 계획 수립
9. 설정 편집 기능 추가 여부 결정
10. DB migration 규칙 문서화
11. RuleBasedAIProvider 개선
12. Android/Capacitor 전환 준비 문서 작성

## 22. 추천/날짜 유틸 구조 동기화

최근 리팩터링으로 추천 업무와 날짜 계산 책임은 다음처럼 정리되었다.

- `src/ai/recommendationScore.ts`
  - `priorityScore`: `high`, `medium`, `low` 우선순위를 추천 점수로 변환한다.
  - `getTaskScore`: 우선순위 점수와 마감일 점수를 합산한다.
  - `compareRecommendedTasks`: 추천 업무 정렬을 담당한다. 점수 내림차순, 동점 시 dueDate 빠른 순, 한쪽만 dueDate가 있으면 dueDate 있는 업무 우선, 둘 다 없거나 invalid이면 `0` 반환 기준을 유지한다.
- `src/ai/RuleBasedAIProvider.ts`
  - 추천 흐름 조립을 담당한다.
  - `suggestTodayTasks()`는 완료되지 않은 업무 필터링, 추천 comparator 적용, `limit` 개수 반환을 조립한다.
  - `findOverdueTasks()`와 `findUpcomingTasks()`는 공용 date predicate를 사용해 지난 마감/예정 업무 목록을 제공한다.
  - `summarizeTasks()`는 업무 통계와 날짜 목록 개수를 문자열로 만든다.
- `src/utils/dateUtils.ts`
  - `startOfToday`, `parseDueDate`, `isOverdueTask`, `isUpcomingTask`를 제공한다.
  - 비어 있거나 invalid인 `dueDate`는 날짜 기반 목록과 추천 마감일 점수에서 안전하게 제외한다.
- `src/utils/taskDates.ts`
  - Today 화면용 지난 마감 업무와 7일 이내 마감 업무 목록 계산을 담당한다.
  - 내부 판단은 `dateUtils`의 predicate helper를 재사용한다.

App.tsx 리팩터링 진행 상태:

- 화면 컴포넌트(`TodayView`, `TasksView`, `ProjectsView`, `SettingsView`) 분리는 완료했다.
- 표시 컴포넌트(`TaskCard`, `ProjectCard`)와 폼 컴포넌트(`TaskForm`, `ProjectForm`) 분리는 완료했다.
- 파생 계산 유틸(`taskLabels`, `taskDates`, `taskFilters`, `taskSummary`, `projectLookup`, `projectStats`) 분리는 진행했다.
- `App.tsx`에는 아직 앱 초기화, 탭 상태, 업무/프로젝트 form 상태, CRUD 핸들러, 화면 props 조립 책임이 남아 있다.

다음 추천 작업 후보:

1. `App.tsx`에 남은 unused import/state/helper를 정리한다.
2. 설정 화면은 현재 읽기 전용 상태 확인 화면이며, 실제 편집 기능은 별도 정책과 수동 테스트 기준이 확정된 뒤 검토한다.
3. 추천 로직은 수동 테스트 체크리스트로 점수/정렬 회귀를 확인한 뒤 기능 추가 여부를 결정한다.

## 23. 설정 저장 정책과 편집 기능 진입 기준

설정 화면은 현재 읽기 전용 상태 확인 화면이다. 향후 실제 편집 기능을 추가하기 전에 현재 저장 구조와 갱신 기준을 아래처럼 고정한다.

현재 타입과 저장 구조:

- `AppSettings`는 앱에서 사용하는 설정 값이다.
  - `theme: "light"`
  - `language: "ko"`
  - `aiProvider: "rule_based"`
  - `enableNotifications: false`
  - `firstLaunchCompleted: boolean`
  - `createdAt: string`
  - `updatedAt: string`
- `StoredAppSettings`는 `AppSettings`에 IndexedDB key인 `id: string`을 더한 저장용 타입이다.
- 현재 설정 레코드는 Dexie `appSettings` 테이블에 `id: "app-settings"`로 1개만 저장한다.
- Zustand store는 `fetchAppSettings()`에서 저장 레코드의 `id`를 제거하고 `appSettings` 상태에 `AppSettings`만 보관한다.

기본 설정 생성 흐름:

- `initializeApp()`이 `db.ensureDefaultData()`를 먼저 호출한다.
- `ensureDefaultData()`는 `appSettings` 테이블에서 `app-settings` 레코드를 찾는다.
- 레코드가 없으면 기본값을 생성한다.
- 기본값은 light theme, ko language, rule_based provider, notifications disabled, firstLaunchCompleted false다.
- `createdAt`과 `updatedAt`은 생성 시점의 ISO 문자열로 저장한다.

현재 `updateAppSettings` 동작:

- `updateAppSettings(settings)`는 전달받은 `settings`에 현재 시각의 `updatedAt`을 더한 뒤 `id: "app-settings"`를 붙여 `db.appSettings.put()`으로 저장한다.
- 저장 후 Zustand `appSettings` 상태를 `updatedAt`이 갱신된 설정 값으로 교체한다.
- 현재 SettingsView는 읽기 전용 화면이므로 `updateAppSettings`를 직접 호출하지 않는다.
- 향후 실제 편집 기능을 구현할 때는 값이 실제로 바뀐 경우에만 `updateAppSettings`를 호출한다.

`updatedAt` 갱신 기준:

- 사용자가 설정 값을 실제로 변경해 저장할 때만 갱신한다.
- 설정 화면을 단순히 열거나 현재 값을 표시하는 것만으로는 갱신하지 않는다.
- 저장 버튼을 눌렀지만 값이 이전 값과 같으면 갱신하지 않는 방향을 우선 검토한다.
- `createdAt`은 최초 생성 시점 이후 변경하지 않는다.
- 여러 설정을 한 번에 저장하면 `updatedAt`은 저장 작업 1회 기준으로 한 번만 갱신한다.

편집 후보와 MVP 범위:

- `theme`: 현재 타입은 `"light"`만 허용하므로 MVP에서는 읽기 전용 표시만 유지한다. dark theme을 추가하려면 타입, UI, CSS, 저장 정책이 함께 필요하므로 별도 작업으로 분리한다.
- `language`: 현재 타입은 `"ko"`만 허용하므로 MVP에서는 읽기 전용 표시만 유지한다. 다국어를 추가하려면 문자열 리소스 구조가 먼저 필요하다.
- `aiProvider`: 현재 타입은 `"rule_based"`만 허용하므로 MVP에서는 읽기 전용 표시만 유지한다. 외부 AI provider는 서버 API/네트워크 정책과 충돌할 수 있어 현재 범위에서 제외한다.
- `enableNotifications`: 현재 타입은 `false`만 허용하므로 MVP에서는 읽기 전용 표시만 유지한다. 알림 권한 요청과 Android notification은 금지 상태이므로 편집 기능으로 켜지 않게 한다.
- `firstLaunchCompleted`: 현재 boolean으로 저장 가능하지만 SettingsView에서는 읽기 전용으로만 표시한다. 향후 일반 설정에서 숨기고 내부 onboarding 상태로 관리할지 별도 작업에서 결정한다.

DB schema 변경 없이 구현 가능한 범위:

- 기존 `appSettings` 단일 레코드의 값을 읽고 저장한다.
- `firstLaunchCompleted` boolean 변경은 schema 변경 없이 가능하다.
- 현재 타입 union에 없는 값을 추가하지 않는다.
- `theme`, `language`, `aiProvider`, `enableNotifications`의 선택지를 늘리지 않는다.
- 저장 시 기존 `createdAt`을 유지하고 `updatedAt`만 정책에 맞게 갱신한다.

중단 기준:

- 새 설정 값을 위해 `AppSettings` 타입 union을 확장해야 하면 별도 작업으로 분리한다.
- Dexie schema version 변경이 필요하면 migration 계획을 먼저 문서화하고 중단한다.
- 알림 권한 요청, 브라우저 Notification API, Capacitor, Android 권한이 필요하면 중단한다.
- 서버 API, 로그인, cloud sync, localStorage가 필요하면 중단한다.
- `App.css` 수정 없이는 UI가 불안정하면 구현하지 말고 디자인/컴포넌트 계획만 문서화한다.

설정 읽기 전용 화면 및 향후 편집 기능 구현 전 수동 테스트 항목:

- 설정 화면에서 현재 theme, language, AI Provider, 알림, 첫 실행 상태가 표시된다.
- 새로고침 후 기존 설정 값이 유지된다.
- 현재 SettingsView에서는 사용자가 설정 값을 직접 변경할 수 없다.
- `updatedAt`은 SettingsView 표시만으로 바뀌지 않는다.
- `createdAt`은 향후 설정 변경 기능을 추가하더라도 유지된다.
- 알림 권한 요청이 발생하지 않는다.
- 서버 API, localStorage, 로그인, cloud sync, Capacitor가 추가되지 않는다.

## 29. App form state / CRUD handler custom hook 분리 계획

이번 단계에서는 코드를 바로 분리하지 않고, `App.tsx`에 남아 있는 사용 중인 책임을 기준으로 다음 리팩터링 순서를 고정한다. 현재 `App.tsx`는 화면 컴포넌트와 유틸 분리는 많이 진행되었지만, 업무/프로젝트 form 상태와 CRUD orchestration handler는 아직 직접 소유한다.

현재 `App.tsx`에 남아 있는 form state:

- 업무 추가 form state
  - `isTaskFormOpen`
  - `newTaskTitle`
  - `newTaskDueDate`
  - `newTaskPriority`
  - `newTaskProjectId`
  - `newTaskMemo`
- 업무 수정 form state
  - `editingTaskId`
  - `editTaskTitle`
  - `editTaskDueDate`
  - `editTaskPriority`
  - `editTaskMemo`
  - `editTaskProjectId`
- 프로젝트 추가 form state
  - `newProjectName`
  - `newProjectDescription`
- 프로젝트 수정 form state
  - `editingProjectId`
  - `editProjectName`
  - `editProjectDescription`

현재 `App.tsx`에 남아 있는 CRUD / form handler:

- 업무 handler
  - `handleAddTask`
  - `handleSaveEditTask`
  - `handleDeleteTask`
  - `handleToggleTaskDone`
  - `handleStartEditTask`
  - `handleCancelEditTask`
- 프로젝트 handler
  - `handleAddProject`
  - `handleSaveEditProject`
  - `handleDeleteProject`
  - `handleStartEditProject`
  - `handleCancelEditProject`

store action과 App handler의 역할 구분:

- `store.ts`의 action은 IndexedDB 저장, Zustand 상태 갱신, `updatedAt` 갱신 같은 데이터 계층 책임을 담당한다.
- `App.tsx`의 handler는 입력값 trim, 빈 값 방지, form reset, 편집 시작/취소 상태 복원, 삭제 확인창, 기본 프로젝트 삭제 방지, 업무가 연결된 프로젝트 삭제 방지 같은 화면 흐름과 정책 조립을 담당한다.
- custom hook을 만들 때 store action 자체를 복제하지 않는다. hook은 화면 상태와 orchestration을 묶고, 실제 데이터 변경은 기존 store action을 계속 호출한다.

custom hook 후보:

- `useTaskFormState`: 업무 추가/수정 form 값, form open 상태, 편집 시작/취소/reset 상태 전환을 담당하는 후보. 첫 코드 분리 후보로 적합하다.
- `useTaskActions`: 업무 추가/수정/삭제/완료 토글 orchestration을 담당하는 후보. `useTaskFormState`가 안정화된 뒤 검토한다.
- `useProjectFormState`: 프로젝트 추가/수정 form 값, 편집 시작/취소/reset 상태 전환을 담당하는 후보. 업무 form보다 필드 수가 적어 낮은 위험도로 분리할 수 있다.
- `useProjectActions`: 프로젝트 추가/수정/삭제 orchestration과 삭제 방지 정책 연결을 담당하는 후보. 기본 프로젝트 삭제 방지와 업무가 있는 프로젝트 삭제 방지가 흔들리지 않아야 한다.

바로 코드 분리하지 말아야 할 이유:

- `TasksView`와 `ProjectsView` props가 이미 크기 때문에 hook 반환 객체를 잘못 설계하면 props 조립 책임이 더 복잡해질 수 있다.
- form submit 흐름이 `FormEvent`와 view 내부 inline submit wrapper에 걸쳐 있어, 분리 중 `preventDefault` 위치가 바뀌면 중복 저장 또는 새로고침 위험이 있다.
- 편집 취소와 저장 후 reset 항목이 많아 하나라도 누락하면 이전 값이 다음 form에 남을 수 있다.
- 프로젝트 삭제 정책은 store action의 기본 프로젝트 방지와 App handler의 업무 연결 방지가 나뉘어 있어, 무리하게 옮기면 정책 일부가 사라질 수 있다.
- build는 성공해도 업무/프로젝트 추가, 수정, 취소, 삭제, 필터, 통계까지 수동 회귀 범위가 넓다.

안전한 분리 순서:

1. 현재 `App.tsx` form state와 handler 목록을 문서 기준으로 다시 확인한다.
2. 코드 첫 단계에서는 `useProjectFormState` 또는 `useTaskFormState`처럼 form state와 reset/start/cancel만 분리한다.
3. submit handler는 처음부터 hook으로 옮기지 말고, form state hook 적용 후 수동 테스트를 먼저 통과시킨다.
4. 다음 단계에서 추가/수정 submit helper를 작은 범위로 분리한다.
5. 삭제와 완료 토글 handler는 마지막에 검토한다. 특히 프로젝트 삭제 방지 정책은 별도 회귀 테스트 후 이동한다.
6. hook 반환값은 view props 이름과 맞추되, `TasksView`/`ProjectsView` 전체 구조를 다시 뒤집지 않는다.
7. 각 단계마다 `npm run build`와 수동 테스트 체크리스트의 업무/프로젝트 form 항목을 확인한다.

중단 조건:

- `TasksView` 또는 `ProjectsView` props가 현재보다 더 읽기 어려운 대형 객체로 바뀐다.
- hook이 store action과 같은 데이터 저장 로직을 중복 구현하기 시작한다.
- form state 분리만으로 끝나지 않고 view JSX나 카드/form 컴포넌트 구조 재작업이 필요해진다.
- build는 되지만 수동 테스트 범위가 업무/프로젝트 전체 회귀를 한 번에 요구할 만큼 커진다.
- 기본 프로젝트 삭제 방지, 업무가 있는 프로젝트 삭제 방지, 편집 취소 reset 정책 중 하나라도 불명확해진다.
- `App.css`, DB schema, `types.ts`, `store.ts` 구조 변경이 필요해진다.

향후 코드 분리 시 우선 확인할 수동 테스트:

- 업무 추가 form 열기/닫기와 저장 후 입력값 reset
- 업무 수정 시작/취소/저장 후 기존 목록 표시 유지
- 업무 완료/미완료 토글과 삭제 확인창
- 프로젝트 추가 form 저장 후 입력값 reset
- 프로젝트 수정 시작/취소/저장 후 기존 통계 표시 유지
- 기본 프로젝트 삭제 방지
- 업무가 연결된 프로젝트 삭제 방지
- 업무/프로젝트 변경 후 오늘 화면 통계와 프로젝트별 업무 수 유지

## 30. useProjectActions 분리 검토 기준

`useProjectFormState` 분리는 완료되었고, 현재 프로젝트 입력값과 수정 대상 id, 수정 시작/취소/reset은 hook이 담당한다. 그러나 프로젝트 추가/수정/삭제 submit handler와 삭제 방지 정책은 아직 `App.tsx`에 남아 있다. 이번 단계에서는 이 handler를 바로 옮기지 않고, `useProjectActions` 같은 hook으로 분리할 수 있는 기준을 문서로 고정한다.

현재 `App.tsx`에 남아 있는 프로젝트 handler:

- `handleAddProject`
  - `FormEvent`에서 `preventDefault()`를 호출한다.
  - `newProjectName.trim()`이 비어 있으면 저장하지 않는다.
  - `addProject({ name, description })` store action을 호출한다.
  - 저장 성공 후 `resetNewProjectForm()`을 호출한다.
- `handleSaveEditProject`
  - `editProjectName.trim()`이 비어 있으면 저장하지 않는다.
  - 기존 `project`에 새 `name`, `description`을 반영해 `updateProject()` store action을 호출한다.
  - 저장 후 `resetEditProjectForm()`을 호출한다.
- `handleDeleteProject`
  - `projectId === "default"`이면 즉시 중단한다.
  - `getProjectTaskStats(tasks, projectId)`로 연결된 업무 수를 확인한다.
  - 연결된 업무가 1개 이상이면 삭제하지 않는다.
  - 삭제 확인창에서 확인한 경우에만 `deleteProject(projectId)` store action을 호출한다.
- `handleStartEditProject` / `handleCancelEditProject`
  - 현재는 `useProjectFormState`의 `startEditProject()`와 `resetEditProjectForm()`을 호출하는 얇은 연결 역할만 한다.

현재 책임 구분:

- `useProjectFormState`
  - `editingProjectId`, `editProjectName`, `editProjectDescription`
  - `newProjectName`, `newProjectDescription`
  - 입력 setter
  - `startEditProject`
  - `resetNewProjectForm`
  - `resetEditProjectForm`
- `App.tsx`
  - form submit event 처리
  - 입력값 trim과 빈 값 방지
  - store action 호출
  - 삭제 확인창 호출
  - 기본 프로젝트 삭제 방지
  - 업무가 연결된 프로젝트 삭제 방지
  - `ProjectsView`에 props 조립

`useProjectActions` 후보 책임:

- 프로젝트 추가 submit orchestration
- 프로젝트 수정 submit orchestration
- 프로젝트 삭제 orchestration
- 삭제 가능 여부 판단 helper 연결
- 삭제 확인창 호출 여부 결정
- 저장 성공 후 `useProjectFormState` reset 함수 호출
- 기존 store action을 호출하되, store action 자체를 중복 구현하지 않는다.

바로 hook으로 옮기면 위험한 이유:

- 기본 프로젝트 삭제 방지는 store action과 UI 버튼 disabled, App handler에 걸쳐 중복 방어되고 있다. hook 이동 중 하나라도 빠지면 회귀가 생긴다.
- 업무가 있는 프로젝트 삭제 방지는 현재 App handler에서 `tasks`와 `getProjectTaskStats()`로 판단한다. hook으로 옮기면 `tasks` 의존성이 추가되어 hook 책임이 커진다.
- 삭제 확인창 호출 위치가 바뀌면 사용자가 실수로 프로젝트를 삭제할 수 있다.
- 추가/수정 저장 후 reset 시점이 바뀌면 form 입력값이 너무 빨리 지워지거나, 저장 실패 후에도 사라질 수 있다.
- `ProjectsView` props 구조가 handler 묶음 객체로 바뀌면 현재 분리 범위를 넘어서는 view props 재설계가 된다.
- handler가 store action과 너무 가까워지면 hook이 데이터 계층 책임까지 가져갈 수 있다.

안전한 코드 분리 순서:

1. `handleStartEditProject`와 `handleCancelEditProject`는 이미 form state hook을 호출하는 얇은 wrapper이므로, 바로 추가 분리하지 않아도 된다.
2. 첫 코드 분리 후보는 `handleAddProject`와 `handleSaveEditProject`의 submit orchestration이다.
3. 추가/수정 submit을 옮기기 전에 hook 인자로 필요한 값과 함수 목록을 명확히 정한다.
   - `newProjectName`
   - `newProjectDescription`
   - `editProjectName`
   - `editProjectDescription`
   - `addProject`
   - `updateProject`
   - `resetNewProjectForm`
   - `resetEditProjectForm`
4. 삭제 handler는 마지막에 검토한다.
5. 삭제 handler를 옮기기 전에는 삭제 가능 여부를 순수 helper로 먼저 분리할 수 있는지 검토한다.
   - 예: `canDeleteProject(projectId, tasks)` 또는 `getProjectDeleteBlockReason(projectId, tasks)`
6. 삭제 방지 helper를 분리한다면 `ProjectCard` 버튼 disabled 조건과 App handler 조건이 같은 기준을 쓰도록 맞춘다.
7. 각 단계마다 `npm run build`와 프로젝트 수동 테스트를 통과한 뒤 다음 단계로 넘어간다.

중단 조건:

- `useProjectActions`가 store action과 같은 IndexedDB 저장 로직을 직접 구현하기 시작한다.
- 삭제 방지 정책이 hook 내부에서만 보이고 `ProjectCard`의 disabled 표시 기준과 어긋난다.
- hook 인자가 너무 많아져 `App.tsx` props 조립보다 이해하기 어려워진다.
- `ProjectsView` 또는 `ProjectForm` 구조 변경이 필요해진다.
- 삭제 확인창, 기본 프로젝트 방지, 업무 연결 프로젝트 방지 중 하나라도 동작 기준이 불명확해진다.
- 프로젝트 handler 이동만으로 끝나지 않고 업무 form/handler까지 함께 건드려야 하는 상황이 된다.

향후 코드 분리 시 수동 테스트 항목:

- 프로젝트 이름만 입력해 추가된다.
- 프로젝트 이름과 설명을 입력해 추가된다.
- 빈 이름으로는 프로젝트가 추가되지 않는다.
- 추가 저장 후 form 입력값이 reset된다.
- 프로젝트 수정 시작 시 기존 이름/설명이 form에 채워진다.
- 프로젝트 수정 취소 시 입력값이 남지 않는다.
- 프로젝트 수정 저장 후 프로젝트 통계가 유지된다.
- 기본 프로젝트는 삭제되지 않는다.
- 업무가 있는 프로젝트는 삭제되지 않는다.
- 업무가 없는 사용자 프로젝트는 확인 후 삭제된다.
- 삭제 취소 시 프로젝트가 유지된다.
- 프로젝트 삭제/수정 후 오늘 화면과 업무 화면의 프로젝트 이름 표시가 유지된다.
