# Abbotik Homebrew Tap

This repository is the public Homebrew tap for Abbotik tools.

It exists to publish Homebrew formulae that install prebuilt artifacts from
[`abbotik/homebrew-releases`](https://github.com/abbotik/homebrew-releases).
It is not the source repository for those tools and it does not build binaries.

## Product Surface

- Tap name: `abbotik/tap`
- Artifact source: `abbotik/homebrew-releases`

## Installation

When formulae are present, users can install them with:

```bash
brew tap abbotik/tap
brew install abbotik/tap/<formula>
```

Or in one shot:

```bash
brew install abbotik/tap/<formula>
```

## Developer Notes

- Add or update a formula only after the matching release assets already exist
  in `abbotik/homebrew-releases`.
- Keep formula `version`, asset filenames, and checksums aligned with the
  published release.
- Keep this repo small. Source code lives in product repos; release artifacts
  live in `abbotik/homebrew-releases`; this repo only maps published binaries
  into Homebrew.
