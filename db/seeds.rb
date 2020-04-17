Event.destroy_all
User.destroy_all
UserEvent.destroy_all

event1 = Event.create(event_name: "Testing One")
event2 = Event.create(event_name: "Programming")
event3 = Event.create(event_name: "Computing")

user1 = User.create(user_name: "Johnny")
user2 = User.create(user_name: "Moxxie")
user3 = User.create(user_name: "Frederick")

user_event1 = UserEvent.create(date: "Now", user: user1, event: event1)
user_event2 = UserEvent.create(date: "Whenever", user: user1, event: event2)
user_event3 = UserEvent.create(date: "All the Time", user: user1, event: event3)
user_event4 = UserEvent.create(date: "Jan 12", user: user2, event: event2)



