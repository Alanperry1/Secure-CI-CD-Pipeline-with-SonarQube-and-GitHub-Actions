# Secure CI/CD Pipeline for Gig-Rush Platform

[![CI/CD Pipeline](https://github.com/your-org/gig-rush/workflows/CI%2FCD%20Pipeline/badge.svg)](https://github.com/your-org/gig-rush/actions)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=gig-rush-mvp&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=gig-rush-mvp)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=gig-rush-mvp&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=gig-rush-mvp)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=gig-rush-mvp&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=gig-rush-mvp)

## 📋 Table of Contents

- [Overview](#overview)
- [Project Architecture](#project-architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [GitHub Actions Setup](#github-actions-setup)
- [SonarQube Integration](#sonarqube-integration)
- [Security Configuration](#security-configuration)
- [Environment Variables](#environment-variables)
- [Testing Strategy](#testing-strategy)
- [Deployment Pipeline](#deployment-pipeline)
- [Monitoring & Quality Gates](#monitoring--quality-gates)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## 🔍 Overview

This repository provides a comprehensive CI/CD pipeline specifically designed for the **Gig-Rush** platform - a local gig marketplace application built with modern Node.js technologies. The pipeline ensures code quality, security, and reliable deployments for this GraphQL-powered application.

### 🏗️ Gig-Rush Platform Features

- 💼 **Local Gig Marketplace**: Connect job posters with workers in their area
- 📍 **Location-Based Matching**: MongoDB geospatial queries for nearby opportunities
- 💬 **Real-time Chat**: Socket.IO powered communication between users
- 🔐 **Secure Authentication**: JWT-based user authentication
- 📊 **GraphQL API**: Modern API layer with Apollo Server
- 🗄️ **MongoDB Integration**: Robust data persistence with Mongoose

### 🚀 CI/CD Pipeline Features

- ✅ **Node.js Optimized**: Tailored for ES modules and modern JavaScript
- 🔒 **Security-First**: Dependency scanning, SAST, and vulnerability assessment
- 📊 **Quality Gates**: Code coverage, complexity, and maintainability checks
- 🚀 **Automated Deployment**: Seamless deployment to production environments
- 💬 **Real-time Monitoring**: Socket.IO and GraphQL endpoint health checks
- 🗄️ **Database Migration**: Safe MongoDB schema updates

## 🏗️ Project Architecture

The Gig-Rush platform uses the following technology stack:

```
┌─────────────────────────────────────────────────────────────┐
│                    Gig-Rush Platform                        │
├─────────────────────────────────────────────────────────────┤
│  Frontend (Mobile/Web)                                     │
│  ├── React Native / React.js                              │
│  └── Socket.IO Client (Real-time chat)                    │
├─────────────────────────────────────────────────────────────┤
│  Backend API Layer                                         │
│  ├── Express.js Server                                    │
│  ├── Apollo GraphQL Server                                │
│  ├── Socket.IO Server (Chat & Notifications)             │
│  └── JWT Authentication                                    │
├─────────────────────────────────────────────────────────────┤
│  Data Layer                                                │
│  ├── MongoDB (Users, Gigs, Messages)                      │
│  ├── Mongoose ODM                                         │
│  └── Geospatial Indexing                                  │
├─────────────────────────────────────────────────────────────┤
│  Security & Validation                                     │
│  ├── Arcjet (Rate limiting & Security)                    │
│  ├── Joi (Data validation)                                │
│  └── bcryptjs (Password hashing)                          │
└─────────────────────────────────────────────────────────────┘
```

## 📋 Prerequisites

Before setting up the CI/CD pipeline, ensure you have:

### Required Accounts & Access
- [ ] GitHub repository with Actions enabled
- [ ] SonarQube Community Edition instance or SonarCloud account
- [ ] MongoDB Atlas account (for production database)
- [ ] Admin access to your repository
- [ ] Access to deployment platform (Heroku, AWS, etc.)

### Development Environment
- [ ] Node.js 18+ installed locally
- [ ] npm or yarn package manager
- [ ] Git installed locally
- [ ] MongoDB running locally (for development)
- [ ] Docker (optional, for local SonarQube setup)

## 🚀 Quick Start

1. **Clone this CI/CD configuration to your Gig-Rush project**
   ```bash
   git clone https://github.com/your-org/gig-rush-cicd.git
   cd gig-rush-cicd
   ```

2. **Set up SonarQube project for Gig-Rush**
   - Create a new project in SonarQube with key: `gig-rush-mvp`
   - Generate a project token
   - Note your organization key (if using SonarCloud)

3. **Configure GitHub Secrets for Gig-Rush**
   Add these secrets to your Gig-Rush repository settings:
   ```bash
   # SonarQube Configuration
   SONAR_TOKEN=your_sonarqube_token
   SONAR_HOST_URL=https://sonarcloud.io

   # MongoDB Configuration (for production)
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/gig-rush
   
   # JWT Configuration
   JWT_SECRET=your_jwt_secret_key
   
   # Environment Configuration
   NODE_ENV=production
   PORT=3000
   CORS_ORIGIN=https://your-frontend-domain.com
   ```

4. **Copy workflow files to your Gig-Rush repository**
   ```bash
   cp -r .github/ /path/to/your/gig-rush/
   cp sonarqube/sonar-project.properties /path/to/your/gig-rush/
   ```

5. **Customize configuration for Gig-Rush**
   - Update `sonar-project.properties` with Gig-Rush specific settings
   - Configure GraphQL and Socket.IO health checks
   - Set up MongoDB connection tests
   - Commit and push changes

## ⚙️ GitHub Actions Setup

### Gig-Rush Specific Workflow Structure

Our CI/CD pipeline is optimized for the Gig-Rush Node.js application:

1. **Main CI/CD Pipeline** (`.github/workflows/ci-cd-pipeline.yml`)
   - **Node.js Setup**: Configures Node.js 18+ with npm caching
   - **Dependency Installation**: Runs `npm ci` for reliable builds
   - **Linting**: ESLint checks for JavaScript/ES module standards
   - **Testing**: Jest tests with coverage for GraphQL resolvers and Socket.IO
   - **SonarQube Analysis**: Code quality and security scanning
   - **Database Tests**: MongoDB connection and geospatial query validation

2. **Security Scanning** (`.github/workflows/security-scan.yml`)
   - **npm audit**: Node.js dependency vulnerability scanning
   - **Snyk Security**: Advanced dependency and container scanning
   - **SAST Analysis**: Static code analysis for authentication flows
   - **Secret Detection**: Scans for exposed API keys and tokens

3. **Gig-Rush Specific Checks**
   - **GraphQL Schema Validation**: Ensures schema compatibility
   - **Socket.IO Connection Tests**: Validates real-time features
   - **MongoDB Health Checks**: Database connectivity verification
   - **JWT Token Validation**: Authentication security tests

### Workflow Triggers

```yaml
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 2 * * 1'  # Weekly security scan
  workflow_dispatch:      # Manual trigger for deployments
```

## 🔐 SonarQube Integration for Gig-Rush

### Quick Setup with SonarCloud

For the Gig-Rush platform, we recommend using SonarCloud for comprehensive analysis:

1. **Create SonarCloud Account for Gig-Rush**
   - Visit [sonarcloud.io](https://sonarcloud.io)
   - Sign in with your GitHub account
   - Import your Gig-Rush repository

2. **Configure Gig-Rush Project**
   - Set project key: `gig-rush-mvp`
   - Choose your organization
   - Enable JavaScript/Node.js analysis
   - Configure quality gate for GraphQL and Socket.IO code

3. **Generate Token for CI/CD**
   - Go to Account > Security > Generate Token
   - Name it "gig-rush-cicd-token"
   - Copy the token for GitHub Secrets

### Gig-Rush Specific Quality Rules

The platform includes custom rules for:

```javascript
// GraphQL resolver security
sonar.javascript.globals=resolvers,typeDefs,context

// Socket.IO event validation
sonar.javascript.file.suffixes=.js,.socket.js

// MongoDB query optimization
sonar.javascript.lcov.reportPaths=coverage/lcov.info

// JWT token security scanning
sonar.security.hotspots.inheritFromParent=true
```

### Self-Hosted SonarQube Setup

For enterprise Gig-Rush deployments:

```bash
# Using our Gig-Rush optimized setup script
./scripts/setup-sonarqube.sh --port 9000 --version 9.9.2-community

# Or manually with Docker for Gig-Rush
docker run -d --name gig-rush-sonarqube \
  -p 9000:9000 \
  -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
  sonarqube:9.9.2-community
```

## 🔒 Security Configuration

### Gig-Rush Security Focus Areas

The security pipeline specifically targets vulnerabilities common in marketplace platforms:

#### 1. Authentication & Authorization
```yaml
- name: JWT Security Scan
  run: |
    # Check for hardcoded secrets in JWT implementation
    grep -r "secret" src/ --exclude-dir=node_modules
    # Validate JWT token expiration settings
    npm audit --audit-level high
```

#### 2. Database Security
```yaml
- name: MongoDB Security Check
  run: |
    # Check for NoSQL injection vulnerabilities
    echo "Scanning for potential NoSQL injection patterns..."
    # Validate geospatial query security
    npm run test:security:db
```

#### 3. Real-time Communication Security
```yaml
- name: Socket.IO Security Validation
  run: |
    # Check for XSS in real-time chat
    # Validate room access controls
    npm run test:security:socket
```

### Required Security Secrets

Add these to your GitHub repository secrets:

```bash
# Core Application Secrets
JWT_SECRET=your_super_secure_jwt_secret_key_here
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/gig-rush

# Security Tool Integration
SONAR_TOKEN=your_sonarqube_token
SNYK_TOKEN=your_snyk_security_token

# Rate Limiting & Protection
ARCJET_KEY=your_arcjet_security_key
```

## 📊 Testing Strategy for Gig-Rush

### Test Categories

#### 1. Unit Tests
```bash
# GraphQL Resolvers
npm run test:resolvers

# MongoDB Models & Methods
npm run test:models

# Socket.IO Event Handlers
npm run test:socket

# Authentication Middleware
npm run test:auth
```

#### 2. Integration Tests
```bash
# API Integration Tests
npm run test:integration:api

# Database Integration
npm run test:integration:db

# Real-time Communication
npm run test:integration:socket
```

#### 3. End-to-End Tests
```bash
# Complete Gig Lifecycle
npm run test:e2e:gig-flow

# User Authentication Flow
npm run test:e2e:auth-flow

# Chat & Notifications
npm run test:e2e:chat-flow
```

### Coverage Requirements

For Gig-Rush platform quality gates:
- **Minimum Coverage**: 80%
- **Critical Path Coverage**: 95% (auth, payments, location)
- **Security-Sensitive Code**: 100%

## 🚀 Deployment Pipeline

### Environment Strategy

#### Development Environment
```yaml
- name: Deploy to Development
  if: github.ref == 'refs/heads/develop'
  run: |
    # Deploy to development server
    npm run deploy:dev
    # Run smoke tests
    npm run test:smoke:dev
```

#### Staging Environment
```yaml
- name: Deploy to Staging
  if: github.ref == 'refs/heads/main'
  run: |
    # Deploy to staging with production-like data
    npm run deploy:staging
    # Run full integration tests
    npm run test:integration:staging
```

#### Production Deployment
```yaml
- name: Deploy to Production
  if: github.ref == 'refs/heads/main' && github.event_name == 'push'
  environment: production
  run: |
    # Blue-green deployment for zero downtime
    npm run deploy:production:blue-green
    # Health checks for GraphQL and Socket.IO
    npm run health:check:production
```

### Database Migration Strategy

```yaml
- name: Database Migration
  run: |
    # Run MongoDB migrations safely
    npm run db:migrate:check
    npm run db:migrate:run
    # Verify geospatial indexes
    npm run db:verify:geo-indexes
```

## 📈 Monitoring & Quality Gates

### Quality Gate Configuration for Gig-Rush

#### Code Quality Metrics
- **Complexity**: Maximum cyclomatic complexity of 10
- **Duplication**: Less than 3% duplicated code
- **Maintainability**: Rating A or B required

#### Security Metrics
- **Vulnerabilities**: Zero high/critical vulnerabilities
- **Security Hotspots**: 100% reviewed
- **Authentication**: All auth flows must pass security scan

#### Coverage Metrics
- **Overall Coverage**: Minimum 80%
- **New Code Coverage**: Minimum 85%
- **Critical Paths**: 100% coverage required

### Health Check Endpoints

```javascript
// GraphQL Health Check
query HealthCheck {
  health {
    status
    database
    socketIO
    timestamp
  }
}

// REST Health Check
GET /health
{
  "status": "healthy",
  "services": {
    "mongodb": "connected",
    "socketio": "active",
    "graphql": "operational"
  },
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

## 🎯 Environment Variables

### Required Environment Variables for Gig-Rush

#### Core Application
```bash
# Server Configuration
NODE_ENV=production
PORT=3000
CORS_ORIGIN=https://your-gig-rush-frontend.com

# Database
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/gig-rush

# Authentication
JWT_SECRET=your_super_secure_jwt_secret
JWT_EXPIRES_IN=7d

# Real-time Features
SOCKET_IO_CORS_ORIGIN=https://your-frontend-domain.com
```

#### Security & Monitoring
```bash
# Security Tools
ARCJET_KEY=your_arcjet_key
SONAR_TOKEN=your_sonarqube_token

# Monitoring
SENTRY_DSN=your_sentry_dsn
LOG_LEVEL=info
```

#### Feature Toggles
```bash
# Feature Flags
ENABLE_CHAT=true
ENABLE_GEOLOCATION=true
ENABLE_NOTIFICATIONS=true
ENABLE_RATE_LIMITING=true
