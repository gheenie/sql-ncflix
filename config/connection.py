import pg8000.native
from config._env_development import (user, password)


con = pg8000.native.Connection( 
    user, password=password, database='nc_flix')
