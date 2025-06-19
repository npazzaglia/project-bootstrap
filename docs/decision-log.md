# 📜 Decision Log

> Use this file to track major architectural or process decisions and the reasoning behind them.

Each entry should include a title, date, context, decision, and consequences.

---

## [1] Use GitHub Actions for CI

**Date:** 2025-06-19  
**Context:** We need a simple, cloud-native CI solution that integrates well with GitHub repositories and supports cross-platform runners.  
**Decision:** Adopt GitHub Actions as the default CI provider for all repos initialized from this template.  
**Consequences:**  
- Easy reuse across projects  
- Leverages GitHub’s hosted runners and secrets  
- Ties CI history directly to pull requests

---

## [2] Use MIT License by Default

**Date:** 2025-06-19  
**Context:** Template needs a permissive license to maximize reusability and reduce legal friction for adopters.  
**Decision:** MIT License is included by default unless explicitly overridden.  
**Consequences:**  
- Allows commercial use and modification  
- Forks can override with project-specific licenses
