FactoryBot.define do
  factory :equipment do
    code { 1 }
    name { "MyText" }
    brand { "MyText" }
    equipment_type { 1 }
    note { "MyText" }
    local_id { 1 }
    equipment_photo { Rack::Test::UploadedFile.new('app/assets/images/ruby_symbol.png', 'image/png') }
  end
end
