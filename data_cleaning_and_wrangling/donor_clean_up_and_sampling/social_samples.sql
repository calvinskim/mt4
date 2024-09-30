create or replace table `marketeam_data.social_samples`
(account_id string,
sustainer_flag bool)
as
((select
  account_id,
  sustainer_flag
from
  `marketeam_data.social_donor_clean`
where
  sustainer_flag is false
order by
  rand()
limit 79067)
UNION ALL
(select
  account_id,
  sustainer_flag
from
  `marketeam_data.social_donor_clean`
where
  sustainer_flag is true))
