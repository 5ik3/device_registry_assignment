FactoryBot.define do
  factory :device do
    serial_number { "123456" } # You can adjust this to your needs
    user { nil } # Set to nil initially, or create a user association if needed
    
    # You can add additional attributes here as required by your Device model
  end
end
