Dog.destroy_all
Shelter.destroy_all
Trait.destroy_all
User.destroy_all
Membership.destroy_all

User.create(username: "Brandon")
User.create(username: "Wendy")
User.create(username: "Geoffrey")
User.create(username: "Gustave")

Shelter.create(name: "The first shelter")
Shelter.create(name: "The second shelter")
Shelter.create(name: "The third shelter")