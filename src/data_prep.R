# to prepare data for ingest into the social network report dashboard

# Setup ####

# data in/out ####

bis = read.csv("data/LG Network Map - Current Draft(1).csv", header = TRUE, stringsAsFactors = FALSE)

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
edges = data.frame("id" = edges$Id,
                  "from" = edges$Line.Source,
                  "to" = edges$Line.Destination,
                  "type" = edges$Name,
                  stringsAsFactors = FALSE)
