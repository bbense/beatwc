defmodule BeatwcTest do
  use ExUnit.Case
  doctest Beatwc

  test "slurp gets the same answer" do
    assert Beatwc.slurp("README.md") == Beatwc.wc_l("README.md")
  end

  test "naive gets the same answer" do
  	assert Beatwc.naive("README.md") == Beatwc.wc_l("README.md")
  end 
end
