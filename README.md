# bloom-packages

This repository hosts package recipes for Bloom.

Current package:

- `bloom`

[![Bloom tag](https://img.shields.io/github/v/tag/wirespider87/bloom?label=bloom&logo=github)](https://github.com/wirespider87/bloom/tags)

Use it from xmake with:

```lua
add_repositories("bloom-packages https://github.com/wirespider87/bloom-packages.git")
add_requires("bloom VERSION")
```

Replace `VERSION` with the semver you want (for example `1.0.5`). Tags on bloom are named `vX.Y.Z`; in `add_requires` use `X.Y.Z` without the `v`.

Bloom source lives here:

- https://github.com/wirespider87/bloom
