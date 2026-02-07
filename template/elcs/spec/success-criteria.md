# Success Criteria

*How we know we're done*

> Every criterion must be observable and testable.
> See the 6 Gates: Observables, Testability, etc.

## Criteria Checklist

| ID | Criterion | Observable? | Test Method | Target | Status |
|----|-----------|-------------|-------------|--------|--------|
| - | (Add criteria during Stage 5) | - | - | - | - |

## Example Criteria

Good criteria:
```
| SC1 | Page load time | ✅ | Performance monitoring | p95 < 2s | ⏳ |
| SC2 | User can complete signup | ✅ | E2E test | 100% pass | ⏳ |
| SC3 | Zero critical security issues | ✅ | Security scan | 0 critical | ⏳ |
```

Bad criteria (avoid these):
```
| ❌ | "App feels fast" | Not measurable |
| ❌ | "Users love it" | Not testable |
| ❌ | "Works well" | Not observable |
```

## How to Test Each Criterion

For each criterion, document:
1. **What tool/method** measures it
2. **What threshold** defines success
3. **When** it will be tested
4. **Who** is responsible

---

*Update as criteria are defined and tested.*
