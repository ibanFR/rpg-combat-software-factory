# Jekyll with just-the-docs for the documentation site

The documentation site under `site/` is built with Jekyll and the just-the-docs theme, even though the rest of the repository is a Node/TypeScript project. We chose this to follow the same pattern as our other projects (react-java-monorepo), so layouts, navigation conventions (Diataxis sections driven by front matter), the blog setup, and the GitHub Pages workflow can be reused as-is. The Ruby toolchain stays contained in `site/` and its CI workflow; the site is excluded from Prettier so Kramdown attribute lists (`{: .class }`) are not reformatted.

## Considered Options

- **Jekyll + just-the-docs (chosen)**: consistent with our other docs sites; native GitHub Pages support.
- **A Node-based generator (Starlight, VitePress)**: single toolchain for the repo, but diverges from the shared pattern and would mean rebuilding the layouts and conventions.

## Consequences

- Contributors previewing the site locally need Ruby and Bundler (`./site/start_local_server.sh`).
- `npm run checks` does not cover the site; the site is only built by the Pages workflow on pushes to `main` that touch `site/**`.
