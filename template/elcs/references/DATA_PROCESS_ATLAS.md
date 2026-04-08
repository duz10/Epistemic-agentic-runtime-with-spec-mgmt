# Data Process Atlas v3

**Platform-agnostic reference for AI-assisted development.**

Four layers, decision protocol, confidence checks, cross-references, and user-facing implications. The questions don't change when tools change — only the answers do.

---

## How to Use This Document

This atlas is a reference and thinking scaffold. Don't read it linearly — jump to the section relevant to your current context.

**Starting a new project:** Begin with [Analysis Guide](#analysis-guide) → then [Lifecycle Phase 1 (Discovery)](#phase-1-discovery--planning). Use the [Constraints](#layer-1-constraints) section to identify what limits exist. Use [Decision Protocol](#decision-protocol) for technology and data layer choices.

**Evaluating a platform or tool:** Use [Platform Assessment](#platform-assessment) to systematically evaluate capabilities across all 9 dimensions. Cross-reference with [Constraints](#layer-1-constraints) to identify where platform limits create real project constraints.

**At a decision point:** Use the [Decision Protocol's](#decision-protocol) 6 steps. Reference the specific Decision Junctures embedded in whichever [Lifecycle](#layer-4-project-lifecycle) phase you're in. Document using the Decision Record Template.

**Building or reviewing code:** Reference [Operations](#layer-1-operations) for data handling patterns. Reference [Architecture Patterns](#layer-2-architecture-patterns) for structural decisions. Reference [Security](#layer-3-security--production-readiness) MUST items for every endpoint and data flow.

**Preparing for production:** Audit against [Security → Production Readiness](#production-readiness) checklist. Walk through [Lifecycle Phase 5 (Deployment)](#phase-5-production-deployment). Verify every MUST item is addressed. Run through deployment testing items.

**Working on an existing system:** Identify current [Lifecycle](#layer-4-project-lifecycle) phase. Use [Architecture → Migration/Evolution](#migration--evolution-patterns) patterns for safe changes. Verify Security posture hasn't drifted. Check Operations phase testing guidance for regression.

**Debugging or investigating an issue:** Use [Connections](#connections-map) to trace which processes and constraints are involved. A problem in one area often has root cause in a connected area (e.g., sync failure may be an integration surface constraint).

**Unsure what you don't know:** Use the Confidence Check prompts in each [Lifecycle](#layer-4-project-lifecycle) phase to surface assumptions, missing information, and areas of uncertainty. Surfacing what you don't know is often more valuable than confirming what you do.

---

## Layer 1: Operations

Every interaction in every system reduces to combinations of these operations. Everything else is orchestration.

### Create

**Bring new data into existence**

Form submission, sensor reading, API response, or user action generating a new record.

**Key Questions:**
- What triggers creation?
- What info required at creation vs. later?
- Who can create?
- Validation before creation?
- Downstream triggers?
- Default state?
- ID generation strategy? (Auto-increment, UUID, human-readable, composite)
- Duplicate handling? (Reject, merge, version)
- Bulk creation needed? (Import, migration, batch — different error handling, transactionality, and progress tracking)

**Pitfalls:**
- Hidden dependencies — related records may need to exist first
- Batch vs. single have different constraints (partial failure: reject whole batch or skip bad rows?)
- Creation time often only chance to enforce certain rules
- Without idempotency, retries create duplicates
- Bulk creation can overwhelm downstream triggers — 10,000 new records each firing a notification

**User-Facing Implications:** What does the user see while creation is processing? If async, how are they notified of success/failure? If validation fails, which fields are wrong and what's the expected format?

**See Also:** Validation process · Schema constraint · Notification process (for downstream alerts) · Regulatory constraint (consent before collecting data)

---

### Read & Query

**Access, search, and retrieve data**

Ranges from simple record lookup to complex search with relevance ranking. By-ID lookup, filtered listing, full-text search, aggregation, and export are fundamentally different operations with different performance and architectural requirements.

**Key Questions:**
- Who needs what data? (Core permissioning question)
- Simple lookup or complex search? (By ID vs. full-text vs. faceted filtering)
- How is data filtered? (By role, ownership, status, time, geography, keyword)
- Joining across sources needed?
- Expected result set size? (Single record, paginated list, bulk export)
- Pagination strategy? (Offset, cursor, keyset — each has different performance and consistency)
- How fresh must data be? (Real-time, cached, daily snapshot)
- Search relevance needed? (Exact match vs. fuzzy vs. ranked)
- Aggregation queries? (Counts, sums, averages — expensive on large datasets)
- Fields never returned? (Internal IDs, secrets, sensitive PII)
- Reads logged for audit?
- Bulk export needed? (Format, size limits, async generation)

**Pitfalls:**
- Reading at scale is where most performance problems live
- Permission checks on reads surprisingly complex
- Cross-system reads need integration infrastructure
- Over-fetching wastes bandwidth and leaks information
- N+1 query problems: list then detail for each item individually
- Search often requires separate infrastructure (search index)
- Pagination inconsistency: data changes between pages can cause missing/duplicate items
- Aggregation on large datasets may need pre-computed summaries

**User-Facing Implications:** How does the user know results are loading? What do they see for empty results vs. no permission? Can they refine search easily? Are error states clear (timeout, too many results)?

**See Also:** Access constraint (permission filtering) · Capacity constraint (query limits, pagination) · Caching patterns (read-heavy = caching opportunity) · Temporal constraint (historical queries)

---

### Update

**Modify existing data**

Changing fields, transitioning status. Identity persists, content changes. Where most business logic lives.

**Key Questions:**
- What fields changeable, under what conditions?
- Who can update which fields?
- Previous values preserved? (Audit trail, version history, changelog)
- Concurrent conflicts? (Two users editing same record)
- State transitions triggered?
- Irreversible updates?
- Atomic or partial? (Update one field or replace entire record)
- Conflict resolution strategy? (Last-write-wins, merge, lock, optimistic concurrency)
- Bulk update needed? (Mass status change, data cleanup — same partial-failure questions as bulk create)

**Pitfalls:**
- No history = lost context about what changed and why
- Concurrent updates need resolution strategy
- Some updates are really versioning (create new version + archive old)
- Field-level permission overlooked until crisis
- Cascading updates across related records
- Bulk updates can violate invariants if not checked per-record

**User-Facing Implications:** If two users edit simultaneously, who 'wins' and how does the other know? For state transitions, is it clear what actions are available from the current state? Can the user undo?

**See Also:** Validation process · Sync process (propagation to other systems) · Monitoring process (audit trail) · State Management patterns · Notification process (status change alerts)

---

### Delete

**Remove data from the system**

Destroying or marking invisible. Most use soft delete because deletion is most dangerous operation.

**Key Questions:**
- Soft or hard?
- Related data handling? (Cascade, orphan, block, nullify)
- Who can delete?
- Recovery window? (Trash, recycle bin, undo period)
- Legal retention/deletion requirements?
- Cleanup triggered? (Caches, indexes, files, related systems)
- GDPR/right-to-be-forgotten handling?
- Accidental deletion recovery?
- Bulk delete safeguards? (Confirmation, preview, undo window)

**Pitfalls:**
- Cascading across connected data
- Legal conflicts: GDPR vs. financial retention
- Soft-deleted still affects performance and storage
- Hard-deleted may persist in backups/logs/caches
- Bulk delete without confirmation is a disaster waiting to happen

**User-Facing Implications:** Is the consequence of deletion clear before confirming? Can the user undo? If deletion affects related data, is that shown? For bulk delete, can they preview what will be removed?

**See Also:** Consistency constraint (related data validity) · Regulatory constraint (retention rules) · Temporal constraint (retention/expiration lifecycle)

---

## Layer 1: Processes

Higher-order patterns that orchestrate operations into workflows. Every feature in every platform implements some combination of these.

### Transformation

**Data changes shape or format**

Input in one form → another. Most ubiquitous process type.

**Key Questions:**
- Input/output shapes?
- Lossless or lossy?
- Where does it happen? (Source, transit, destination)
- Error handling for unexpected input?
- Real-time or batch?
- Edge cases? (Null values, encoding issues, unexpected formats)

**Subtypes:**
- Format conversion — same info, different structure (CSV→JSON, XML→DB)
- Normalization — standardizing variations (address cleanup, date formats)
- Derivation — computing new values (total = price × quantity)
- Aggregation — collapsing into summaries (sum, average, count)
- Enrichment — adding from external sources (geocoding, company lookup)
- Filtering/Projection — selecting subset of fields or records

**See Also:** Schema constraint (determines valid output shapes) · Integration patterns (transformation at system boundaries)

---

### Validation

**Checking against constraints**

Constraint enforcement — defining boundaries of what's allowed.

**Key Questions:**
- Hard constraints (must be true) vs. soft (warnings)?
- When validated? (Input, before processing, before storage, continuously)
- Failure feedback to user/system?
- Role-dependent rules?
- Rules change over time? How are existing records handled?
- Server-side validation? (MUST — client-side is UX convenience only, never a security boundary)

**Subtypes:**
- Type checking — right kind of data?
- Range/boundary — within acceptable limits?
- Referential integrity — referenced record exists?
- Business rules — domain requirements met?
- Cross-field consistency — multiple fields agree?
- Uniqueness — no duplicates where required
- Input sanitization — no injection, no malicious content
- Format validation — email, phone, URL format

**User-Facing Implications:** When validation fails, does the user know exactly which field(s) failed and why? Are error messages helpful or cryptic? Can the user fix errors without re-entering everything? Is validation instant (on blur/keystroke) or only on submit?

**See Also:** Security > Data Protection (input sanitization) · Security > API Security (request validation) · Schema constraint (defines what validation enforces) · Regulatory constraint (business rules from compliance)

---

### Routing

**Directing flow based on conditions**

Decision points determining what happens next.

**Key Questions:**
- What conditions determine routing?
- Static or dynamic rules?
- No-match handling?
- Conflicting rules?
- Sequential or parallel?
- Rule maintenance and testing?

**Subtypes:**
- Conditional branching — if/else paths
- Fan-out — one input, multiple parallel paths
- Fan-in — multiple inputs converge
- Load balancing — distribute across destinations
- Priority queuing — route by urgency
- Content-based routing — route by data content

**See Also:** Orchestration process (routing within workflows) · Notification process (routing determines who gets notified)

---

### Orchestration

**Coordinating multi-step processes**

Managing sequences with dependencies, error handling, state tracking. Includes automated pipelines and human-in-the-loop workflows.

**Key Questions:**
- Step sequence? Which in order vs. parallel?
- Failure handling per step? (Retry, rollback, skip, alert, compensate)
- Duration? (Seconds to days — affects architecture)
- Human intervention needed? (Approvals, reviews, escalations)
- If human: timeout? Delegation? Reminders? Escalation chain?
- State tracking? (Where in workflow, what's completed, who's responsible)
- Cancelable or modifiable mid-flight?
- Start trigger? (Event, schedule, manual)

**Subtypes:**
- Sequential pipeline — A→B→C
- Parallel processing — simultaneous, merged
- Saga/compensation — if step 3 fails, undo 1 and 2
- State machine — defined states and transitions
- Event-driven chain — loosely coupled
- Scheduled batch — timer-based
- Approval workflow — automated + human decisions + escalation
- Review queue — items waiting for evaluation with SLA

**User-Facing Implications:** Can the user see where their request is in the process? If waiting for approval, who is it with? If stuck, can they escalate or cancel? Is there a timeline or expected duration shown?

**See Also:** Routing process (decision points within orchestration) · Notification process (human steps need notifications) · Temporal constraint (SLA windows, timeouts) · Capacity constraint (rate limits on processing speed)

---

### Notification

**Telling humans or systems that something happened**

First-class process type. Involves determining what happened, who cares, how to reach them, what to say, and respecting preferences.

**Key Questions:**
- What events trigger notifications?
- Who receives each type?
- What channel(s)?
- User preference controls?
- Content? (Template, personalization, localization)
- Delivery reliability? (Best-effort vs. guaranteed)
- Timing? (Immediate, digest, scheduled)
- Anti-spam/compliance? (Rate limits, unsubscribe, CAN-SPAM/GDPR)
- Delivery tracking?
- Escalation? (If unacknowledged)

**Subtypes:**
- Transactional — event-triggered, immediate (order confirmation, password reset)
- Digest/batch — collected periodically (daily summary)
- Broadcast — to many recipients (announcement)
- Alert/escalation — time-sensitive with acknowledgment
- Preference-driven — user controls what/when/how
- System-to-system — webhook or event to another service

**User-Facing Implications:** Can users control notification frequency and channels? Is it clear why they received a notification? Can they easily unsubscribe or adjust? Are notifications actionable (links to relevant item)?

**See Also:** Regulatory constraint (CAN-SPAM, GDPR consent for marketing) · Orchestration process (human-in-loop steps need notifications) · Monitoring process (alerts are a form of notification) · Temporal constraint (digest timing, escalation windows)

---

### Synchronization

**Keeping data consistent across systems**

One of hardest distributed systems problems.

**Key Questions:**
- Source of truth per data piece?
- Direction?
- Speed requirement?
- Conflict resolution?
- Unavailability handling?
- Verification?

**Subtypes:**
- One-way push
- One-way pull
- Bidirectional (hardest)
- Event streaming
- Periodic reconciliation
- Cache invalidation (deceptively difficult)

**See Also:** Consistency constraint (cross-system invariants) · Integration surface constraint (determines sync capability) · Caching patterns (cache invalidation is sync) · Monitoring process (verify sync health)

---

### Monitoring

**Observing state and responding**

System self-awareness — detecting problems, tracking performance, triggering responses.

**Key Questions:**
- What to detect?
- Who notified, how?
- Speed?
- History retention?
- SLA requirements?
- Signal vs. noise?

**Subtypes:**
- Health checks
- Threshold alerts
- Audit logging
- Analytics/metrics
- Anomaly detection
- SLA tracking

**See Also:** Notification process (alerts delivered through notification) · Temporal constraint (SLA windows, retention periods) · Regulatory constraint (audit requirements) · Security > Error Handling & Logging

---

## Layer 1: Constraints

Understanding constraints tells you more about what's possible than knowing the feature list.

### Access & Permission

**Who can do what to which data**

Filter on possibility space.

**Key Questions:**
- Roles and capabilities?
- Granularity level?
- Inheritance model?
- Delegatable?
- Audited?
- Default permissive or restrictive?

**Spectrum:** System-level → Feature-level → Object-level → Record-level → Field-level

**See Also:** Security > Auth & Authorization · Multi-tenancy patterns · Regulatory constraint (compliance dictates access rules)

---

### Schema & Data Model

**Structure data must conform to**

Hard constraint on what's storable/processable. Early decisions cascade through everything.

**⚠ DATA MODEL RADIATION:** Your schema choice directly affects query patterns (Read), validation rules, sync complexity, caching strategy, multi-tenancy approach, migration difficulty, and portability. When revisiting the data model, re-evaluate all of these downstream impacts.

**Key Questions:**
- Entities managed?
- Properties per entity? Required vs. optional?
- Relationships between entities?
- Fixed or flexible?
- Evolution strategy?
- Matches how users think about the domain?

**Spectrum:** Rigid (SQL) → Extensible (CRM platforms) → Flexible (document DB) → Schemaless (key-value)

**See Also:** Validation process (schema defines what validation enforces) · Migration/Evolution patterns (schema changes are the hardest) · Data Access patterns (schema shapes query approach) · Portability constraint (schema portability = data portability)

---

### Sequencing

**What must happen before what**

Temporal/logical ordering defining allowable paths.

**Key Questions:**
- Prerequisites?
- Strict or policy?
- Parallel possible?
- Bottlenecks?
- Deadlines?
- Failure handling?

**Spectrum:** Strict → Dependency graph → Soft → Unordered

---

### Consistency

**What must remain true always**

System invariants — the 'laws of physics' of your system.

**Key Questions:**
- What invariants must hold?
- Violation response?
- Immediate or eventual?
- Cross-system enforcement?
- Inconsistency consequences?
- Assumed but unenforced invariants?

**Spectrum:** Strong → Eventual → Causal → No guarantees

**See Also:** Sync process (consistency across systems) · Caching patterns (stale cache = inconsistency) · Multi-tenancy patterns (cross-tenant data isolation)

---

### Capacity

**How much and how fast**

Often invisible until hit. Changes what's practically possible.

**Key Questions:**
- Storage limits?
- Rate limits?
- Latency requirements?
- Concurrency?
- Behavior at limits?
- Cost at scale?

**Spectrum:** Fixed → Elastic → Degrading → Transparent

**See Also:** Caching patterns (caching reduces capacity pressure) · Error Handling patterns (circuit breaker, degradation at limits)

---

### Integration Surface

**How systems connect**

Often determines achievability more than internal capability.

**Key Questions:**
- APIs exposed?
- Event triggers?
- Data formats?
- Auth requirements?
- Real-time or batch?
- Reliability?
- Existing connectors?

**Spectrum:** Rich API → Limited API → Webhooks only → File import/export → Manual

**See Also:** Integration patterns (architectural approach) · Sync process (surface determines sync capability) · Secrets management (credentials for integration)

---

### Temporal

**Time-related rules and boundaries**

Time is a constraint dimension beyond sequencing. Data has lifecycles, operations have windows, users exist in time zones, scheduled processes must handle clock edge cases.

**Key Questions:**
- Retention: how long must data be kept?
- Expiration: auto-remove or archive when?
- TTL patterns: sessions, tokens, caches?
- Archival strategy?
- Timezone handling?
- Scheduling edge cases? (DST, leap seconds, clock drift)
- SLA windows?
- Audit trail retention?
- Historical/point-in-time queries needed?
- Cross-system timestamp synchronization?

**Spectrum:** Ephemeral → Active → Archived → Retained → Expired/Purged

**See Also:** Regulatory constraint (legally mandated retention/deletion) · Delete operation (retention prevents or requires deletion) · Monitoring process (SLA tracking is time-aware)

---

### Regulatory & Compliance

**Legal and policy requirements**

Externally imposed requirements with legal consequences. Identify which frameworks apply EARLY — they cascade into data model, access, audit, retention, and operations.

**Key Questions:**
- Personal data collected?
- User jurisdictions?
- Industry regulations?
- Data residency?
- Consent requirements?
- Right to access?
- Right to deletion?
- Right to portability?
- Breach notification requirements?
- Accessibility?
- Audit requirements?
- DPIA needed?

**Spectrum:** Unregulated → Privacy-regulated (GDPR, CCPA) → Industry-regulated (HIPAA, PCI-DSS) → Heavily regulated → Government/classified

**See Also:** Access constraint (compliance dictates permissions) · Temporal constraint (retention periods) · Monitoring process (audit requirements) · Notification process (breach notification, consent) · Security (all sections)

---

### Environment & Infrastructure

**Where and how your code runs**

Deployment environment constrains architecture, code structure, state management, operations. Invisible locally, load-bearing in production.

**Key Questions:**
- Compute model?
- Stateful or stateless?
- Code structure imposed?
- Max execution duration?
- Scaling model?
- Networking constraints?
- Traffic routing?
- SSL termination?
- File system access?
- Co-located services?
- Secrets delivery?
- Logging infrastructure?
- Deployment mechanism?
- Cost model?
- Vendor lock-in?
- Compliance/residency?

**Spectrum:** Serverless/FaaS → Containers (managed) → Containers (self-managed) → VPS/VM → PaaS → Static/Edge

**See Also:** Architecture patterns (environment constrains viable patterns) · Portability constraint (environment shapes lock-in) · Security > Environment Management · Cost dimensions

---

### Portability & Lock-in

**What's portable and what's trapped**

Every platform decision creates coupling. Understanding what's portable lets you make trade-offs consciously.

**Key Questions:**
- Standard vs. platform-specific code %?
- Rewrite scope if changing provider?
- Data models portable?
- API patterns portable?
- Auth portable?
- Logic in code or platform config?
- Data exportable?
- Tests runnable locally?
- Switching cost?
- Abstraction layers available?

**Spectrum:** Fully portable → Mostly portable → Partially locked → Heavily locked → Fully locked

**See Also:** Schema constraint (data portability) · Environment constraint (platform shapes lock-in) · Decision Protocol step 5 (reversible vs. irreversible)

---

## Layer 2: Architecture Patterns

Concrete implementation approaches — platform-agnostic but specific enough to make structural decisions.

### Data Flow Patterns

**Request-Response (Sync)**
- When: User action → immediate result
- How: Client sends request, waits for response.
- Trade-offs: Simple. Blocks user. Fails if slow.
- Security: Validate server-side. HTTPS. Rate limit.

**Event-Driven (Async)**
- When: Background processing, notify later
- How: Action publishes event. Workers consume independently.
- Trade-offs: Handles long processes. More complex. Must handle retries.
- Security: Auth publishers. Validate payloads. Idempotent processing.

**Pipeline (ETL/ELT)**
- When: Source → transform → destination
- How: Extract → Transform → Load.
- Trade-offs: Great for batch. Latency between change and update.
- Security: Secure credentials. Encrypt in transit. Log operations.

**API Gateway / Hub**
- When: Multiple systems, avoid point-to-point
- How: Central broker routes, transforms, handles protocols.
- Trade-offs: Single management. Single failure point.
- Security: Critical security boundary. Auth all. Rate limit. Log.

---

### State Management Patterns

**Status Field**
- When: Small number of defined phases
- How: Single field = state. Validation enforces transitions.
- Trade-offs: Simple. No history unless logged.
- Security: Validate transitions server-side.

**State Machine**
- When: Complex lifecycle with rules
- How: Explicit states, transitions, guards, permissions.
- Trade-offs: Clear rules. More upfront design.
- Security: State machine IS a security mechanism.

**Event Sourcing**
- When: Full history critical
- How: Store every event. State = replay. Immutable.
- Trade-offs: Complete audit trail. Complex.
- Security: Immutable, tamper-evident. Append-only.

---

### Integration Patterns

**Direct API Call**
- When: Real-time data from another system
- How: HTTP request, wait for response.
- Trade-offs: Simple. Tight coupling.
- Security: Keys as env vars. Least-privilege. Validate responses.

**Webhook**
- When: System B notifies System A
- How: A registers URL. B POSTs on events.
- Trade-offs: Real-time. Must verify sender.
- Security: CRITICAL: Verify signatures. HTTPS. Idempotent.

**Message Queue**
- When: Reliable async communication
- How: Producer → queue → consumer.
- Trade-offs: Decoupled. More infrastructure.
- Security: Encrypt transit+rest. Auth both sides. Dead letter queue.

**Shared Database**
- When: Multiple services, same data
- How: Multiple apps read/write same DB.
- Trade-offs: Simple. Tight coupling.
- Security: Each service own credentials, minimum permissions.

**File Exchange**
- When: No real-time or very large volumes
- How: Export → transfer → import.
- Trade-offs: Works with anything. Batch only.
- Security: Encrypt. SFTP. Validate before import.

---

### Error Handling Patterns

**Retry with Backoff**
- When: Transient failures
- How: Increasing intervals. Max attempts.
- Trade-offs: Must be idempotent.
- Security: Log retries. Alert on repeated failures.

**Circuit Breaker**
- When: Downstream consistently failing
- How: Track failures. Open circuit = fail fast.
- Trade-offs: Prevents cascade. Needs fallback.
- Security: State not user-controllable.

**Dead Letter Queue**
- When: Failed messages shouldn't be lost
- How: Failed → separate queue for investigation.
- Trade-offs: No data loss. Requires monitoring.
- Security: May contain sensitive data.

**Graceful Degradation**
- When: Part fails, rest continues
- How: Independent features. Reduced > none.
- Trade-offs: Better UX. More complex.
- Security: CRITICAL: Degraded mode must not bypass security.

---

### Caching Patterns

**Cache-Aside (Lazy Loading)**
- When: Read-heavy, infrequent changes
- How: Check cache → miss → read source → store with TTL.
- Trade-offs: Simple. Can be stale until TTL. Miss = slower.
- Security: Never cache sensitive data without encryption. Permission changes must invalidate cache.

**Write-Through**
- When: Cache must stay consistent
- How: Every write to both cache and source.
- Trade-offs: Always consistent. Slower writes.
- Security: Both cache and source must enforce same access controls.

**Write-Behind**
- When: Write-heavy, brief inconsistency OK
- How: Write cache first, async flush to source.
- Trade-offs: Fast writes. Data loss risk if cache fails before flush.
- Security: Evaluate carefully for sensitive data.

**Cache Invalidation**
- When: Stale data must be refreshed
- How: On source change, remove/update cached copies. TTL, event-based, or manual.
- Trade-offs: Getting this wrong = users see stale data.
- Security: Permission changes must invalidate — user loses access but cache serves old data = security hole.

---

### Data Access Patterns

**Direct Queries**
- When: Full control, performance-critical
- How: Application writes SQL/query language directly.
- Trade-offs: Maximum control. Tightly coupled to database.
- Security: ALWAYS parameterized queries. Never concatenate user input.

**ORM**
- When: Work with data as code objects
- How: Library maps objects to tables. Generates queries.
- Trade-offs: Faster dev. Can generate inefficient queries.
- Security: Verify parameterized queries. Don't expose ORM objects to API.

**Repository Pattern**
- When: Decouple logic from storage
- How: Abstract interface for data ops. Business logic only knows interface.
- Trade-offs: Clean separation. Easy to test. More code.
- Security: Good place to enforce access control — check permissions at boundary.

**CQRS**
- When: Read/write patterns very different
- How: Separate models for reading and writing.
- Trade-offs: Optimize each independently. Much more complex.
- Security: Both paths need independent authorization checks.

---

### Authentication Flow Patterns

**Session-Based**
- When: Traditional web, server-rendered
- How: Login → server session → cookie → lookup per request.
- Trade-offs: Simple. Requires session storage. Hard to scale across servers.
- Security: HttpOnly, Secure, SameSite cookies. Regenerate after login. CSRF protection.

**Token-Based (JWT)**
- When: SPAs, mobile, API-first, stateless
- How: Login → signed token → client stores → sends in header → server validates.
- Trade-offs: Stateless (scales). Can't revoke until expiry.
- Security: Short expiry. Secure storage. Validate signature AND claims. Refresh tokens.

**OAuth2 / OIDC**
- When: Delegate auth to provider, third-party access
- How: Redirect to IdP → authenticate → redirect back with code → exchange for tokens.
- Trade-offs: No password handling. Depends on provider. Complex flow.
- Security: Auth code + PKCE. Validate state. Verify issuer/audience. No implicit flow.

**API Key**
- When: Service-to-service, developer APIs
- How: Pre-shared secret in request header.
- Trade-offs: Simple. No user context. Full access if leaked.
- Security: HTTPS only. Store hashed. Scope permissions. Rotate. Log usage.

**Machine Auth**
- When: Backend service-to-service
- How: Mutual TLS, client credentials, or rotating secrets.
- Trade-offs: No human. Must automate credentials.
- Security: Mutual TLS strongest. Auto-rotate. Monitor unauthorized calls.

---

### Multi-tenancy Patterns

**Shared DB, Shared Schema**
- When: Cost-efficient, many tenants, simple isolation
- How: All tenants in same tables, tenant_id column. Every query filters.
- Trade-offs: Cheapest. Risk if filter forgotten. Hard to customize per-tenant.
- Security: CRITICAL: Every query MUST filter by tenant. Missing WHERE = data breach. Use row-level security.

**Shared DB, Separate Schemas**
- When: Moderate isolation, some customization
- How: Same server, each tenant own schema. App switches based on auth.
- Trade-offs: Better isolation. Per-schema migrations. Moderate cost.
- Security: Schema-level permissions. Verify correct schema per connection.

**Separate Databases**
- When: Strongest isolation, regulated industries
- How: Each tenant own database. App routes by tenant.
- Trade-offs: Strongest isolation. Most expensive. Ops scales with tenants.
- Security: Strongest boundary. Own credentials per DB. Routing failure = wrong tenant's data.

---

### Migration & Evolution Patterns

**Expand/Contract (Schema)**
- When: Need to change database schema without downtime
- How: Expand: add new column/table alongside old. Migrate data. Contract: remove old after all code uses new. Two deploys minimum.
- Trade-offs: Zero-downtime schema changes. More deploys. Temporary duplication.
- Security: Both old and new paths must enforce same validation and access controls during transition.

**Blue-Green Deployment**
- When: Deploy new version with instant rollback
- How: Two identical environments. Deploy to inactive. Switch traffic. Old stays ready.
- Trade-offs: Instant rollback. Double infrastructure during transition. DB compatibility required.
- Security: Both environments must have correct security config. Don't leave old running with stale secrets.

**Feature Flags**
- When: Deploy code without activating features. Gradual rollout.
- How: Code behind flag. Flag controls who sees it. Turn off instantly if problems.
- Trade-offs: Deploy and activate are separate. More conditionals. Flag cleanup debt.
- Security: Flags must not be user-controllable unless intentional. Don't bypass security for testing.

**Dual-Write / Shadow Mode**
- When: Migrating systems, need to verify new before switching
- How: Write to both. Read from old. Compare results. Switch when confident.
- Trade-offs: Validates with real data. Double write load. Comparison logic needed.
- Security: Both systems need consistent auth. Sensitive data now in two places.

**Strangler Fig**
- When: Gradually replacing legacy system
- How: New handles new functionality. Gradually redirect existing from old to new.
- Trade-offs: Low risk (incremental). Can take long. Need routing layer.
- Security: Auth consistent across old and new. Boundary must not be security gap.

---

## Layer 3: Security & Production Readiness

MUST = non-negotiable before production. SHOULD = strongly recommended.

### Authentication & Authorization

- **[MUST]** Auth method implemented — OAuth 2.0, sessions, JWT, API keys. Use a provider when possible. See Architecture > Auth Flows.
- **[MUST]** Passwords hashed (bcrypt/scrypt/Argon2) — NEVER plaintext. NEVER MD5/SHA-1.
- **[MUST]** Secure session management — HttpOnly cookies. Secure flag. SameSite. Timeout. Regenerate after login. Invalidation on logout.
- **[MUST]** API auth on all endpoints — Every endpoint returning/modifying data must verify identity.
- **[MUST]** Authorization on every request — Auth = WHO. Authorization = WHAT. Check both every time. Broken authorization = #1 API vulnerability.
- **[MUST]** Rate limiting on auth endpoints — Login, registration, reset — rate limited vs brute force.
- **[SHOULD]** MFA available — Especially admin and sensitive operations.
- **[SHOULD]** Token refresh strategy — Short-lived access + longer refresh. Rotate on use.

### Data Protection

- **[MUST]** HTTPS everywhere — All TLS. No HTTP. HSTS header.
- **[MUST]** Sensitive data encrypted at rest — DB + files. Passwords, tokens, PII, financial, health.
- **[MUST]** Input validation and sanitization — ALL input server-side. Parameterized queries. Sanitize HTML. See also: Validation process, API Security.
- **[MUST]** Output encoding — Encode before rendering in HTML, URLs, JS. Prevents XSS.
- **[MUST]** No sensitive data in URLs — Logged by servers, proxies, browser history.
- **[MUST]** No sensitive data in client storage — No tokens/PII in localStorage. HttpOnly cookies.
- **[MUST]** Backups encrypted — Common attack vector. Test restores.
- **[SHOULD]** Data minimization — Only collect what you need. Less data = less breach risk.

### CORS

- **[MUST]** Understand what CORS is — Browser blocks cross-origin API calls unless server explicitly allows it. Protects users from malicious sites using their credentials against your API.
- **[MUST]** Allowed origins explicitly listed — Your exact frontend domain(s). NEVER wildcard (*) with credentials.
- **[MUST]** Methods and headers restricted — Only allow what your API actually uses.
- **[MUST]** Credentials mode understood — If using cookies: Allow-Credentials = true AND origin must be explicit.
- **[SHOULD]** Preflight caching — Set Access-Control-Max-Age to reduce OPTIONS overhead.

### File Upload Security

- **[MUST]** File type validated server-side — Check actual content (magic bytes), not just extension.
- **[MUST]** File size limits enforced — At web server, application, and storage level.
- **[MUST]** Files stored outside web root — Serve through application with access checks.
- **[MUST]** Filenames sanitized — Never use user-provided filename. Prevent path traversal.
- **[MUST]** Content-Type headers correct when serving — Prevents browser from executing uploads.
- **[SHOULD]** Malware scanning — Scan before processing.
- **[SHOULD]** Image re-encoding — Strip embedded malicious content.

### API Security

- **[MUST]** Request size limits — Max body size per endpoint. Different for upload vs JSON.
- **[MUST]** Response filtering — Never return internal fields, DB columns, debug info.
- **[MUST]** Request validation — Validate shape, reject unknown fields, enforce types. See: Validation process.
- **[MUST]** Error responses don't leak info — No stack traces, DB errors, file paths. Generic error + request ID.
- **[SHOULD]** Rate limiting per consumer — Per-user/per-key. 429 with Retry-After.
- **[SHOULD]** API versioning strategy — How deprecated? Can't remove insecure old version if consumers depend on it. See: Migration patterns.
- **[SHOULD]** Pagination enforced — Never unbounded results. See: Read operation.

### Secrets Management

- **[MUST]** No secrets in code or git — Check git history for past leaks.
- **[MUST]** Env vars for config — Different per environment.
- **[MUST]** .env excluded from git — Provide .env.example with placeholders.
- **[MUST]** Client code is PUBLIC — Secret calls through server.
- **[MUST]** Secrets delivery pattern understood — Env var, mounted file, or API call to manager — each has different rotation properties.
- **[SHOULD]** Rotation plan — Keys rotatable without downtime.
- **[SHOULD]** Least-privilege keys — Each service minimum permissions.
- **[SHOULD]** Production secrets manager — Dedicated manager for sensitive deployments.

### Environment Management

- **[MUST]** Separate environments — Local, staging, production minimum.
- **[MUST]** No production data in dev — Seed/anonymized only.
- **[MUST]** Environment-specific config — DB URLs, endpoints, flags, log levels differ.
- **[SHOULD]** Deployment documented and repeatable — Automated > manual.
- **[SHOULD]** Rollback capability — Test before needed. See: Migration patterns.
- **[SHOULD]** DB migration strategy — Version-controlled, tested, reversible. See: Migration patterns.

### Error Handling & Logging

- **[MUST]** Structured error handling — Try/catch externals. No stack traces to users.
- **[MUST]** No sensitive data in errors or logs — Never log passwords, tokens, CC numbers. Mask/redact.
- **[SHOULD]** Centralized logging — All logs to one place. Structured JSON.
- **[SHOULD]** Error alerting — Critical errors notify team immediately.
- **[SHOULD]** Request ID tracing — Unique ID per request through all steps.
- **[SHOULD]** Health check endpoint — Monitoring can verify app running.

### Dependency Security

- **[MUST]** Lock files in version control — Reproducible builds.
- **[SHOULD]** Regular dependency audit — Address critical/high vulnerabilities.
- **[SHOULD]** Minimize dependencies — Every dep = potential vulnerability.
- **[SHOULD]** Automated vulnerability scanning — Dependabot, Snyk.

### Production Readiness

- **[MUST]** HTTPS enforced — SSL cert. Redirect. HSTS.
- **[MUST]** DNS configured — Domain pointing. Propagation confirmed.
- **[MUST]** DB backed up and tested — Automated. Restore verified.
- **[MUST]** All env vars set — All secrets present. No dev values.
- **[MUST]** Error monitoring active — Tracking + alerts.
- **[MUST]** CORS correct — Only your domains.
- **[MUST]** Legal compliance — Privacy, ToS, cookies, GDPR/CCPA. See Regulatory constraint.
- **[SHOULD]** Rate limiting — Different for auth/unauth.
- **[SHOULD]** CSP headers — Prevents XSS and injection.
- **[SHOULD]** Uptime monitoring — External check. Alert when down.
- **[SHOULD]** Incident response plan — Who, communication, runbooks.
- **[SHOULD]** Performance baseline — Know normal. Alert on deviation.

### Cost Awareness

- **[SHOULD]** Compute costs identified — Per-request, per-hour, per-container. Understand your cost unit.
- **[SHOULD]** Storage costs identified — DB, files, backups, logs. Data grows over time.
- **[SHOULD]** Bandwidth/transfer costs — Between services, to users, between regions.
- **[SHOULD]** Third-party API costs — Per-call pricing. Volume can surprise you.
- **[SHOULD]** Operational cost (human time) — Maintenance, monitoring, incidents. Cheapest to build may be most expensive to run.
- **[SHOULD]** Cost trajectory understood — Linear with users? With data? Know what drives largest cost.

---

## Layer 4: Project Lifecycle

Different concerns dominate at different stages. Each phase includes key questions, deliverables, testing guidance, confidence checks, common mistakes, and decision junctures.

### Phase 1: Discovery & Planning

**Focus: Get the domain model right.**

**Key Questions:**
- Core entities and relationships?
- Primary workflows?
- User roles and needs?
- Hard constraints? (Technical, regulatory, business)
- Systems to integrate?
- Existing data?
- Regulatory frameworks?

**Deliverables:**
- Entity relationship map
- Roles and capabilities
- Workflow descriptions
- Integration inventory
- Constraint inventory
- Regulatory assessment
- Initial decision records

**Testing:**
- No code yet — document expected behaviors (become test cases later)
- Define acceptance criteria: how will you know each workflow is 'done'?

**Confidence Check:**
- What am I assuming about the domain that I haven't verified?
- Are there stakeholders I haven't consulted who will have requirements?
- Am I confident about which regulations apply, or should I verify?
- What about this domain am I least familiar with?
- What would change my technology or data layer recommendation?

**Common Mistakes:**
- Coding before understanding domain
- Assuming requirements
- Edge cases before happy path
- Integrating before core works
- Over-engineering
- Ignoring regulatory requirements until late

**Decision Junctures:**

> **Technology Selection:** What language/framework for the core?
> Evaluate: Team skills · Library ecosystem · Deployment target compatibility · Community quality · Maintenance trajectory · Operational burden
> ⚠ Choose based on: can you ship and maintain this?

> **Data Layer Selection:** Where and how will data be stored?
> Evaluate: Data shape · Query patterns · Scale expectations · Environment compatibility · Portability · Operational burden
> ⚠ Hardest thing to change later. Get right early. See Schema constraint — data model radiation.

---

### Phase 2: Prototyping & Core Build

**Focus: Data flowing through happy path.**

**Key Questions:**
- Data model supports workflows?
- CRUD working?
- Workflows complete E2E?
- Basic validation?
- Can demo core value?
- Simplest working auth?

**Deliverables:**
- Working data model
- CRUD for core entities
- One complete E2E workflow
- Basic validation
- Basic auth
- Seed data
- Data model documentation
- API documentation

**Testing:**
- Test core data ops (CRUD correct?)
- Test primary workflow E2E
- Test with realistic volume
- Verify auth works — authenticated in, unauthenticated out

**Confidence Check:**
- Does my data model actually support the workflows, or am I force-fitting?
- Am I building what was requested or what I think was requested?
- What's the riskiest assumption in my prototype?
- If I showed this to a user right now, what would confuse them?

**Common Mistakes:**
- Perfecting UI before data works
- All features before any E2E
- Skipping auth
- Unrealistic test data volume
- No version control

**Decision Junctures:**

> **Auth Strategy:** How will users prove identity?
> Evaluate: Deployment target IdP? · Role complexity · Internal vs. external · Compliance · Build vs. provider · Token strategy
> ⚠ Auth is load-bearing. Always harder to add later.

> **API Design:** How will consumers talk to backend?
> Evaluate: Environment constraints? · REST/GraphQL/RPC by access patterns · Versioning · Auth method · Rate limiting · Documentation
> ⚠ API is a contract. Changing it means coordinating all consumers.

> **Prototype-to-Production:** What survives into production?
> Evaluate: What shortcuts are now tech debt? · Scale assumptions hold? · Data model need revision? · Auth sufficient? · What worked?
> ⚠ Prototype's purpose is to learn, not to ship. Be willing to rebuild.

---

### Phase 3: Integration & Expansion

**Focus: Systems talking reliably.**

**Key Questions:**
- Data between systems?
- Source of truth per piece?
- Failure handling?
- Timing dependencies?
- Monitoring?
- Rate limits?

**Deliverables:**
- Working integrations
- Error handling all points
- Retry logic
- Monitoring/alerting
- Integration docs
- Secondary workflows
- Notification system

**Testing:**
- Test with external service unavailable
- Test rate limit handling
- Test malformed external responses
- Test retry logic
- Test notification delivery
- Verify idempotency

**Confidence Check:**
- Have I actually tested what happens when each integration fails?
- Am I handling all error responses the external API can return?
- Is my sync strategy actually keeping data consistent, or am I assuming it is?
- What happens if the external service changes their API?

**Common Mistakes:**
- Assuming APIs always up
- No error handling
- Not handling rate limits
- Tight coupling
- No event logging
- Insecure credentials

**Decision Junctures:**

> **Integration Architecture:** How will systems connect?
> Evaluate: Real-time vs. batch? · Reliability · Volume · Available surfaces · Transformation complexity · Monitoring
> ⚠ Every integration is a failure point. Design for failure.

> **Sync Strategy:** Data consistency across systems?
> Evaluate: Authoritative source? · Conflict resolution? · Latency tolerance? · Recovery? · Idempotency?
> ⚠ Bidirectional sync is order-of-magnitude harder. Avoid unless needed.

---

### Phase 4: Security Hardening

**Focus: Close gaps. Test failure modes.**

**Key Questions:**
- User access unauthorized data?
- Unauthorized actions?
- Malicious input?
- Secrets managed?
- Under load?
- Dependency failures?

**Deliverables:**
- All MUST security items
- Permission testing every endpoint/role
- Input validation all inputs
- Secrets audit
- Load testing
- Error handling tested
- Security headers
- File upload security
- API security review

**Testing:**
- Every endpoint unauthenticated (should fail)
- Every endpoint as wrong role (should fail/filter)
- SQL injection, XSS, oversized inputs
- Concurrent ops (race conditions)
- Load test critical paths
- Dependencies killed (DB, API, queue down)
- Verify audit logs capture events

**Confidence Check:**
- Have I tested as every role, not just admin?
- Have I actually tried to break my own auth — not just tested that it works?
- Am I confident no secrets are in git history?
- What's my weakest security point right now?

**Common Mistakes:**
- Only happy path
- Auth provider ≠ all security
- Client code is public
- Git history secrets
- Admin-only testing
- Ignoring dep vulnerabilities

**Decision Junctures:**

> **Security vs. Velocity:** What's non-negotiable for launch?
> Evaluate: Data sensitivity? · User profile · Breach blast radius · Regulatory · All MUST items non-negotiable · SHOULD by risk × impact
> ⚠ 'Security later' is the most expensive sentence in software.

---

### Phase 5: Production Deployment

**Focus: Deploy safely. Monitor. Ready to roll back.**

**Key Questions:**
- Production Readiness complete?
- Rollback tested?
- Monitoring active before launch?
- 48-hour response plan?
- Communication plan?
- Gradual rollout?

**Deliverables:**
- Production configured
- SSL verified
- Monitoring active
- Backup tested
- Rollback tested
- Response plan
- Launch comms
- Operational runbook

**Testing:**
- Production matches staging
- Rollback actually executed
- Monitoring catches test error
- Backup restore works
- Smoke test after deploy
- SSL valid and redirects work

**Confidence Check:**
- Is production truly configured identically to staging?
- If something breaks in the first hour, do I know who to contact and what to do?
- Have I actually tested rollback or just planned it?
- What's my biggest worry about this deployment?

**Common Mistakes:**
- Friday afternoon deploy
- No monitoring
- No rollback plan
- Missing env vars
- Untested migrations
- All-at-once launch

**Decision Junctures:**

> **Deployment Architecture:** How does code get to production?
> Evaluate: What target accepts? · Automation level? · Fix speed? · Rollback? · Staging? · Zero-downtime?
> ⚠ Deploy pipeline is daily infrastructure. Invest in reliability.

> **Environment Parity:** How closely does local match production?
> Evaluate: Same DB engine? · Same auth? · Same constraints? · Can reproduce prod issues? · Staging faithful?
> ⚠ Every difference = potential surprise.

---

### Phase 6: Operations & Evolution

**Focus: Monitor, maintain, iterate.**

**Key Questions:**
- Recurring maintenance?
- Bug prioritization?
- Safe feature addition?
- Dependencies current?
- Performance trending?
- Documentation sufficient?

**Deliverables:**
- Operational runbook
- Incident response docs
- Dep update schedule
- Performance dashboards
- Decision records current
- Documentation maintained
- Backup verification
- Dependency audit results

**Testing:**
- Continuous: error rates, response times, resource anomalies
- Regular: dep audit, critical vuln fixes
- Regular: backup restore verification
- Per-change: staging before prod
- Per-change: monitoring catches regressions

**Confidence Check:**
- If I left this project tomorrow, could someone else maintain it from the documentation?
- When was the last dependency audit?
- Am I ignoring any slow-growing problems?
- What's the biggest risk to this system right now that I'm not actively addressing?

**Common Mistakes:**
- Set and forget
- Years without dep updates
- No docs — bus factor 1
- Testing in production
- Ignoring degradation

**Decision Junctures:**

> **Evolution Strategy:** How to add features without breaking things?
> Evaluate: Feature flags? · DB migration strategy? · API versioning? · Testing for regressions? · Monitoring for regressions?
> ⚠ Safest change is smallest change. Ship small, verify, repeat. See Migration patterns.

---

## Decision Protocol

When choosing between approaches, use this framework. Specific junctures are embedded in each Lifecycle phase, but this is the general protocol.

**Step 1: Name the decision explicitly.** Write it as a question. Vague decisions produce vague outcomes.

**Step 2: Identify the constraints.** What's already decided? Environment, skills, budget, timeline, compliance, integrations. Reference Constraints — especially Environment, Portability, Regulatory.

**Step 3: Enumerate options.** Realistic choices that satisfy constraints. Research current capabilities. Don't evaluate yet — list.

**Step 4: Evaluate on dimensions.** Per option: Immediate need? Future constraints imposed? Portability? Security? Operational burden (can you RUN it, not just build it)? Learning curve? Cost trajectory across all dimensions (compute, storage, bandwidth, APIs, human time)?

**Step 5: Reversible vs. irreversible.** CSS framework = easy to change. Database engine = extremely hard. Spend proportional time. Agonize over irreversible, move fast on reversible.

**Step 6: Decide and document.** Choose. Record using the template below.

### Anti-patterns

- Choosing technology before understanding the problem
- Optimizing for the wrong dimension
- Assuming current constraints are permanent (over-engineering)
- Assuming current constraints will change (under-engineering)
- Copying another company's architecture without understanding their context
- Making irreversible decisions quickly, reversible ones slowly (should be opposite)
- Not documenting — future you won't know why
- Choosing most technically interesting over most appropriate

### Decision Record Template

Document significant decisions. Store alongside project.

```
Decision: [What was decided, clearly stated]
Date: [When decided]
Context: [Situation and constraints that prompted this]
Options Considered: [Alternatives evaluated]
Choice & Reasoning: [Selected option and why]
Consequences: [What this enables, constrains, and trades off]
Revisit Triggers: [When to reconsider this decision]
```

---

## Connections Map

Nothing operates in isolation. A problem in one area often has root cause in a connected area.

- Create → Validate: Must pass constraints
- Create → Transform: Input reshaped before storage
- Create → Route: Triggers workflows
- Create → Notify: May trigger notifications
- Read → Transform: Reformatted for display
- Read → Access: Permissions filter visibility
- Read → Caching: Read-heavy = caching opportunity
- Update → Validate: Changes satisfy constraints
- Update → Sync: Propagates to other systems
- Update → Monitor: Generates audit trail
- Update → Notify: Status changes trigger alerts
- Delete → Consistency: Related data must stay valid
- Delete → Regulatory: Retention may prevent/require deletion
- Delete → Temporal: Expiration governs lifecycle
- Orchestrate → Route: Routing at decision points
- Orchestrate → Notify: Human steps need notifications
- Sync → Consistency: Cross-system invariants
- Schema → Validate: Schema defines validation
- Schema → Migration: Schema changes require migration patterns
- Schema → Everything: Data model radiates into all other decisions
- Capacity → Caching: Caching reduces capacity pressure
- Integration → Sync: Surface determines sync capability
- Environment → All Patterns: Deployment constrains viable patterns
- Portability → All Decisions: Lock-in shapes every choice
- Temporal → Monitor: SLA windows, retention periods
- Regulatory → Access: Compliance dictates permissions
- Regulatory → Monitor: Audit requirements shape logging
- Auth → All Ops: Every op verifies identity+permission
- Secrets → Integration: Credentials enable cross-system access
- Logging → Monitor: Feeds monitoring and alerting
- Cost → All Decisions: Cost trajectory shapes every architectural choice

---

## Analysis Guide

Five-phase walkthrough for approaching any project.

### 1. Understand Domain

Before any system, understand what you're working with.

- **Core entities?** What 'things' does this deal with?
- **How do entities relate?** Map the relationships.
- **Entity lifecycles?** States each goes through.
- **Who are the actors?** Roles and needs.
- **Core workflows?** End-to-end processes.
- **Regulations?** Privacy, industry, accessibility — identify early.

### 2. Map Data Flow

Trace how data enters, moves, exits.

- **Origins?** User input, API, sensor, import?
- **Transformations?** How does data change shape?
- **Destinations?** Displays, reports, other systems?
- **Handoffs?** What changes at system boundaries?
- **Source of truth?** Which wins when they disagree?
- **Notifications?** Who must know when things happen?

### 3. Identify Constraints

What limits what's possible.

- **Hard constraints?** Regulatory, physical, data model.
- **Platform constraints?** Rate limits, gaps, pricing.
- **Environment?** Compute, networking, scaling.
- **Temporal?** Retention, expiration, timezones.
- **Permissions & compliance?** Who sees what, legally.
- **Human?** Skills, maintenance, learning curve.

### 4. Design Solution

Match process types to constraints.

- **Process types needed?** Map each step to atlas.
- **Platform matches?** Built-in or build/integrate?
- **Gaps?** Integration/custom points.
- **Caching?** What benefits? Invalidation?
- **Failure modes?** What when each step fails?
- **Testing?** What tests per phase?

### 5. Evaluate Trade-offs

Make trade-offs explicit.

- **Build vs. buy vs. connect?** Cost/flexibility/maintenance.
- **Flexibility vs. reliability?** More flexible = harder reliable.
- **Portability vs. convenience?** Features vs. lock-in.
- **Simplicity vs. capability?** Worth the complexity?
- **What don't you know?** Gaps needing research before deciding.

---

## Platform Assessment

9 dimensions to systematically evaluate any platform or tool.

### 01. Data Model
Entity flexibility? — Custom types? · Custom fields? · Field types? · Relationships? · Limits? · Evolution?

### 02. Operations
CRUD granularity? — API vs UI? · Bulk ops? · Partial updates? · Delete types? · Query/search? · Pagination?

### 03. Automation
What's automatable? — Triggers? · Actions? · Multi-step? · Conditions? · Loops? · Failure handling?

### 04. Permissions
Access granularity? — Level? · Custom roles? · Record visibility? · Field-level? · Inheritance? · External access?

### 05. Integration
Connection capability? — API type? · Webhooks? · Connectors? · Formats? · Rate limits? · SDK?

### 06. Environment
Infrastructure? — Compute model? · Scaling? · Networking? · File system? · Secrets? · Cost model?

### 07. Portability
Lock-in profile? — Code portable? · Data exportable? · Standard protocols? · Abstraction? · Switching cost? · Multi-cloud?

### 08. Developer Experience
Productivity? — Docs quality? · Community? · Tooling? · Local dev? · Debugging? · Learning resources?

### 09. Operational Model
Day-to-day burden? — What breaks? · Support? · Incident path? · Maintenance? · Upgrades? · Vendor viability?

---

*Platform-agnostic reference. Designed as thinking scaffold and AI agent reference document for any codebase at any stage.*
