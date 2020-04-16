# Furry Finder CLI APP

This CLI application simulates a dog shelter network management software. The purpose of this application is to provide management of dog data as dogs come into and are adopted out of shelters. Throught this application, a dog may be added to a shelter, adopted by a foster parent, and adopted by a regular adopter.

#

## Application Structure and Rules

### Login
* Users may create a new username by entering a username onto the login screen.
* There may not be duplicate usernames.
* Once a username is defined, the user may log back into the application by using the same username.
* *Shelters may log in by using the super secret keyword "shelter" at the login prompt and selecting a shelter.

### Shelters
* Shelters may view their own profile. Properties for a shelter include:
   * Name
   * Address
* Shelters may update their all properties in thier profile
* Shelters may add new dogs into themselves.
* Shelters may update their dogs' properties including:
   * Name
   * Age
   * Breed
   * Traits

#### Foster Parents
Foster parents are users that have joined at least one shelter
* Foster parents may view their own profile. Properties for foster parents include:
   * Username
   * Address
   * Traits
   * Desired Dog Breed
   * Desired Dog Age
* Foster parents may update all items in their profile except username.
* Foster parents may adopt a dog from other foster parents if the dog has been declared as adoption ready.
* Foster parents may adopt a dog from only the shelters to which they belong.
* Foster parents may update their dogs' properties including:
   * Name
   * Age
   * Breed
   * Traits
   * Adoption Ready
* Foster parents can join shelters for which they do not already belong.

#### Adopters
Adopters are users that have not joined a shelter.
* Adopters may view their own profile. Properties for adopters include:
   * Username
   * Address
   * Traits
   * Desired Dog Breed
   * Desired Dog Age
* Adopters may update all items in their profile except username.
* Adopters may adopt a dog from foster parents only if the foster parent has declared the dog as adoption ready.
* Adopters may not adopt dogs directly from a shelter.
* Adopters can become a foster parent by joining a shelter.

#

## Program Flow
The program flow is largely based on the movement of dogs to different owners. The following will attempt to illustrate this ownership flow.

#### Dog Added to Shelter
When a dog is added to the shelter, the shelter enters a name, age, breed, and traits of the dog. While the dog is at the shelter, the shelter may update any of the dog's properties. 

#### Dog Adoption by Foster Parent
Only a foster parent may adopt a dog from a shelter. Once adopted, the ability to update the dog's properties is transferred to the foster parent. In addition to name, age, breed, and traits, the adopter may also declare the dog as adoption ready. Once adoption ready, the dog may be adopted by regular adopters.

It is worth noting that foster parents may adopt from other foster parents, however, they are considered as regular adopters when doing so. Therefore, a foster parent is not allowed to adopt a dog from a foster parent if the dog is not declared as adoption ready.

#### Dog Adoption by Regular Adopter
As stated before, regular adopters may not adopt dogs directly from the shelter. They may only adopt a dog once the dog has been considered "adoption ready" by the foster parent. Once adopted, the dog's shelter and foster parent attachments are cleared, and the adopter becomes the new owner of the dog. Since adopted dogs are no longer part of the shelter system, an adopted dog's properties may not be altered in this application.