create or replace table `marketeam_data.envr_data_temp`
(account_id string,
gift_date date,
first_sustainer bool,
sustainer_flag bool,
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
(with temp as
  (
    select
      g.PledgeSustainer as sustainer_flag,
      g.AccountID as account_id,
      g.DonationID as donation_id,
      date(g.GiftDate) as gift_date,
      date(p.MailDate) as mail_date,
      LAG(g.PledgeSustainer) OVER (partition by g.AccountID order by date(GiftDate)) as lag_sustainer,
      FY,
      FY_Campaign,
      string_agg(g.AppealCode) over (partition by g.AccountID order by unix_date(date(g.GiftDate)) range between 365 preceding and current row) as appeal_code_agg_t12m,
      string_agg(g.AppealCode) over (partition by g.AccountID order by unix_date(date(g.GiftDate)) range between 10000 preceding and current row) as appeal_code_agg_lt,
      date_diff(date(g.GiftDate),date(p.MailDate),month) as month_since_promo,
      case when g.DM = 'Y' then 1 else 0 end as dm,
      case when g.TM = 'Y' then 1 else 0 end as tm,
      case when g.WM = 'Y' then 1 else 0 end as wm,
      case when g.Email = 'Y' or g.Web = 'Y' then 1 else 0 end as digital,
      case when g.FaceToFace = 'Y' then 1 else 0 end as f2f,
      case when g.Events = 'Y' then 1 else 0 end as events,
      case when g.DRTV = 'Y' then 1 else 0 end as drtv,
      case when g.Channel = 'Other' then 1 else 0 end as other,
      case when g.Channel is null then 1 else 0 end as no_channel,
      case when g.Member = 'Y' then 1 else 0 end as member,
      cast(g.Amount as decimal) as amount 
    from
      `marketeam_data.envr_gifts` g
    left join
      `marketeam_data.envr_promotions` p
      on g.AccountID = p.AccountID
      and g.AppealCode = p.AppealCode
    where
      g.AccountID in (select account_id from `marketeam_data.envr_samples`)
  ),
temp2 as 
  (
    select
      g.AccountID,
      g.DonationID,
      g.GiftDate,
      date_trunc(date(g.GiftDate),month),
      date_add(date_trunc(date(g.GiftDate),month),interval -dense_rank() over (partition by g.AccountID order by date_trunc(date(g.GiftDate),month)) month) as date_group
    from
      `marketeam_data.envr_gifts` g
    where
      g.AccountID in (select account_id from `marketeam_data.envr_samples`)
  ),
temp3 as
  (
    select
      t.AccountID,
      t.DonationID,
      t.GiftDate,
      dense_rank() over (partition by t.AccountID,t.date_group order by date_trunc(date(t.GiftDate),month)) as cons_month
    from
      temp2 t
  ),
final as
  (
    select
      t.account_id,
      t.gift_date,
      case when sustainer_flag = 'Y' and lag_sustainer is null then true else false end as first_sustainer, --this marks when the donor first became a sustainer in a long time
      case when t.sustainer_flag = 'Y' then true else false end as sustainer_flag,
      min(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as gift_min_t12m, --min gift in a rolling 12 month period
      max(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as gift_max_t12m, --max gift in a rolling 12 month period
      round(avg(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row),2) as gift_avg_t12m, --avg gift in a rolling 12 month period
      count(t.donation_id) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as gift_count_t12m, --num of times donated in a 12 month period
      (select count(distinct id) from unnest(split(t.appeal_code_agg_t12m)) as id) as promo_count_t12m, --num of promos sent to donor in rolling 12 month period
      max(t3.cons_month) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as cons_month_t12m,
      max(t.dm) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as dm_t12m,
      max(t.tm) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as tm_t12m,
      max(t.wm) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as wm_t12m,
      max(t.digital) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as digital_t12m,
      max(t.f2f) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as f2f_t12m,
      max(t.events) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as events_t12m,
      max(t.drtv) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as drtv_t12m,
      max(t.other) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as other_t12m,
      max(t.no_channel) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as no_channel_t12m,
      max(t.member) over (partition by t.account_id order by unix_date(t.gift_date) range between 365 preceding and current row) as member_t12m,
      min(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 100000 preceding and current row) as gift_min_lt, --min lifetime gift preceding this donation
      max(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 100000 preceding and current row) as gift_max_lt, --max lifetime gift preceding this donation
      round(avg(t.amount) over (partition by t.account_id order by unix_date(t.gift_date) range between 100000 preceding and current row),2) as gift_avg_lt, --avg lifetime gift preceding this donation
      count(t.donation_id) over (partition by t.account_id order by unix_date(t.gift_date) range between 100000 preceding and current row) as gift_count_lt, --num of times donated in lifetime preceding this donation
      (select count(distinct id) from unnest(split(t.appeal_code_agg_lt)) as id) as promo_count_lt, --num of promos sent to donor lifetime
      coalesce(max(t3.cons_month) over (partition by t.account_id order by unix_date(t.gift_date) range between 100000 preceding and current row),0) as cons_month_lt
    from
      temp t
    left join
      temp3 t3
      on t.account_id = t3.AccountID
      and t.donation_id = t3.DonationID
  )
select
  *
from
  final f
where
  f.gift_date between date('2019-01-01') and date('2024-06-30'))
