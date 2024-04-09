## Ecko v-0.0.2

- Manage singleton services, make the classes singleton and solve the problem of
  dependency injection, i.w A simple service locator to manage services

-

- What I need is a disciplined approach to help write scalable and reliable code

- Can use either type, for idle and error for states or idle, loading and error for
  future states

  Can make handling various states of state easier, like loading state, error state, etc.

- Interdependent states
- Inherited widget based approach
- Controller based

---

- ViewModel based approach is very good

  - Good architecture
  - Idle, loading and error states

  - Interdependent states (use graph, update child nodes when root node is mutated)
  - Multiple states in a single viewModel (can make the build widget to listen to
    specific states, it can be a list)

    [INIT]

  - way to create instances of viewModel, manually or when builder is listening to
    a viewModel. So all the states can be initialised, and it should be a singleton

    [dependencies]

  - Interdependent viewModels (create a function for viewModel to
    create their instance if not already created)

    [delete]

  - Option to keep viewModels in memory even after the builder is disposed, way
    to manually delete viewModels like controllers

<!-- - Store states as simple variables, and update the UI w/ an function -->

- Store states in a state class, w/ depends on, update, set functions

  - Avoids valueNotifier or stream overhead from the app
  - Removes the need of dispose

  - How to update UI for the specific state (builder widget can choose from states
    available in viewModel to update when they are mutated)

    <!-- (create option in builder widgets to choose, like reactive to either true or false) -->
