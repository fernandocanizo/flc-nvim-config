# README for syntax in vim

Taken from [Stack Exchange](https://vi.stackexchange.com/a/21249/44737).

For working with syntax and highlighting I have the following in my vimrc:

```vimscript
command SyntaxId echo synIDattr(synID(line("."), col("."), 1), "name")
```

Move the cursor to the place you want to inspect (e.g. a bracket) and execute `:SyntaxId`. It will print the name of the syntax item under the cursor.

a. If it prints nothing, your syntax match does not work.
b. If it prints the correct name, but is not higlighted, there is a problem with the `hi` statement.
c. If it prints a different name, you might want to look at `:help :syn-contains`, `:help :syn-contained` and `:help :syn-containedin`.
