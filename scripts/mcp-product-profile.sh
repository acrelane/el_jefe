#!/bin/bash

# MCP Product Profile Configuration Script
# Enables: Linear, Notion, Byterover (memory management)
# For product managers, designers, and non-technical team members

echo "🎯 Setting up MCP Product Profile..."

# Get the script's directory (where the project is)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

CONFIG_FILE=".claude/mcp-config.json"
AGENTS_DIR=".claude/agents"
AGENTS_BACKUP=".claude/agents-backup"
PRODUCT_AGENTS=".claude/agents-product"

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

# Create symlink to product agents
ln -s "agents-product" "$AGENTS_DIR"
echo "✅ Switched to product agent profile"

# Create product profile configuration
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
      "name": "notion",
      "type": "http",
      "url": "https://mcp.notion.com/mcp"
    }
  ]
}
EOF

echo "✅ Product profile configured!"
echo ""
echo "📋 Enabled MCP Servers:"
echo "  • Linear - Issue tracking, project management"
echo "  • Notion - Documentation, specs, meeting notes"
echo "  • Byterover - Knowledge management and memory"
echo ""
echo "🤖 Active Agents (17):"
echo "  Product:"
echo "    • Product Owner, Requirements Analyst, Business Analyst"
echo "  Tech Leadership:"
echo "    • Architect Review, Backend Architect, Cloud Architect"
echo "    • API Designer, API Documenter, GraphQL Architect"
echo "    • Code Reviewer, Docs Architect, Legacy Modernizer, TDD Orchestrator"
echo "  Data:"
echo "    • Data Scientist"
echo "  Marketing & Support:"
echo "    • Content Marketer, Customer Support"
echo "  Design:"
echo "    • UI/UX Designer"
echo ""
echo "ℹ️  MCP servers use HTTP/SSE endpoints (API keys handled by Claude)"
echo ""
echo "🔄 Restart Claude to apply changes"
