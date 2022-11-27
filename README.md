An [Alfred](https://www.alfredapp.com) workflow for Rust crates searching.

Search Rust crates on https://crates.io via its API[^policy], and then provide a convenient way to open the target crate page, docs.rs page, repository page, or its homepage in your browser.
This workflow is inspired by [Hex.workflow](https://github.com/clarkema/alfred-hex).

![Screenshot for example](/screenshots/example.png)

## Installation

Download a pre-build workflow package from the [releases](https://github.com/belltoy/search.rust.crates.alfredworkflow/releases) page, double click it.

Make sure you have a Alfred Powerpack purchased.

## Usage

The default action (`Enter`) on the search result list is to open the crate's [documentation page](https://docs.rs), aka https://docs.rs.

- `Enter`: open the crate's documentation page, **Default**
- `Cmd` + `Enter`: Open the crate's repository
- `Alt` + `Enter`: Open the crate's homepage
- `Ctrl` + `Enter`: Open in [crates.io](https://crates.io)
- `Shift` + `Enter`: Copy crate dependency text to the system clipboard

## License

MIT or Apache-2

[^policy]: https://crates.io/policies#crawlers
