FactoryBot.define do
  factory :company, class: Jobspikr::Job do
    to_create { |instance| instance.save }

    add_attribute(:name) { Faker::Company.name }
  end
end