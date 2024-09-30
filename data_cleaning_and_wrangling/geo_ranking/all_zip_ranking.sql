create or replace table `marketeam_data.all_zip_rank`
(zip string,
all_zip_rank int64)
as
(with temp as
  (
    (
      select
        d.Zip,
        sum(cast(g.Amount as decimal)) as total_amount
      from
        `marketeam_data.advcy_gifts` g
      left join
        `marketeam_data.advcy_donor` d
        on g.AccountID = d.AccountID
      where
        length(g.GiftDate) = 10
        and date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      group by
        1
    )
    union all
    (
      select
        d.Zip,
        sum(cast(g.Amount as decimal)) as total_amount
      from
        `marketeam_data.envr_gifts` g
      left join
        `marketeam_data.envr_donor` d
        on g.AccountID = d.AccountID
      where
        date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      group by
        1
    )
    union all
    (
      select
        d.Zip,
        sum(cast(g.Amount as decimal)) as total_amount
      from
        `marketeam_data.health2_gifts` g
      left join
        `marketeam_data.health2_donor` d
        on g.AccountID = d.AccountID
      where
        date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      group by
        1
    )
    union all
    (
      select
        d.Zip,
        sum(cast(g.Amount as decimal)) as total_amount
      from
        `marketeam_data.health_gifts` g
      left join
        `marketeam_data.health_donor` d
        on g.AccountID = d.AccountID
      where
        date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      group by
        1
    )
    union all
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
    union all
    (
      select
        d.Zip,
        sum(cast(g.Amount as decimal)) as total_amount
      from
        `marketeam_data.veteran_gifts` g
      left join
        `marketeam_data.veteran_donor` d
        on g.AccountID = d.AccountID
      where
        length(g.GiftDate) = 10
        and date(g.GiftDate) between date('2019-01-01') and date('2024-06-30')
      group by
        1
    )
  ),
temp1 as
  (
    select
      t.Zip,
      sum(t.total_amount) as total_amount 
    from
      temp t
    group by
      1
  )
select
  t1.Zip as zip,
  dense_rank() over (order by t1.total_amount) as all_zip_rank
from
  temp1 t1)
