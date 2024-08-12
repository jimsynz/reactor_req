# Reactor.Req

[![Build Status](https://drone.harton.dev/api/badges/james/reactor_req/status.svg)](https://drone.harton.dev/james/reactor_req)
[![Hex.pm](https://img.shields.io/hexpm/v/reactor_req.svg)](https://hex.pm/packages/reactor_req)
[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/full.html)

A [Reactor](https://github.com/ash-project/reactor) extension that provides steps for working with HTTP requests via [Req](https://github.com/wojtekmach/req).

## Example

The following example uses Reactor to retrieve the repository description from the Forgejo API:

```elixir
defmodule GetForgejoRepoDescription do
  use Reactor, extensions: [Reactor.Req]

  input :hostname
  input :owner
  input :repo

  step :repo_url do
    argument :hostname, input(:hostname)
    argument :owner, input(:owner)
    argument :repo, input(:repo)

    run fn args ->
      URI.new("https://#{args.hostname}/api/v1/repos/#{args.owner}/#{args.repo}")
    end
  end

  req_get :get_repo do
    url result(:repo_url)
    headers value([accept: "application/json"])
    http_errors value(:raise)
  end

  step :get_description do
    argument :description, result(:get_repo, [:body, "description"])
    run fn args -> {:ok, args.description} end
  end
end

Reactor.run!(GetForgejoRepoDescription, %{
  hostname: "harton.dev",
  owner: "james",
  repo: "reactor_req"
})

# => "A Reactor DSL extension for making HTTP requests with Req."
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `reactor_req` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:reactor_req, "~> 0.1.0"}
  ]
end
```

Documentation for the latest release is available on [HexDocs](https://hexdocs.pm/reactor_req).

## Github Mirror

This repository is mirrored [on Github](https://github.com/jimsynz/reactor_req)
from it's primary location [on my Forgejo instance](https://harton.dev/james/reactor_req).
Feel free to raise issues and open PRs on Github.

## License

This software is licensed under the terms of the
[HL3-FULL](https://firstdonoharm.dev), see the `LICENSE.md` file included with
this package for the terms.

This license actively proscribes this software being used by and for some
industries, countries and activities. If your usage of this software doesn't
comply with the terms of this license, then [contact me](mailto:james@harton.nz)
with the details of your use-case to organise the purchase of a license - the
cost of which may include a donation to a suitable charity or NGO.
