# web-furrymusic.org

Source and deployment tooling for `furrymusic.org`.

The active site is now a plain static HTML/CSS site in `site-next/`. The
previous Jekyll-based work is still present for reference, but it is not the
current source of truth.

## Directory Layout

- `site-next/` - active website source. Edit pages, CSS, and current image
  assets here.
- `site-next/assets/css/site.css` - shared stylesheet for the new static site.
- `site-next/assets/img/` - current image assets used by the static site.
- `static/` - static files copied into the generated site before `site-next/`.
- `www.furrymusic.org/` - generated output. Do not hand-edit this directory;
  it is deleted and rebuilt by `generate-pages.sh`.
- `feeling-responsive/` - legacy Jekyll site/theme kept as a reference source.
- `legacy-jekyll-starter/` - old starter Jekyll scaffold retained for history.
- `examples/` - upstream/reference example material.

## Build And Deploy

The deployment script is:

```sh
./generate-pages.sh
```

That script:

1. Removes the existing `www.furrymusic.org/` build directory.
2. Copies `static/` into `www.furrymusic.org/`.
3. Copies `site-next/` over that generated layout.
4. Replaces `__LAST_UPDATED__` placeholders in generated HTML with the current
   timestamp.
5. Publishes the result with `rsync --delete` to the configured web host.

Because the script deploys the live site, run it only when the local changes are
ready to publish.

The deploy step expects these environment variables:

```sh
MY_WEBUSER=...
MY_WEBHOST=...
```

## Editing Notes

Add or change pages under `site-next/`. Navigation and shared layout are
currently hand-maintained HTML, so update related pages when adding a new page.

The generated footer timestamp is controlled by the `__LAST_UPDATED__`
placeholder in HTML source files. Leave that placeholder in source files where a
deploy timestamp should appear.
