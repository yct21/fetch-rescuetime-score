Fetch Rescuetime
===============

This is a simple toy to fetch productivity score of RescueTime implemented by Elixir.

Steps:

- export env variable `RESCUETIME_API_KEY` (your api key from rescuetime.com) somewhere.
- clone this repository
- run `mix deps.get`
- run `mix escript.build`
- An executed file `fetch_rescuetime` generated in the repository directory.

To get rescue time score:

`fetch_rescuetime 20150526`

or

`fetch_rescuetime today`
