# Postman Assets

This folder contains shareable Postman assets for the SubFlix backend.

## Safe To Commit

- API collections
- sample environments with non-secret defaults
- local sample files used for upload requests

## Do Not Commit

- bearer tokens
- API keys
- session cookies
- personal credentials
- production-only private environment exports

## Naming Convention

- committed sample environments should include `sample` in the file name
- private local environments should use names like:
  - `*.private.postman_environment.json`
  - `*.secret.postman_environment.json`

Those private variants are ignored by git through the root `.gitignore`.

## Included Files

- `SubFlix Backend.postman_collection.json`
- `SubFlix Backend.local.sample.postman_environment.json`
- `sample-upload.srt`

## Recommended Workflow

1. Import the collection.
2. Import the sample environment.
3. Duplicate the environment locally if you want custom values.
4. Keep secrets only in your duplicated private environment.

## Notes

- `Catalog / Get Subtitle Sources` supports optional query params: `preferredLanguage`, `seasonNumber`, and `episodeNumber` (season/episode must be supplied together for TV).
- `subtitleSourceId` values returned by the API are stable opaque ids in the `ssrc:*` format.
