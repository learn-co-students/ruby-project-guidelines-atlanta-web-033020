Event.destroy_all
User.destroy_all
UserEvent.destroy_all

event1 = Event.create(event_name: "Testing One")
event2 = Event.create(event_name: "Programming")
event3 = Event.create(event_name: "Computing")

user1 = User.create(user_name: "Johnny")
user2 = User.create(user_name: "Moxxie")
user3 = User.create(user_name: "Frederick")

user_event1 = UserEvent.create(date: "Now", event: event1, user: user1)
user_event2 = UserEvent.create(date: "Whenever", event: event2, user: user1)
user_event3 = UserEvent.create(date: "All the Time", event: event3, user: user1)
user_event4 = UserEvent.create(date: "Jan 12", event: event2, user: user2)



