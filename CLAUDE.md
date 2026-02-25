# OpenAttributeGraph Project Guide

## Project Overview
OpenAttributeGraph is a Swift package that provides attribute graph functionality, serving as a foundation for OpenSwiftUI project. It interfaces with DarwinPrivateFrameworks for compatibility testing.

## Development Workflow

### 1. Make Changes and Commit
- Implement your feature or fix
- Format changed Swift files: `Scripts/format-swift.sh`
- Test locally
- Commit changes with descriptive messages

### 2. (Optional) Compatibility Testing
If changes affect the interface with DarwinPrivateFrameworks:
```bash
# Generate AG template
Scripts/gen_ag_template.sh
`
# Update code in ../DarwinPrivateFramework from .ag_template

# Set useLocalDeps to true in Package.swift
xed -l -c 's/let useLocalDeps = envEnable("OPENATTRIBUTEGRAPH_USE_LOCAL_DEPS")/let useLocalDeps = true/' Package.swift

# Build and test with both compatibility modes:
OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST=0 swift build
OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST=1 swift build
```

### 3. Create DarwinPrivateFramework PR
After testing, discard local changes from step 2:
```bash
# Discard any local testing changes
git checkout -- Package.swift

# Create PR for DarwinPrivateFramework
Scripts/bump_ag_pr.sh <branch-name>
```

### 4. Update Dependencies
After the DarwinPrivateFramework PR is merged:
```bash
# Update package dependencies
swift package update DarwinPrivateFramework

# Commit the updated Package.resolved
git add Package.resolved
git commit -m "Update DarwinPrivateFrameworks dependency"
```

### 5. Create Project PR
```bash
# Create PR for the current branch
gh pr create --base main --head <current-branch>
```

## Key Scripts
- `Scripts/format-swift.sh` - Formats changed Swift files (run before committing)
- `Scripts/gen_ag_template.sh` - Generates AG template for compatibility testing
- `Scripts/bump_ag_pr.sh` - Creates PR for DarwinPrivateFramework updates

## Environment Variables
- `OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST=0` - Test without compatibility mode
- `OPENATTRIBUTEGRAPH_COMPATIBILITY_TEST=1` - Test with compatibility mode

## Important Notes
- Always test compatibility when changing interfaces
- Ensure DarwinPrivateFramework PR is merged before creating main project PR
- Keep Package.resolved updated after dependency changes