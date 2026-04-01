# Release Checklist

Quick reference for releasing new versions of sznm_dart_packages.

## Options

You have two options for releasing:

1. **Automated (Recommended)**: Let GitHub Actions handle everything
2. **Manual**: Run commands locally for full control

---

## Option 1: Automated Release (Recommended)

Just push your commits to `main` - GitHub Actions handles the rest!

### Step 1: Commit with Conventional Commits

```bash
git add .
git commit -m "feat: add new lint rule"
git push origin main
```

### Step 2: GitHub Actions Automatically

The `release.yaml` workflow will:
- ✅ Run `melos version` to bump versions
- ✅ Update `CHANGELOG.md` and `pubspec.yaml`
- ✅ Commit changes with `chore(release): publish packages`
- ✅ Create git tags (e.g., `sznm_lints-v2.0.1`)

The `publish.yaml` workflow will then:
- ✅ Detect the new tag
- ✅ Run verification
- ✅ Publish to pub.dev

### Step 3: Verify

Check:
- [ ] GitHub Actions completed successfully
- [ ] Git tag was created
- [ ] Package published on pub.dev

---

## Option 2: Manual Release

### Pre-Release

- [ ] All changes committed with conventional commit messages
- [ ] Run verification: `./scripts/verify.sh`
- [ ] All tests pass (if applicable)
- [ ] Code is formatted: `fvm dart run melos run format-check`
- [ ] No analysis errors: `fvm dart run melos run analyze`

### Version

- [ ] Preview version changes:
  ```bash
  fvm dart run melos run release-dry-run
  ```

- [ ] Review the version bump (patch/minor/major)
- [ ] Create version commit:
  ```bash
  fvm dart run melos run release
  ```

- [ ] Verify `CHANGELOG.md` was updated correctly
- [ ] Verify git tag was created

### Push

- [ ] Push changes and tags:
  ```bash
  git push origin main --tags
  ```

### Publish

- [ ] Run publish dry-run:
  ```bash
  fvm dart run melos run publish-dry-run
  ```

- [ ] Verify no errors or warnings (except uncommitted changes)
- [ ] Publish to pub.dev:
  ```bash
  # Option 1: Via melos
  fvm dart run melos run publish-all
  
  # Option 2: Direct publish
  cd packages/sznm_lints
  fvm dart pub publish
  ```

### Post-Release

- [ ] Verify package on pub.dev
- [ ] Create GitHub release from tag (optional)
- [ ] Update any dependent projects

---

## Quick Commands

```bash
# Full release workflow
./scripts/verify.sh
fvm dart run melos run release-dry-run
fvm dart run melos run release
git push origin main --tags
fvm dart run melos run publish-all
```

## Manual Version Override

```bash
# Force specific version bump
dart --disable-dart-dev pub global run melos version sznm_lints:minor

# Force exact version
dart --disable-dart-dev pub global run melos version sznm_lints:2.1.0
```

---

## GitHub Actions Workflows

| Workflow | File | Trigger |
|----------|------|---------|
| CI | `ci.yaml` | Push/PR to `main` |
| Release | `release.yaml` | Push to `main` |
| Publish | `publish.yaml` | Tag push (`sznm_lints-v*`) |

### Workflow Details

**CI Workflow:**
- Runs on every push/PR to `main`
- Checks code formatting
- Runs static analysis
- Verifies publish readiness

**Release Workflow:**
- Runs on every push to `main`
- Automatically bumps versions based on commits
- Creates git tags
- Commits changelog updates

**Publish Workflow:**
- Runs when version tags are pushed
- Publishes to pub.dev using OIDC authentication
- No credentials needed (uses trusted publishing)
