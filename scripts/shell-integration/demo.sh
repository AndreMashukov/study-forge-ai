#!/bin/bash
# Demo script to showcase VS Code Shell Integration features
# Run this in a VS Code terminal to see the integration in action

set -e

echo "🚀 VS Code Shell Integration Demo"
echo "=================================="
echo

# Show current integration status
echo "📊 Current Integration Status:"
echo "TERM_PROGRAM: $TERM_PROGRAM"
echo "VSCODE_SHELL_INTEGRATION: $VSCODE_SHELL_INTEGRATION"
echo "Current Shell: $SHELL"
echo

# Show workspace context
echo "📁 Workspace Context:"
echo "Current Directory: $(pwd)"
if [[ "$PWD" == *"study-forge-ai"* ]]; then
    echo "✅ Inside study-forge-ai workspace"
else
    echo "⚠️  Not in workspace root"
fi
echo

# Demonstrate command decorations by running successful and failing commands
echo "🎨 Testing Command Decorations:"
echo "Running successful command..."
echo "Hello from successful command!" >&1

echo "Running command that will fail..."
false 2>/dev/null || echo "This demonstrates how failed commands are decorated"
echo

# Show available Nx commands
echo "⚡ Available Nx Commands:"
echo "- npx nx serve web    (start web dev server)"
echo "- npx nx build web    (build web app)" 
echo "- npx nx test web     (run tests)"
echo "- npx nx lint         (lint all projects)"
echo

# Show workspace shortcuts
echo "🔧 Workspace Shortcuts (when shell integration is loaded):"
echo "- nx, nxb, nxt, nxl   (Nx command shortcuts)"
echo "- cdweb, cdfunctions  (quick navigation)"
echo

echo "💡 Features to Try:"
echo "- Press Ctrl/Cmd+Up/Down to navigate between commands"
echo "- Hover over the left margin to see command decorations" 
echo "- Try typing 'npx nx ' and use Tab for autocompletion"
echo "- Use Ctrl/Cmd+Alt+R for command history search"
echo

echo "✨ Setup Complete! Your terminal now has enhanced VS Code integration."
echo "To get the full experience, run: npm run setup-shell-integration"