# Changelog Template

This project follows the principles of **Keep a Changelog** and **Semantic Versioning (SemVer)**.

---

# Changelog

All notable changes to this project should be documented in this file.

The format is based on:

- Keep a Changelog
- Semantic Versioning

---

# Version Format

```text
MAJOR.MINOR.PATCH
```

Example:

```text
1.0.0
1.1.0
1.1.1
2.0.0
```

---

# Release Entry Template

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added

-

### Changed

-

### Deprecated

-

### Removed

-

### Fixed

-

### Security

-

### Breaking Changes

-

### Migration Notes

-

### Contributors

-
```

---

# Example Release

## [1.0.0] - 2026-07-23

### Added

- Initial repository structure
- Terraform modules
- AWS infrastructure design
- GitHub Actions automation
- Documentation
- Disaster Recovery runbooks

### Changed

- Initial production-ready architecture

### Deprecated

- None

### Removed

- None

### Fixed

- Initial release

### Security

- Added CodeQL
- Added Secret Scanning
- Added Dependency Review
- Added Security Policy

### Breaking Changes

None.

### Migration Notes

Not applicable.

### Contributors

- Project Maintainers

---

# Release Sections

## Added

Use this section for:

- New features
- New Terraform modules
- New workflows
- New documentation
- New automation

---

## Changed

Use this section for:

- Improvements
- Refactoring
- Performance enhancements
- Documentation updates

---

## Deprecated

Document features planned for removal.

Include:

- Deprecation reason
- Planned removal version
- Recommended alternative

---

## Removed

Document removed:

- Modules
- Workflows
- Features
- Documentation
- Infrastructure components

---

## Fixed

Document:

- Bug fixes
- Infrastructure fixes
- Workflow fixes
- Documentation corrections

---

## Security

Include:

- Vulnerability fixes
- IAM improvements
- Security policy updates
- Dependency updates
- Secret management improvements

---

## Breaking Changes

Document any incompatible changes.

Examples:

- Variable name changes
- Module restructuring
- Output changes
- Workflow redesign

Include:

- Impact
- Upgrade guidance
- Migration requirements

---

# Migration Notes

Migration guidance should include:

- Required actions
- Configuration changes
- Terraform state considerations
- Rollback guidance
- Validation steps

---

# Contributor Attribution

Contributors may be listed by:

- Repository Maintainers
- Individual Contributors
- External Contributors
- Community Contributions

---

# Release Date Format

Use ISO 8601 format.

Example:

```text
2026-07-23
```

---

# Release Checklist

Before publishing a release:

- [ ] Version updated
- [ ] CHANGELOG updated
- [ ] Documentation updated
- [ ] Security review completed
- [ ] Validation completed
- [ ] Release notes prepared
- [ ] Git tag created
- [ ] GitHub Release published

---

# Best Practices

- Update the changelog for every release.
- Keep entries concise and descriptive.
- Group related changes together.
- Clearly identify breaking changes.
- Include migration guidance when needed.
- Credit contributors where appropriate.

---

# References

- Keep a Changelog
- Semantic Versioning
- GitHub Releases

---

# Summary

Maintaining a consistent changelog improves traceability, simplifies upgrades, and provides users with a clear history of changes across releases.