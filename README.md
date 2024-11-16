## Development

### 🚀 Setup

- [Install Sui CLI](https://docs.sui.io/guides/developer/getting-started/sui-install), e.g. with `brew install sui`
- Install `move-analyzer` language server
  ```
  cargo install --git https://github.com/move-language/move move-analyzer
  ```
- Install `sui-move-analyzer` language server
  ```
  cargo install --git http://github.com/movebit/sui-move-analyzer --branch master sui-move-analyzer
  ```

Also, if you use **vsc\*de**, don't sleep on the recommended extensions!

### 🤌 Formatting

Formatting is supported via Prettier and [Sui's Move prettier plugin](https://github.com/MystenLabs/sui/tree/main/external-crates/move/crates/move-analyzer/prettier-plugin#installation).

It's not _MOVED_ into a separate npm package yet, so the build artifacts of that plugin are actually included in the repo (see `./prettier-plugin-move`), as the opposite of cloning and compiling it locally.

### 📦 Build

Generate the build artifacts in `./build`:

```
sui move build
```

### 🧪 Test

```
sui move test
```
