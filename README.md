# 1State Proto

Prototype for a state management lib in flutter

### Features

- Stores
- Graph (for stores dependency)
- StateBuilder (to rebuild the ui)
- Controller (help segregate state logic)
- Dependency Injection management for controllers
- StateWidget (for east state management)

### Structure

- Stores,
  - ValueStore (For single values)
  - StreamStore (For objects, streams, etc.)
    (Needs to be interdependent, both should implement a single interface)
- Graph
  - A store can be dependent on another store
