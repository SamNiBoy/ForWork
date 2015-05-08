select 
'Segment Advice -----' || chr(10) ||
'Tablespace_name :'|| tablespace_name || chr(10)||
'Segment_owner :'|| segment_owner || chr(10)||
'Segment_name :'||segment_name || chr(10)||
'Allocated_space :'|| allocated_space || chr(10) ||
'Reclaimable_space :'|| reclaimable_space || chr(10)||
'Recommendations :'|| recommendations || chr(10)||
'Solution 1 :' || c1 || chr(10)||
'Solution 2 :' || c2 || chr(10)||
'Solution 3 :' || c3 Advice
from TABLE(dbms_space.asa_recommendations('FALSE','FALSE','FALSE'));