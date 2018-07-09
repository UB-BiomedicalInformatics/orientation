library(plotly)

# Basic plot ----
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

# Save basic ggplot object as p ----
p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))

# Build plots using p ----
p + geom_point()
p + geom_line()
p + geom_smooth() # add smooth regression line
p + geom_point() + geom_smooth()

# Using pipes ----
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Simple log tranformation ----
ggplot(gapminder, aes(x = log10(gdpPercap), y = lifeExp)) + 
  geom_point()

# A better way to log transform ----
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() + 
  scale_x_log10()

p <- p + scale_x_log10() # Let's save that as the new basic plot object

ggplotly(p + geom_point(aes(color = continent)))

## add summary(p)!
plot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + scale_x_log10() # in full detail, up to now

# Adjust transparency to correct overplotting ----
p + geom_point(alpha = (1/3), size = 3)

# Let's look at lifeExp vs year ====

# geom_jitter ----
ggplot(gapminder, aes(x = year, y = lifeExp, color = continent)) +
  geom_point(alpha = 1/3, size = 3)

ggplot(gapminder, aes(x = year, y = lifeExp, color = continent)) +
  geom_jitter(alpha = 1/3, size = 3)

# Faceted plots ----
ggplot(gapminder, aes(x = year, y = lifeExp, color = continent)) +
  facet_wrap(~ continent, scales = "free_x") +
  geom_jitter(alpha = 1/3, size = 3) 

# Distributions ====
ggplot(gapminder, aes(x = gdpPercap)) +
  geom_histogram()

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram()

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "dodge")

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(alpha = 0.3)

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram() +
  facet_grid(~continent)

ggplotly(ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram() +
  facet_wrap(~continent))

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density()

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.3)

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density() +
  facet_grid(~continent)

ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density() +
  facet_wrap(~continent)

ggplot(gapminder, aes(x = lifeExp, fill = continent)) + 
  geom_histogram() +
  facet_grid(continent ~ .)

ggplotly(ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + geom_bin2d())

# try geom_violin() instead and just generally goofing off now
ggplotly(ggplot(gapminder, aes(x = year, y = lifeExp)) +
  geom_violin(aes(group = year)) +
  geom_jitter(alpha = 1/4) +
  geom_smooth(se = FALSE))
