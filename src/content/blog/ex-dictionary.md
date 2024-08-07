---
author: tpotts
pubDatetime: 2023-09-27T00:00:00Z
title: Dictionary of Terms
slug: ex-dictionary
featured: true
draft: false
tags:
  - dictionary
description: As I understand them
---

This is a reference for myself, that I update as I further understand terms, and expand on their definitions. Don't take anything here as gospel, I'm frequently wrong and I appreciate correction!

# Dictionary

### Key

- **Bold** is a defined term
- _Italics_ is an assumed known term

### Contents

##### Because y'know programmers love to use confusing language

- **Class**: A template for creating **objects** – it is conceptual so is not represent any specific **state**, but generally shows what the object is and what it can do. It generally has:
  - Properties / Attributes: Defining what makes up the **object**, and or it's capabilities;
  - Methods / Functions: Defining what the **object** can do
  - Classes are static.
    <br>
    <br>
- **Constructor**: Special functions for **classes** – specifically for creating new **objects**. They have these unique properties / functions:
  - Initialise new **objects** when created
  - They are automatically called when creating the **object(s)**
  - They cannot _return_ values
  - They do not have a _declaration keyword_ "constructor" – e.g. in Dart you use the **class** name
    <br>
    <br>
- **Object**: A specific example of a **class**. Objects are explicitly created using a class, often through calling a constructor defined in the class. It generally has:
  - Real values but each object can have different values from another object from the same class.
  - Structure / Behaviour defined by the class that the object adheres to
    <br>
    <br>
- **Syntactic Sugar**: A method of providing more concise or programmer friendly code - depends on each language's syntax.

  - E.g. One way that Dart uses it is for **constructor** shorthand - otherwise we'd have to explicitly set the type after the **constructor** as below:

        class Spacecraft { String name; DateTime? launchDate;

            // Read-only non-final property
            int? get launchYear => launchDate?.year;

            // Constructor, with syntactic sugar for assignment to members.
            Spacecraft(this.name, this.launchDate) {
                // Initialization code goes here. }

    <br>

- **Type-inference**: A variable does not have to explicitly declare it's _type_, the language effectively knows from the data declared
  - E.g. `int year = 1997` is the same as `var year = 1997` in Dart
  - Be careful that types match each other! E.g. You think you have a static list but when you add to it – that's actually a dynamic list!
    <br>
    <br>
- **Type-safe**: A language (e.g. Dart) that has an environment that avoids any _type_ mismatches.
  - Dart does this specifically by **static-type checking** and _runtime checks_ – basically as you type and as it compiles it's checking what's expected versus actual data
    <br>
    <br>
