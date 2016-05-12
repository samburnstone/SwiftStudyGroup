/*:

## Structs and Classes.

The book recommends using classes when an object has an explicit lifecycle i.e. created, changed then destroyed
e.g. *NSFileHandle*.
A struct is suitable for types where if two instances have the same properties, they can be considered equal, such as a *URL*
___

Values never change - they are *immutable*, which is handy if we want our code to be thread-safe: anything that cannot change can be safely shared across threads.
___

As structs have a single owner, a reference cycle cannot be created.
_____

Performance on an array of just structs is usually much faster than an array containing objects due to structs having less indirecton: the values are stored directly inside the array's memory. In many cases, the compiler can put structs on the stack, rather than on the heap which also boots speed.
*/