require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Feed.new.valid?
  end
end
