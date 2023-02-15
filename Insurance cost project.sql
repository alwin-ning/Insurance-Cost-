select * from life_insurance;

/* charges if they smoker or not*/
with t1 as (
	select smoker, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	group by smoker
)
select * from t1;

/* charges by gender*/
with t2 as (
	select sex, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	group by sex
)
select * from t2;

/* charges based on gender and smoking*/
with t3 as (
	select sex, smoker, cast(avg(charges) as decimal (1000, 2)) as cost
	from life_insurance
	group by smoker, sex
	order by cost
)
select * from t3;

/* charges based on age*/
with t4 as (
	select age, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	group by age
	order by age
)
select * from t4;

/* charges based on children*/
with t5 as (
	select children, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	group by children
	order by children
)
select * from t5;

/* charges based on region*/
with t6 as (
	select region, cast(avg(charges) as decimal (1000, 2)) as cost from life_insurance
	group by region
	order by cost
)
select * from t6;

/* charges based on bmi in groups of integers*/
with t9 as (
	select floor(bmi) as low, charges from life_insurance
	order by bmi
),
t10 as (
	select low, cast(avg(charges) as decimal (1000, 2))
	from t9
	group by low
	order by low
)
select * from t10;

/* group by age for females and males seperately*/
with t11 as (
	select age, sex, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	where sex = 'female'
	group by age, sex
	order by age
),
t12 as (
	select age, sex, cast(avg(charges) as decimal (1000, 2)) from life_insurance
	where sex = 'male'
	group by age, sex
	order by age
)
select t11.age, t11.sex, t11.avg, t12.sex, t12.avg from t11
left join t12 
on t11.age = t12.age;

/* group by bmi for females and males*/
with t13 as (
	select floor(bmi) as low, sex, charges from life_insurance
	where sex = 'female'
	order by bmi
),
t14 as (
	select low, sex, cast(avg(charges) as decimal (1000, 2))
	from t13
	group by low, sex
	order by low
),
t15 as (
	select floor(bmi) as low, sex, charges from life_insurance
	where sex = 'male'
	order by bmi
),
t16 as (
	select low, sex, cast(avg(charges) as decimal (1000, 2))
	from t15
	group by low, sex
	order by low
)
select t14.low, t14.sex, t14.avg, t16.sex, t16.avg from t14
left join t16
on t14.low = t16.low;

/* group by region for females and males*/
with t17 as (
	select region, sex, cast(avg(charges) as decimal (1000, 2)) as cost 
	from life_insurance
	where sex = 'female'
	group by region, sex
	order by region
),
t18 as (
	select region, sex, cast(avg(charges) as decimal (1000, 2)) as cost 
	from life_insurance
	where sex = 'male'
	group by region, sex
	order by region
)
select t17.region, t17.sex, t17.cost, t18.sex, t18.cost
from t17 left join t18
on t17.region = t18.region;

/* average charge*/
with t18 as (
	select cast(avg(charges) as decimal(1000, 2)) as average from life_insurance
)
