Fabricator(:pretty_list_item) do
  name { Faker::Name.name }
  description { Faker::Lorem.paragraph }
  sort_order { sequence(:prety_list_item_sort_order, 1) { |i| i } }
end
