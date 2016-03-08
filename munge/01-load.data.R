# load datasets

# orginal training dataset
org.df <- fread("data/TAS1E35150309 (2016-01-21)RAW.csv", stringsAsFactors = F, skip = 10, header = T, data.table = F)
# marie's data
test.df <- fread("data/TAS1E31150005 (2016-02-26)RAW.csv", stringsAsFactors = F, skip = 10, header = T, data.table = F)
# louis data
test.new <- fread("data/TAS1E31150003 (2016-02-26)RAW.csv", stringsAsFactors = F, skip = 10, header = T, data.table = F)

# merge maries
df <- rbind(org.df, test.df)
rm(org.df, test.df)
