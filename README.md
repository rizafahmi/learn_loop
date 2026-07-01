# LearnLoop

LearnLoop is a Phoenix web app for self-paced learning. Learners discover Published Courses, start them, resume from the next suggested Lesson, and manually track Lesson completion. Admins manage Course, Chapter, and Lesson content through the app.

The MVP is intentionally small: Phoenix LiveView, SQLite, creation-time Course Order, manual Lesson Progress, and a simple Draft → Published → Archived Course lifecycle.

## Project status

LearnLoop is an early MVP. The core product shape is documented and the app is suitable for local development, experimentation, and iteration. It is not yet a polished production learning platform.

## Product scope

Core Learner flows:

- Sign up and land on the Learner Dashboard.
- Continue enrolled Courses and see Progress.
- Explore Published Courses that have not been started.
- View a Course Overview before Enrollment.
- Start or resume a Course.
- View enrolled Lesson bodies and freely navigate Lessons.
- Mark Lessons complete or incomplete.

Core Admin flows:

- Create and edit Courses, Chapters, and Lessons.
- Publish structurally valid Draft Courses.
- Archive Published Courses instead of deleting them.
- Assign Admin access to Users.

For the detailed product contract, see:

- [`docs/PRD.md`](docs/PRD.md) — product requirements and MVP boundaries.
- [`docs/BDD_SPEC.md`](docs/BDD_SPEC.md) — behavior scenarios.
- [`docs/CONTEXT.md`](docs/CONTEXT.md) — domain language and rules.
- [`docs/adr/`](docs/adr/) — architectural decisions.

## Tech stack

- Elixir / Phoenix 1.8
- Phoenix LiveView
- Ecto with SQLite
- Tailwind CSS
- PhoenixTest, ExUnit, Credo, Dialyxir, ExDNA, and Reach for quality checks

## Prerequisites

You can run the project with the included Nix flake or with your own local Elixir toolchain.

Recommended local dependencies:

- Elixir compatible with `mix.exs`
- Erlang/OTP compatible with your Elixir version
- SQLite

If you use Nix and direnv:

```sh
direnv allow
```

## Getting started

Install and set up dependencies, the database, and assets:

```sh
mix setup
```

Start the Phoenix server:

```sh
mix phx.server
```

Or run it inside IEx:

```sh
iex -S mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) from your browser.

## Configuration

Development and test use local SQLite databases by default.

Production reads configuration from environment variables:

- `DATABASE_PATH` — required path to the SQLite database file.
- `SECRET_KEY_BASE` — required Phoenix secret. Generate one with `mix phx.gen.secret`.
- `PHX_HOST` — public host name. Defaults to `example.com` if unset.
- `PORT` — HTTP port. Defaults to `4000`.
- `POOL_SIZE` — Ecto connection pool size. Defaults to `5`.
- `DNS_CLUSTER_QUERY` — optional DNS clustering query.

## Development commands

Run the test suite:

```sh
mix test
```

Run the project precommit checks before finishing a change:

```sh
mix precommit
```

Run the full CI-quality check locally:

```sh
mix ci
```

Useful database commands:

```sh
mix ecto.reset
mix ecto.migrate
```

## Project documentation

The project keeps product and architecture context in version-controlled docs:

- [`docs/PRD.md`](docs/PRD.md) — product requirements and MVP boundaries.
- [`docs/BDD_SPEC.md`](docs/BDD_SPEC.md) — behavior scenarios.
- [`docs/CONTEXT.md`](docs/CONTEXT.md) — domain language and rules.
- [`docs/adr/`](docs/adr/) — architectural decisions.

## Contributing

Contributions are welcome while the project is taking shape. Before opening a change, please run:

```sh
mix precommit
```

For larger changes, read the product docs first so the implementation matches the current MVP boundaries and domain language.

## Deployment

This project follows standard Phoenix deployment practices. See the [Phoenix deployment guides](https://hexdocs.pm/phoenix/deployment.html) when preparing a production release.

## License

LearnLoop is released under the [MIT License](LICENSE).
