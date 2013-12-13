Fabricator :stage do
  name {Faker::Company.name}
  tags {"{\"default\":\"#{Faker::Name.first_name}\",\"primary\":\"#{Faker::Name.first_name}\",\"success\":\"#{Faker::Name.first_name}\",\"info\":\"#{Faker::Name.first_name}\",\"warning\":\"#{Faker::Name.first_name}\",\"danger\":\"#{Faker::Name.first_name}\"}"}
  tasks(count: 60) {Fabricate :task}
end