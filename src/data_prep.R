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

nodes = read.csv("data/Node_Attributes_For_Jared_V2.csv", header = TRUE, stringsAsFactors = FALSE)
edges = read.csv("data/Edge_List_Template_V2.csv", header = TRUE, stringsAsFactors = FALSE)

# data prep ####

nodes = nodes[, c(2,1,3,4)]
colnames(nodes) = c("id", "text", "group_1", "group_2")

edges = edges[, c(2,4,1,3)]
colnames(edges) = c("from", "to", "from_text", "to_text")

# make net

sample_net = igraph::graph_from_data_frame(edges, vertices = nodes, directed = TRUE)

# save ####

# save out the network as a R data file.
saveRDS(sample_net, "./data/my_bis2a_net.rds")


