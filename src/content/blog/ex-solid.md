---
author: tpotts
pubDatetime: 2023-11-08T00:00:00Z
title: SOLID Principles
slug: ex-solid
featured: true
draft: false
tags:
  - SOLID
description: A pratical explanation
---

# SOLID - A practical explanation

## The principles by Uncle Bob

These principles are designed to make development more readable, predictable and maintainable, they are:

**S - Single-responsibility principle:** "There should never be more than one reason for a class to change." In other words, every class should have only one responsibility.

**O - Open-closed principle:** "Software entities ... should be open for extension, but closed for modification."

**L - Liskov substitution principle:** "Functions that use pointers or references to base classes must be able to use objects of derived classes without knowing it."

**I - Interface segregation principle:** "Clients should not be forced to depend upon interfaces that they do not use."

**D - Dependancy inversion principle:** "Depend upon abstractions, \[not\] concretions."

That sounds like a bunch of jargon - because it is. I'll explain further below what it means for me.

### S - Single-responsibility principle

I'm sure we're all familiar with this:

![](/one_job.gif)

This principle means that a class (or module, function, or whatever) - only has one reason to change.

In Flutter this could mean that a widget should be responsible only for piece of the UI. For example, if you have a widget that displays user data, it shouldn't also be responsible for fetching that data. That fetching job should be delegated to a provider or service.

**Goal:** Understanding and Managing Changes - changes should only have a local impact, if a change in billing also impacts user authentication that's bad software.

### **O - Open-closed principle**

This second one is both a reversal and extension of the first rule - SRP. Consider below:

![](/open_closed_1.png)

If we were adhering strictly to SRP everytime - we'd always be making Edward Scissorhands, instead of a person who can use a lot of things including scissors.

This means that we should be writing our modules in a way that doesn't require us to refactor later if we want to add on a new module, or extend the functionality of that module.

For Flutter this would mean creating widgets that are easily extensible through composition. For example, if you have a button widget and later need a button with an icon, instead of modifying the original button, you can create a new widget that combines the original button with an icon.

**Goal:** Maintaining flexibility - by adhering to OCP then we can easily extend the functionality of new and existing modules.

### L - Liskov substitution principle

Now this one is a bit harder to explain, so remember this scene?

![](/lsp.gif)

In the movie both parents are black, but the child brought to the prison is white. This is the essence of LSP - a child object of a parent object needs to be able to behave in the exact same way.

Basically what it means is the lower-level objects and higher-level objects work the exact same way if they are part of the same class. The only use of a higher-level object is to extend the behaviour of the lower-level object without changing it's expected behaviour.

Just like if both parents are black, you don't get a white baby. That means that the white baby (as a higher-level object) of the parents (lower-level objects) violates the LSP.

**Goal:** Maintaining consistency in behaviour

### I - Interface-segregation principle

This principle is actuall quite straightforward:

![](/bring-me-everyone-gary-oldman.gif)

The point of ISP is that you break down large interfaces in favour of smaller interfaces. If you display all of the information in one go you risk overwhelming the user.

Break it down for them in chunks so the input is more accurate and the users are more attentive to the smaller details.

**Goal:** Reduce unnecessary implementation - and risk overwhelming the user or giving them unauthorised access

### D - Dependancy-inversion principle

This one actually took the most time for me to understand.

![](/canyousaythatagain.gif)

Anyway the best way I describe it is to think of a tree:

- The **trunk** represents the core functionality of your application.
- The **branches** represent the different layers or modules of your application.
- The **forks** or **junctions** between branches represent the abstractions or contracts that dictate how each branch (or layer) interacts with others.
- The **leaves** represent the end functionalities or features that users interact with.

When we are talking abstractions we are talking about in between layers that allow the layers of each application to be **de-coupled** from each other.

Now let's imagine this tree had different colours depending on how old it was, because it needed to camoflauge itself from predators depending on the seasons. Imagine that the season requires the tree to go from red to blue, but that the tree grows in the colour red, and matures to blue. So the tree has these properties:

- Young growth is at the top, and is red. It is putting all of it's energy into converting it's colour from red to green.
- Middle growth is half way down the tree, and is green. It is putting all of it's energy into converting it's colour from blue to green.
- Old growth is at the bottom, and is blue. It doesn't require any further output, the state is correct.

Instead of thinking of abstractions as a way to understand the tree by **removing** the colour element (which is impossible - like abstracting large concepts from an entire application accurately), it is seen as a half way “save point” if you will. For each layer, it would be as such:

- Young growth is at the top, and is red. It is now only putting in **half** of the energy required to go from red to yellow.
- **A forking branch (an abstraction) and is yellow** \- here the fork in the branch allows easier change for both the young and middle growth.
- Middle growth is half way down the tree, and is green.  It is now only putting in **half** of the energy required to go from green to blue.
- **A forking branch (an abstraction) and is aqua** \- here the fork in the branch allows easier change for both the middle and old growth.
- Old growth is at the bottom, and is blue

Likewise - let's say the seasons switched and the tree had to change from blue to red again. The process is same but instead of the colour at the bottom is blue, it's now red. The whole process has been flipped and so the abstractions help speed up the process.

Or think about it like this - in terms of an intelligence agency such as the CIA:

**1\. Presentation Layer (Field Agents):**

- **Description:** This is the user interface of the app. It's what users see and interact with.
- **Analogy:** Just as field agents interact directly with sources and environments, the presentation layer interacts directly with users. It gathers user inputs and displays outputs.
- **Example:** A user taps a button to submit a report.

**2\. Abstraction between Presentation and Logic (Mission Briefing):**

- **Description:** Defines what actions the UI can request but not how they're executed.
- **Analogy:** The mission briefing tells the field agent what to do but not the detailed analysis behind it.
- **Example:** The button knows it can initiate a "submit report" action, but it doesn't know how the report is processed or where it's stored.

**3\. Logic Layer (Analysts):**

- **Description:** Processes user input, decides what data to fetch or store, and contains the business logic.
- **Analogy:** Analysts receive raw data, analyze it, and produce actionable intelligence.
- **Example:** Upon receiving the "submit report" action, this layer checks the report for errors, maybe analyzes its content, and decides where to store it.

**4\. Abstraction between Logic and Data (Secure Communication Channels):**

- **Description:** Defines what data operations can be performed but not how they are executed.
- **Analogy:** The encrypted communication methods ensure data is transferred securely without revealing the method of encryption to either end.
- **Example:** The logic layer knows it needs to store a report but doesn't know the specifics of how the database operates.

**5\. Data Access Layer (Data Repositories):**

- **Description:** The methods and operations to interact with the data, without concerning itself with the actual storage mechanism.
- **Analogy:** The secure databases where raw intelligence is stored. They know how to store and retrieve data but not the significance of the data.
- **Example:** This layer takes the report and knows how to format it for storage, whether it's in a cloud database, local storage, etc.

**6\. Abstraction between Data Access and Database (Not needed in Firestore, but let's imagine):**

- **Description:** Determines how data should be passed to the database but not the specifics of database operations.
- **Analogy:** Think of it as the protocol for how data is handed off between the data repository and a secure vault.
- **Example:** The data access layer knows it needs to save a report but doesn't know the intricacies of how the database system writes that data to disk.

**7\. Database (The Secure Vault):**

- **Description:** The actual storage of the data.
- **Analogy:** The ultra-secure vaults where the most sensitive intelligence is kept. They store items but don't know their significance.
- **Example:** The database system takes the report data and writes it to disk, ensuring data integrity and redundancy.

**Goal:** It allows for easier replacement / movement of layers. Replacing one layer won't destroy the whole workflow.
