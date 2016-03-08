# summarise datasets

df.summary  <- summary.df(df = df, freq = 100, k=10)              # marie
test.new.summary <- summary.df(test.new, freq = 100, k=10)        # louis

cache("df.summary")
cache("test.new.summary")
