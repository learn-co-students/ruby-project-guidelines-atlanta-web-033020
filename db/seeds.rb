require_relative '../config/environment'

Publisher.destroy_all
Game.destroy_all
User.destroy_all
Review.destroy_all

p1 = Publisher.create({name: "Nintendo"})
p2 = Publisher.create({name: "Sony"})
p3 = Publisher.create({name: "EA"})


games = [
    Game.create({name: "The Legend of Zelda: A Link to the Past", release_date: "11/21/1991", publisher_id: p1.id}),
    Game.create({name: "Animal Crossing: New Horizons", release_date: "3/20/2020", publisher_id: p1.id}),
    Game.create({name: "Pokemon Sword", release_date: "11/15/2019", publisher_id: p1.id}),
    Game.create({name: "Pokemon Shield", release_date: "11/15/2019", publisher_id: p1.id}),
    Game.create({name: "The Legend of Zelda: Breath of the Wild", release_date: "3/3/2017", publisher_id: p1.id}),
    Game.create({name: "The Legend of Zelda: Ocarina of Time", release_date: "11/23/1998", publisher_id: p1.id}),
    Game.create({name: "Super Mario RPG: Legend of the Seven Stars", release_date: "5/22/1996", publisher_id: p1.id}),
    Game.create({name: "Super Mario Bros. 3", release_date: "10/23/1988", publisher_id: p1.id}),
    Game.create({name: "Super Mario Bros.", release_date: "7/14/1983", publisher_id: p1.id}),
    Game.create({name: "Super Mario World", release_date: "11/21/1990", publisher_id: p1.id}),
    Game.create({name: "Super Mario World 2: Yoshi's Island", release_date: "11/5/1995", publisher_id: p1.id}),
    Game.create({name: "Super Mario 64", release_date: "6/23/1996", publisher_id: p1.id}),
    Game.create({name: "Bloodborne", release_date: "3/25/2015", publisher_id: p2.id}),
    Game.create({name: "God of War", release_date: "4/20/2018", publisher_id: p2.id}),
    Game.create({name: "Killzone: Shadow Fall", release_date: "11/15/2013", publisher_id: p2.id}),
    Game.create({name: "Resogun", release_date: "11/15/2013", publisher_id: p2.id}),
    Game.create({name: "God of War II", release_date: "5/13/2007", publisher_id: p2.id}),
    Game.create({name: "God of War III", release_date: "5/16/2010", publisher_id: p2.id}),
    Game.create({name: "Uncharted: Drake's Fortune", release_date: "11/19/2007", publisher_id: p2.id}),
    Game.create({name: "Uncharted 2: Among Thieves", release_date: "10/13/2009", publisher_id: p2.id}),
    Game.create({name: "Uncharted 3: Drake's Deception", release_date: "11/1/2011", publisher_id: p2.id}),
    Game.create({name: "Uncharted 4: A Thief's End", release_date: "5/10/2016", publisher_id: p2.id}),
    Game.create({name: "Star Wars Jedi: Fallen Order", release_date: "11/15/2019", publisher_id: p3.id}),
    Game.create({name: "FIFA 20", release_date: "9/24/2019", publisher_id: p3.id}),
    Game.create({name: "Apex Legends", release_date: "2/4/2019", publisher_id: p3.id}),
    Game.create({name: "The Sims 4", release_date: "9/2/2014", publisher_id: p3.id}),
    Game.create({name: "Star Wars Battlefront II", release_date: "11/17/2017", publisher_id: p3.id}),
    Game.create({name: "Star Wars The Old Republic", release_date: "12/20/2011", publisher_id: p3.id}),
    Game.create({name: "Titanfall 2", release_date: "10/28/2016", publisher_id: p3.id}),
    Game.create({name: "Madden NFL 20", release_date: "8/2/2019", publisher_id: p3.id})
]

users = [
    User.create({username: "TheStupendousOne", name:"Geoffrey", password: "Password1", critic?: true}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean}),
    User.create({username: Faker::Internet.username, name:Faker::Name.name, password: Faker::Alphanumeric.alphanumeric(number: 10), critic?: Faker::Boolean.boolean})
]

users.each do |user|
    20.times do
        Review.create({game_id: games[rand(games.length)].id, user_id: user.id, date: "4/15/2020", score: rand(1..10), review_text: Faker::Lorem.sentence(word_count: 5)})
    end
end

