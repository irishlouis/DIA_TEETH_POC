# subsets for when subject teeth brushing was occuring
df1 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 170115", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 170445", tz = "GMT") ) 

df2 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 180505", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 180915", tz = "GMT") ) 

df3 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 182700", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 183050", tz = "GMT") )

df4 <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 215515", tz = "GMT") & Timestamp < dmy_hms("20/01/2016 215800", tz = "GMT") )

df5 <- df %>% 
  filter(Timestamp > dmy_hms("25/02/2016 171900", tz = "GMT") & Timestamp < dmy_hms("25/02/2016 172200", tz = "GMT") )

df6 <- df %>% 
  filter(Timestamp > dmy_hms("25/02/2016 230122", tz = "GMT") & Timestamp < dmy_hms("25/02/2016 230450", tz = "GMT") )

df7 <- df %>% 
  filter(Timestamp > dmy_hms("26/02/2016 072927", tz = "GMT") & Timestamp < dmy_hms("26/02/2016 073230", tz = "GMT") )

event1.plot <- plot.data(df1)
event2.plot <- plot.data(df2)
event3.plot <- plot.data(df3)
event4.plot <- plot.data(df4)
event5.plot <- plot.data(df5)
event6.plot <- plot.data(df6)
event7.plot <- plot.data(df7)

lapply(list("event1.plot","event2.plot","event3.plot",
            "event4.plot","event5.plot","event6.plot",
            "event7.plot"), 
       cache)

df1.zoomed <- df %>% 
  filter(Timestamp > dmy_hms("20/01/2016 170321", tz = "GMT") & 
           Timestamp < dmy_hms("20/01/2016 170326", tz = "GMT") ) %>%
  plot.data

##### 
# repeat for subject 2 Louis

# subsets for when subject teeth brushing was occuring
new.df1 <- test.new %>% 
  filter(Timestamp > dmy_hms("25/02/2016 214200", tz = "GMT") & Timestamp < dmy_hms("25/02/2016 214455", tz = "GMT") ) 

new.df2 <- test.new %>% 
  filter(Timestamp > dmy_hms("26/02/2016 080800", tz = "GMT") & Timestamp < dmy_hms("26/02/2016 081055", tz = "GMT") ) 

new.event1.plot <- plot.data(new.df1)
new.event2.plot <- plot.data(new.df2)

lapply(list("new.event1.plot","new.event2.plot"), 
       cache)

