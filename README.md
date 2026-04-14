# Abbotik Homebrew Tap

This repository is the public Homebrew tap for Abbotik tools.

It exists to publish Homebrew formulae that install prebuilt artifacts from
[`abbotik/homebrew-releases`](https://github.com/abbotik/homebrew-releases).
It is not the source repository for those tools and it does not build binaries.

## Product Surface

- Tap name: `abbotik/tap`
- Artifact source: `abbotik/homebrew-releases`

## Installation

Users can install the current public CLI with:

```bash
brew tap abbotik/tap
brew install abbotik/tap/abbot
```

Or in one shot:

```bash
brew install abbotik/tap/abbot
```

## Formulae

### abbot

Rust CLI for the Abbotik API.

```bash
brew install abbotik/tap/abbot
```

## Developer Notes

- Add or update a formula only after the matching release assets already exist
  in `abbotik/homebrew-releases`.
- Keep formula `version`, asset filenames, and checksums aligned with the
  published release.
- Keep this repo small. Source code lives in product repos; release artifacts
  live in `abbotik/homebrew-releases`; this repo only maps published binaries
  into Homebrew.
