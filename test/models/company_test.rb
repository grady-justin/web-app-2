require "test_helper"

class CompanyTest < ActiveSupport::TestCase

  # runs before every test method
  def setup
    Company.destroy_all
  end

  # --- Create ---
  test "create a company" do
    company = Company.new
    company["name"] = "Nike"
    company["city"] = "Beaverton"
    company["state"] = "OR"
    company["url"] = "https://www.nike.com"
    company.save

    assert_equal 1, Company.all.count
  end

  # --- Read ---
  test "find a company by name" do
    company = Company.new
    company["name"] = "Nike"
    company["city"] = "Beaverton"
    company.save

    found = Company.find_by({ "name" => "Nike" })
    assert_equal "Beaverton", found["city"]
  end

  # --- Update ---
  test "update a company name" do
    company = Company.new
    company["name"] = "Nike"
    company.save

    company["url"] = "https://www.nike.com"
    company.save

    updated = Company.find_by({ "name" => "Nike" })
    assert_equal "https://www.nike.com", updated["url"]
  end

  # --- Delete ---
  test "delete a company" do
    company = Company.new
    company["name"] = "Nike"
    company.save

    assert_equal 1, Company.all.count

    company.destroy

    assert_equal 0, Company.all.count
  end

  # --- Validation: Presence ---
  test "company without name should not save" do
    company = Company.new
    company["city"] = "Beaverton"
    company["state"] = "OR"
    company.save

    assert_equal 0, Company.all.count
  end

  # --- Validation: Uniqueness ---
  test "company name must be unique" do
    company1 = Company.new
    company1["name"] = "Nike"
    company1.save

    company2 = Company.new
    company2["name"] = "Nike"
    company2.save

    assert_equal 1, Company.all.count
  end

end
