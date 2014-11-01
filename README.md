# [checkbox.el][1]

[![Build status][2]][3]

A tiny library for working with textual checkboxes in Emacs buffers.
Use it to keep grocery lists in text files, feature requests in source
files, or task lists on GitHub PRs.

Installation
------------

Download the `checkbox.el` file and add it somewhere in your
`load-path`.  Then add `(require 'checkbox)` to your `.emacs` file.

I'd recommend globally binding `checkbox/toggle` to a convenient
keystroke.  For example:

```elisp
(global-set-key (kbd "C-c C-t") 'checkbox/toggle)
```

Usage
-----

If you have a simple to-do list in a Markdown file
like this:

```md
- [ ] Buy gin<point>
- [ ] Buy tonic
```

And you invoke `checkbox/toggle`, you'll get the following:

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
