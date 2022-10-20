use test;
CREATE TABLE dept (
    deptno INT NOT NULL PRIMARY KEY,
    dname VARCHAR(30),
    loc VARCHAR(30)
);
CREATE TABLE emp (
    empno INT NOT NULL PRIMARY KEY,
    ename VARCHAR(20),
    job VARCHAR(30),
    mgr INT,
    hiredate DATE,
    sal FLOAT(7 , 2 ),
    comm FLOAT(7 , 2 ),
    deptno INT REFERENCES dept (deptno)
);
CREATE TABLE salgrade (
    grade INT NOT NULL PRIMARY KEY,
    losal INT,
    hisal INT
);
/*
use mysql;
show tables;
select * from db;
desc db;
select * from user;
*/
use test;
-- dept 테이블에 값 입력
insert into dept (deptno, dname, loc) values (10, '회계팀', '서울');
insert into dept values (20, '연구소', '인천');
insert into dept values (30, '영업팀', '대전');
insert into dept values (40, '운영팀', '부산');
select * from dept;

-- emp 테이블에 값 입력(oracle 값 가져오기)
set global local_infile = 1;
load data infile
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/emp.txt'
into table emp;
select * from emp;

-- where 조건에서 등호 사용
select empno, ename, job, sal from emp where sal > 3000;
select empno, ename, job, sal from emp where sal >= 3000;
select empno, ename, job, sal from emp where sal < 3000;
select empno, ename, job, sal from emp where sal = 3000;
select empno, ename, job, sal from emp where sal <> 3000;
select empno, ename, job, sal from emp where sal != 3000;

-- not / and / or
select ename, job, sal from emp where job = 'MANAGER' and sal > 2000;
select ename, job, sal from emp where job = 'MANAGER' or sal > 2000;
select ename, job, sal from emp where not job = 'MANAGER' and sal > 2000;
select ename, job, sal from emp where job = 'MANAGER' or job = 'SALESMAN';

-- in
select ename, job, sal from emp where job in ('MANAGER', 'SALESMAN');
select ename, job, sal from emp where job not in ('MANAGER', 'SALESMAN');
select ename, job, sal, deptno from emp where deptno in (10, 20);
select ename, job, sal, deptno from emp where deptno not in (10, 20);

-- and를 먼저 계산한 후 or 계산
select empno, ename, job, sal from emp where job = 'SALESMAN' or job = 'MANAGER' and sal >= 2000;
select empno, ename, job, sal from emp where job = 'SALESMAN' or (job = 'MANAGER' and sal >= 2000);
select empno, ename, job, sal from emp where (job = 'SALESMAN' or job = 'MANAGER') and sal >= 2000;
select empno, ename, job, sal from emp where job in ('SALESMAN', 'MANAGER') and sal >= 2000;

-- between
select ename, sal from emp where sal between 1500 and 2500;
select ename, sal from emp where sal >= 1500 and sal <= 2500;
select ename, sal from emp where sal not between 1500 and 2500;

-- is null (오라클에서 null 은 가장 큰 값으로 지정하지만 mysql은 null을 가장 작은 값으로 지정함)
select ename, sal, comm from emp where comm is null;
select ename, sal, comm from emp where comm is not null;
select ename, comm from emp order by 2;

-- like
select ename, hiredate from emp where hiredate between '19810101' and '19811231';
select ename, hiredate from emp where hiredate like '1981%';
select ename from emp where ename like 's%'; -- 첫 글자가 s 
select ename from emp where ename like '%s'; -- 마지막 글자가 s
select ename from emp where ename like '%s%'; -- 첫, 중간, 마지막 상관없이 s
select ename from emp where ename like '%l%l%'; -- 첫, 중간, 마지막 상관없이 l 2개
select ename from emp where ename like '%ll%'; -- 첫, 중간, 마지막 상관없이 ll
select ename from emp where ename like '_d%'; -- 두 번째 글자가 d
select ename from emp where ename like '__a%'; -- 세 번째 글자가 a
select ename from emp where ename like '%t_'; -- 끝에서 두 번째 글자가 t
-- 신문이나 게시글 조회할 때 사용
-- select content from newspaper where title like '%코로나%';
update emp set ename = 'SMI%TH' where ename = 'SMITH';
-- '%'가 있는 데이터 조회 : *는 모든 문자로 사용 가능
select ename from emp where ename like '%*%%' escape '*';
select ename from emp where ename like '%3%%' escape '3';
select ename from emp where ename like '%/%%' escape '/';
select ename from emp where ename like '%a%%' escape 'a';
-- 단, \는 escape 제외하고 사용
select ename from emp where ename like '%\%%';

-- order by : desc(내림차순), asc(default, 오름차순)
select ename, job, sal, deptno from emp order by deptno;
select ename, job, sal, deptno from emp order by deptno, sal desc;
select ename, job, sal, deptno from emp order by 4 desc, 3 desc;
select ename, job, sal, deptno from emp order by 4 desc, job;

-- distinct
select distinct deptno from emp order by 1;

-- 별칭 사용 : ①as "", ②as '', ③'', ④띄어쓰기 없이 그냥 별칭 사용
select ename as "이름", job as '직무', sal 급여, deptno '부 서' from emp order by 4, 1;

-- group by : 오라클에서는 'group by'를 안쓰면 에러가 떴지만 mysql은 에러는 안뜨지만 잘못된 값을 추출함 ∴ group by 를 항상 써줘야 함
select ename, max(sal) from emp group by ename;
select deptno, max(sal), min(sal), round(avg(sal), 2), sum(sal), count(*) from emp group by deptno;

-- having
select deptno, max(sal), min(sal), round(avg(sal), 2), sum(sal), count(*)
from emp group by deptno having count(*) >= 5;

-- ceil/ceiling 올림, floor 내림, truncate 버림, round 반올림
select round(3.7), ceil(3.7), floor(3.7), truncate(3.7, 0) from dual;
select round(3.1), ceil(3.1), floor(3.1), truncate(3.1, 0); -- mysql에서는 from dual 생략 가능
select round(-3.7), ceil(-3.7), floor(-3.7), truncate(-3.7, 0);
select round(-3.1), ceil(-3.1), floor(-3.1), truncate(-3.1, 0);
select round(sal/3), round(sal/3, 1), round(sal/3, 2), round(sal/3, -1) from emp;
select truncate(sal/3, 0), truncate(sal/3, 1), truncate(sal/3, 2), truncate(sal/3, -1) from emp;
-- pow/power(a, b) a의 b승, mod(a, b) a 나머지 b,
-- greatest(a, b, c...) a,b,c... 중 가장 큰 수, least(a,b,c...) a,b,c... 중 가장 작은 수
select pow(2, 3), power(2, 3), mod(10, 3), greatest(2, 7, 8), least(2, 7, 8);
-- substr/substring(칼럼명, a, b) 칼럼명의 a번째에서 b글자만큼 추출
select ename, substr(ename, 2, 2), substring(ename, 2, 2) from emp;
-- concat(a, b, c) abc 로 연결 (오라클에서는 ||으로 연결함)
select concat(ename, '(', sal, ')') from emp;
-- insert(칼럼명, a, b, 변경할 값) 칼럼명의 a번째에서 b글자만큼 변경할 값으로 바꿈
select ename, insert(ename, 2, 1, '대박') from emp;
-- replace(칼럼명, 기존의 변경하고 싶은 값, 새로 변경하고 싶은 값) 칼럼명의 기존 값을 변경함 
select job, replace(job, 'MAN', 'PERSON') from emp;
-- instr(칼럼명, a) 해당 칼럼명에 들어간 값의 a의 개수
select ename, instr(ename, 'A') from emp;
-- left(칼럼명, a) 왼쪽에서부터 a글자만큼 추출, right(칼럼명, a) 오른쪽에서부터 a글자만큼, mid(칼럼명, a, b) a번째에서 b글자만큼
select ename, left(ename, 2), right(ename, 2), mid(ename, 2, 2) from emp;
-- mysql은 대소문자 구분 상관없이 검색 가능
select ename, job from emp where job in ('manager', 'analyst');
-- lower/lcase 소문자로 추출, upper/ucase 대문자로 추출
select ename, lower(ename), upper(ename), lcase(ename), ucase(ename) from emp;
-- reverse 값을 뒤집어서 추출
select ename, reverse(ename) from emp;

-- 현재 시간
select now(), sysdate(), current_timestamp(); -- 날짜, 시간
select now() + 0, sysdate() + 0, current_timestamp() + 0; -- '+0'은 날짜, 시간 사이에 -, : , 공백 제거
select curdate(), current_date(); -- 날짜만
select curdate() + 0, current_date() + 0; -- 날짜만
select curtime(), current_time(); -- 시간만
-- date_add(칼럼명, interval a b) a에는 숫자(정수), b에는 년, 월, 일, 시, 분 등의 시간단위
-- date_add(hiredate, interval 2 day) hiredate로부터 2일 후
select hiredate, date_add(hiredate, interval 2 day), date_add(hiredate, interval 2 year),
	   date_add(hiredate, interval 2 month), date_add(hiredate, interval 2 hour), date_add(hiredate, interval 2 minute)
from emp;
-- date_add와 반대
-- date_add(hiredate, interval 2 day) hiredate로부터 2일 전
select hiredate, date_sub(hiredate, interval 2 day), date_sub(hiredate, interval 2 year),
	   date_sub(hiredate, interval 2 month), date_sub(hiredate, interval 2 hour), date_sub(hiredate, interval 2 minute)
from emp;