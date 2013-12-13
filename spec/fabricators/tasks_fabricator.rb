Fabricator :task do
  text {  Faker::Lorem.paragraph }
  state {  Stage.new.states.sample  }
end