FactoryGirl.define do
    # This is to tell Factory Girl that the subsequent definition is for a User model object.
    factory :user do
        firstname   "foo"
        lastname    "baz"
        email       "foo.baz@baz.com"
        year_of_birth         1990
        city        "Sydney"
        gender      "Male"
        username    "foobaz"
        password    "foobazbaz"
        password_confirmation   "foobazbaz"
        terms_and_conditions "1"

    end
end
