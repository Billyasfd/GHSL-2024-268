# GHSL-2024-268

This repository contains a test case for GitHub Security Lab vulnerability research, focusing on database-related CI/CD security patterns and Pre-merge Pull request Enforcement (PPE) mechanisms.

## Attack Scenario Demonstration

The attacker branch demonstrates a vulnerability in the CI/CD pipeline through the following attack chain:

1. Uses `pull_request_target` trigger which runs workflows in the context of the base branch but with code from the PR
2. Exploits the unsafe checkout configuration:
   ```yaml
   ref: ${{ github.event.pull_request && format('refs/pull/{0}/head', github.event.pull_request.number) || github.ref }}
   ```

3. Executes two malicious scripts with elevated permissions:
   - `.github/ci-prerequisites.sh`:
     - Creates file `attacker_evidence_prereq.txt` with content "pwned-by-attacker"
     - Dumps first 20 environment variables
     - Demonstrates access to workflow environment
   
   - `ci/database-start.sh`:
     - Creates file `attacker_evidence_dbstart.txt` with content "dbstart evidence"
     - Dumps first 20 environment variables
     - Shows ability to write files in workspace

The attack demonstrates how an attacker could:
- Access sensitive environment variables
- Execute arbitrary code in privileged workflow context
- Create unauthorized files in the workspace
- Potentially access secrets through the `pull_request_target` event
- Exploit the unsafe PR head checkout in a privileged context

## What this PPE Does

This PPE test case demonstrates secure database initialization and deployment patterns in CI/CD pipelines. It includes:

1. A controlled CI prerequisites script (`ci-prereq`)
2. Secure database startup procedure (`db-start`)
3. Build step verification
4. Safe deployment script that prevents exposure of sensitive information
5. Shell script validation in the `ci/` directory

The purpose is to showcase proper handling of database operations and deployment scripts in a pull request context, preventing potential security vulnerabilities like:
- Unauthorized database access
- Exposure of database credentials
- Script injection in database initialization
- Unsafe deployment practices

## Project Structure

- `package.json` - Node.js project configuration
- `.github/workflows/` - GitHub Actions workflow definitions
- `ci/` - CI/CD related scripts
  - `database-start.sh` - Database initialization script

## Development Setup

1. Install dependencies:
```bash
npm install
```

2. Setup database (requires proper credentials):
```bash
./ci/database-start.sh
```

3. Run build:
```bash
npm run build
```

## Security Notes

This repository demonstrates CI/CD pipeline vulnerabilities with a focus on database interactions. For research purposes only. Do not deploy this code in production environments.

## Contributing

This is a test repository for security research. No contributions are accepted.

## License

For research purposes only. Not for production use.