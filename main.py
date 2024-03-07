import sys
from src import Gmaps

def is_int(num):
    try:
        float(num)
        return True
    except ValueError:
        return False
        
def isascii(s):
    return len(s) == len(s.encode())

if ( len(sys.argv) < 4 or not is_int(sys.argv[1]) or not is_int(sys.argv[2]) ):
    print("Usage: {} max_nr_of_businesses_to_search max_nr_of_reviews query...".format(sys.argv[0]))
    print("If max_nr_of_reviews is negative it will retrieve all reviews")
    sys.exit(1)

queries = [" ".join(sys.argv[3:])]

if (not isascii(queries[0])):
    print("The query must be ASCII characters only!")

max_number_of_businesses= int(sys.argv[1])
reviews_max= int(sys.argv[2])
if (reviews_max <= 0):
    reviews_max = None

Gmaps.places(queries, scrape_reviews=True, reviews_max=reviews_max, max=max_number_of_businesses)