SELECT * FROM election_results.constituencywise_results;

-- 1.Total seats
select distinct count(`Constituency ID`)
from constituencywise_results

-- 2. What are the total number of seats available for elections in each states

select distinct count(CR.`Parliament Constituency`), SR.State
from constituencywise_results CR
join statewise_results SR on CR.`Parliament Constituency` =SR.`Parliament Constituency`
join states S on S.`State ID` =SR.`State ID`
group by SR.State

-- 3.Total seats won by NDA
select 
sum(case
	when Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then Won
		else 0
	end) as N
from `partywise_results`

-- Anothr method

with cte as
(
select Won,
case
	when Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then "NDA"
		else "N/A"
	end as N
from partywise_results
)
select sum(Won)
from cte
where N= "NDA"

-- 4. Seats Won by NDA Allianz Parties

with cte as
(
select Won, Party,
case
	when Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then "NDA"
		else "N/A"
	end as N
from partywise_results
)
select Party, Won
from cte
where N= "NDA"


-- 5. Total seats won by INDIA

select 
sum(case
	when Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
) then Won
		else 0
	end) as Total
from `partywise_results`

-- 6 Seats Won by I.N.D.I.A. Allianz Parties

select Party, Won
from partywise_results
where Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
);

-- 7. Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

alter table partywise_results
add column Allianz varchar(50);


create table partywise_results2
as 
select * from partywise_results;


update partywise_results
set Allianz =
case
 when Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then "NDA"
	when Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK') then "I.N.D.I.A"
	Else "Other Parties"
end;

-- 8. Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select Allianz, (Maxi)
from
(
select Allianz, count(CR.`Constituency ID`) as Maxi
from partywise_results PR
join constituencywise_results CR on PR.`Party ID`= CR.`Party ID`
group by Allianz) as D
group by Allianz;

-- Alternate query
SELECT 
    p.Allianz,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
WHERE 
    p.Allianz IN ('NDA', 'I.N.D.I.A', 'Other Parties')
GROUP BY 
    p.Allianz
ORDER BY 
    Seats_Won DESC;


-- 9.Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency.

select `Winning Candidate`, PR.Party, CR.`Total Votes`,CR.Margin
from constituencywise_results CR
left join partywise_results PR on CR.`Party ID`=PR.`Party ID`
join statewise_results SR on SR.`Parliament Constituency`=CR.`Parliament Constituency`
JOIN states s ON SR.`State ID` = s.`State ID`
where CR.`Constituency Name`= 'AMETHI' 


-- 10.WHAT IS The distribution of EVM Votes vs Postal votes for candidate in a specific constituency.

select CD.`Total Votes`, CD.`EVM Votes`, CD.`EVM Votes`- CD.`Postal Votes` AS Diff,
ROUND(CD.`EVM Votes`/CD.`Total Votes`,2)*100 as `%ofEVM`, CD.`Postal Votes`
from constituencywise_details CD
right join constituencywise_results CR on CD.`Constituency ID`=CR.`Constituency ID`
WHERE CR.`Constituency Name`= 'AZAMGARH'


-- 11. Which parties won the most seats in state, how many seats did each party won

select  count(CR.`Constituency ID`) Seats_won, CD.Party
from states S
join statewise_results SR on S.`State ID`=SR.`State ID`
join constituencywise_results CR on CR.`Parliament Constituency`=SR.`Parliament Constituency`
join constituencywise_details CD on CD.`Constituency ID`= CR.`Constituency ID`
group by  CD.Party
order by  Seats_won desc

-- 12.What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

select SR.State,
SUM(CASE When PR.Allianz= "NDA" THEN 1 else 0 end) as seatsbynda,
SUM(CASE When PR.Allianz= 'I.N.D.I.A' THEN 1 else 0 end) as `seatsbyi.n.d.i.a`,
SUM(CASE When PR.Allianz= 'Other Parties' THEN 1 else 0 end) as seatsbyother
from constituencywise_results CR
join partywise_results PR on PR.`Party ID`=CR.`Party ID`
join statewise_results SR on CR.`Parliament Constituency`=SR.`Parliament Constituency`
group by   SR.State


-- 13.Which candidate received the highest number of EVM votes in each constituency (Top 10)?

with cte as(
select `Constituency Name`,`Constituency ID`
from constituencywise_results
group by `Constituency Name`, `Constituency ID`
)
select `Constituency Name`, max(`EVM Votes`)
from constituencywise_results CR
join constituencywise_details CD on CR.`Constituency ID`=CD.`Constituency ID`
GROUP BY `Constituency Name`, `EVM Votes`
order by CD.`EVM Votes` desc
LIMIT 10;


/* Below query we need to group by the constituency but we don't need to group by other column which comes in the select statement
So in where cluase we used sub query and self condition to match unique rec by const id , (without group by)*/


SELECT 
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.Candidate,
    cd.`EVM Votes`
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE 
    cd.`EVM Votes` = (
        SELECT cd1.`EVM Votes`
        FROM constituencywise_details cd1
        WHERE cd1.`Constituency ID` = cd.`Constituency ID`
        order by cd1.`EVM Votes` desc
        limit 1
    )
order by  cd.`EVM Votes` desc;

select `Constituency Name`, `EVM Votes`
from constituencywise_results CR
join constituencywise_details CD on CD.`Constituency ID` = CR.`Constituency ID`
where `EVM Votes`= (select `EVM Votes` from constituencywise_details cd1 where cd1.`Constituency ID` = CD.`Constituency ID` order by 1 desc limit 1)
order by 2 desc;


-- Another method without correlated subquery
SELECT 
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.Candidate,
    cd.`EVM Votes`
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
JOIN 
    (
        -- Get the max EVM Votes per Constituency ID
        SELECT 
            `Constituency ID`,
            MAX(`EVM Votes`) AS max_votes
        FROM 
            constituencywise_details
        GROUP BY 
            `Constituency ID`
    ) max_votes_tbl 
    ON cd.`Constituency ID` = max_votes_tbl.`Constituency ID` 
    AND cd.`EVM Votes` = max_votes_tbl.max_votes
order by cd.`EVM Votes` desc;


-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

with cte as(
select CD.`Constituency ID`, CD.Candidate, `EVM Votes` + `Postal Votes` as Total_votes, row_number() over(partition by `Constituency ID`
order by (`EVM Votes` + `Postal Votes`) desc) as rnks
from constituencywise_details CD)
select CR.`Constituency Name`,
max(CASE when rnks =1 then Candidate end) as Winner,
max(CASE when rnks =2 then Candidate end) as Runnerup
from cte CT
join constituencywise_results CR on CR.`Constituency ID`= CT.`Constituency ID`
group by CR.`Constituency Name`;


-- For the state of Maharashtra, what are the total number of seats, total number of candidates, 
-- total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

select  Count(distinct CR.`Constituency ID`), count(distinct CD.Candidate), count(distinct PR.`Party ID`), sum(CD.`Total Votes`), sum(CD.`EVM Votes`),
sum(CD.`Postal Votes`)
from constituencywise_results CR
join constituencywise_details CD on   CR.`Constituency ID`= CD.`Constituency ID`
left join partywise_results PR on PR.`Party ID`=CR.`Party ID`
left join  statewise_results SR on  SR.`Parliament Constituency`=CR.`Parliament Constituency`
left join states S on S.`State ID`= SR.`State ID`
where S.State= 'Maharashtra'

