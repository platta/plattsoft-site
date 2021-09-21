# Plattsoft Web Site

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

## TODO List

- Google analytics key
- Favicon
- Apple icon
