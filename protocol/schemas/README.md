# ELCS Schemas

*JSON Schema definitions for all ELCS artifacts*

## Schema Registry

| Schema | Version | Purpose |
|--------|---------|--------|
| [epistemic-state.schema.json](./epistemic-state.schema.json) | v1 | Central belief ledger |
| [work-token.schema.json](./work-token.schema.json) | v1 | Unit of coordination |
| [spec.schema.json](./spec.schema.json) | v1 | Goal attractor |
| [lens-output.schema.json](./lens-output.schema.json) | v1 | Lens evaluation results |
| [cognitive-cone.schema.json](./cognitive-cone.schema.json) | v1 | Agent capability scope |
| [coalition-contract.schema.json](./coalition-contract.schema.json) | v1 | Multi-agent agreement |
| [journal-checkpoint.schema.json](./journal-checkpoint.schema.json) | v1 | Compressed narrative state |
| [codec.schema.json](./codec.schema.json) | v1 | Decompression metadata |
| [distance-vector.schema.json](./distance-vector.schema.json) | v1 | Distance to completion metrics for self-selection |

## Schema Versioning

All schemas follow semantic versioning:
- **Major version** (v1 → v2): Breaking changes, not backward compatible
- **Minor version** (v1.0 → v1.1): New optional fields, backward compatible

Schema version is embedded in the `$id` URL.

## Validation

Schemas are JSON Schema draft-07 compliant. Validate using:

```bash
# Using ajv (Node.js)
npx ajv validate -s epistemic-state.schema.json -d your-state.json

# Using jsonschema (Python)
python -m jsonschema -i your-state.json epistemic-state.schema.json
```

## ID Patterns

| Pattern | Example | Artifact |
|---------|---------|----------|
| `A[0-9]+` | A1, A42 | Assumption |
| `H[0-9]+` | H1, H7 | Hypothesis |
| `E[0-9]+` | E1, E12 | Evidence |
| `C[0-9]+` | C1, C5 | Constraint |
| `P[0-9]+` | P1, P3 | Preference |
| `SC[0-9]+` | SC1 | Success Criterion |
| `PH[0-9]+` | PH1 | Phase |
| `Q[0-9]+` | Q1 | Question |
| `T[0-9]+` | T1 | Test |

## Relationships

```
EpistemicState ←──────────────────────────────────────→ Spec
       ↑                                                   ↑
       │                                                   │
       ├── Assumptions                                     ├── Success Criteria
       ├── Hypotheses ←────────────────────→ Evidence     ├── Phases/Tasks
       ├── Constraints                                     └── Open Questions
       └── Preferences                                           ↓
                                                          WorkTokens
                                                               ↓
                                                          LensOutputs
                                                               ↓
                                                    JournalCheckpoints
                                                               ↓
                                                            Codecs
```
