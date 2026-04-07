# ecosystem-platform

Shared **Flutter/Dart packages** for EMP AI hosts: **foundation** contracts, **core** (router, RBAC, network hooks), **Northstar** design system (**`emp_ai_ds_northstar`**, **`emp_ai_ds_widgets`**), and **`emp_ai_app_shell`** (`MiniApp`, super-app shell).

**Official boilerplate hosts** pin this repo as **`packages/ecosystem-platform`** (**Git submodule**) and depend with **`path:`** from the app — see **[emp_ai_auth_dependency.md](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/integrations/emp_ai_auth_dependency.md)**. **Other product apps** can depend via **`git:`** `url` + `path` + **`ref`** without vendoring a full checkout unless they develop platform code here.

| If you… | Start here |
|--------|------------|
| **Use the official host template** | Boilerplate **[repositories overview](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/engineering/repositories_overview.md)** and **[getting started](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/onboarding/getting_started.md)** |
| **Depend on platform only** (no boilerplate clone) | **[CONTRIBUTING.md — Consuming without the boilerplate](CONTRIBUTING.md#consuming-without-the-boilerplate)**; boilerplate hosts: **[emp_ai_auth_dependency.md](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/integrations/emp_ai_auth_dependency.md)** |
| **Change `emp_ai_*` code** | **[CONTRIBUTING.md](CONTRIBUTING.md)** (setup, boundaries, PRs) |

---

## Getting started (platform contributors)

**Prerequisites:** Flutter SDK (stable), Dart (via Flutter), [Melos](https://melos.invertase.dev/) (`dart pub global activate melos` or use `dart run melos` after root `dart pub get`).

```bash
git clone git@github.com:maplepam/ecosystem-platform.git
cd ecosystem-platform
dart pub get
dart run melos bootstrap
```

**Analyze all packages** (same idea as CI):

```bash
dart run melos run analyze:all
```

Work on a branch, open a PR to **`main`** (or your org’s default). See **[CONTRIBUTING.md](CONTRIBUTING.md)** for boundaries, versioning, and consumer impact. After merge, **consumers** bump the **same commit SHA** (or tag) on **every** `emp_ai_*` Git dependency (or advance the **`packages/ecosystem-platform`** submodule in the boilerplate) — see **[emp_ai_auth_dependency.md](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/integrations/emp_ai_auth_dependency.md)**.

---

## Layout

| Path | Role |
|------|------|
| `packages/emp_ai_foundation` | Contracts (`AppResult`, ports, feature flags) |
| `packages/emp_ai_core` | Router factory, RBAC, flavor parsing, Dio config hooks |
| `packages/emp_ai_ds_northstar` | Design tokens, themes, assets |
| `packages/emp_ai_ds_widgets` | Northstar UI components |
| `packages/emp_ai_app_shell` | `MiniApp`, route merging, shell scaffolds |

**Library packages do not commit `pubspec.lock`** — apps that depend on this repo own lockfiles.

---

## Related repositories

| Repo | Role |
|------|------|
| [ecosystem_boilerplate](https://github.com/maplepam/ecosystem_boilerplate) | Sample host, mini-apps, consumer docs |
| `emp-ai-flutter-auth` (Bitbucket) | `emp_ai_auth`; pins `emp_ai_core` from this repo |
