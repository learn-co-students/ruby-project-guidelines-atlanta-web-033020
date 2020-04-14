Dog.destroy_all
Shelter.destroy_all
Trait.destroy_all
User.destroy_all
Membership.destroy_all

u1 = User.create(username: "Brandon")
u2 = User.create(username: "Wendy")
u3 = User.create(username: "Geoffrey")
u4 = User.create(username: "Gustave")

s1 = Shelter.create(name: "The first shelter")
s2 = Shelter.create(name: "The second shelter")
s3 = Shelter.create(name: "The third shelter")

u1.shelters << s1
u1.shelters << s2
u2.shelters << s2
u2.shelters << s3
u3.shelters << s1
u3.shelters << s3