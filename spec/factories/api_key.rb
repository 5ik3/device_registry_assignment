FactoryBot.define do
  factory :api_key do
    token { SecureRandom.hex(16) }
    association :bearer, factory: :user
  end
end
