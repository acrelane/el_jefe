#!/bin/bash

# MCP Developer Profile Configuration Script
# Enables: All tools including Playwright, Linear, Notion, Byterover
# For developers, QA engineers, and technical team members

echo "💻 Setting up MCP Developer Profile..."

# Get the script's directory (where the project is)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

CONFIG_FILE=".claude/mcp-config.json"
AGENTS_DIR=".claude/agents"
AGENTS_BACKUP=".claude/agents-backup"
DEVELOPER_AGENTS=".claude/agents-developer"

# Backup existing config
if [ -f "$CONFIG_FILE" ]; then
  cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
  echo "✅ Backed up existing MCP config"
fi

# Handle agents directory
if [ -d "$AGENTS_DIR" ] && [ ! -L "$AGENTS_DIR" ]; then
  # Backup original agents directory if it exists and is not a symlink
  if [ ! -d "$AGENTS_BACKUP" ]; then
    mv "$AGENTS_DIR" "$AGENTS_BACKUP"
    echo "✅ Backed up original agents directory"
  fi
elif [ -L "$AGENTS_DIR" ]; then
  # Remove existing symlink
  rm "$AGENTS_DIR"
fi

# Create symlink to developer agents
ln -s "agents-developer" "$AGENTS_DIR"
echo "✅ Switched to developer agent profile"

# Create developer profile configuration
cat > "$CONFIG_FILE" << 'EOF'
{
  "servers": [
    {
      "name": "byterover-mcp",
      "type": "http",
      "url": "https://mcp.byterover.dev/v2/mcp"
    },
    {
      "name": "linear-server",
      "type": "sse",
      "url": "https://mcp.linear.app/sse"
    },
    {
      "name": "playwright",
      "type": "stdio",
      "command": "npx",
      "args": [
        "@playwright/mcp@latest"
      ],
      "env": {}
    }
  ]
}
EOF

echo "✅ Developer profile configured!"
echo ""
echo "📋 Enabled MCP Servers:"
echo "  • Linear - Issue tracking, project management"
echo "  • Byterover - Knowledge management and memory"
echo "  • Playwright - Browser automation, E2E testing"
echo ""
echo "🤖 Active Agents (42):"
echo "  AI & ML (5):"
echo "    • AI Engineer, ML Engineer, MLOps Engineer, Prompt Engineer, Context Manager"
echo "  Data (5):"
echo "    • Data Engineer, Data Scientist, Database Admin, Database Optimizer, SQL Pro"
echo "  Development (8):"
echo "    • Frontend Developer, Full Stack Dev, FastAPI Pro, Python Pro"
echo "    • TypeScript Pro, JavaScript Pro, Payment Integration, iOS Developer"
echo "  DevOps (3):"
echo "    • Deployment Engineer, DevOps Troubleshooter, Observability Engineer"
echo "  Quality & Security (9):"
echo "    • QA Expert, Test Automator, Debugger, Error Detective"
echo "    • Performance Engineer, UI Visual Validator"
echo "    • Backend/Frontend/Mobile Security Coders"
echo "  Tech Leadership (10):"
echo "    • Architect Review, Backend/Cloud/GraphQL Architects"
echo "    • API Designer, API Documenter, Code Reviewer"
echo "    • Docs Architect, Legacy Modernizer, TDD Orchestrator"
echo "  Design (2):"
echo "    • UI/UX Designer"
echo ""
echo "ℹ️  MCP servers use HTTP/SSE endpoints (API keys handled by Claude)"
echo ""
echo "🔄 Restart Claude to apply changes"
