# summarise datasets

org.df.summary   <- summary.df(org.df, freq = 100, k=10)          # org data used to generate fingerprint
test.df.summary  <- summary.df(df = test.df, freq = 100, k=10)    # marie
test.new.summary <- summary.df(test.new, freq = 100, k=10)        # louis