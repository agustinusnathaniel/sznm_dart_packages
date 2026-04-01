#!/bin/bash
# Verification script for sznm_dart_packages workspace
# Run this before publishing or merging PRs

set -e

echo "========================================"
echo "  sznm_dart_packages Verification"
echo "========================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass() { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

# Detect Dart/Flutter command
if command -v flutter &> /dev/null; then
    DART_CMD="dart"
    FLUTTER_VERSION=$(flutter --version | head -1)
    echo "Using Flutter SDK"
    echo "   $FLUTTER_VERSION"
elif command -v fvm &> /dev/null && [ -f ".fvmrc" ]; then
    DART_CMD="fvm dart"
    FVM_VERSION=$(cat .fvmrc | grep flutter | cut -d'"' -f4)
    echo "Using FVM"
    echo "   Flutter version: $FVM_VERSION"
else
    DART_CMD="dart"
    echo "Using system Dart"
fi

# Check .fvmrc (if using FVM or koji-1009/setup-flutter)
echo ""
echo "1. Checking version config..."
if [ -f ".fvmrc" ]; then
    pass ".fvmrc exists"
    FVM_VERSION=$(cat .fvmrc | grep flutter | cut -d'"' -f4)
    echo "   Flutter version: $FVM_VERSION"
else
    warn ".fvmrc not found (CI will use latest stable)"
fi

# Check Melos
echo ""
echo "2. Checking Melos workspace..."
if $DART_CMD run melos list > /dev/null 2>&1; then
    pass "Melos workspace bootstrapped"
    echo "   Packages: $($DART_CMD run melos list | wc -l | tr -d ' ')"
else
    fail "Melos workspace not bootstrapped"
fi

# Check formatting
echo ""
echo "3. Checking code formatting..."
if $DART_CMD format --set-exit-if-changed packages/ > /dev/null 2>&1; then
    pass "All code is formatted"
else
    fail "Code formatting issues found"
fi

# Check analysis
echo ""
echo "4. Running static analysis..."
if $DART_CMD analyze packages/ > /dev/null 2>&1; then
    pass "No analysis issues"
else
    fail "Analysis errors found"
fi

# Check publish dry-run for each package
echo ""
echo "5. Checking publish readiness..."
for pkg in packages/*/; do
    pkg_name=$(basename "$pkg")
    echo "   Checking $pkg_name..."
    if (cd "$pkg" && $DART_CMD pub publish --dry-run 2>&1 | grep -q "Sorry"); then
        fail "$pkg_name has publish errors"
    else
        pass "$pkg_name can publish"
    fi
done

# Check for outdated dependencies
echo ""
echo "6. Checking dependencies..."
OUTDATED=$($DART_CMD pub outdated 2>&1 | grep -v "all dependencies are up-to-date" | grep -v "transitive" | grep -v "Package Name" | grep -v "^$" | grep -v "Showing outdated" | grep "\*" | head -1 || true)
if [ -z "$OUTDATED" ]; then
    pass "All direct dependencies up-to-date"
else
    warn "Some dependencies have newer versions available"
fi

# Check git status
echo ""
echo "7. Checking git status..."
UNCOMMITTED=$(git status --porcelain | grep -v "^??" | wc -l)
if [ "$UNCOMMITTED" -eq 0 ]; then
    pass "Git working tree clean"
else
    warn "$UNCOMMITTED files with uncommitted changes"
    git status --porcelain | grep -v "^??" | head -5
    if [ "$UNCOMMITTED" -gt 5 ]; then
        echo "   ... and $((UNCOMMITTED - 5)) more files"
    fi
fi

echo ""
echo "========================================"
echo -e "${GREEN}  Verification Complete!${NC}"
echo "========================================"
