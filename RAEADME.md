```docker-compose up -d```

database ```marshall``` port ```15432```

import schema from 'marshall_development' in to ```public```

create 2 schemas: ```staging```, ```transform```

schema **staging** is for pulling raw data from legacy DB kind of our target format


```psql -h localhost -p 15432 -d marshall -U postgres -f marshall_localhost-2023_03_01_13_45_35-dump.sql -W```

```ruby app/run.rb```