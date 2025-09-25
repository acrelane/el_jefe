#!/usr/bin/env node

/**
 * Agent Discovery Utility for El_Jefe
 * Dynamically discovers Claude Code subagents across sibling repositories
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

/**
 * Discover all Claude Code subagents in sibling repositories
 * @returns {Object} Map of repository names to their available agents
 */
function discoverAgents() {
  try {
    console.log('🔍 Discovering Claude Code agents across repositories...\n');
    
    // Find all .claude/agents directories in sibling repos
    const agentDirs = execSync('find ../ -path "*/.claude/agents" -type d 2>/dev/null', 
      { encoding: 'utf8' }).trim().split('\n').filter(Boolean);
    
    if (agentDirs.length === 0) {
      console.log('❌ No .claude/agents directories found in sibling repositories');
      return {};
    }

    const repoAgents = {};
    
    agentDirs.forEach(dir => {
      const repoPath = path.dirname(path.dirname(dir));
      const repoName = repoPath.split('/').pop();
      
      console.log(`📁 Scanning repository: ${repoName}`);
      
      try {
        const agentFiles = execSync(`find "${dir}" -name "*.md" 2>/dev/null`, 
          { encoding: 'utf8' }).trim().split('\n').filter(Boolean);
        
        repoAgents[repoName] = agentFiles.map(file => {
          const content = fs.readFileSync(file, 'utf8');
          const nameMatch = content.match(/^name:\s*(.+)$/m);
          const descMatch = content.match(/^description:\s*(.+)$/m);
          const toolsMatch = content.match(/^tools:\s*(.+)$/m);
          const modelMatch = content.match(/^model:\s*(.+)$/m);
          
          const agent = {
            name: nameMatch ? nameMatch[1].trim() : path.basename(file, '.md'),
            description: descMatch ? descMatch[1].trim() : 'No description available',
            tools: toolsMatch ? toolsMatch[1].trim().split(',').map(t => t.trim()) : [],
            model: modelMatch ? modelMatch[1].trim() : 'inherit',
            file: file,
            repository: repoName
          };
          
          console.log(`  ✅ ${agent.name}: ${agent.description.substring(0, 60)}...`);
          return agent;
        });
        
        console.log(`  📊 Found ${repoAgents[repoName].length} agents in ${repoName}\n`);
        
      } catch (error) {
        console.log(`  ❌ Error scanning ${repoName}: ${error.message}\n`);
        repoAgents[repoName] = [];
      }
    });
    
    return repoAgents;
    
  } catch (error) {
    console.error('❌ Error discovering agents:', error.message);
    return {};
  }
}

/**
 * Generate a summary report of discovered agents
 * @param {Object} repoAgents - Map of repositories to agents
 */
function generateSummaryReport(repoAgents) {
  console.log('📋 AGENT DISCOVERY SUMMARY');
  console.log('========================\n');
  
  const totalRepos = Object.keys(repoAgents).length;
  const totalAgents = Object.values(repoAgents).reduce((sum, agents) => sum + agents.length, 0);
  
  console.log(`📁 Repositories discovered: ${totalRepos}`);
  console.log(`🤖 Total agents available: ${totalAgents}\n`);
  
  if (totalAgents === 0) {
    console.log('❌ No agents found. Make sure sibling repositories have .claude/agents/ directories with .md files.');
    return;
  }
  
  // Group agents by capability/type
  const agentsByType = {};
  Object.values(repoAgents).flat().forEach(agent => {
    const type = agent.name.includes('backend') ? 'Backend' :
                 agent.name.includes('mobile') || agent.name.includes('ios') || agent.name.includes('android') ? 'Mobile' :
                 agent.name.includes('ai') || agent.name.includes('ml') || agent.name.includes('crew') ? 'AI/ML' :
                 agent.name.includes('test') ? 'Testing' :
                 agent.name.includes('deploy') || agent.name.includes('devops') ? 'DevOps' :
                 agent.name.includes('ui') || agent.name.includes('frontend') ? 'Frontend' :
                 'General';
    
    if (!agentsByType[type]) agentsByType[type] = [];
    agentsByType[type].push(agent);
  });
  
  console.log('🏷️  AGENTS BY CATEGORY:');
  Object.entries(agentsByType).forEach(([type, agents]) => {
    console.log(`\n${type} (${agents.length}):`);
    agents.forEach(agent => {
      console.log(`  • ${agent.name} (${agent.repository})`);
    });
  });
  
  console.log('\n🚀 COORDINATION RECOMMENDATIONS:');
  console.log('• Use master-orchestrator to coordinate cross-repo features');
  console.log('• Use task-generator to create Linear tickets with agent assignments');
  console.log('• Navigate to specific repos to invoke specialist subagents');
  console.log('• Use release-manager for multi-repo deployment coordination\n');
}

/**
 * Find agents by capability or name
 * @param {Object} repoAgents - Map of repositories to agents
 * @param {string} query - Search query
 */
function findAgents(repoAgents, query) {
  const results = [];
  const queryLower = query.toLowerCase();
  
  Object.values(repoAgents).flat().forEach(agent => {
    if (agent.name.toLowerCase().includes(queryLower) || 
        agent.description.toLowerCase().includes(queryLower)) {
      results.push(agent);
    }
  });
  
  return results;
}

// CLI interface
if (require.main === module) {
  const args = process.argv.slice(2);
  const command = args[0];
  
  const repoAgents = discoverAgents();
  
  switch (command) {
    case 'summary':
    case undefined:
      generateSummaryReport(repoAgents);
      break;
      
    case 'json':
      console.log(JSON.stringify(repoAgents, null, 2));
      break;
      
    case 'search':
      const query = args[1];
      if (!query) {
        console.log('Usage: node discover-agents.js search <query>');
        process.exit(1);
      }
      const results = findAgents(repoAgents, query);
      console.log(`🔍 Search results for "${query}":`);
      results.forEach(agent => {
        console.log(`• ${agent.name} (${agent.repository}): ${agent.description}`);
      });
      break;
      
    case 'help':
      console.log(`
El_Jefe Agent Discovery Utility

Usage:
  node discover-agents.js [command]

Commands:
  (none)     Show summary report of discovered agents
  summary    Show detailed summary with recommendations
  json       Output raw JSON data
  search <query>  Search for agents by name or description
  help       Show this help message

Examples:
  node discover-agents.js
  node discover-agents.js search backend
  node discover-agents.js json | jq '.["backend-admin"]'
      `);
      break;
      
    default:
      console.log(`Unknown command: ${command}`);
      console.log('Run "node discover-agents.js help" for usage information.');
      process.exit(1);
  }
}

module.exports = { discoverAgents, findAgents };
