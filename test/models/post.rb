require "test_helper"

class PosttTest < ActiveSupport::TestCase

  # runs before every test method
  def setup
    Post.destroy_all
  end

  test "description" do
  end
end
