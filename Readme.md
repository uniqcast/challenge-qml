# Challenge: QML

Tasks and guides that should help you learn [QML](http://doc.qt.io/qt-5/qtqml-index.html).

## Tasks

The assignment is to solve a number of tasks targeted at sharpening your QML skills. All tasks are solvable even if you are not an experienced frontend developer as the point of tasks itself is to make you learn QML.

Take your time. We put more focus on quality of code over speed of coding, since in time, quality of code will directly regulate speed of coding.

There are few things to remember:

1. **Communication** - if you have an issue, ask.
2. **Team** - you work with other people, everything you write will at some time be read and changed by someone else.
3. **Code** - code must be clean, unneeded whitespace and old code in comments should never be upstream.
4. **Comments** - your code is not self documenting but it doesn't need a comment of every line, describe complex blocks and modules so even a newcomer can understand what was the idea.
5. **Stability** - write safe code which always expects malformed input and unexpected actions.

### List of Tasks

1. Movie Browser
    * [Subtask 1](movie-browser/subtask-1/Readme.md), introduction to QML.
    * [Subtask 2](movie-browser/subtask-2/Readme.md), dynamic content.
    * [Subtask 3](movie-browser/subtask-3/Readme.md), REST API.
2. Simple TV
    * [Subtask 1](simple-tv/subtask-1/Readme.md), content playout.
    * [Subtask 2](simple-tv/subtask-2/Readme.md), responsiveness.

### Prerequisites & Environment

* Use latest version of [open source Qt 5](https://www.qt.io/download-open-source).
* Use Qt Creator for development and follow guidelines described in the [Qt Creator section](#working-with-qt-creator).
* If possible, test solutions on Android devices. Otherwise, only desktop version for desired OS should be implemented.

### Solutions

* Solutions for each task should be placed in a standalone repository.
    * Each subtask should be placed in its own directory.
* Solutions should work on desktop (Linux, Mac, Windows) and Android devices.
    * Since video playout is a complicated issue which requires different approaches for different platforms, it's not required that video works properly on every platform.

### Further Improvements & Tasks

* Use `git rebase` instead of `git pull/merge`.
* Find grammatical errors and send a pull request with fixes.
* Add `.gitignore` to exclude files that should not be upstream.
* Send pull requests to improve what you think could be better.
* Write a new task that you think would be useful for people when learning QML.

## Working with Qt Creator

Every task should be a standalone Qt project created from Qt Creator IDE.

To create a new project, click on `File > New File or Project` and select a template `Application > Qt Quick Application Empty`.

---

*This project is licensed under the terms of the MIT license.*
