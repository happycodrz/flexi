# Flexi

A flexible Elixir Mix test runner. (>= Elixir 1.7)


## Usage

Start your IEx console in test mode:
```bash
$ MIX_ENV=test iex -S mix
```


Now we can start running tests depending on our desires.
First run with a fresh Erlang VM will run all tests to load the modules into memory, this happens implicitly.

Grep for file names:

```elixir
iex> Flexi.filematch("")
```


Grep for test names:

```elixir
iex> Flexi.namematch("")
```


Grep for test module names:

```elixir
iex> Flexi.modulematch("")
```


Show current filters for ExUnit (convenience function):

```elixir
iex> Flexi.config()
```


## Requirements:

- Elixir 1.7-dev after [Introducing :only_test_ids as options for ExUnit](https://github.com/elixir-lang/elixir/commit/594f778fffbf71c03e05a5f4e5beadcbcd0c7b58#diff-1e5179d66aaabef6fbc8efa93ae33493)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `flexi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:flexi, "~> 0.4", only: [:dev, :test]}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/flexi](https://hexdocs.pm/flexi).
