def join_shelter_menu(user)
  selection_valid = false
  options = []
  shelters = Shelter.shelters_not_joined(user)

  while !selection_valid
    index = 1
    puts ""
    puts "Which shelter would you like to join?"
    shelters.each do |shelter|
      puts "#{index}. #{shelter.name} at #{shelter.address}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection = gets.chomp
    
    selection_valid = check_valid_selection(options, selection)
  end

  user.join_shelter(shelters[selection.to_i - 1])
end

def adopt_from_foster_menu(user)
  selection_valid = false
  options = []
  selection = nil
  
  puts ""
  puts "Your criteria:"
  show_user_criteria(user)

  puts "Press Enter to search dogs with your criteria:"
  gets.chomp
  dogs = show_list_of_compatible_dogs(user)
  dogs.each_with_index { |d, i| options << (i + 1).to_s}

  if dogs.empty?
    puts "Looks like all the dogs are adopted!"
  else
    puts "Please select a dog to adopt or type \"quit\" to quit"
    while !selection_valid do
      selection = gets.chomp
      if selection == "quit"
        break
      end
      selection_valid = check_valid_selection(options, selection)
    end
    
    if selection != "quit"
      new_best_friend = dogs[selection.to_i - 1]
      user.adopt_dog(new_best_friend)
    
      puts "Thank you for adopting #{new_best_friend.name}!"
      puts "I've never seen his tail wag so fast!"
    end
  end

  puts "Press enter to return to the main menu."
  gets.chomp
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

def check_valid_selection(options, selection)
  if options.include? selection
    true
  else
    puts "Invalid selection received. Please choose again."
    false
  end
end

def update_dog_menu(dog)
  selection_valid = false
  options = ["1", "2", "3", "4"]

  while !selection_valid
    puts ""
    puts "What would you like to update?"
    puts "1. Name"
    puts "2. Age"
    puts "3. Breed"
    puts "4. Traits"
    puts "5. Main Menu"
    selection = gets.chomp
    
    if selection == "1"
      dog.update_name(get_dog_name)
    elsif selection == "2"
      dog.update_age(get_dog_age)
    elsif selection == "3"
      dog.update_breed(get_dog_breed)
    elsif selection == "4"
      dog.update_traits(get_dog_traits)
    elsif selection == "5"
      break
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def get_dog_name
  puts ""
  puts "Enter the dog's name"
  gets.chomp
end

def get_dog_age
  puts ""
  puts "Enter the dog's age"
  gets.chomp.to_i
end

def get_dog_breed
  dog_breeds = Dog.all.map { |dog| dog.breed }.uniq

  selection_valid = false
  options = []
  selection = ""

  while !selection_valid
    index = 1
    puts ""
    puts "Select the dog's breed"
    dog_breeds.each do |breed|
      puts "#{index}. #{breed}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection  = gets.chomp
    dog_breed = dog_breeds[selection.to_i - 1]

    selection_valid = check_valid_selection(options, selection)
  end
  dog_breed
end

def get_dog_traits
  trait_list = Trait.all
  puts ""
  puts "Select your traits separated by commas. i.e. 1,2,3"
  trait_list.each_with_index { |t, index| puts "#{index + 1}. #{t.trait_name}" }
  puts ""
  user_input = gets.chomp
  trait_nums = user_input.split(",")
  trait_nums.map { |t| t.strip } # remove white space
  .map { |t| trait_list[t.to_i - 1] } # map to trait instances
end