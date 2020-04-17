# Module 1 Final Project - Moxxie McDonald

# Description

This project was designed as a basic calendar that is capable of storing and persisting users and events.

# Project Requirements

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a  command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate models for your runner and CLI interface.

# Three Models
- User
- Events
- UserEvents

# CRUD ability
- Users
  - End Users can create a new User Instance using the CLI
  - End Users can delete their User Instnace using the CLI
  - End Users can update their Username using the CLI
  - End Users can read a list of all current users before signing in using the CLI
  - After signing in End Users are told the name of the current user signed in
- Events
  - End Users can see a list of their current events and at what time they occur
  - End Users can Create new events if they provide a name and a date for the event to occur
  - End Users can delete events from their list
  - End Users can edit events to change the name and time of the event
  
# Functionability
- End Users are able to move forward and back in the menus to complete tasks

# Install Instructions
1. Fork and Clone this repository and navigate in your text editor (I use VS Code) to the file directory
2. Use the Command "bundle install" to install various gems
3. Use the Command "gem install 'tty-prompt'" to ensure that the gem TTY Prompt is installed
4. Use the Command "ruby bin/run.rb" to run the file
5. Enjoy
