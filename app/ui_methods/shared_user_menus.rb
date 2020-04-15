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

    new_best_friend = dogs[selection.to_i - 1]
    user.adopt_dog(new_best_friend)
  
    puts "Thank you for adopting #{new_best_friend.name}!"
    puts "I've never seen his tail wag so fast!"
  end

  puts "Press enter to return to the main menu."
  gets.chomp
end