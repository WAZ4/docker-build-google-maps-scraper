from src import Gmaps

queries = [
   "Kennedy Space Center"
]

max_number_of_businesses=1

Gmaps.places(queries=queries, max=max_number_of_businesses)