#!/bin/bash

# Script to copy CI/CD configuration files to your GitHub repository
# Usage: ./copy-to-repo.sh /path/to/your/Secure-CI-CD-Pipeline-with-SonarQube-and-GitHub-Actions

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if target directory is provided
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Usage: $0 /path/to/your/repository${NC}"
    echo -e "${YELLOW}Example: $0 ~/Secure-CI-CD-Pipeline-with-SonarQube-and-GitHub-Actions${NC}"
    exit 1
fi

TARGET_DIR="$1"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Target directory does not exist: $TARGET_DIR${NC}"
    echo -e "${YELLOW}Please clone your repository first:${NC}"
    echo "git clone https://github.com/your-username/Secure-CI-CD-Pipeline-with-SonarQube-and-GitHub-Actions.git"
    exit 1
fi

echo -e "${BLUE}🚀 Copying CI/CD configuration files to your repository...${NC}"

# Create directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p "$TARGET_DIR/.github/workflows"
mkdir -p "$TARGET_DIR/sonarqube"
mkdir -p "$TARGET_DIR/scripts"
mkdir -p "$TARGET_DIR/docs"
mkdir -p "$TARGET_DIR/examples"

# Copy main documentation
echo -e "${BLUE}📚 Copying documentation...${NC}"
cp README.md "$TARGET_DIR/"
cp DEPLOYMENT_GUIDE.md "$TARGET_DIR/"

# Copy GitHub workflows
echo -e "${BLUE}⚙️ Copying GitHub Actions workflows...${NC}"
cp .github/workflows/ci-cd-pipeline.yml "$TARGET_DIR/.github/workflows/"
cp .github/workflows/security-scan.yml "$TARGET_DIR/.github/workflows/"

# Copy SonarQube configuration
echo -e "${BLUE}🔍 Copying SonarQube configuration...${NC}"
cp sonarqube/sonar-project.properties "$TARGET_DIR/sonarqube/"

# Copy setup scripts
echo -e "${BLUE}🔧 Copying setup scripts...${NC}"
cp scripts/setup-sonarqube.sh "$TARGET_DIR/scripts/"
chmod +x "$TARGET_DIR/scripts/setup-sonarqube.sh"

# Copy documentation
echo -e "${BLUE}📖 Copying additional documentation...${NC}"
cp docs/SECURITY.md "$TARGET_DIR/docs/"
cp docs/TROUBLESHOOTING.md "$TARGET_DIR/docs/"

# Copy examples
echo -e "${BLUE}📋 Copying configuration examples...${NC}"
cp examples/sonar-scanner-config.json "$TARGET_DIR/examples/"

# Copy this script for reference
cp copy-to-repo.sh "$TARGET_DIR/"
chmod +x "$TARGET_DIR/copy-to-repo.sh"

echo -e "${GREEN}✅ All files copied successfully!${NC}"
echo ""
echo -e "${BLUE}📝 Next steps:${NC}"
echo "1. cd $TARGET_DIR"
echo "2. Review and customize the files for your specific needs"
echo "3. Set up GitHub secrets (see DEPLOYMENT_GUIDE.md)"
echo "4. git add ."
echo "5. git commit -m 'Add comprehensive CI/CD pipeline for Gig-Rush platform'"
echo "6. git push origin main"
echo ""
echo -e "${YELLOW}📖 Don't forget to read DEPLOYMENT_GUIDE.md for detailed setup instructions!${NC}"
echo ""
echo -e "${GREEN}🎉 Your Gig-Rush platform is ready for enterprise-grade CI/CD!${NC}"