# trying dbscan clustering

## make wide datasets
df.summary.wide <- melt(df.summary %>% rename(metric = variable), id.vars = c("time_minute", "metric")) %>% 
  dcast(time_minute ~ metric + variable, fill = 0) 

times <- filter(df.summary, brushing >0) %>% select(time_minute) %>% distinct

## train pca model
pca.mdl <- preProcess(df.summary.wide %>% select(-time_minute, -vector.mag_brushing), method = "pca", pcaComp = 2)

## apply pca model, keep timestamp and brushing flag
df.summary.wide.pca <- cbind(time_minute = df.summary.wide$time_minute,
                               brushing = df.summary.wide$vector.mag_brushing,
                               predict(pca.mdl, df.summary.wide %>% select(-time_minute, -vector.mag_brushing)))

## plot results
ggplot(df.summary.wide.pca,
       aes(PC1, PC2)) + geom_point(aes(col = as.factor(brushing)))

## apply dbscan to data
set.seed(234)
d.cluster <- dbscan(df.summary.wide %>% select(-time_minute, -vector.mag_brushing), 
                    eps = .1, MinPts = 3, scale = TRUE)
## plot results
ggplot(cbind(cluster = d.cluster$cluster, df.summary.wide.pca), aes(PC1, PC2)) + geom_point(aes(col = as.factor(cluster)))

# what cluster are brushing events in
cbind(cluster = d.cluster$cluster, time_minute = as.character(df.summary.wide$time_minute)) %>% 
  data.frame %>% filter(time_minute %in% as.character(times$time_minute))


# kmeans
set.seed(234)
k.cluster <- kmeans(df.summary.wide %>% select(-time_minute, -vector.mag_brushing), centers = 25)
table(k.cluster$cluster)

# what cluster are events in
cbind(cluster = k.cluster$cluster, time_minute = as.character(df.summary.wide$time_minute)) %>% 
  data.frame %>% filter(time_minute %in% as.character(times$time_minute))

# cluster 8 looks promising
cbind(cluster = k.cluster$cluster, time_minute = as.character(df.summary.wide$time_minute)) %>% 
  data.frame %>% filter(cluster == 8)

