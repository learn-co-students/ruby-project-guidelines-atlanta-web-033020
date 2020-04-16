# Furry Finder CLI APP

This CLI application simulates a dog shelter network management software. The purpose of this application is to allow shelters to list new dogs, and allow foster parents to foster a dog, and allow users to adopt a dog.

## Application Structure

### Rules

There are a few rules that define the structure of this application.

#### Login
1. Users may create a new username by entering a username onto the login screen.
2. There may not be duplicate usernames.
3. Once username is defined, user may log in using this username.
4. Shelters may log in by using the super secret keyword "shelter" at the login prompt and selecting a shelter.

#### Shelters
1. Shelters can view their own profile. Properties for a shelter include:
   * Name
   * Address
2. Shelters can change their own profile
   * Address
3. Shelters can add new dogs into themselves.
4. Shelters can update their dogs' properties including:
   * Name
   * Age
   * Breed
   * Traits

#### Foster Parents
Foster parents are users that have joined at least one shelter
1. Foster parents can view their own profile. Properties for foster parents include:
   * Username
   * Address
   * Traits
   * Desired Dog Breed
   * Desired Dog Age
2. Foster parents can change all items in their profile except for username.
3. Foster parents can adopt a dog from other foster parents only if the dog has been declared as adoption ready.
4. Foster parents can adopt a dog from only the shelters to which they belong.
5. Foster parents can manage dogs that belong to them including updates to name, age, breed, and traits. They may also declare a dog as adoption ready.
6. Adopters can join shelters for which they do not already belong.

#### Adopters
Adopters are users that have not joined a shelter.
1. Adopters can view their own profile. Properties for adopters include:
   * Username
   * Address
   * Traits
   * Desired Dog Breed
   * Desired Dog Age
2. Adopters can change all items in their profile except for username.
3. Adopters can adopt a dog from foster parents only if the foster parent has declared the dog as adoption ready.
4. Adopters cannot adopt dogs directly from a shelter.
5. Adopters can become a foster parent by signing up at a shelter.



### Program Flow
The program flow is largely based on the movement of dogs to different owners.

#### Dog Added to Shelter
When a dog is added to the shelter, the shelter enters a name, age, breed, and traits of the dog. While the dog is at the shelter, the shelter may update any of the dog's properties. 

#### Dog Adoption by Foster Parent
When a dog is in a shelter, only a foster parent may adopt him/him. Once adopted, the shelter may no longer update the dog's information. Instead, only the foster parent can update the dog's properties including the adoption ready property. The adoption ready property allows the dog to be adopted by regular adopters.

It is worth noting that foster parents can adopt from other foster parents. However, when doing so, they are considered as regular adopters. Because of this, a foster parent is not allowed to adopt a dog that is not considered adoption ready by the dog's foster parent.

#### Dog Adoption by Adopter
As stated before, regular adopters cannot adopt dogs directly from the shelter and may only do so once the dog has been considered "adoption ready" by the foster parent. Once adopted, the dog's shelter and foster parent attachments are cleared, and the adopter becomes the new owner of the dog. Since adopted dogs are no longer part of the shelter system, an adopted dog's properties cannot be altered by this application.