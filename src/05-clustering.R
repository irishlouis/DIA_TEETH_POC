# trying dbscan clustering

## make wide datasets
test.summary.wide <- melt(test.summary %>% rename(metric = variable), id.vars = c("Timestamp", "metric")) %>% 
  dcast(Timestamp ~ metric + variable, fill = 0) 

times <- filter(test.results, event >0) %>% select(time_minute) %>% distinct
test.summary.wide <- test.summary.wide %>% filter(Timestamp %in% times$time_minute)

## train pca model
pca.mdl <- preProcess(test.summary.wide %>% select(-Timestamp), method = "pca", pcaComp = 2)

## apply pca model, keep timestamp
test.summary.wide.pca <- cbind(Timestamp = test.summary.wide$Timestamp, 
                               predict(pca.mdl, test.summary.wide %>% select(-Timestamp)))

## plot results
ggplot(test.summary.wide.pca %>% mutate(flag = ifelse(Timestamp %in% times$time_minute, 1, 0)),
       aes(PC1, PC2)) + geom_point(aes(col = as.factor(flag)))

## apply dbscan to pca data
d.cluster <- dbscan(test.summary.wide.pca %>% select(-Timestamp), eps = .05, MinPts = 3, scale = TRUE)
## plot results
ggplot(cbind(cluster = d.cluster$cluster, test.summary.wide.pca), aes(PC1, PC2)) + geom_point(aes(col = as.factor(cluster)))

cbind(cluster = d.cluster$cluster, Timestamp = as.character(test.summary.wide$Timestamp)) %>% 
  data.frame %>% filter(Timestamp %in% as.character(times$time_minute))

cbind(cluster = d.cluster$cluster, Timestamp = as.character(test.summary.wide$Timestamp)) %>% 
  data.frame %>% filter(cluster == 1)

# kmeans
k.cluster <- kmeans(test.summary.wide %>% select(-Timestamp), centers = 25)
table(k.cluster$cluster)
cbind(cluster = k.cluster$cluster, Timestamp = as.character(test.summary.wide$Timestamp)) %>% 
  data.frame %>% filter(Timestamp %in% as.character(times$time_minute))

cbind(cluster = k.cluster$cluster, Timestamp = as.character(test.summary.wide$Timestamp)) %>% 
  data.frame %>% filter(cluster == 21)