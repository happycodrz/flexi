# Flexi

A flexible Elixir Mix test runner.


## Usage

Start your IEx console in test mode:
```bash
$ MIX_ENV=test iex -S mix
```

First load / execute all test modules with an empty query:

```elixir
# grepping based on file names
iex> Flexi.filematch("")
```


```elixir
# grepping based on test names
iex> Flexi.namematch("")
```


```elixir
# grepping based on test module names
iex> Flexi.modulematch("")
```


## Requirements:

- Elixir 1.7-dev after [Introducing :only_test_ids as options for ExUnit](https://github.com/elixir-lang/elixir/commit/594f778fffbf71c03e05a5f4e5beadcbcd0c7b58#diff-1e5179d66aaabef6fbc8efa93ae33493)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `flexi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:flexi, "~> 0.1.0", only: [:dev, :test]}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/flexi](https://hexdocs.pm/flexi).



## Future ideas:
  - combining different types of filters, like module + name
  - debug mode / more logging (?)
  - make Flexi part of [Cortex](https://github.com/urbint/cortex/commits/master), so it would re-run tests that match the query,
    because the current implementation for `Cortex.focus` is not useful at all :(