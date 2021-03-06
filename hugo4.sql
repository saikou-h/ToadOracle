SELECT DISTINCT aa.INSTR_ID, aa.TYPE, aa.EFFECTIVE_DATE, 
       aa.MATURITY_DATE, aa.OPTION_EXPIRATION_DATE, cc.START_DATE
FROM (
    SELECT INSTR_ID, TYPE, DATE_ID, EFFECTIVE_DATE, 
           MATURITY_DATE, OPTION_EXPIRATION_DATE
    FROM PFEDIM.POSITION
    WHERE TYPE = 2 AND DATE_ID in (18138, 18148, 18157, 18167, 18176, 
            18186, 18196, 18205, 18215, 18225, 18235, 18244, 18254, 18264, 18274, 
            18284, 18294, 18304, 18313, 18323, 18333, 18342, 18352, 18361, 18370, 
            18380, 18389, 18399, 18412, 18421, 18431, 18441, 18450, 18460, 18470, 
            18480, 18490, 18499, 18509, 18518)
    ) aa
INNER JOIN (
    SELECT INSTR_ID, DATE_ID
    FROM PFEDIM.FORWARD_VALUE
    WHERE HORIZON_ID = 1 AND DATE_ID in (18130, 18138, 18148, 18157, 18167, 18176, 
            18186, 18196, 18205, 18215, 18225, 18235, 18244, 18254, 18264, 18274, 
            18284, 18294, 18304, 18313, 18323, 18333, 18342, 18352, 18361, 18370, 
            18381, 18390, 18402, 18412, 18421, 18431, 18441, 18450, 18460, 18470, 
            18480, 18490, 18499, 18509)
    ) bb
ON aa.DATE_ID BETWEEN bb.DATE_ID + 1 AND bb.DATE_ID + 13
    AND aa.INSTR_ID = bb.INSTR_ID
inner join
(select * from
(select * from PFESTG2.STG_MUREX_POS_DATA) a
inner join
(select * from pfedim.position_mapping) b
on a.VALUABLE_ID = B.SOURCE_SYSTEM_INSTRUMENT_ID
inner join
(select * from pfedim.calendar_date) c
on a.as_of_date = c.calendar_date) cc
on aa.instr_id = cc.instr_id and aa.date_id = cc.date_id;