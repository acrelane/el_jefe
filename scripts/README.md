# MCP Profile Scripts

These scripts allow you to quickly switch between different Claude Code configurations tailored for different team roles.

## Available Profiles

### Product Profile (`mcp-product-profile.sh`)
**For**: Product managers, designers, and non-technical team members

**MCP Servers**:
- **Linear** - Issue tracking and project management
- **Notion** - Documentation, specs, and meeting notes
- **Byterover** - Knowledge management and memory

**Agents (17)**:
- **Product**: Product Owner, Requirements Analyst, Business Analyst
- **Tech Leadership**: Architect Review, Backend Architect, Cloud Architect, API Designer, API Documenter, GraphQL Architect, Code Reviewer, Docs Architect, Legacy Modernizer, TDD Orchestrator
- **Data**: Data Scientist
- **Marketing & Support**: Content Marketer, Customer Support
- **Design**: UI/UX Designer

### Developer Profile (`mcp-developer-profile.sh`)
**For**: Developers, QA engineers, and technical team members

**MCP Servers**:
- **Linear** - Issue tracking and project management
- **Byterover** - Knowledge management and memory
- **Playwright** - Browser automation and E2E testing

**Agents (42)**:
- **AI & ML (5)**: AI Engineer, ML Engineer, MLOps Engineer, Prompt Engineer, Context Manager
- **Data (5)**: Data Engineer, Data Scientist, Database Admin, Database Optimizer, SQL Pro
- **Development (8)**: Frontend Developer, Full Stack Dev, FastAPI Pro, Python Pro, TypeScript Pro, JavaScript Pro, Payment Integration, iOS Developer
- **DevOps (3)**: Deployment Engineer, DevOps Troubleshooter, Observability Engineer
- **Quality & Security (9)**: QA Expert, Test Automator, Debugger, Error Detective, Performance Engineer, UI Visual Validator, Backend/Frontend/Mobile Security Coders
- **Tech Leadership (10)**: Architect Review, Backend/Cloud/GraphQL Architects, API Designer, API Documenter, Code Reviewer, Docs Architect, Legacy Modernizer, TDD Orchestrator
- **Design (2)**: UI/UX Designer

## Usage

### From Within Project Directory

```bash
# Switch to product profile
./scripts/mcp-product-profile.sh

# Switch to developer profile
./scripts/mcp-developer-profile.sh
```

### Global Commands (From Any Terminal)

```bash
# Launch Claude in el_jefe with developer profile
jefe-dev

# Launch Claude in el_jefe with product profile
jefe-product
```

These global commands will automatically:
1. Navigate to ~/acrelane/el_jefe
2. Activate the appropriate MCP profile
3. Launch Claude Code in the el_jefe directory

**Setup**: The global commands are installed in `~/bin/` and added to your PATH automatically.

Each script will:
1. Back up your existing MCP configuration (with timestamp)
2. Back up original agents directory (first time only)
3. Switch MCP servers configuration
4. Switch active agents via symlink
5. Show confirmation of enabled servers and agents

After running either script, **restart Claude** to apply the changes.

## API Keys

API keys are handled automatically by Claude through HTTP/SSE connections to:
- Byterover: `https://mcp.byterover.dev/v2/mcp`
- Linear: `https://mcp.linear.app/sse`
- Notion: `https://mcp.notion.com/mcp`

No environment variables needed - authentication is managed by Claude Code.

## How It Works

### MCP Configuration
Scripts update `.claude/mcp-config.json` in the project directory with the appropriate MCP server configurations.

### Agent Switching
The scripts use symlinks to switch between agent profiles:
- `.claude/agents` → symlink to active profile
- `.claude/agents-product/` → product profile agents
- `.claude/agents-developer/` → developer profile agents
- `.claude/agents-backup/` → original agents (backup, created first time)

## Adding Custom Agents

### To Product Profile
Add agent markdown files to `.claude/agents-product/`

### To Developer Profile
Add agent markdown files to `.claude/agents-developer/`

### To Both Profiles
Add the agent file to both directories.

## Troubleshooting

**Issue**: "Permission denied" when running script
```bash
chmod +x scripts/mcp-product-profile.sh scripts/mcp-developer-profile.sh
```

**Issue**: Changes not applying
- Make sure you **restarted Claude** after running the script
- Check that MCP config was created: `cat .claude/mcp-config.json`

**Issue**: Can't switch back to original agents
- The original agents are backed up to `.claude/agents-backup/`
- Remove the symlink: `rm .claude/agents`
- Restore: `mv .claude/agents-backup .claude/agents`

## Configuration Files

- **MCP Config**: `.claude/mcp-config.json` (in project directory)
- **MCP Config Backups**: Same directory with `.backup.YYYYMMDD_HHMMSS` suffix
- **Agent Config**: `.claude/agents` (symlink)
- **Agent Backups**: `.claude/agents-backup/` (created on first run)
