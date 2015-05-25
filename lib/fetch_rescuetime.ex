defmodule FetchRescuetime do
  use Timex

  @local_zone "{CDT}"

  def main([day]) do
    result = day
      |> get_day
      |> fetch_raw_data
      |> process_response
      |> compute_production

    IO.puts result
  end

  def fetch_raw_data(day) do
    HTTPoison.get url(day)
  end

  def process_response({:ok, %HTTPoison.Response{body: body}}) do
    Poison.Parser.parse body
  end

  def process_response(response) do
    :error
  end

  def compute_production(:error) do
    "Error"
  end

  def compute_production({:ok, %{"rows" => rows}}) do
    {total_time, value} = Enum.reduce rows, {0, 0}, fn([_rank, time, _, productivity], {total_time, value}) ->
      {total_time + time, value + (productivity+2) * time}
    end

    cond do
      total_time == 0 ->
        "N/A"
      total_time > 0 ->
        "#{production(total_time, value)}% - #{total_hours(total_time)}h"
    end
  end

  def production(total_time, value) do
    (value * 25.0) / total_time
      |> Float.to_string [decimals: 0]
  end

  def total_hours(total_time) do
    (total_time/3600.0)
      |> Float.to_string [decimals: 1]
  end

  def get_day(day) when day == "today" do
    DateFormat.format! Date.local, "{YY}-{0M}-{0D}"
  end

  def get_day(day) do
    day
    |> DateFormat.parse("{YYYY}{M}{D}")
    |> DateFormat.format! "{YY}-{0M}-{0D}"
  end

  def url(day) do
    base_url = "https://www.rescuetime.com/anapi/data"
    api_str = "key=#{System.get_env("RESCUETIME_API_KEY")}"
    format_str = "format=json&&resolution_time=day&&rk=productivity"
    date_range_str = "restrict_begin=#{day}&&restrict_end=#{day}"

    "#{base_url}?#{api_str}&&#{format_str}&&#{date_range_str}"
  end
end
