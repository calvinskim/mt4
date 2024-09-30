create or replace table `marketeam_data.social_zip_rank`
(zip string,
client_zip_rank int64)
as
(with temp as
  (
    select
      d.Zip,
      sum(cast(g.Amount as decimal)) as total_amount
    from
      `marketeam_data.social_gifts` g
    left join
      `marketeam_data.social_donor` d
      on g.AccountID = d.AccountID
    where
      length(g.GiftDate) = 10
      and date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
    group by
      1
  )
select
  t.Zip as zip,
  dense_rank() over (order by t.total_amount) as client_zip_rank
from
  temp t)
