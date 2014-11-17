# [checkbox.el][1]

[![Build status][2]][3] [![MELPA][7]][8] [![MELPA Stable][9]][10]

A tiny library for working with textual checkboxes in Emacs buffers.
Use it to keep grocery lists in text files, feature requests in source
files, or task lists on GitHub PRs.

Installation
------------

The recommended method of installation is via `package.el`.  If you
haven't previously added [MELPA][6] as a package source, add the
following to your `.emacs` and either evaluate it or restart Emacs:

```elisp
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
```

With that in place you can simply run `M-x package-install RET
checkbox RET` to download and install the package.

I'd recommend globally binding `checkbox-toggle` to a convenient
keystroke.  For example:

```elisp
(global-set-key (kbd "C-c C-t") 'checkbox-toggle)
```

Usage
-----

If you have a simple to-do list in a Markdown file
like this:

```md
- [ ] Buy gin<point>
- [ ] Buy tonic
```

And you invoke `checkbox-toggle`, you'll get the following:

```md
- [x] Buy gin<point>
- [ ] Buy tonic
```

Invoke it again and you're back to the original unchecked version.

```md
- [ ] Buy gin<point>
- [ ] Buy tonic
```

Next, if we add a line without a checkbox...

```md
- [ ] Buy gin
- [ ] Buy tonic
- Buy limes<point>
```

We can invoke the command again to insert a new checkbox.

```md
- [ ] Buy gin
- [ ] Buy tonic
- [ ] Buy limes<point>
```

If we want to remove a checkbox entirely we can do so by passing a
prefix argument (`C-u`) to `checkbox-toggle`.

Finally, checkbox.el treats programming modes specially, wrapping
inserted checkboxes in comments so we can quickly go from this:

```elisp
(save-excursion
  (beginning-of-line)<point>
  (let ((beg (point)))
```

To this:

```elisp
(save-excursion
  (beginning-of-line)                ; [ ] <point>
  (let ((beg (point)))
```

If you prefer to use an alternate set of checkboxes, you can do so by
changing the value of `checkbox-states`, a buffer-local variable.
Less advanced users may prefer to do this through the `customize`
facility:

```
M-x customize-group RET checkbox RET
```

Advanced users may prefer to do so via their `.emacs` file:

```elisp
(require 'checkbox)
(setq-default checkbox-states '("TODO" "DONE" "WAITING"))
```

Additionally, a convenient way to give a file a unique set of checkbox
states is via [File Variables][4] (also see the handy
`add-file-local-variable` function), allowing us to specify the state
set we want to use via a small comment near the end of the file. For
example, in a Markdown file:

```md
<!-- Local Variables: -->
<!-- checkbox-states: ("TODO" "DONE" "WAITING") -->
<!-- End: -->
```

Passing a prefix argument to `checkbox-toggle` allows us to directly
choose a checkbox to insert via its position in `checkbox-states`,
which is useful when we have more than two states.  For example,
assuming the custom state set above and a buffer with the following
contents:

```md
- Review report<point>
```

`C-u 2 C-c C-t` will yield:

```md
- WAITING Review report<point>
```

Note that the first state is 0.

Alternatives
------------

For a more featureful alternative, check out the amazing
[org-mode][5].  I love and use org-mode, but org-mode generally
expects to be running as a major mode whereas checkbox.el will happily
handle your checkbox needs inside of any mode.

Testing
-------

To run the full test suite (unit + integration) simply run:

```sh
$ make
```

License
-------

Copyright (C) 2014 Cameron Desautels

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

**Author:** Cameron Desautels \<<camdez@gmail.com>\>  
**Source:** <https://github.com/camdez/checkbox.el>

[1]: https://github.com/camdez/checkbox.el
[2]: https://travis-ci.org/camdez/checkbox.el.svg?branch=master
[3]: https://travis-ci.org/camdez/checkbox.el
[4]: https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Variables.html
[5]: http://orgmode.org
[6]: http://melpa.org
[7]: http://melpa.org/packages/checkbox-badge.svg
[8]: http://melpa.org/#/checkbox
[9]: http://stable.melpa.org/packages/checkbox-badge.svg
[10]: http://stable.melpa.org/#/checkbox
