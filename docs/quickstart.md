> **Note:** This is a reference copy of `template/elcs/QUICKSTART.md` for GitHub Pages.

# ELCS Quickstart

> **Get productive in 5 minutes or less.**

---

## 🚀 You Just Opened an ELCS Project

Great! Here's what you need to know:

### The One Rule
> **Write to files, not just chat.** If your session ends, ELCS artifacts survive.

### The Three Folders That Matter

| Folder | What's In It |
|--------|-------------|
| `elcs/state/` | What we believe (assumptions, evidence, constraints) |
| `elcs/spec/` | What we're building (goals, success criteria) |
| `elcs/tokens/open/` | What needs to be done next |

---

## ⚡ Quick Commands

### "I'm new, set me up"
```
Please help me initialize this ELCS project. 
Ask me about my goals and create the initial state.
```

### "I'm returning, catch me up"
```
Read the latest journal checkpoint and tell me where we left off.
```

### "What should I work on?"
```
Check elcs/tokens/open/ and recommend the highest priority task.
```

### "I finished something"
```
Update the relevant WorkToken to closed and write a checkpoint.
```

---

## 📋 The Stages (Simplified)

| Stage | What Happens | You're Done When |
|-------|--------------|------------------|
| **0** | Create folder structure | Folders exist |
| **1** | Define what you believe/assume | `state/current.json` populated |
| **2** | Apply perspectives (lenses) | Risks & gaps identified |
| **3** | Find what's missing | Gaps prioritized |
| **4** | Define goals that pass tests | At least 1 approved goal |
| **5** | Plan the build | Spec with phases exists |
| **6** | Verify ready to build | Human approves |
| **7+** | Build it! | Ship it! |

---

## 🎯 The 6 Gates (For Goals)

Before a goal becomes "real," it must pass:

1. ✅ **Can we measure success?** (Observables)
2. ✅ **Can we test pass/fail?** (Testability)
3. ✅ **Can we undo if wrong?** (Reversibility)
4. ✅ **Are we confident enough?** (Confidence ≥ 0.6)
5. ✅ **Do multiple perspectives agree?** (Lens Agreement)
6. ✅ **Is this based on evidence?** (Evidence Grounding)

---

## 🔄 The Loop (How We Work)

Every action follows:

```
OBSERVE → ORIENT → DECIDE → ACT → OBSERVE
   ↑                                  │
   └──────────────────────────────────┘
```

1. **Observe**: Read the current state
2. **Orient**: Figure out what matters
3. **Decide**: Pick the smallest useful action
4. **Act**: Do it (with a way to undo)
5. **Observe**: Record what happened

---

## 💾 End of Session Checklist

Before you close:

- [ ] Updated `state/current.json` if beliefs changed
- [ ] Moved completed tokens to `tokens/closed/`
- [ ] Wrote a journal checkpoint if significant progress
- [ ] Noted any blockers in the checkpoint

---

## ❓ FAQ

**Q: Do I have to follow all the stages?**  
A: For small experiments, you can be lightweight. For real projects, the stages prevent expensive mistakes.

**Q: What if the AI ignores ELCS?**  
A: Remind it: "This is an ELCS project. Please read elcs/PROTOCOL.md before proceeding."

**Q: What's a WorkToken?**  
A: A sticky note for work that needs doing. Lives in `tokens/open/` until done.

**Q: What's a Journal Checkpoint?**  
A: A summary of progress. Like a save point in a game.

**Q: Can I skip the lenses?**  
A: You can, but you'll miss risks. At minimum, apply Safety and Product lenses.

---

## 🆘 If Something Goes Wrong

1. **Read the last checkpoint** in `elcs/journal/`
2. **Check for open tokens** that might be stuck
3. **Look at the gap analysis** for known issues
4. **Ask**: Create a token with type "question"

---

## 📖 Want More?

- Full protocol: `elcs/PROTOCOL.md`
- Complete glossary: Check project `docs/glossary.md`
- Schema definitions: Check project `protocol/schemas/`

---

*You're ready. Start building.* 🚀
