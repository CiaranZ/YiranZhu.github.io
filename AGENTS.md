# Project Instructions

## Required local development environment

This GitHub Pages site has a **project-specific Docker/Jekyll environment**. Use it first for all local development, builds, and visual verification.

- Start the site with `./run_server.sh` or `docker compose up`.
- Browse the rendered site at `http://127.0.0.1:4000/`; LiveReload uses port `35729`.
- The `site` service uses `yiranzhu-homepage-jekyll:local`, Ruby 3.3.4, Bundler 2.5.11, and the gems pinned in `Gemfile.lock`.
- On a fresh machine, build the environment with `docker compose build`, then start it with `docker compose up`.
- For a one-off production-style check, run:
  ```bash
  docker compose run --rm site bundle _2.5.11_ exec jekyll build --source /workspace --destination /tmp/site
  ```
- Inspect failures with `docker compose logs --tail 100 site`. Stop the development server with `docker compose down`; do not use `down -v` unless explicitly asked, because it deletes Jekyll/Sass caches.

Do **not** use the macOS system Ruby or run a host-level `bundle install` for normal work. The host Ruby is 2.6 and does not carry the locked Jekyll dependency set; this can cause misleading Bundler or RubyGems errors. Keep `Gemfile.lock` unchanged unless a task explicitly requires dependency upgrades.

The source directory is mounted read-only inside the container at `/workspace`; edit files on the host workspace, never from inside the container.

The following startup warnings are expected and non-blocking:

- `To use retry middleware with Faraday v2.0+...`
- `GitHub Metadata: No GitHub API authentication could be found...`

## Site structure

- Homepage content: `_pages/about.md`
- Homepage-specific styles: `assets/css/main.scss`
- Global identity/sidebar settings: `_config.yml` and `_includes/author-profile.html`
- Navigation anchors: `_data/navigation.yml`
- Institution logos: `images/affiliations/`

When changing the homepage, verify the actual rendered page through the Docker service at desktop and mobile widths. Check that referenced images load, navigation anchors work, and there is no horizontal overflow on mobile.

## Content conventions

- For research affiliations, attach external links to the laboratory or research-group name, not to an advisor's name, unless a task explicitly asks otherwise.
- Do not publish temporary or non-public research-affiliation and advisor details unless the user explicitly asks to show them.
- AIMS Lab links to `https://junxia97.github.io/`; write its advisor as `Prof. Jun Xia` without linking the name.
- LivSyn Robotics links to `https://www.livsynrobotics.com/en`.
