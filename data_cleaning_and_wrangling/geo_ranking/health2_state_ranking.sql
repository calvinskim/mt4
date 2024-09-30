create or replace table `marketeam_data.health2_state_rank`
(state string,
client_state_rank int64)
as
(with temp as
  (
    select
      d.State,
      sum(cast(g.Amount as decimal)) as total_amount
    from
      `marketeam_data.health2_gifts` g
    left join
      `marketeam_data.health2_donor` d
      on g.AccountID = d.AccountID
    where
      date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      and State in ('AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
    group by
      1
  )
select
  t.State as state,
  dense_rank() over (order by t.total_amount) as client_state_rank
from
  temp t)
