FactoryBot.define do
  factory :folder do
    name { Faker::Name.middle_name }
    top_folder { nil }
  end
end
