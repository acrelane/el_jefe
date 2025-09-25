# Epic Breakdown Workflow

Breaks down a Linear epic into detailed, actionable tasks across multiple repositories.

**Process:**
1. **Epic Analysis**: Read existing Linear epic and understand scope
2. **Repository Discovery**: Auto-discover available specialist subagents
3. **Task Creation**: Generate detailed Linear issues with assignments
4. **Dependency Mapping**: Create Linear dependencies and blockers
5. **Specialist Assignment**: Recommend appropriate subagents for each task

**Usage:**
```
Break down Linear epic [EPIC-ID] into cross-repo tasks
```

**What this creates:**
- Detailed Linear issues for each repository
- Clear assignment recommendations to specialist subagents
- Dependency mapping between cross-repo tasks
- Integration and testing task specifications
- Effort estimates and timeline projections

**Example:**
```
Break down Linear epic PROD-456 "User Authentication Overhaul" into cross-repo tasks
```

This will create backend API tasks, mobile UI tasks, AI integration tasks, and coordination tasks with proper Linear dependencies.
