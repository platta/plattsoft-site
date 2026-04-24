# Plattsoft Web Site

## Local Development

**Prerequisites:** Ruby and Bundler must be installed (`gem install bundler`).

**One-time setup** (install gems):

```bash
make install
# or: cd docs && bundle install
```

**Sync versions with GitHub**:

```bash
make sync
```

This reads the current dependencies from GitHub and modifies your local
environment to match so that your local process should be an exact match with
what GitHub Pages will create when you push a commit.

**Start the local preview server:**

```bash
make serve
# or: cd docs && bundle exec jekyll serve
```

Then open <http://localhost:4000> in your browser. Jekyll watches for file
changes and rebuilds automatically; refresh to see updates.

The generated `docs/_site/` directory is git-ignored and should never be
committed.

## Mathjax for LaTeX

Add `usemathjax: true` to the frontmatter of a post, and the `scripts.html`
include file will throw in the CDN link to load mathjax. Use $$ for block math
and $ for inline math.

## Style

Style sheets are built using SCSS. The main style sheet is in
`assets/css/style.scss` and imports other files which live in `_sass`. The
`bootstrap` folder in there is the actual source of bootstrap 4.3.1. The
`pygments` folder contains coloring rules for code snippets, and the rest of the
styles are defined in the `plattsoft` folder.

## wp_content

The old `wp_content/uploads` contents are in the root of the repo for now. Just
hanging onto them in case they're needed.

## img_src

Source files for the logo/favicon. Maybe eventually other stuff.
