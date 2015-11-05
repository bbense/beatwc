defmodule BeatwcTest do
  use ExUnit.Case
  doctest Beatwc

  test "slurp gets the same answer" do
    assert Beatwc.slurp("README.md") == Beatwc.wc_l("README.md")
  end

  test "naive gets the same answer" do
  	assert Beatwc.naive("README.md") == Beatwc.wc_l("README.md")
  end 

  test "allnifs gets the same answer" do
  	assert Beatwc.allnifs("README.md") == Beatwc.wc_l("README.md")
  end 

  test "chunkynifs gets the same answer" do
  	assert Beatwc.chunkynifs("./bench/data/1000000") == Beatwc.wc_l("./bench/data/1000000")
  end 
end
