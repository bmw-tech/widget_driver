# Welcome to WidgetDriver contributing guide

Thank you for investing your time in contributing to our project!

To start off, read our [Code of Conduct](./CODE_OF_CONDUCT.md) to keep our community approachable and respectable.

In this guide you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing, and merging the PR.

### Getting started

To get an overview of the project, read the [README](README.md).

### Did you find a bug?

If you spot a problem with WidgetDriver, ensure that the bug was not already reported by searching on GitHub under [Issues](https://github.com/bmw-tech/widget_driver/issues).  
[Here](https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests#search-by-the-title-body-or-comments) is a guide for how to search effectively on GitHub.

If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/bmw-tech/widget_driver/issues/new?assignees=&labels=bug&template=bug_report.md&title=). Be sure to include a title and a clear description, as much relevant information as possible.

### Do you want to solve an issue

Scan through our [existing issues](https://github.com/bmw-tech/widget_driver/issues) to find one that interests you. You can narrow down the search using `labels` as filters. If you are only interested in solving bugs then please check out [all our open bugs](https://github.com/bmw-tech/widget_driver/labels/bug).

If you find an issue to work on, you are more than welcome to open a PR with a fix.

### Did you write code that fixes a issue?

* Once you think you're done coding, open a new pull request. Target the `master` branch. We are doing trunk based development.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

* When you think that your PR is ready to be checked & tested, add the `ready for pipeline` label to it. This will start the pipeline quality-checks which will verify your code. PRs can only be merged with a green pipeline.  

    *If you want to emulate running the pipeline on your local machine, please see the [Makefile](Makefile) or read the [workflows README](.github/workflows/README.md).*

* Once the pipeline becomes green and you have the required review approvals, then feel free to squash and merge your PR.


### Do you intend to add a new feature or change an existing one?

Check out the [existing enhancement issues](https://github.com/bmw-tech/widget_driver/labels/enhancement) and make sure that a similar suggestion does not already exist.

If you're unable to find an open issue addressing the suggestion, [open a new one](https://github.com/bmw-tech/widget_driver/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=). Be sure to include as much relevant information as possible.

We will try to comment and give you feedback on your suggestion as a soon as possible. If you're excited about your idea and cannot wait for feedback to start, then feel free to start coding right away.  
But please note that we cannot guarantee that your suggestion will be accepted.

### Do you have questions about the source code?

Feel free to contact us and ask questions about how to use WidgetDriver at flutter-dev@bmwgroup.com.

### Thanks! ❤️ ❤️ ❤️

Thanks again for investing your time in contributing to our project!

The WidgetDriver Team