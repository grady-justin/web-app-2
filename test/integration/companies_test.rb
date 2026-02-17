require "test_helper"

class CompaniesTest < ActionDispatch::IntegrationTest
  test "index displays company names" do
    # Create test data
    Company.create(name: "Google")
    Company.create(name: "Apple")

    # Visit the companies index page
    get "/companies"

    # Verify the response is successful
    assert_response :success

    # Verify company names appear on the page
    assert_select "li", text: "Google"
    assert_select "li", text: "Apple"
  end

  test "show displays company details and contacts" do
    # Create a company and associated contact
    company = Company.create(name: "Google", city: "Mountain View", state: "CA")
    Contact.create(first_name: "Sundar", last_name: "Pichai", company_id: company["id"])

    # Visit the company show page
    get "/companies/#{company["id"]}"

    # Verify the response is successful
    assert_response :success

    # Verify company details appear on the page
    assert_select "h1", text: "Google"
    assert_select "h2", text: "Mountain View, CA"

    # Verify contact appears on the page
    assert_select "li", text: /Pichai, Sundar/
  end

  test "new displays the new company form" do
    # Visit the new company page
    get "/companies/new"

    # Verify the response is successful
    assert_response :success

    # Verify form fields are present
    assert_select "form"
    assert_select "input[name='name']"
    assert_select "input[name='city']"
    assert_select "input[name='state']"
  end

  test "create fails with invalid company data and re-renders new" do
    assert_no_difference('Company.count') do
      post "/companies", params: { company: { name: "" } } # Missing name
    end
    assert_response :unprocessable_entity
    assert_select "div.alert", "Company could not be created."
    assert_template :new
  end

  test "create adds a new company and redirects to its show page on success" do
    assert_difference('Company.count', 1) do
      post "/companies", params: { company: { name: "New Company Name" } }
    end
    company = Company.last
    assert_redirected_to company_path(company)
    follow_redirect!
    assert_response :success
    assert_select "div.notice", "Company was successfully created."
    assert_select "h1", text: "New Company Name"
  end

  test "edit displays the edit company form with existing data" do
    # Create a company
    company = Company.create(name: "Google", city: "Mountain View", state: "CA")

    # Visit the edit page
    get "/companies/#{company["id"]}/edit"

    # Verify the response is successful
    assert_response :success

    # Verify form is pre-filled with existing data
    assert_select "input[name='name'][value='Google']"
    assert_select "input[name='city'][value='Mountain View']"
    assert_select "input[name='state'][value='CA']"
  end

  test "update modifies a company and redirects to index" do
    # Create a company
    company = Company.create(name: "Google", city: "Mountain View", state: "CA")

    # Submit the edit form with updated data
    patch "/companies/#{company["id"]}", params: { name: "Alphabet", city: "Mountain View", state: "CA" }

    # Verify redirect to companies index
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # Verify the updated name appears on the index page
    assert_select "li", text: "Alphabet"

    # Verify the company was updated in the database
    company.reload
    assert_equal "Alphabet", company["name"]
  end

  test "destroy deletes a company and redirects to index" do
    # Create a company
    company = Company.create(name: "Google", city: "Mountain View", state: "CA")

    # Verify the company exists
    assert_equal 1, Company.count

    # Submit the delete request
    delete "/companies/#{company["id"]}"

    # Verify redirect to companies index
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # Verify the company was removed from the database
    assert_equal 0, Company.count
  end
end
