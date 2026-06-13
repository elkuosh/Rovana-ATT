-- جدول الموظفين
create table if not exists employees (
  code text primary key,
  name text not null,
  job text,
  salary numeric not null default 0,
  phone text
);

-- جدول الحضور والانصراف
create table if not exists attendance (
  id bigint generated always as identity primary key,
  emp_code text references employees(code) on delete cascade,
  att_date date not null,
  status text not null, -- present / absent_excused / absent_unexcused
  checkin time,
  checkout time,
  unique(emp_code, att_date)
);

-- السماح بالوصول العام (للاستخدام الداخلي عن طريق anon key)
alter table employees enable row level security;
alter table attendance enable row level security;

create policy "allow all employees" on employees
  for all using (true) with check (true);

create policy "allow all attendance" on attendance
  for all using (true) with check (true);
