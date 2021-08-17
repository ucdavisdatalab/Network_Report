# to prepare data for ingest into the social network report dashboard

# Setup ####

# data in/out ####

bis = read.csv("data/LG Network Map - Current Draft(1).csv", header = TRUE, stringsAsFactors = FALSE)[-1,]

# data prep ####

## split into nodes and edges ####

# split nodes off
nodes = bis[bis$Shape.Library != "", ]
# and clean
nodes = data.frame("id" = nodes$Id,
                  "text" = substring(nodes$Text.Area.1,  16, 99999),
                  "text_id" = substring(nodes$Text.Area.1,  1, 14),
                  "type" = nodes$Name,
                  stringsAsFactors = FALSE)

# split edges off
edges = bis[bis$Source.Arrow != "",]
# and clean
edges = data.frame("from" = edges$Line.Source,
                  "to" = edges$Line.Destination,
                  "id" = edges$Id,
                  "type" = edges$Name,
                  stringsAsFactors = FALSE)

# save ####
write.csv(nodes, "./data/nodes.csv", row.names = FALSE)
write.csv(edges, "./data/edges.csv", row.names = FALSE)
