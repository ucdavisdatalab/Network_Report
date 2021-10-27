group_iter = "group_1"


# I'm so sorry for this. It subsets the nodes dataframe to only include the iterative group column and iterative group color column
test = vnet$nodes[, !(colnames(vnet$nodes) %in% colnames(vnet$nodes)[grep("group_", colnames(vnet$nodes))][!(colnames(vnet$nodes)[grep("group_", colnames(vnet$nodes))] %in% colnames(vnet$nodes)[grep(group_iter, colnames(vnet$nodes))])])]


test_melt = reshape2::melt(test)

# this could break a lot of things depending on the other columns from dataset
gsub("_\\d+", "", colnames(test_melt))



do.call(rbind, by(data = test_melt, INDICES = list(as.factor(melt_nodes$group_1), as.factor(melt_nodes$variable)), FUN = function(mes){
  data.frame("group" = mes$group_1[1], "variable" = mes$variable[1], "value" = mean(mes$value), "color" = mes$group_1_color[1], stringsAsFactors = FALSE)
}))



# now just need to make the group and group color column arbitrary.
















# melt the node attributes
melt_nodes = reshape2::melt(vnet$nodes)
# aggregate by group
melt_nodes = do.call(rbind, by(data = melt_nodes, INDICES = list(as.factor(melt_nodes$group), as.factor(melt_nodes$variable)), FUN = function(mes){
  data.frame("group" = mes$group[1], "variable" = mes$variable[1], "value" = mean(mes$value), "color" = mes$color[1], stringsAsFactors = FALSE)
}))

# make plots for each network attribute

## degree
degree_bell = ggplot(melt_nodes[melt_nodes$variable == "degree",], aes(x=variable, y=value)) +
  geom_segment(aes(x=variable, xend=variable, y=min(value), yend=max(value)), linetype="dashed", size=0.1) +   # Draw dashed lines
  geom_point(aes(col=group), size=5) +   # Draw points
  labs(title="Total Degree", subtitle=NULL, color = "Group") + xlab(NULL) + ylab("Mean Value") +
  theme_classic(base_size = 12) + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) + coord_flip() +
  scale_color_manual(name = "Group", breaks = unique(melt_nodes$group), values = structure(melt_nodes[1:length(unique(melt_nodes$group)), "color"], .Names = melt_nodes[1:length(unique(melt_nodes$group)), "group"]))

## mean_geodist
gdist_bell = ggplot(melt_nodes[melt_nodes$variable == "mean_geodist",], aes(x=variable, y=value)) +
  geom_segment(aes(x=variable, xend=variable, y=min(value), yend=max(value)), linetype="dashed", size=0.1) +   # Draw dashed lines
  geom_point(aes(col=group), size=5) +   # Draw points
  labs(title="Mean Geodesic Distance", subtitle=NULL, color = "Group") + xlab(NULL) + ylab("Mean Value") +
  theme_classic(base_size = 12) + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) + coord_flip() +
  scale_color_manual(name = "Group", breaks = unique(melt_nodes$group), values = structure(melt_nodes[1:length(unique(melt_nodes$group)), "color"], .Names = melt_nodes[1:length(unique(melt_nodes$group)), "group"]))

## norm_betweenness
bet_bell = ggplot(melt_nodes[melt_nodes$variable == "norm_betweenness",], aes(x=variable, y=value)) +
  geom_segment(aes(x=variable, xend=variable, y=min(value), yend=max(value)), linetype="dashed", size=0.1) +   # Draw dashed lines
  geom_point(aes(col=group), size=5) +   # Draw points
  labs(title="Norm Betweenness", subtitle=NULL, color = "Group") + xlab(NULL) + ylab("Mean Value") +
  theme_classic(base_size = 12) + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) + coord_flip() +
  scale_color_manual(name = "Group", breaks = unique(melt_nodes$group), values = structure(melt_nodes[1:length(unique(melt_nodes$group)), "color"], .Names = melt_nodes[1:length(unique(melt_nodes$group)), "group"]))

## eigenvector
evc_bell = ggplot(melt_nodes[melt_nodes$variable == "evc",], aes(x=variable, y=value)) +
  geom_segment(aes(x=variable, xend=variable, y=min(value), yend=max(value)), linetype="dashed", size=0.1) +   # Draw dashed lines
  geom_point(aes(col=group), size=5) +   # Draw points
  labs(title="Eigenvector", subtitle=NULL, color = "Group") + xlab(NULL) + ylab("Mean Value") +
  theme_classic(base_size = 12) + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank()) + coord_flip() +
  scale_color_manual(name = "Group", breaks = unique(melt_nodes$group), values = structure(melt_nodes[1:length(unique(melt_nodes$group)), "color"], .Names = melt_nodes[1:length(unique(melt_nodes$group)), "group"]))

# show combined plots
ggpubr::ggarrange(degree_bell, gdist_bell, bet_bell, evc_bell, ncol = 1, nrow = 4)