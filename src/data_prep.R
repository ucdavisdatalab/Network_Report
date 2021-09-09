# to prepare data for ingest into the social network report dashboard

# This file will give you a template for the data expected by the network dash-
# board. As your data matches the examples provided here, you should be able to
# drop your data into the report without additional work. Keep in mind that you
# may have to do some work to get your data into this expected format.

# Additionally, you will need to denote some of the properties of the network
# at the start of the report document, including a random seed, if the network
# is directed, and if there are multiplex edges.

# Setup ####

# no packages needed

# data in/out ####

bis = read.csv("data/LG Network Map - Current Draft(1).csv", header = TRUE, stringsAsFactors = FALSE)[-1,]

# data prep ####

## split into nodes and edges ####

# split nodes off
nodes = bis[bis$Shape.Library != "", ]
# and clean
nodes = data.frame("id" = trimws(nodes$Id),
                  "text" = substring(nodes$Text.Area.1,  16, 99999),
                  "text_id" = substring(nodes$Text.Area.1,  1, 14),
                  "type" = nodes$Name,
                  stringsAsFactors = FALSE)

# split edges off
edges = bis[bis$Source.Arrow != "",]
# and clean
edges = data.frame("from" = edges$Line.Source,
                  "to" = edges$Line.Destination,
                  "weight" = NA,
                  "id" = edges$Id,
                  "type" = edges$Name,
                  stringsAsFactors = FALSE)

sample_net = graph_from_data_frame(edges, vertices = nodes, directed = FALSE)

# save ####

# save out the network as a R data file.
saveRDS(sample_net, "./data/dl_net.rda")


