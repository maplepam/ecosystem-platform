# Contributing to ecosystem-platform

This repository holds **`emp_ai_foundation`**, **`emp_ai_core`**, **`emp_ai_ds_northstar`**, **`emp_ai_ds_widgets`**, and **`emp_ai_app_shell`**. Changes here affect **every host** that pins these packages — including **ecosystem_boilerplate** via the **`packages/ecosystem-platform`** **submodule gitlink** and **`path:`** deps (see **[emp_ai_auth_dependency.md](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/integrations/emp_ai_auth_dependency.md)**).

**Not using the boilerplate?** You can still depend on this repo via **`git:`** `url` + `path` + **`ref`** (commit SHA or tag). See [Consuming without the boilerplate](#consuming-without-the-boilerplate) below.

**Multi-repo map** (boilerplate vs platform vs auth): [ecosystem_boilerplate — repositories_overview](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/engineering/repositories_overview.md).

---

## Local setup

```bash
git clone git@github.com:maplepam/ecosystem-platform.git
cd ecosystem-platform
dart pub get
dart run melos bootstrap
dart run melos run analyze:all
```

Fix analyzer issues before opening a PR. Prefer **`flutter analyze`** per package (what CI runs).

---

## Package boundaries (do not blur)

| Package | Stays in scope |
|---------|----------------|
| **`emp_ai_foundation`** | Contracts (`AppResult`, ports, feature-flag reader shapes). **No** Flutter UI, **no** Dio. |
| **`emp_ai_core`** | Router factory, RBAC types, flavor parsing, **`NetworkStackConfig`** / Dio hooks — **no** product screens. |
| **`emp_ai_ds_northstar`** | Tokens, `ThemeData`, assets. **No** auth or network. |
| **`emp_ai_ds_widgets`** | Reusable Northstar UI; depends on northstar tokens package. |
| **`emp_ai_app_shell`** | `MiniApp`, route trees, super-app shell scaffolds — **host-agnostic**; no product mini-app code. |

**Product-specific UI and OAuth wiring** belong in the **host** (e.g. boilerplate app) or **`emp_ai_auth`**, not in these packages.

---

## Pull requests

1. **Branch from `main`** (or your org’s default integration branch).
2. **Describe** what changed and **why**; link issues or initiatives.
3. **Call out breaking changes** to public APIs (exports, constructor shapes, `MiniApp` contract). Consumers must bump **all** platform Git deps to the **same** `ref`.
4. **Keep diffs focused** — no unrelated refactors in the same PR.
5. **Tests / examples:** add or adjust tests in the affected package when behavior changes.

---

## Versioning and consumers

- **Library packages do not commit `pubspec.lock`.** Lockfiles live in **apps** that depend on this repo.
- Hosts should pin **one** **`ref`** (SHA or tag) for **every** `emp_ai_*` path from this repository — boilerplate users track **`packages/ecosystem-platform`** as a submodule; see **[emp_ai_auth_dependency.md](https://github.com/maplepam/ecosystem_boilerplate/blob/main/docs/integrations/emp_ai_auth_dependency.md)**.
- After you merge to `main`, downstream teams **update all** those `ref` entries together. Mixing different SHAs for different platform paths can break Pub resolution.

**`emp_ai_auth`** (separate repo) pins **`emp_ai_core`** from here; coordinate **core** API changes with auth maintainers so their branch stays buildable.

---

## Consuming without the boilerplate

1. In your app’s **`pubspec.yaml`**, add **`git`** dependencies for each package you need, with the **same** `url`, **`ref`**, and distinct **`path`** (e.g. `packages/emp_ai_foundation`, `packages/emp_ai_core`, …).
2. Run **`flutter pub get`** in your app; ensure **SSH/HTTPS** access to the Git remote matches your org.
3. Wire **router**, **theme**, and **`MiniApp`** registration in your host — the boilerplate app is an optional **reference implementation**, not a runtime dependency.
4. For **OAuth**, either integrate **`emp_ai_auth`** (and align its **`emp_ai_core`** ref with yours) or implement your own session layer behind **`emp_ai_foundation`** ports.

---

## Maintenance (maintainers)

- **CI:** Run **`dart run melos run analyze:all`** on PRs; keep scripts in root **`melos.yaml`** in sync with local practice.
- **Tags (optional):** If your org uses **Git tags** for releases, document the tag → consumer bump process in your internal runbook.
- **Security / secrets:** Never commit tokens; packages stay free of environment-specific endpoints where possible — hosts pass **`NetworkStackConfig`** and flavors.

Questions about **host** wiring (Melos, mini-apps, `build_defines`) belong in **ecosystem_boilerplate** `docs/`, not here.
