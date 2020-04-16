def view_profile(user)
  puts ""
  puts "Your Profile:"
  puts "Username: #{user.username}"
  puts "Address: #{user.address}"
  show_user_criteria(user)
  puts "Press enter to return to Main Menu"
  gets.chomp
end

def update_profile_menu(user)
  puts ""
  choices = ["Address", "Traits", "Desired Dog Breed", "Desired Dog Age", "Back to Main Menu"]
  choice = PROMPT.select("What would you like to update?", choices)
  
  case choice
  when "Address"
    puts "Enter your address"
    user.update_address(get_address)
  when "Traits"
    puts "Select your traits"
    user.update_traits(select_traits)
  when "Desired Dog Breed"
    puts "Select desired dog breed"
    user.update_breed_preference(get_dog_breed)
  when "Desired Dog Age"
    puts "Enter desired dog age"
    user.update_dog_age_preference(get_dog_age)
  end
end

def adopt_from_foster_menu(user)
  puts ""
  puts "Your criteria:"
  show_user_criteria(user)

  puts "Press Enter to search dogs with your criteria:"
  gets.chomp
  dogs = show_list_of_compatible_dogs(user)

  if dogs.empty?
    puts "Looks like all the dogs are adopted!"
    puts "Press enter to return to the main menu."
    gets.chomp
  else
    choice = PROMPT.select("Please select a dog to adopt", per_page: 10) do |menu|
      dogs.each_with_index do |d, i|
        menu.choice "#{i + 1}. #{d.name} the #{d.breed}", i
      end
      menu.choice "Nevermind, I don't want to adopt"
    end
    
    if choice != "Nevermind, I don't want to adopt"
      new_best_friend = dogs[choice]
    
      user.adopt_dog(new_best_friend)
    
      puts "Thank you for adopting #{new_best_friend.name}!"
      puts "I've never seen his tail wag so fast!"
      puts "Press enter to return to the main menu."
      gets.chomp
    end
  end
end

def show_user_criteria(user)
  puts "Traits: #{user.traits.map { |t| t.trait_name }.join(", ")}"
  puts "Desired Dog Breed: #{user.dog_breed_preference}"
  puts "Desired Dog Age:  #{user.dog_age_preference}"
  puts ""
end

def show_list_of_compatible_dogs(user)
  dogs = user.find_compatible_dogs.map { |d| d[:dog]}[0...20]
  puts ""
  table = TTY::Table.new header: ['', 'Name', 'Breed', 'Age', 'Traits']
  dogs.each_with_index do |d, i|
    index = 0
    traits = d.traits
    loop do
      if index == 0
        table << [i + 1, d.name, d.breed, d.age, traits[index] == nil ? "" : traits[index].trait_name]
      else
        table << ["", "", "", "", traits[index].trait_name]
      end
      index += 1
      break if index >= traits.length
    end
  end
  puts table.render(:unicode)
  dogs
end

def get_address
  PROMPT.ask("Address:")
end

def select_traits
  choices = Trait.all.each_with_index.map { |t, i| "#{t.trait_name}" }
  PROMPT.multi_select("Select your traits:", choices)
end

def get_dog_breed
  choices = Dog.all.map { |dog| dog.breed }.uniq
  PROMPT.select("Select your desired dog breed", choices)
end

def get_dog_age
  age = PROMPT.ask("Age:")
end

def get_dog_name
  puts ""
  puts "Enter the dog's name"
  PROMPT.ask("Name:")
end

def join_shelter_menu(user)
  shelters = Shelter.shelters_not_joined(user)

  choice = PROMPT.select("Which shelter would you like to join?", per_page: 10) do |menu|
    shelters.each_with_index do |s, i|
      menu.choice "#{s.name} at #{s.address}", i
    end
    menu.choice "Nevermind, I don't want to join a shelter"
  end

  if choice != "Nevermind, I don't want to join a shelter"
    user.join_shelter(shelters[choice])
  end
end