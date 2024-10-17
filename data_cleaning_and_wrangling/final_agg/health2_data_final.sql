create or replace table `marketeam_data.health2_data_final`
(sustainer int64,
gender int64,
client_state_rank int64,
all_state_rank int64,
client_zip_rank int64,
all_zip_rank int64,
age int64,
account_id string,
gift_date date,
gift_min_t12m decimal,
gift_max_t12m decimal,
gift_avg_t12m decimal,
gift_count_t12m int64,
promo_count_t12m int64,
cons_month_t12m int64,
dm_t12m int64,
tm_t12m int64,
wm_t12m int64,
digital_t12m int64,
f2f_t12m int64,
events_t12m int64,
drtv_t12m int64,
other_t12m int64,
no_channel_t12m int64,
member_t12m int64,
gift_min_lt decimal,
gift_max_lt decimal,
gift_avg_lt decimal,
gift_count_lt int64,
promo_count_lt int64,
cons_month_lt int64
)
as
((select
  case when c.sustainer_flag then 1 else 0 end as sustainer,
  c.* except(sustainer_flag,account_id,city,state,zip),
  d.* except(first_sustainer,sustainer_flag)
from
  `marketeam_data.health2_data_temp` d
left join
  `marketeam_data.health2_donor_clean` c
  on d.account_id = c.account_id
where
  d.first_sustainer is false
  and d.sustainer_flag is false
  )
union all
(select
  case when c.sustainer_flag then 1 else 0 end as sustainer,
  c.* except(sustainer_flag,account_id,city,state,zip),
  d.* except(first_sustainer,sustainer_flag)
from
  `marketeam_data.health2_data_temp` d
left join
  `marketeam_data.health2_donor_clean` c
  on d.account_id = c.account_id
where
  d.first_sustainer is true
  and d.sustainer_flag is true))
