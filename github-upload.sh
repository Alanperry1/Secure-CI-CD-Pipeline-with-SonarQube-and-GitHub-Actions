#!/bin/bash

# GitHub Repository Upload Script for CI/CD Pipeline
# This script helps you upload all configuration files to your GitHub repository

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 GitHub Repository Upload Assistant${NC}"
echo "============================================"

# Get repository details
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (Secure-CI-CD-Pipeline-with-SonarQube-and-GitHub-Actions): " REPO_NAME
REPO_NAME=${REPO_NAME:-"Secure-CI-CD-Pipeline-with-SonarQube-and-GitHub-Actions"}

echo -e "${YELLOW}📋 You'll need your GitHub token ready for authentication${NC}"
echo -e "${YELLOW}💡 Tip: You can set it as an environment variable: export GITHUB_TOKEN=your_token${NC}"

# Create a temporary working directory
WORK_DIR="temp_upload_$(date +%s)"
mkdir -p "$WORK_DIR"

echo -e "${BLUE}📁 Preparing files for upload...${NC}"

# Copy all files to the working directory
cp -r .github "$WORK_DIR/"
cp -r sonarqube "$WORK_DIR/"
cp -r scripts "$WORK_DIR/"
cp -r docs "$WORK_DIR/"
cp -r examples "$WORK_DIR/"
cp README.md "$WORK_DIR/"
cp DEPLOYMENT_GUIDE.md "$WORK_DIR/"
cp copy-to-repo.sh "$WORK_DIR/"

# Create git commands file
cat > "$WORK_DIR/upload_commands.sh" << 'EOF'
#!/bin/bash

# Initialize git repository if not already done
if [ ! -d ".git" ]; then
    git init
    git remote add origin https://github.com/GITHUB_USERNAME/REPO_NAME.git
fi

# Configure git (update with your details)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add all files
git add .

# Commit with descriptive message
git commit -m "Add comprehensive CI/CD pipeline with SonarQube integration for Gig-Rush platform

Features:
- GitHub Actions workflows for CI/CD and security scanning
- SonarQube integration optimized for Node.js/GraphQL/Socket.IO
- Automated setup scripts and comprehensive documentation
- Security-focused pipeline for marketplace applications
- MongoDB and JWT authentication support"

# Push to repository (will prompt for token if not set as env var)
git push -u origin main

echo "✅ Files uploaded successfully to GitHub!"
EOF

# Replace placeholders in the upload script
sed -i "s/GITHUB_USERNAME/$GITHUB_USERNAME/g" "$WORK_DIR/upload_commands.sh"
sed -i "s/REPO_NAME/$REPO_NAME/g" "$WORK_DIR/upload_commands.sh"
chmod +x "$WORK_DIR/upload_commands.sh"

echo -e "${GREEN}✅ Files prepared in directory: $WORK_DIR${NC}"
echo ""
echo -e "${BLUE}📋 Next Steps:${NC}"
echo "1. cd $WORK_DIR"
echo "2. Review the files (optional)"
echo "3. Run: ./upload_commands.sh"
echo "4. Enter your GitHub token when prompted"
echo ""
echo -e "${YELLOW}🔑 Authentication Options:${NC}"
echo "Option A: Set environment variable first:"
echo "  export GITHUB_TOKEN=your_github_token"
echo "  ./upload_commands.sh"
echo ""
echo "Option B: Git will prompt you for credentials during push"
echo ""
echo -e "${BLUE}🧹 Cleanup:${NC}"
echo "After successful upload, you can remove the temp directory:"
echo "rm -rf $WORK_DIR"

# Show the commands to run
echo ""
echo -e "${GREEN}🚀 Ready to upload! Run these commands:${NC}"
echo -e "${YELLOW}cd $WORK_DIR && ./upload_commands.sh${NC}"