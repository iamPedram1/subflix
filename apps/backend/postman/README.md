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

- `Auth / Sign Up` and `Auth / Sign In` store `accessToken` and `refreshToken` in collection variables for reuse.
- `Auth / Sign Up` also stores `emailVerificationToken` in non-production environments for confirming email.
- `Auth / Forgot Password` stores `passwordResetToken` in non-production environments for resetting passwords.
- `Catalog / Get Subtitle Sources` supports optional query params: `preferredLanguage`, `seasonNumber`, `episodeNumber` (season/episode must be supplied together for TV), and `releaseHint`.
- `subtitleSourceId` values returned by the API are stable opaque ids in the `ssrc:*` format.
- The backend localizes error `message` strings based on the `Accept-Language` header (fallback: `en`).
