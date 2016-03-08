# subsets for when teeth brushing was occuring
df1 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 170115", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 170445", tz = "GMT") ) 

df2 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 180505", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 180915", tz = "GMT") ) 

df3 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 182700", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 183050", tz = "GMT") )

df4 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 215515", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 215800", tz = "GMT") )

plot.data(df1)
plot.data(df2)
plot.data(df3)
plot.data(df4)