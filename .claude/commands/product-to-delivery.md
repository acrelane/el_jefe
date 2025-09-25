# Product-to-Delivery Pipeline

Complete workflow from product idea to deployed feature across all repositories.

**Phase 1: Product Definition**
Use product-owner subagent to:
- Define business requirements and user stories
- Set success metrics and acceptance criteria
- Prioritize features and create Linear epic
- Research market opportunities and competitive landscape

**Phase 2: Requirements Analysis**
Use requirements-analyst subagent to:
- Analyze technical feasibility across platforms
- Identify edge cases and constraints
- Define technical acceptance criteria
- Document requirements in Linear with technical specifications

**Phase 3: Task Generation**
Use task-generator subagent to:
- Auto-discover available repository specialists
- Break down Linear epic into actionable tasks
- Map dependencies and sequencing in Linear
- Assign tasks to appropriate specialist subagents

**Phase 4: Technical Orchestration**
Use master-orchestrator subagent to:
- Coordinate implementation across repositories
- Navigate between repos to delegate tasks
- Manage integration points and dependencies
- Track progress through Linear updates

**Phase 5: Release Management**
Use release-manager subagent to:
- Coordinate multi-repository deployments
- Monitor rollout and success metrics
- Plan iteration based on feedback
- Document release outcomes

**Usage:**
```
Execute product-to-delivery for "[product idea/epic description]"
```

**Example:**
```
Execute product-to-delivery for "AI-powered personalized workout recommendations that sync between mobile app and admin dashboard"
```

This will trigger the complete pipeline from product definition through deployment across all discovered repositories.
