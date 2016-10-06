

:- [map].

% Represent a trie as a pair trie(Map, IsWord).
% Map: mapping of chars to child trie nodes.
% IsWord: whether the path frmo root trie to this trie is a word.

% The empty trie has no children 
empty_trie(trie([], false)).

% trie_has(Phrase, Trie): holds if the atom Phrase is contained in the Trie.
% Split Phrase into a list of characters, then defer to trie_has2.
trie_has(Phrase, Trie) :-
    atom_chars(Phrase, CharList),
    trie_has2(CharList, Trie).

% Base case: at end of string. Succeeds if that trie node is a word.
trie_has2([], trie(_, true)).

% Recursive case: succeed if there's a mapping from current character to some child trie.
% Then check if rest of word is contained in that child trie.
trie_has2([Char | String], trie(Map, _)) :-
    map_has(Char, ChildTrie, Map),
    trie_has2(String, ChildTrie).

% trie_insert(Phrase, Trie1, Trie2): holds if Trie2 is the result of inserting Phrase
% into Trie1. Break Phrase into a list of characters, then defer to trie_insert2.
trie_insert(Phrase, Trie1, Trie2) :-
    atom_chars(Phrase, CharList),
    trie_insert2(CharList, Trie1, Trie2).

% Base case: inserting empty string. Current trie becomes a word.
trie_insert2([], trie(Children, _), trie(Children, true)).

% Recursive case: inserting, where Char is in the Trie. Insert rest of word 
% into that child, producing ChildResult. Then map Char to ChildResult.
trie_insert2([Char | String], trie(MapIn, IsWord), trie(MapOut, IsWord)) :-
    map_has(Char, ChildTrie, MapIn), !,
    trie_insert2(String, ChildTrie, ChildResult),
    map_insert(Char, ChildResult, MapIn, MapOut).

% Recursive case: inserting, where Char not in the Trie. We create a new child node
% and insert the rest of the string into that. Then map Char to that child node.
trie_insert2([Char | String], trie(MapIn, IsWord), trie(MapOut, IsWord)) :-
    empty_trie(EmptyTrie),
    trie_insert2(String, EmptyTrie, ChildResult),
    map_insert(Char, ChildResult, MapIn, MapOut). 
    

