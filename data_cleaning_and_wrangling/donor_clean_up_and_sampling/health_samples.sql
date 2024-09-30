create or replace table `marketeam_data.health_samples`
(account_id string,
sustainer_flag bool)
as
((select
  account_id,
  sustainer_flag
from
  `marketeam_data.health_donor_clean`
where
  sustainer_flag is false
order by
  rand()
limit 4024)
UNION ALL
(select
  account_id,
  sustainer_flag
from
  `marketeam_data.health_donor_clean`
where
  sustainer_flag is true))
