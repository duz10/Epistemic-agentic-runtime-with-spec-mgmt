# Changelog

All notable changes to the ELCS Framework.

## [1.1.0] — 2025-07-09

### Added

#### Data Process Atlas Integration
- **Data Process Atlas** (`template/elcs/references/DATA_PROCESS_ATLAS.md`) — 56KB platform-agnostic domain knowledge reference covering operations, processes, constraints, architecture patterns, security, and project lifecycle
- **Reference Atlas routing table** in PROTOCOL.md — Stage-gated navigation that tells agents which Atlas sections to consult at each ELCS stage
- **`elcs/references/` directory** — New first-class location for domain knowledge documents
- **Atlas-aware lens evaluations** — Cross-references added to Safety/Risk, Topology, Systems Engineering, and Product/UX lenses
- **Atlas awareness in all 4 bootstrap files** — AGENTS.md, CLAUDE.md, .cursorrules, .windsurfrules all check for Atlas during session start

#### Documentation & Install Improvements
- Install scripts (`install.sh`, `install.ps1`) now create `elcs/references/` and copy reference documents
- All directory structure trees updated across 8+ files for consistency
- Fixed install script description in README.md (previously referenced non-existent `.elcs-ref/`)
- Fixed `.elcs-ref/` references in bootstrap files (now correctly point to `elcs/`)

### Changed
- Updated "Adoption Protocol" in all bootstrap files — section 1.5 now checks for existing `elcs/` setup instead of defunct `.elcs-ref/`

---

## [1.0.0] — 2025-02-09

### 🎉 Initial Release — VALIDATED

The first complete release of the ELCS Framework!

### Added

#### Core Framework
- **EpistemicState** management (assumptions, hypotheses, evidence, constraints)
- **7 Core Lenses** (Philosophy, Data Science, Safety, Topology, Math, Systems, Product)
- **6-Gate Protocol** for earned goals
- **WorkToken** coordination system
- **Journal** checkpoints with Codec decompression keys
- **Ralph Loop** as universal cognitive primitive

#### Template
- Multi-entry bootstrap (CLAUDE.md, .cursorrules, .windsurfrules)
- PROTOCOL.md — Full agent operating instructions
- QUICKSTART.md — 5-minute adoption guide
- Starter files for state, spec, tokens, journal

#### CLI Generator
- `create-elcs` command for scaffolding new projects
- Placeholder replacement
- uvx support for zero-install usage

#### Documentation
- Complete glossary (41 terms)
- Lens application guide
- Gap analysis process
- Progressive formalization guide (L0-L4)
- Scaling stages guide (A-E)
- Conflict resolution protocol

#### Schemas
- epistemic-state.schema.json
- work-token.schema.json
- spec.schema.json
- lens-output.schema.json
- cognitive-cone.schema.json
- coalition-contract.schema.json
- journal-checkpoint.schema.json
- codec.schema.json

### Validation
- ✅ **Validated via GroceryBrain test case** (complex multi-domain project)
- 9 tokens completed, 160 tests passing
- Hypotheses H6, H8, H9 validated with 0.90+ confidence
- See [docs/VALIDATION.md](docs/VALIDATION.md) for full report

### Development Process
- Built using the EAR (Epistemic Agent Runtime) methodology
- Self-documented via epistemic/ folder
- 7 journal checkpoints recorded

---

## Future Plans

### v1.1 (Planned)
- [x] ~~Telemetry infrastructure~~ ✅ Done (E17)
- [x] ~~Coalition formation protocol~~ ✅ Done (H5 validated)
- [x] ~~Distance vector computation~~ ✅ Done (H6 validated)
- [x] ~~Data Process Atlas integration~~ ✅ Done (v1.1.0)
- [ ] Validation scripts for artifact integrity
- [ ] Token templates for common work types
- [ ] Quick-start wizard

### v2.0 (Planned)
- [ ] Formal problem space definitions
- [ ] Reachability analysis
- [ ] Multi-project portfolio support
- [ ] Agent skill matching via formal distance vectors
