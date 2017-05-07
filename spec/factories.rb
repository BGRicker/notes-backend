FactoryGirl.define do
  factory :tag do
  end

  factory :note, class: Note do
    title "An Ode to Guy Fieri"
    content "The Flavor Lord"
  end
end
