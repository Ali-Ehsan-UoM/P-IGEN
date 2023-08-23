function mgc = GB_46node


%% 46-node, 44 pipe natural gas system for optimal power & natural gas flow.

%% ---------------------- Matpower gas case version ----------------------
mgc.version = '1'; 

%% ------------------------------ Gas bases ------------------------------

mgc.pbase = 500; % base pressure [psia]
mgc.fbase = 50;  % base flow [MMSCFD]
mgc.wbase = 100; % base power [MW]

%% ------------------------------ Node data ------------------------------                                    
% gd based on average LDZ gas demand over 2015-2020

% node_id  type  p 	Pmax    Pmin	pi_+	pi_-	al_pi_+     al_pi_-     gd  #gd
mgc.node.info = [
1	2	1000	1400	300	0	0	100000	100000	0	1
2	1	950	1400	300	0	0	100000	100000	110	1
3	1	764	1400	300	0	0	100000	100000	110	1
4	1	935	1400	300	0	0	100000	100000	110	1
5	1	933	1400	300	0	0	100000	100000	96	1
6	1	897	1400	300	0	0	100000	100000	150	1
7	1	878	1400	300	0	0	100000	100000	150	1
8	1	833	1400	300	0	0	100000	100000	150	1
9	1	931	1400	300	0	0	100000	100000	202	1
10	1	1008	1400	300	0	0	100000	100000	170	1
11	1	909	1400	300	0	0	100000	100000	202	1
12	1	839	1400	300	0	0	100000	100000	52	1
13	1	929	1400	300	0	0	100000	100000	52	1
14	1	865	1400	300	0	0	100000	100000	52	1
15	1	801	1400	300	0	0	100000	100000	172	1
16	1	851	1400	300	0	0	100000	100000	172	1
17	1	852	1400	300	0	0	100000	100000	190	1
18	1	782	1400	300	0	0	100000	100000	190	1
19	1	796	1400	300	0	0	100000	100000	170	1
20	1	672	1400	300	0	0	100000	100000	84	1
21	1	727	1400	300	0	0	100000	100000	84	1
22	1	786	1400	300	0	0	100000	100000	96	1
23	1	646	1400	300	0	0	100000	100000	96	1
24	1	517	1400	300	0	0	100000	100000	110	1
25	2	754	1800	300	0	0	100000	100000	0	1
26	2	632	1800	300	0	0	100000	100000	0	1
27	1	628	1400	300	0	0	100000	100000	150	1
28	1	532	1400	300	0	0	100000	100000	52	1
29	1	440	1400	300	0	0	100000	100000	150	1
30	1	417	1400	300	0	0	100000	100000	150	1
31	2	413	1400	300	0	0	100000	100000	0	1
32	1	414	1400	300	0	0	100000	100000	52	1
33	1	416	1400	300	0	0	100000	100000	190	1
34	1	411	1400	300	0	0	100000	100000	190	1
35	1	402	1400	300	0	0	100000	100000	190	1
36	2	401	1400	300	0	0	100000	100000	0	1
37	1	493	1400	300	0	0	100000	100000	190	1
38	1	451	1400	300	0	0	100000	100000	190	1
39	2	426	1400	300	0	0	100000	100000	0	1
40	1	412	1400	300	0	0	100000	100000	170	1
41	2	405	1400	300	0	0	100000	100000	0	1
42	2	405	1400	300	0	0	100000	100000	0	1
43	1	406	1400	300	0	0	100000	100000	84	1
44	1	430	1400	300	0	0	100000	100000	84	1
45	1	475	1400	300	0	0	100000	100000	84	1
46	2	576	1400	300	0	0	100000	100000	0	1
    ];

%   Res     Ind         Com     NGV         Ref     Pet      <---- [MMSCFD]
mgc.node.dem = [
0
110
110
110
96
150
150
150
202
170
202
52
52
52
172
172
190
190
170
84
84
96
96
110
0
0
150
52
150
150
0
52
190
190
190
0
190
190
0
170
0
0
84
84
84
0
    ];

% al_Res    al_Ind	al_Com  al_NGV	al_Ref	al_Pet          <----[GBP/MMSCFD]
mgc.node.demcost = [
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
4290
    ];
    
%% ------------------------------ Well data ------------------------------
% lmax based on qadrdan et al. Energy Policy 38(2010) pp.5684-5695 
% also see https://mip-prd-web.azurewebsites.net/entryzonegraphs
% (1mcm/d=35.3107mmscfd) https://www.energy-sea.gov.il/English-Site/Pages/Data%20and%20Maps/calc.aspx

% node  I   pw  Imax   Imin     status      Cg
mgc.well = [
1	600	1400	 3828     0	1    500   % st fergus
25	600	1400	194       0	1	 500   % barrow
26	600	1400	35         0   1	  500   % burton  point
31	600	1400	1766     0   1	500   %milford haven
36	600	1400	1112     0   1	500   % isle of grain
39	600	1400	4661     0   1	500   % bacton
41	600	1400	85         0	 1	  500   % theddlethorpe
42	600	1400	2825     0   1	500   % easington
46	600	1400	1095     0   1	500   % teeside
          ];

% increase supply at Wells 25, 26, 41
mgc.well([2,3,4,7],4) = 1000;


%% ---------------------------- Pipeline data ----------------------------

% fnode  tnode  FG_O    Kij	D   L   Fg_max Fg_min C_O 
mgc.pipe = [
1	2	1	2.00	73	70	4000	0	5          % st fergus
3	4	1	2.00	54	215	4000	0	5         %1-2 st fergus
5	6	1	2.00	46	88	1200	-1200	5
6	7	1	2.00	46	44	1200	-1200	5
7	8	1	2.00	46	103	1200	-1200	5
8	9	1	2.00	54	100	1200	-1200	5
9	10	1	2.00	35	35	1200	-1200	5
11	12	1	2.00	61	50	1200	-1200	5
13	14	1	2.00	50	67	1200	-1200	5
14	15	1	2.00	35	51	1200	-1200	5
15	16	1	2.00	43	65	1200	-1200	5
17	18	1	2.00	24	70	1200	-1200	5
18	19	1	2.00	18	60	1200	-1200	5
20	21	1	2.00	28	97	1200	-1200	5
21	22	1	2.00	39	45	1200	-1200	5
3	24	1	2.00	46	43	1200	-1200	5
6	25	1	2.00	54	43	0	-1200	5          % 25-barrow
8	26	1	2.00	54	85	0	-1200	5   % 26-burton
8	27	1	2.00	66	60	1200	-1200	5
12	28	1	2.00	47	70	1200	-1200	5
29	30	1	2.00	47	95	1200	-1200	5
30	31	1	2.00	41	143	0	-1800	5      % 31-milford
12	30	1	2.00	24	18	1200	-1200	5
13	32	1	2.00	41	51	1200	-1200	5
17	33	1	2.00	24	20	1200	-1200	5
34	35	1	2.00	35	3	1200	-1200	5
35	36	1	2.00	28	60	0	-1200	5   % 36-isle of grain 
18	10	1	2.00	28	60	1200	-1200	5
18	11	1	2.00	24	34	1200	-1200	5
18	33	1	2.00	35	128	1200	-1200	5
18	37	1	2.00	35	186	1200	-1200	5
38	39	1	2.00	18	26	0	-5000	5  % 39-bacton
33	39	1	2.00	35	41	0	-5000	5  % 39-bacton
34	39	1	2.00	35	80	0	-5000	5  % 39-bacton
19	40	1	2.00	43	37	1200	-1200	5
19	41	1	2.00	40	23	0	-1200	5  %31- theddle
20	42	1	2.00	35	105	0	-3000	5 % 42-easington
42	43	1	2.00	35	71	1200	-1200	5  % 42-easington
20	44	1	2.00	35	56	1200	-1200	5
21	45	1	2.00	46	40	1200	-1200	5
22	46	1	2.00	61	29	0	-1200	5   %46-teeside
22	5	1	2.00	61	68	1200	-1200	5
23	2	1	2.00	35	131	0	-4000	5   %1-2 st fergus
23	3	1	2.00	35	125	1200	-1200	5
    ];

% update Kij
mgc.pipe(:,4)=2; 

%% ---------------------------- Compressor data ----------------------------
% fnode  tnode  Type    fgc     pcc     gcc     ratio   bc  zc  al  be  ga      fmaxc   costc
mgc.comp = [
2	3	2	0	0	0	  1.15	  4.9	0.99	0	0.00025	0	4000	5  %1-2 st fergus
4	5	2	0	0	0	  1.15	  4.9	0.99	0	0.00025	0	4000	5   %1-2 st fergus
10	11	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
12	13	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
16	17	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
19	20	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
22	23	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	4000	5    %1-2 st fergus
28	29	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
33	34	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
37	38	2	0	0	0	1.15	4.9	0.99	0	0.00025	0	1200	5
    ];

%% -------------------------------- Storage --------------------------------
%https://www.ofgem.gov.uk/sites/default/files/docs/2019/01/181207_storage_update_website.pdf
%https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fassets.publishing.service.gov.uk%2Fgovernment%2Fuploads%2Fsystem%2Fuploads%2Fattachment_data%2Ffile%2F1006635%2FDUKES_4.4.xls&wdOrigin=BROWSELINK

%node   V	V0 Vmax V_max   fs  fs+ fs- fsmax   fsmin   sta	C_V C_S+ C_S-
mgc.sto = [
9	0	442	883	132	0	0	0	99	0	1	5	1529	1223
15	0	5297	10593	1589	0	0	0	247	0	1	5	1529	1223
32	0	1423	2846	427	0	0	0	508	0	1	5	1529	1223
44	0	4149	8298	1245	0	0	0	424	0	1	5	1529	1223
45	0	1236	2472	371	0	0	0	71	0	1	5	1529	1223

43	0	3443	6886	1033	0	0	0	424	0	1	5	1529	1223
27	0	353	706	106	0	0	0	71	0	1	5	1529	1223
27	0	3531	7062	1059	0	0	0	777	0	1	5	1529	1223
27	0	3884	7768	1165	0	0	0	636	0	1	5	1529	1223
     ];
 
 %increase deliver. 
 mgc.sto(:,9)= mgc.sto(:,9);
 
%% Names
mgc.nodenames = {
    'Node 1','Node 2','Node 3','Node 4','Node 5','Node 6','Node 7', 'Node 8','Node 9','Node 10', ...
    'Node 11','Node 12','Node 13','Node 14','Node 15','Node 16','Node 17', 'Node 18','Node 19','Node 20', ...
    'Node 21','Node 22','Node 23','Node 24','Node 25','Node 26','Node 27', 'Node 28','Node 29','Node 30', ...
    'Node 31','Node 32','Node 33','Node 34','Node 35','Node 36','Node 37', 'Node 38','Node 39','Node 40', ...
    'Node 41','Node 42','Node 43','Node 44','Node 45','Node 46'
    };

mgc.wellnames = {
    'Well_1', 'Well_2', 'Well_3', 'Well_4', 'Well_5', 'Well_6', 'Well_7'
    };

   