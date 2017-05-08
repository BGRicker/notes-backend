FactoryGirl.define do
  factory :tag do
    name "cool tag"
  end

  factory :note, class: Note do
    title "An Ode to Guy Fieri"
    content "The Flavor Lord"
  end
end
