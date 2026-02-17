Company.destroy_all
Contact.destroy_all

# Create companies

apple = Company.new
apple["name"] = "Apple"
apple["city"] = "Cupertino"
apple["state"] = "CA"
apple["url"] = "https://apple.com"
apple.save

amazon = Company.new
amazon["name"] = "Amazon"
amazon["city"] = "Seattle"
amazon["state"] = "WA"
amazon["url"] = "https://amazon.co"
amazon.save

anthropic = Company.new
anthropic["name"] = "Anthropic"
anthropic["city"] = "San Francisco"
anthropic["state"] = "CA"
anthropic["url"] = "https://anthropic.com"
anthropic.save

# Create contacts

tim = Contact.new
tim["first_name"] = "Tim"
tim["last_name"] = "Cook"
tim["email"] = "tim@apple.com"
tim["phone_number"] = "777-777-7777"
tim["company_id"] = apple.id
tim.save

craig = Contact.new
craig["first_name"] = "Craig"
craig["last_name"] = "Federighi"
craig["email"] = "craig@apple.com"
craig["phone_number"] = "888-888-8888"
craig["company_id"] = apple.id
craig.save

jeff = Contact.new
jeff["first_name"] = "Andy"
jeff["last_name"] = "Jassy"
jeff["email"] = "andy@amazon.com"
jeff["phone_number"] = "666-666-6666"
jeff["company_id"] = amazon.id
jeff.save

elon = Contact.new
elon["first_name"] = "Dario"
elon["last_name"] = "Amodei"
elon["email"] = "dario@anthropic.com"
elon["phone_number"] = "555-555-5555"
elon["company_id"] = anthropic.id
elon.save

puts "There are now #{Company.all.count} companies and #{Contact.all.count} contacts."
