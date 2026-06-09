## Description

<!-- Provide a brief description of what this PR does -->

## Type of Change

<!-- Mark the relevant option with an 'x' -->

- [ ] New tool installation script
- [ ] Bug fix
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Helper function addition/improvement
- [ ] Other (please describe):

## Changes Made

<!-- List the specific changes made in this PR -->

- 
- 
- 

## New Tools Added

<!-- If adding new tools, list them here. Otherwise, remove this section -->

| Tool Name | Category | Description |
|-----------|----------|-------------|
| | | |

## Testing

### Test Environment
- **Ubuntu Version**: <!-- e.g., 22.04 LTS, 24.04 LTS -->
- **Architecture**: <!-- e.g., amd64, arm64 -->
- **Test Type**: <!-- e.g., Fresh VM, Existing installation -->

### Testing Steps
<!-- Describe how you tested these changes -->

1. 
2. 
3. 

### Test Results
- [ ] Script runs without errors
- [ ] Tool installs successfully
- [ ] Script is idempotent (safe to run multiple times)
- [ ] Verified tool works after installation
- [ ] Tested with `./bootstrap.sh install`
- [ ] No conflicts with existing tools

## Checklist

<!-- Mark completed items with an 'x' -->

- [ ] I have read the [CONTRIBUTING.md](../CONTRIBUTING.md) guidelines
- [ ] My code follows the project's code style (2 spaces, quoted variables, etc.)
- [ ] I have added appropriate comments to my code
- [ ] My script uses `set -euo pipefail` for error handling
- [ ] My script checks if the tool is already installed before proceeding
- [ ] I have updated the README.md if adding new tools
- [ ] I have added metadata comments (`meta:update`, `meta:description`, `meta:link`)
- [ ] I have tested on a fresh Ubuntu installation
- [ ] My commit messages follow the conventional commits format

## Script Metadata

<!-- If adding/modifying scripts, confirm metadata is correct -->

- [ ] `meta:update` is set appropriately
- [ ] `meta:description` clearly describes what gets installed
- [ ] `meta:link` points to official documentation

## Documentation Updates

<!-- If you updated documentation, describe the changes -->

- [ ] Updated README.md
- [ ] Updated CONTRIBUTING.md
- [ ] Updated QUICKSTART.md
- [ ] No documentation changes needed

## Breaking Changes

<!-- Does this PR introduce any breaking changes? -->

- [ ] No breaking changes
- [ ] Yes, breaking changes (describe below)

<!-- If breaking changes, explain what breaks and how users should adapt -->

## Additional Notes

<!-- Any additional information, context, or screenshots -->

## Related Issues

<!-- Link any related issues here -->

Closes #
Relates to #
