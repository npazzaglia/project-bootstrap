# Contributing to repo-template

Thank you for your interest in contributing to this project! We welcome contributions in various forms, including code, documentation, bug reports, and feature suggestions. This document outlines the process for contributing to ensure a smooth collaboration.

## How to Contribute

### Reporting Issues
- **Before reporting an issue**, please search the [issue tracker](https://github.com/npazzaglia/repo-template/issues) to see if the problem has already been reported.
- Provide a clear and descriptive title.
- Include a detailed description of the issue, including steps to reproduce it, expected behavior, and screenshots or logs if applicable.

### Submitting Pull Requests
1. **Fork the repository.**
2. **Create a feature branch:**

   ```bash
   git checkout -b feature/my-feature
   ```
   
3. **Make your changes** ensuring that they adhere to the project's coding style.
4. **Commit your changes** with clear, concise commit messages.
5. **Run tests** to verify your changes. (Refer to the testing section in the README.)
6. **Open a pull request** against the main branch of the upstream repository.
7. **Discuss and update** your pull request as needed based on feedback.

> Pull requests should follow the structure in [`.github/pull_request_template.md`](.github/pull_request_template.md).

### Code Style Guidelines
- Follow the existing code style and formatting conventions.
- Write clear and descriptive commit messages.
- Document your code where necessary and include inline comments for clarity.
- Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) when possible, e.g. `feat: add login handler`.

### Testing
- Add or update tests to cover your changes.
- Run all tests locally before submitting your pull request.
- Include any additional test instructions if your changes require special setup.

```bash
make test
# or, if using pytest:
pytest tests/
```

### Documentation
- Update documentation to reflect any changes in functionality.
- Ensure that new features or changes are clearly explained.
- Include examples or code snippets if they help clarify the usage of your changes.

### Communication
- For major changes or new features, consider discussing your proposal by opening an issue before starting work.
- Maintain respectful and constructive communication in all discussions.

## Code of Conduct
Please note that by contributing to this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). We expect all participants to follow these guidelines to ensure a welcoming and respectful community.

## Licensing
By contributing, you agree that your contributions will be licensed under the same terms as the project’s [LICENSE](LICENSE).

## Acknowledgements
We appreciate your time and effort in helping to improve this project. Your contributions make a significant impact!

Thank you for contributing to repo-template!