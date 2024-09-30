create or replace table `marketeam_data.health2_donor_clean`
(account_id string,
gender int64,
city string,
state string,
zip string,
client_state_rank int64,
all_state_rank int64,
client_zip_rank int64,
all_zip_rank int64,
age int64,
sustainer_flag bool)
as
(
with sustainer as (
  select
    AccountID
  from
    `marketeam_data.health2_gifts`
  where
    PledgeSustainer = 'Y'
  group by
    1
)
  select
  d.AccountID as account_id,
  CASE
    WHEN d.Female = '1' and d.Male = '1' THEN 2
    WHEN d.Female = '0' and d.Male = '0' THEN 3
    WHEN d.Female = '1' THEN 0
    WHEN d.Male = '1' THEN 1
  END AS gender,
  d.City as city,
  d.State as state,
  d.Zip as zipcode,
  sr1.client_state_rank,
  sr2.all_state_rank,
  zr1.client_zip_rank,
  zr2.all_zip_rank,
  cast(d.Age as int64) as age,
  case when s.AccountID is not null then true else false end as sustainer_flag
from
  `marketeam_data.health2_donor` d
left join
  sustainer s
  on d.AccountID = s.AccountID
left join
  `marketeam_data.health2_state_rank` sr1
  on d.State = sr1.state
left join
  `marketeam_data.all_state_rank` sr2
  on d.State = sr2.state
left join
  `marketeam_data.health2_zip_rank` zr1
  on d.Zip = zr1.zip
left join
  `marketeam_data.all_zip_rank` zr2
  on d.Zip = zr2.zip
where
  d.State in ('AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
  and d.City is not null
  and d.Zip is not null)
