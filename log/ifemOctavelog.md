### unique

In matlab, the behavior of `unique`  has been changed.  This includes:

      -	occurrence of indices in IA and IC switched from last to first
      -	IA and IC will always be column index vectors
    
    If this change in behavior has adversely affected your code, you may 
    preserve the previous behavior with:
      
         [C,IA,IC] = unique(A,'legacy')
In ifem, we need 'last'. So in `myunique` different call of `unique` is provided depending on the version of matlab. 

In Octave, delete `myunique` file and replace `myunique` by `unique` in all calls since `unique` in Octave return the last index.

1. Search inside ifemOctave in Finder with `myunique`
2. replace `myunique` by `unique`  in searched files 

To edit these files easily, download ATOM, which is a very nice code editor, and install [language-matlab](https://atom.io/packages/language-matlab). 

