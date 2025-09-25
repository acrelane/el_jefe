# El_Jefe 🎯

**The Boss** - Stateless orchestration hub for Claude Code subagents across multiple repositories.

El_Jefe (Spanish for "The Boss") is a lightweight, stateless coordination system that auto-discovers Claude Code subagents across your repositories and orchestrates complex, cross-repo development workflows through Linear integration.

## 🏗️ Architecture

El_Jefe operates as a **stateless orchestration hub** with these key principles:

- **🔍 Dynamic Discovery**: Auto-discovers repositories and their specialist subagents at runtime
- **📋 Linear Integration**: All task management and state handled through Linear MCP
- **🚀 Zero Configuration**: Works with any repository structure without hardcoded assumptions  
- **🔄 Stateless Operation**: No persistent project files, completely dynamic coordination
- **🎯 Specialist Delegation**: Routes tasks to the most appropriate subagent specialists

## 📁 Repository Structure

```
El_Jefe/
├── .claude/
│   ├── agents/                     # Orchestration specialists
│   │   ├── product-owner.md        # Product strategy & requirements
│   │   ├── requirements-analyst.md # Technical feasibility analysis
│   │   ├── task-generator.md       # Linear task creation & assignment
│   │   ├── master-orchestrator.md  # Cross-repo coordination
│   │   └── release-manager.md      # Multi-repo deployment
│   └── commands/                   # Workflow automation
│       ├── product-to-delivery.md  # End-to-end feature pipeline
│       ├── epic-breakdown.md       # Epic → tasks workflow
│       └── cross-repo-feature.md   # Multi-repo coordination
├── scripts/
│   └── discover-agents.js          # Agent discovery utility
└── README.md
```

## 🤖 Orchestration Specialists

### Product Owner
- Defines product strategy and user requirements
- Creates Linear epics with business context
- Sets success metrics and acceptance criteria
- Coordinates stakeholder communication

### Requirements Analyst  
- Analyzes technical feasibility across platforms
- Identifies edge cases and constraints
- Translates business requirements to technical specs
- Documents requirements in Linear with technical details

### Task Generator
- Auto-discovers available repository specialists
- Breaks down Linear epics into actionable tasks
- Creates cross-repo coordination tasks
- Assigns tasks to appropriate specialist subagents

### Master Orchestrator
- **The Boss** - coordinates all cross-repo activities
- Dynamically discovers available repositories and agents
- Navigates between repos to delegate tasks
- Manages integration points and dependencies
- Tracks progress through Linear integration

### Release Manager
- Coordinates multi-repository deployments
- Manages deployment sequencing and dependencies
- Monitors rollout success and handles rollbacks
- Tracks release metrics and outcomes

## 🚀 Quick Start

1. **Clone El_Jefe** as a sibling to your other repositories:
   ```bash
   git clone [this-repo] El_Jefe
   cd El_Jefe
   ```

2. **Set up Linear MCP integration** (configure in your Claude Code setup)

3. **Discover available agents** across your repositories:
   ```bash
   node scripts/discover-agents.js
   ```

4. **Start orchestrating**:
   ```bash
   claude-code "Execute product-to-delivery for 'AI-powered user recommendations'"
   ```

## 🔍 Agent Discovery

El_Jefe automatically discovers Claude Code subagents in sibling repositories:

```bash
# Run discovery utility
node scripts/discover-agents.js

# Search for specific agents
node scripts/discover-agents.js search backend

# Get raw JSON output
node scripts/discover-agents.js json
```

**Example Discovery Output:**
```
🔍 Discovering Claude Code agents across repositories...

📁 Scanning repository: backend-admin
  ✅ backend-architect: API design & implementation specialist...
  ✅ database-expert: Schema design & query optimization...
  📊 Found 4 agents in backend-admin

📁 Scanning repository: mobile-app  
  ✅ react-native-expert: Mobile app development specialist...
  ✅ ios-specialist: iOS-specific implementation...
  📊 Found 4 agents in mobile-app

📋 AGENT DISCOVERY SUMMARY
📁 Repositories discovered: 3
🤖 Total agents available: 12
```

## 🌊 Workflow Examples

### Complete Product-to-Delivery Pipeline
```bash
claude-code "Execute product-to-delivery for 'Social login integration with biometric authentication'"
```

This triggers:
1. **Product Owner**: Define requirements and Linear epic
2. **Requirements Analyst**: Technical feasibility and constraints  
3. **Task Generator**: Break down into cross-repo Linear tasks
4. **Master Orchestrator**: Coordinate implementation across repos
5. **Release Manager**: Deploy and monitor success metrics

### Epic Breakdown
```bash
claude-code "Break down Linear epic PROD-123 into cross-repo tasks"
```

### Cross-Repo Feature Implementation
```bash
claude-code "Implement cross-repo feature 'Real-time collaborative editing' with coordination"
```

## 🎯 Integration with Your Repositories

El_Jefe works with **any repository structure** that has Claude Code subagents:

**Expected Repository Structure:**
```
your-repo/
├── .claude/
│   └── agents/
│       ├── specialist-1.md
│       ├── specialist-2.md
│       └── specialist-3.md
└── src/
```

**Supported Repositories:**
- Backend/API services  
- Mobile applications (React Native, iOS, Android)
- AI/ML systems (CrewAI, model training, data pipelines)
- Frontend applications
- DevOps and infrastructure
- Any repository with Claude Code subagents

## 📋 Linear Integration

All task management and project state is handled through Linear:

- **Epics**: High-level product initiatives
- **Issues**: Individual development tasks  
- **Dependencies**: Cross-repo task coordination
- **Projects**: Multi-repo feature tracking
- **Labels**: Repository and specialist assignments
- **Comments**: Specialist recommendations and progress updates

## 🔧 Configuration

El_Jefe is **zero-configuration** by design. It dynamically adapts to:

- Any number of sibling repositories
- Any Claude Code subagent configurations
- Any Linear project structure
- Any deployment pipeline setup

## 🎪 Advanced Usage

### Chaining Multiple Specialists
```bash
claude-code "Use requirements-analyst to validate technical feasibility, then use task-generator to create Linear breakdown, then use master-orchestrator to coordinate implementation"
```

### Repository-Specific Coordination
```bash
claude-code "Use master-orchestrator to coordinate mobile and backend teams for real-time sync feature"
```

### Release Coordination
```bash  
claude-code "Use release-manager to coordinate deployment of Linear epic PROD-456 across all repositories"
```

## 🤝 Contributing

1. **Add New Orchestration Specialists**: Create new agent `.md` files in `.claude/agents/`
2. **Enhance Discovery**: Improve `scripts/discover-agents.js` for better repository scanning
3. **Create Workflow Commands**: Add new coordination patterns in `.claude/commands/`
4. **Improve Linear Integration**: Enhance MCP integration for better project management

## 📄 License

MIT License - Feel free to adapt El_Jefe for your own multi-repo coordination needs!

---

**El_Jefe** - Because every distributed development team needs a boss who knows where all the specialists are and how to get things done! 🎯🤖
