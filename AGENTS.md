# Agent Notes

This repository contains the source and deployment tooling for
`furrymusic.org`. The current site is a staged static replacement, not a Jekyll
build.

## Source Of Truth

- Edit the active site in `site-next/`.
- Do not hand-edit `www.furrymusic.org/`; it is generated output and is deleted
  by `generate-pages.sh`.
- Treat `feeling-responsive/` as legacy Jekyll reference material only unless
  the user explicitly asks to change the old Jekyll site.
- Treat `legacy-jekyll-starter/` as historical scaffold only.
- `static/` is copied into the generated output before `site-next/`, so files in
  `site-next/` can overlay files from `static/`.

## Build And Deploy

Use:

```sh
./generate-pages.sh
```

The script rebuilds `www.furrymusic.org/`, stamps `__LAST_UPDATED__` placeholders
in generated HTML, and deploys to the live server with `rsync --delete`.

Because this publishes the live site, do not run it casually. Confirm the user
intends to deploy unless they have directly asked to run the script.

Deployment requires:

```sh
MY_WEBUSER
MY_WEBHOST
```

## Static Site Conventions

- Pages are plain HTML under `site-next/`.
- Shared CSS is in `site-next/assets/css/site.css`.
- Current site images are in `site-next/assets/img/`.
- Legacy images copied from the old Jekyll site are under
  `site-next/assets/img/legacy/`.
- Navigation is hand-maintained HTML. When adding or renaming pages, update
  affected nav links manually.
- Footer timestamps should use the `__LAST_UPDATED__` placeholder in source
  HTML when a generated deploy timestamp is desired.

## Content Guidance

- Preserve user-provided wording, spelling, and punctuation unless the user asks
  for a copy edit.
- The site currently emphasizes performance opportunities and ensemble pages.
  Keep new changes consistent with that structure unless the user asks for a
  redesign.
- For image work, prefer keeping source assets in `site-next/assets/img/` and
  documenting any generated variants by filename.

## Editing Workflow

- Inspect files before editing.
- Use `rg` and `rg --files` for searches when available.
- Use `apply_patch` for manual text/code edits.
- Avoid modifying generated files in `www.furrymusic.org/`; change `site-next/`
  and regenerate only when deployment is intended.
- Do not revert unrelated dirty work in the repository.
