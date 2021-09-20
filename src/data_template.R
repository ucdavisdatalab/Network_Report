# to prepare data for ingest into the social network report dashboard

# This file will give you a template for the data expected by the network dash-
# board. If your data matches the examples provided here, you should be able to
# drop your data into the report without additional work. If it does not you
# will need to do some work to get your data into this expected format.

# Additionally, you will need to denote some of the properties of the network
# at the start of the report document, including a random seed.

# Setup ####

library(igraph)

# synthetic data generation ####

# Networks require two data files: 1) a file to denote the things in a network 
# (nodes), and 2) a file to denote the connections in the network (edges).

## Synthetic attributes (nodes) dataframe ####

# An attributes file contains all the information about individual nodes in the
# network. This includes a unique identifier, plus anything else you know about
# the node. Sometimes this includes things like height or age (for people), 
# location and owner (for buildings), address and type (for web pages), etc. If
# there is anything you would like to organize the nodes by, this is where it
# would go. Later on, calculated network metrics will also be stored here.

# N.B. The first column MUST be named "id"

### Columns

# id:     (REQUIRED) The unique identifier for the node
# group:  A categorical grouping of nodes
# OTHER:  Other columns are currently ignored

nodes = data.frame(
  "id" = c("Samantha Carter", "Alyx Vance", "Jesse Faden", "Ramona Flowers", "Ameiko Kaijitsu", "Paul Atreides", "Gordon Freeman", "Levi Ackerman", "Spike Spiegel", "Edward Elric"),
  "group" = c("A", "B", "C", "A", "B", "C", "A", "B", "B", "A"),
  "age" = c(41, 24, 30, 24, 31, 33, 27, 33, 27, 18),
  "hair_color" = c("Blonde", "Black", "Red", "Varies", "Black", "Black", "Brown", "Black", "Green", "Blonde"),
  stringsAsFactors = FALSE)

# sort alphabetically for easier navigation later
nodes = nodes[order(nodes$id), ]

## Synthetic edgelist (edges) ####

# An edgelist file contains all information of how nodes are connected or
# related. After adding information on the sender and receiver of ties using
# the ids from the attribute file, you can start specifying other metadata.
# You could include the "weight" or value of that tie, the type, or a time stamp.

# N.B. The first column must be named "from" and the second must be named "to"
# These values must match the "id" column in the attribute file. Connections
# originate from the "from" node and go to the "to" node. This is important for
# directed networks; if your network is un-directed, it does not matter.

### Columns

# from:   (REQUIRED) Node id which is the source of connection
# to:     (REQUIRED) Node id which is the end of connection
# weight: Optional numeric weight denoting importance of connection (higher
#         more important). DO NOT INCLUDE if not important or all NAs.
# other:  Other columns currently ignored

edges = data.frame(
  "from" = c("Jesse Faden", "Levi Ackerman", "Samantha Carter", "Ameiko Kaijitsu", "Paul Atreides", "Levi Ackerman", "Alyx Vance", "Jesse Faden", "Ramona Flowers", "Gordon Freeman", "Alyx Vance", "Ramona Flowers", "Gordon Freeman", "Alyx Vance", "Jesse Faden"),
  "to" = c("Samantha Carter", "Samantha Carter", "Alyx Vance", "Levi Ackerman", "Alyx Vance", "Jesse Faden", "Ramona Flowers", "Ameiko Kaijitsu", "Ameiko Kaijitsu", "Paul Atreides", "Gordon Freeman", "Levi Ackerman", "Spike Spiegel", "Spike Spiegel", "Edward Elric"),
  "weight" = c(1,5,2,7,3,1,6,8,3,1,5,7,2,5,5),
  stringsAsFactors = FALSE)

## Create igraph network ####

# Once you have the two parts of your network, you can use them to create an
# igraph network object. The example below creates an un-directed network. If
# you would want a directed network, change the argument `directed` below from
# FALSE to TRUE. In a directed network, the sender and received of a connection
# are distinct, like a follow on twitter. In contract, and un-directed network
# treats all connections as mutual, like a friend on facebook. This will have
# a significant effect on how things are measure in the report, so please
# give thought to what you pick!

sample_net = graph_from_data_frame(edges, vertices = nodes, directed = FALSE)

# save ####

# The last step is to save out the network! This rda file will be what the
# network report reads in. 

# save out the network as a R data file.
saveRDS(sample_net, "./data/sample_net.rds")
