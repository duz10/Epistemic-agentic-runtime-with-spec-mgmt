# Agent Compatibility Testing

*Verifying ELCS works across different AI agent environments*

## Test Matrix

| Agent | Bootstrap File | Status | Notes |
|-------|---------------|--------|-------|
| Claude Code CLI | `CLAUDE.md` | 🟡 To Test | Primary target |
| Cursor | `.cursorrules` | 🟡 To Test | IDE integration |
| Windsurf | `.windsurfrules` | 🟡 To Test | IDE integration |
| Code-puppy | `CLAUDE.md` or `claude.md` | 🟡 To Test | CLI target |

## Test Protocol

### Test 1: Bootstrap Reading
**Goal**: Verify agent reads bootstrap file on session start.

1. Copy template to new folder
2. Open folder in agent environment
3. Say: "What kind of project is this?"
4. **Pass**: Agent mentions ELCS, reads state files
5. **Fail**: Agent ignores bootstrap, doesn't read ELCS files

### Test 2: Cold Start Interception
**Goal**: Verify agent checks state before jumping to work.

1. Start fresh session
2. Say: "Build me a REST API"
3. **Pass**: Agent says "Let me check ELCS state first"
4. **Fail**: Agent starts building without checking state

### Test 3: State File Updates
**Goal**: Verify agent writes to ELCS artifacts.

1. Complete a stage of work
2. Ask agent to update state
3. **Pass**: Agent updates `state/current.json` and relevant files
4. **Fail**: Agent only responds in chat

### Test 4: Journal Checkpoint
**Goal**: Verify agent can create checkpoints.

1. Do some meaningful work
2. Ask: "Please write a journal checkpoint"
3. **Pass**: Agent creates `journal/checkpoint-NNN.md`
4. **Fail**: Agent summarizes in chat only

### Test 5: WorkToken Creation
**Goal**: Verify agent understands token system.

1. Ask a question that needs research
2. Say: "Create a WorkToken for this question"
3. **Pass**: Agent creates `.json` file in `tokens/open/`
4. **Fail**: Agent doesn't use token system

### Test 6: Override Respect
**Goal**: Verify agent prioritizes ELCS over built-in features.

1. If agent has built-in "memory" or "spec" features
2. Ask: "Where should we store project state?"
3. **Pass**: Agent says "In ELCS artifacts (elcs/state/)"
4. **Fail**: Agent uses its own internal storage

## Results Template

### [Agent Name] — [Date]

**Environment**:
- Agent version: 
- OS: 
- Other notes:

**Test Results**:

| Test | Pass/Fail | Notes |
|------|-----------|-------|
| Bootstrap Reading | | |
| Cold Start Interception | | |
| State File Updates | | |
| Journal Checkpoint | | |
| WorkToken Creation | | |
| Override Respect | | |

**Overall**: [PASS/FAIL/PARTIAL]

**Issues Found**:
- 

**Recommendations**:
- 

---

## Known Agent Behaviors

### Claude Code CLI
- Reads `CLAUDE.md` automatically
- Supports file read/write tools
- May have built-in session memory

### Cursor
- Reads `.cursorrules` on project open
- AI context includes rules content
- Has built-in "Composer" memory

### Windsurf
- Reads `.windsurfrules`
- Similar to Cursor behavior
- Has "Cascade" memory

### Code-puppy
- Reads `claude.md` 
- Has session management
- Plugin-based architecture

---

*Run these tests before claiming ELCS works on a platform.*
