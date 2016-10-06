



% Basic implementation of a (bi-directional) map as a list of pairs.
% Show cases a really neat use of running predicates backwards in Prolog.


% Delete existing key so we don't have same key more than once.


% ===========================================================================
% map_insert(Key, Val, Map1, Map2)
% Holds if Map2 is the result of inserting the pair Key -> Val into Map1.
% ===========================================================================


map_insert(Key, Val, InputMap, OutputMap) :-
    map_delete(Key, InputMap, Map),
    map_insert2(Key, Val, Map, OutputMap).

map_insert2(Key, Val, [], [pair(Key, Val)]).

map_insert2(Key, Val, [X | Xs], [pair(Key, Val), X | Xs]).



% ===========================================================================
% map_has(Key, Val, Map)
% Holds if Map has the given Key -> Val pair.
% ===========================================================================


% Head of list has the key-value pair.
map_has(Key, Val, [pair(Key, Val) | _]).

% Below predicate makes it bi-directional.
% Recurse on rest of list regardless of head.
map_has(Key, Val, [ _ | Rest]) :-
    map_has(Key, Val, Rest).



% ===========================================================================
% map_delete(Key, Map1, Map2)
% Holds if Map2 is the result of deleting the first Key -> _ pair in Map1.
% If Key isn't in Map1, then Map2 = Map1.
% ===========================================================================


% Deleting from empty map gives empty map.
map_delete(_, [], []).

% Target key at head of list.
map_delete(Key, [pair(Key, _) | Rest], Rest).

% Target key not at head of list.
map_delete(Key, [pair(Key2, Val2) | Rest], [pair(Key2, Val2) | Rest2]) :-
    Key \= Key2,
    map_delete(Key, Rest, Rest2).


