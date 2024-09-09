--FINANCIACIONES INCUMPLIDAS
declare @numero_financiacion int
declare @id_tipo_convenio int
declare @numero_cuotas int
declare @fecha_anulacion datetime
declare @fecha_fecha_registro datetime
DECLARE @numero_referencia_terceros INT;
declare @anio int;
DECLARE @id_deudor INT;
declare @identificacion_persona varchar(20);
declare @id_identificacion_persona nvarchar(3);
DECLARE @codigo_organismo INT;
declare @id_movimiento_cartera bigint

declare @rollback int
DECLARE @numeroProceso BIGINT;
DECLARE @id_proceso INT;

declare @contador_financiaciones_procesadas int = 0;

if object_id('tempdb..#temp_fechas_y_correos') is not null
	drop table #temp_fechas_y_correos
if object_id('tempdb..#temp_fechas_y_correos') is null
	begin
		create table #temp_fechas_y_correos(
			numero_financiacion int primary key,
			fecha_notificacion datetime2(7),
			correos varchar(500)
		)

		insert into #temp_fechas_y_correos
		values 
		(460498,'2024-1-31 14:25','willianjimenez2014-4@hotmail.com'),
		(464424,'2024-1-4 14:55','tomaspalma862@gmail.com'),
		(530678,'2024-1-11 0:10','vivicis79@hotmail.com'),
		(530870,'2024-1-15 0:41','demetriolvera@hotmail.com'),
		(500368,'2024-3-11 9:30','bellalucero@hotmail.es,imp_graphic_blue@hotmail.com'),
		(502126,'2024-2-2 12:51','ronnyvizueta0@gmail.com'),
		(501027,'2024-2-6 10:57','henry.vera1994@gmail.com'),
		(492390,'2024-1-12 12:40','P.NARANJO@GMAIL.COM'),
		(493757,'2024-3-11 9:01','jnarvaez@espol.edu.ec'),
		(499358,'2024-2-2 12:39','atm@cooperativa-atag.com,gustavo_cordova_97@hotmail.com'),
		(499938,'2024-2-2 12:20','juan1.505505@gmail.com,juan121283@hotmail.com'),
		(497249,'2024-2-2 12:51','patricioarmas1967@gmail.com,patricioromanarmaspantoja1967@hotmail.com'),
		(495849,'2024-2-2 12:51','humbertoborja1408@gmail.com'),
		(498646,'2024-2-2 14:08','willianquimi@gmail.com'),
		(496846,'2024-2-2 12:51','gerencia@resinban.com'),
		(503418,'2024-1-4 15:09','BQUINDE@CONSERSA.ORG,QUINDE694@GMAIL.COM'),
		(502095,'2024-2-2 11:12','rolandomalapenafiel@gmail.com'),
		(504667,'2024-1-4 15:12','ab.fehana@hotmail.com,ab.jesus1956@hotmail.com'),
		(504905,'2024-1-17 15:03','ANITAPALACIOSM@GMAIL.COM,DANIELTUTIVENM@HOTMAIL.COM'),
		(502598,'2024-2-2 12:51','luisguananga1987@yahoo.com,luisguananga1804@yahoo.com'),
		(504568,'2024-1-5 10:18','chonillocesar09@gmail.com'),
		(501744,'2024-2-2 13:07','san-lucas1980@hotmail.com'),
		(503679,'2024-2-2 12:36','ramirezkerly36@gmail.com'),
		(502319,'2024-2-2 10:25','sancalde1972@hotmail.com,calderonsantiago2011@hotmail.com'),
		(500740,'2024-2-2 12:51','alexi_mazzini@hotmail.com'),
		(503116,'2024-1-23 0:01','darwinmorales102022@gmail.com,angelmp2760@gmail.com'),
		(502239,'2024-2-2 10:29','carlossanandresfuentes@hotmail.com'),
		(503745,'2024-3-11 9:40','cheodelgado1010@gmail.com'),
		(507085,'2024-2-6 11:10','riosbenavidezevelyn@gmail.com'),
		(506724,'2024-2-2 16:15','kevinsuarez.rs@gmail.com'),
		(505490,'2024-1-15 0:20','revisionmunicipaldetransito@gmail.com'),
		(505956,'2024-2-2 12:36','maicoleduardo1990@gmail.com'),
		(503301,'2024-2-2 12:36','jlrodf@gmail.com'),
		(513664,'2024-2-1 18:21','marthinarvaez12@hotmail.com,marthanarvaez12@hotmail.com'),
		(501029,'2024-1-11 9:38','rmoranv-l.70@hotmail.com,carlos.juliov91@gmail.com'),
		(498891,'2024-2-5 8:43','TAURO20092014@GMAIL.COM'),
		(509202,'2024-1-29 0:31','edgarguitar95@gmail.com,COOPETRANSZ1-102@HOTMAIL.COM'),
		(509412,'2024-1-29 0:31','ASISTENTELEGALTRES@LEGALVAL.COM,VILLAALCOSERE@YAHOO.ES'),
		(509238,'2024-3-19 10:04','leo1964nor@outlook.es'),
		(509426,'2024-3-19 10:46','anthony.vs.tony@hotmail.com'),
		(506407,'2024-1-4 15:21','coopdetaxisalbanborja@hotmail.com'),
		(507651,'2024-2-2 12:51','REVISIONMUNICIPALDETRANSITO@GMAIL.COM'),
		(505730,'2024-2-2 12:51','javieralonsopin@gmail.com'),
		(506633,'2024-1-5 10:12','elviscomand@hotmail.com'),
		(507028,'2024-2-1 12:32','STALINPAZ-1996@OUTLOOK.ES'),
		(506021,'2024-2-2 11:06','rebelojohn25@gmail.com'),
		(506863,'2024-2-2 12:51','cucalonandres760@gmail.com'),
		(508449,'2024-2-2 12:36','wism16@hotmail.com'),
		(505604,'2024-1-23 15:36','juanitocanola@gmail.com'),
		(512176,'2024-3-11 9:20','BETTY_MARITZA_@HOTMAIL.COM,betty_maritza@hotmail.com'),
		(510018,'2024-1-9 0:00','ambienteshab@gmail.com,nescha1955@gmail.com'),
		(513379,'2024-3-11 9:20','caferva@hotmail.com'),
		(513047,'2024-2-1 12:25','coop30denero2005@hotmail.com,alejaseg9@gmail.com'),
		(511653,'2024-1-5 10:18','leandro.gomez.medina@hotmail.com'),
		(504263,'2024-2-2 16:33','darioausbetorcerezedabarberan@gmail.com'),
		(515029,'2024-2-2 11:31','jhonny_aveo@outlook.com,jhonny_aveo@hotmail.com'),
		(517764,'2024-3-19 10:11','angelbolivarulloa@outlook.com'),
		(511944,'2024-3-11 9:30','ala431328@gmail.com'),
		(514196,'2024-2-2 12:51','luisalfaro@hotmail.com,carlosguerra_cg@outlook.com'),
		(517356,'2024-2-5 8:51','poison_14_8@outlook.com'),
		(517636,'2024-2-2 0:01','jaher5@hotmail.com'),
		(516516,'2024-2-2 12:51','carolinadeloza1986@gmail.com'),
		(521382,'2024-1-29 0:21','AQUINTEROSG@HOTMAIL.COM'),
		(521132,'2024-1-22 0:41','andres8772@outlook.com'),
		(522216,'2024-1-11 0:01','coop30denero2005@hotmail.com,yagloa97@outlook.com'),
		(519568,'2024-1-31 0:11','fidersuare@gmail.com'),
		(518314,'2024-1-11 0:01','dieguitopradovillao@gmail.com'),
		(518589,'2024-1-17 9:40','JAIMEBRAVOGAME@GMAIL.COM'),
		(515167,'2024-3-11 9:00','miltonzamora69@hotmail.com,geoconda.zamora1998@hotmail.com'),
		(515765,'2024-3-11 9:01','darkchuack110978@hotmail.com'),
		(516059,'2024-1-3 0:00','raulalejandrovillacissuarez@gmail.com'),
		(517625,'2024-3-11 9:01','DAVIDDANNYLP@GMAIL.COM,juancarlosamat@hotmail.com'),
		(515840,'2024-2-1 6:10','olivonelly732@gmail.com'),
		(514729,'2024-2-2 12:51','henryvo69@hotmail.com'),
		(515893,'2024-1-2 6:40','dianaesthe98@hotmail.com'),
		(514717,'2024-3-11 9:30','ellobosolitario2011@live.com'),
		(520978,'2024-1-19 6:10','alexandergil-92@hotmail.com'),
		(519801,'2024-2-5 0:12','palcf170@gmail.com'),
		(521181,'2024-3-22 12:07','vapoloc@gmail.com,victoria_apolo@hotmail.com'),
		(521743,'2024-1-3 0:01','castroliliancastro08@gmail.com'),
		(522680,'2024-2-2 13:01','OCTAVIOREYESQ@GMAIL.COM,guillermoloor-26@hotmail.com'),
		(519824,'2024-1-4 0:00','ZORAIDANA@OUTLOOK.COM'),
		(520920,'2024-1-18 6:10','luis15albertotroya@gmail.com,coop.luisnietopico@hotmail.com'),
		(522950,'2024-1-9 12:33','armanditosalsa7@gmail.com,armandocastro2806@gmail.com'),
		(522143,'2024-1-10 0:00','joseph_1498@hotmail.com,davidlopec2032@gmail.com'),
		(523277,'2024-3-18 12:36','LUISBAYAS2009@HOTMAIL.COM'),
		(532127,'2024-1-18 18:30','emilioperea27@gmail.com'),
		(532644,'2024-1-5 0:00','LUPEVITE593@GMAIL.COM'),
		(515756,'2024-2-9 10:44','COOP.LUISNIETOPICO@HOTMAIL.COM,g.joange@hotmail.com'),
		(532777,'2024-3-15 11:03','darwinhs26@outlook.com'),
		(533749,'2024-3-15 16:30','odaliabriones@yahoo.com'),
		(528909,'2024-1-2 0:30','freddymedina1604@gmail.com'),
		(522839,'2024-2-2 13:01','alfonsomelec@gmail.com'),
		(521378,'2024-1-29 0:02','ZAMYJULISSA@HOTMAIL.COM'),
		(521800,'2024-1-4 0:00','leo732931@gmail.com,sanmartinalmeida92@gmail.com'),
		(519464,'2024-1-30 0:11','orlandojuvencio@yahoo.com'),
		(532648,'2024-1-5 0:10','boadajordhan@gmail.com'),
		(527151,'2024-1-19 0:00','gloriaveragarcia@gmail.com,juanveragarcia1@hotmail.com'),
		(531173,'2024-01-11 12:58','ALFREDOCARRENO61@GMAIL.COM'),
		(531494,'2024-1-31 0:02','egi_blas@hotmail.com'),
		(532791,'2024-2-7 0:01','AFERNANDEZV1997@GMAIL.COM'),
		(517827,'2024-1-4 0:00','ritabaquerealpe@hotmail.com'),
		(532641,'2024-1-5 0:00','FERCHOCALVACHE1986@GMAIL.COM'),
		(528279,'2024-1-22 0:21','RVELEZBASTIDAS2416@HOTMAIL.COM'),
		(524645,'2024-1-30 17:49','angelgonce1990@gmail.com'),
		(526229,'2024-2-7 16:11','icazahector09@hotmail.com'),
		(526242,'2024-1-11 0:00','carlosarreaga1987@gmail.com'),
		(533055,'2024-1-15 0:40','ja28vi@yahoo.es'),
		(533467,'2024-1-22 0:40','ANTONIOAVELINOVILLON@GMAIL.COM'),
		(533468,'2024-1-22 0:01','COOP30DENERO2005@HOTMAIL.COM'),
		(533663,'2024-1-30 0:02','mirnasantos2019@gmail.com,carlosvillalta1982@hotmail.com'),
		(498614,'2024-1-5 0:00','VCASTRO@AYASA.COM.EC,romana.2185@hotmail.com'),
		(533398,'2024-1-22 0:01','rosamejm@hotmail.com,cooptaxicarbonoboa35@hotmail.com'),
		(533437,'2024-1-22 0:20','carmitaaviles1973@icloud.com'),
		(533771,'2024-2-6 0:11','marjorielindao@gmail.com'),
		(533805,'2024-2-6 0:01','miguelangelvillacresherrera@gmail.com'),
		(533818,'2024-3-15 15:24','nunezpatricia@gmail.com'),
		(533820,'2024-2-6 0:10','patiaulla44@hotmail.com'),
		(530801,'2024-1-12 0:10','culebra.xp@gmail.com,daneilayllon76@gmail.com'),
		(531480,'2024-1-31 0:02','MNBVC@HOTMAIL.COM'),
		(532946,'2024-3-12 17:40','and.dica11@gmail.com'),
		(533108,'2024-1-15 0:40','amm_gye@hotmail.com'),
		(525609,'2023-12-29 0:00','OPERACIONES@VELTRUCKS.COM,CONTABILIDAD@VELTRUCKS.COM'),
		(531613,'2024-2-7 0:01','papitojortgito@hotmail.com'),
		(531664,'2024-2-8 0:01','amparoburgos1954@hotmail.com'),
		(532863,'2024-3-12 12:05','j_avico1991@hotmail.com'),
		(533321,'2024-1-19 0:04','lash3297@gmail.com'),
		(533325,'2024-1-19 0:03','CARPER_S@HOTMAIL.COM'),
		(533377,'2024-1-19 0:11','winino99@hotmail.com'),
		(526240,'2024-1-11 0:00','mtumbaco065@gmail.com'),
		(530950,'2024-1-17 0:01','nancy5059quevedo@hotmail.com,ALVARO.FRANCOA@HOTMAIL.COM'),
		(533096,'2024-1-15 0:30','freddybastidas89@hotmail.com'),
		(533489,'2024-1-22 0:41','mishubebe2009@hotmail.com'),
		(533585,'2024-1-29 0:31','rdunnm@gmail.com'),
		(533628,'2024-1-30 0:11','leroyvulga@hotmail.com'),
		(533821,'2024-2-6 0:11','julitap_93@hotmail.com'),
		(527275,'2024-1-2 0:10','lmoreiramero@gmail.com'),
		(533388,'2024-1-22 0:50','CARLOSCHE18@HOTMAIL.COM'),
		(533806,'2024-2-6 0:01','maximilianorufinopincaycruz@gmail.com'),
		(528207,'2024-1-30 9:30','GABO_CARBO@HOTMAIL.COM'),
		(529030,'2024-2-6 0:01','cargudo@aretina.com'),
		(532487,'2023-12-29 0:10','xaviiba298@gmail.com'),
		(532595,'2024-1-2 0:20','hecgeolaz@gmail.com'),
		(527362,'2024-2-2 0:01','ladyleonela@hotmail.es'),
		(532448,'2023-12-29 0:10','javimendieta69@hotmail.com'),
		(520598,'2024-2-2 13:01','wiltonzambrano79@hotmail.com'),
		(532930,'2024-1-9 0:00','nathanhurtado014@gmail.com'),
		(530015,'2024-3-11 9:10','jacksongomezc@gmail.com'),
		(528091,'2024-01-25 16:54','MIGUELANGELCAGUACAGUA@GMAIL.COM'),
		(531830,'2024-1-11 0:00','vaca_paguayluis@outlook.com'),
		(533018,'2024-1-12 0:01','meliton.vega.macias@gmail.com'),
		(494978,'2024-2-2 12:51','luisbolivarquis24@gmail.com'),
		(514865,'2024-2-2 12:36','talo83@hotmail.com'),
		(525546,'2024-1-29 0:11','waltermartinez09@outlook.es,waltermartinez108@gmail.com'),
		(533823,'2024-2-6 0:01','alexandermalagon611@gmail.com'),
		(505052,'2024-1-9 12:43','abgcarlosmota2664@hotmail.com'),
		(527446,'2024-1-3 0:00','misstetoca@hotmail.com'),
		(531903,'2024-1-15 0:41','coronelcriss9@gmail.com'),
		(532463,'2023-12-29 0:01','jamech1968@hotmail.com,roma20576@hotmail.com'),
		(532466,'2024-1-29 0:31','jordanvelasco2015@gmail.com'),
		(532858,'2024-3-11 16:40','metalruiz1468@gmail.com'),
		(533513,'2024-1-22 0:10','adrian_da900@outlook.com,adrian_da90@hotmail.com'),
		(530640,'2024-2-7 0:01','carlitosivan1994@hotmail.com'),
		(526434,'2024-1-15 0:41','angelarias10a@gmail.com'),
		(532643,'2024-1-5 0:10','luiseduardogualliguaranga@gmail.com'),
		(531813,'2024-1-11 0:01','isabelfar08@hotmail.com'),
		(531816,'2024-1-11 0:01','miltonraul58@hotmail.com'),
		(532900,'2024-2-9 0:01','RICARDOFAJARDOS@GMAIL.COM'),
		(532901,'2024-3-15 15:51','RICARDOFAJARDOS@GMAIL.COM'),
		(526726,'2024-1-30 11:50','mauricio_25_01@hotmail.es'),
		(530726,'2024-1-11 0:11','barcefavio@hotmail.com'),
		(530452,'2024-3-11 9:10','jslc_1995@hotmail.com'),
		(533365,'2024-1-19 0:11','rodrigoceron1972@hotmail.com'),
		(533491,'2024-1-22 0:50','richardbermudez097@gmail.com'),
		(531808,'2024-1-11 0:00','mjjaraczs5@gmail.com'),
		(531524,'2024-1-2 0:41','coop10enerogye@hotmail.com,SEGUNDO_CORDOVA1972@HOTMAIL.COM'),
		(528874,'2024-2-1 0:01','saidamunoz025@gmail.com'),
		(531185,'2024-1-22 0:11','franciscoarreaga1992@outlook.com'),
		(527062,'2024-2-5 13:20','anavel1958@hotmail.com'),
		(532533,'2024-1-2 0:00','josemcm5602011@gmail.com'),
		(532536,'2024-1-31 0:01','brunomichael823@gmail.com'),
		(529546,'2024-2-2 13:00','byronssuares0@gmail.com'),
		(531577,'2024-2-2 0:01','titizevallos@yahoo.com'),
		(524320,'2024-1-15 0:01','gcve_552@hotmail.com'),
		(523662,'2024-2-1 0:01','altamiranoluis@gmail.com,jessicabarrenoes@gmail.com'),
		(528583,'2024-3-27 12:21','escobarlopezjoseignacio8@gmail.com'),
		(531145,'2024-1-22 0:00','cfajardovillafuerte@gmail.com'),
		(530865,'2024-1-23 14:43','wachoquimi08@gmail.com,coop30denero2005@hotmail.com'),
		(532263,'2024-1-23 0:01','lylyvillarrealm@hotmail.com'),
		(524868,'2024-2-6 15:40','josellugsha45@gmail.com'),
		(532904,'2024-2-9 0:02','J.ARMANDOAVILES2011@GMAIL.COM'),
		(532605,'2024-3-15 11:04','SANCHEZBARKER17@OUTLOOK.ES'),
		(528698,'2024-1-29 0:11','wilmerzambrano966@gmail.com'),
		(528873,'2024-2-1 0:02','ab.dennisbarrerapfg_303@hotmail.com'),
		(505567,'2024-1-4 15:15','ma_angeles3009@hotmail.com'),
		(533265,'2024-3-12 17:50','MARLONROLDANMEZA@GMAIL.COM'),
		(531208,'2024-1-24 0:01','lady_brig16@hotmail.com'),
		(529506,'2023-12-28 14:18','DANIELA_ASPIAZU@HOTMAIL.COM'),
		(533078,'2024-1-15 0:41','manuel1980cusquillo@gmail.com'),
		(523562,'2024-1-31 0:02','luischimbo407@yahoo.com'),
		(531473,'2024-1-2 0:50','TITO5023@OUTLOOK.ES'),
		(532912,'2024-1-9 0:01','jonathanquinonez9023@live.com'),
		(533219,'2024-1-15 0:01','davidpicoespinoza.65@gmail.com,davidfernandopicoespinoza@hotmail.com'),
		(533220,'2024-1-15 0:30','tamamiangeloswaldo@outlook.com'),
		(533453,'2024-1-22 0:01','albertoasen@hotmail.com'),
		(533558,'2024-1-29 0:11','pintavaquilema@gmail.com'),
		(530366,'2024-1-29 0:30','LUISSEGURAMORA@HOTMAIL.COM'),
		(530515,'2024-1-4 0:01','anderstiven95@gmail.com'),
		(532630,'2024-3-15 11:04','construccionesmg26@gmail.com'),
		(533670,'2024-1-30 0:02','javierpena1994@gmail.com'),
		(531446,'2024-1-29 0:00','luisantander1595@gmail.com'),
		(526722,'2024-1-19 0:01','alber_car_77@hotmail.com'),
		(527791,'2024-1-15 14:17','kevin_cedeno2467@gmail.com,coopatahualpa469@hotmail.com'),
		(531324,'2024-3-18 12:49','mariojoelprado@gmail.com'),
		(533299,'2024-1-16 0:01','alvarez0924319932@gmail.com'),
		(532667,'2024-2-6 0:01','jjac_2091@hotmail.com,jj1117jh2009@hotmail.com'),
		(533472,'2024-1-22 0:21','yamilectomala@outlook.com,preciado-luis@hotmail.com'),
		(533689,'2024-1-30 0:11','henryalvarezlindao@gmail.com'),
		(527506,'2024-1-4 0:00','rodriguezluisalberto306@gmail.com'),
		(514119,'2024-3-27 12:30','rosadoelias96@gmail.com'),
		(529486,'2024-1-15 0:30','leoandres_226@hotmail.com'),
		(531294,'2024-3-11 9:50','xmzn08@gmail.com'),
		(533767,'2024-2-6 0:11','DANIEL19862013@GMAIL.COM,DANIELRODRIGUEZ1986@HOTMAIL.ES'),
		(533793,'2024-3-15 15:17','VASENCIO2000@GMAIL.COM'),
		(532519,'2024-1-2 0:30','leningarcia.1820@gmail.com'),
		(532591,'2024-1-2 0:00','robalinogabriel9@gmail.com'),
		(530681,'2024-3-11 9:01','carolinaespinmeza91@gmail.com'),
		(530477,'2024-2-5 0:01','OLGA2809GOMEZ@GMAIL.COM'),
		(532593,'2024-1-2 0:50','jorgeruiz.88@hotmail.com'),
		(532650,'2024-2-5 0:21','fabdelga1975@gmail.com'),
		(533695,'2024-3-12 17:40','solangeyepez17@gmail.com'),
		(533698,'2024-1-30 0:02','katherinecedeno89@gmail.com,kathy260389@hotmail.com'),
		(533717,'2024-1-30 0:10','edisonxaviercardenasarmijo@gmail.com'),
		(533739,'2024-2-5 0:21','jaimepotes0@gmail.com'),
		(525945,'2024-1-5 0:01','antogarcesm@gmail.com'),
		(531556,'2024-2-1 0:01','ivanbenabel1976@hotmail.com'),
		(528213,'2023-11-21 0:20','propercoin@hotmail.com'),
		(533009,'2024-1-12 0:10','mari_01frei@hotmail.com'),
		(528608,'2024-3-11 9:40','peter.chavez77@gmail.com,omarmartines_2009@hotmail.com'),
		(528839,'2024-2-1 0:01','totitofajardo69@hotmail.com'),
		(532077,'2024-1-17 0:01','carlosguamansoria@outlook.es'),
		(527544,'2024-1-5 0:10','PAULCAMPIW@HOTMAIL.COM'),
		(532476,'2023-12-29 0:00','RD23JV21@HOTMAIL.COM'),
		(532489,'2023-12-29 0:01','juanpa_metallica84@hotmail.com,juanpametallica84@gmail.com'),
		(533066,'2024-1-15 0:10','empresarioslatinosom@yahoo.com'),
		(532481,'2023-12-29 0:10','ab-emorales.c@hotmail.com,anaibravo2012@hotmail.com'),
		(533679,'2024-1-30 0:02','JUANBUSTOS20@GMAIL.COM'),
		(532627,'2024-1-5 0:00','jesusalbertojuelachuya@hotmail.com'),
		(532893,'2024-1-9 0:01','LEOGARMO1990@GMAIL.COM'),
		(532894,'2024-1-9 0:01','ricardoquintanacabrera7@gmail.com'),
		(531172,'2024-1-22 0:40','jquimis43@gmail.com'),
		(532657,'2024-1-5 0:00','wendypererovera@gmail.com'),
		(530390,'2024-1-30 0:11','edgartrivino38@gmail.com'),
		(527775,'2024-1-9 0:00','ANA1981BARZOLA@GMAIL.COM'),
		(526679,'2024-2-7 16:11','GOODCOFFEE.CATERING@GMAIL.COM,ELMANABA2000@HOTMAIL.COM'),
		(530049,'2024-1-11 12:51','ksgm1516@outlook.com'),
		(507687,'2024-1-9 12:30','juancarlos_81@hotmail.com'),
		(533063,'2024-1-15 0:01','calderasm1@hotmail.com'),
		(532516,'2024-1-2 0:40','heinertvitervo71@gmail.com'),
		(532910,'2024-2-9 0:01','franciscoalvarez@hotmail.com'),
		(533375,'2024-1-19 0:11','johanna_lilibeth@live.com'),
		(533570,'2024-1-29 0:11','gsantoscanal1@gmail.com'),
		(533669,'2024-1-30 0:01','SUSANARODRI67@HOTMAIL.COM'),
		(533275,'2024-1-16 0:01','MAFER_ADRI@HOTMAIL.COM,mafer_cardenas09@hotmail.com'),
		(532336,'2024-4-1 10:09','paojoseamor@gmail.com'),
		(533576,'2024-1-29 0:31','miguelpincaylopez@gmail.com'),
		(527074,'2024-2-5 13:15','normamestanzach@gmail.com'),
		(527346,'2024-1-2 0:01','ian_8osorio@hotmail.com,ianchacon18@gmail.com'),
		(518836,'2024-2-2 11:43','JOSECHIQUITARCO968@GMAIL.COM'),
		(532197,'2024-1-22 0:31','JLICAZAM@HOTMAIL.COM'),
		(498237,'2024-1-3 11:22','salazarchasingronaldjavier@gmail.com'),
		(532623,'2024-2-5 0:21','edurospe2411@gmail.com,janethalexandra2010@hotmail.com'),
		(533676,'2024-1-30 0:11','san91mar@gmail.com'),
		(529824,'2024-3-11 9:20','xavierchacon1982@hotmail.com'),
		(532773,'2024-2-14 13:51','IVANVILLON15@GMAIL.COM'),
		(527176,'2024-1-11 12:56','bayancela@hotmail.com,ROBERTO.BAYANCELA@OUTLOOK.COM'),
		(533010,'2024-1-12 0:10','matiorralla55@gmail.com,fcojavalejandro@gmail.com'),
		(531007,'2024-1-17 0:11','asuarezm91@gmail.com'),
		(532911,'2024-1-9 0:01','leo1997eb@hotmail.com'),
		(532914,'2024-1-9 0:00','erickscarrieta@hotmail.com'),
		(533011,'2024-1-12 0:10','puentesjulian3103@gmail.com'),
		(530525,'2024-2-5 0:11','VALESKALOPEZ1989@OUTLOOK.ES,rachel_cat_22@hotmail.com'),
		(533114,'2024-1-15 0:50','ranitanelly@yahoo.com,rafaelmacias095@gmail.com'),
		(533758,'2024-2-5 0:21','vmor19931993@gmail.com'),
		(533116,'2024-3-12 17:40','AWILLIAMGONZALO@GMAIL.COM'),
		(533118,'2024-1-15 0:10','livington_v_@hotmail.com'),
		(533480,'2024-1-22 0:01','barbaraisrael2011@hotmail.com'),
		(526656,'2024-2-5 15:27','josemiguelbv1007@gmail.com,COOPRUTA77@GMAIL.COM'),
		(533611,'2024-1-30 0:01','gregor011718@gmail.com'),
		(533436,'2024-1-22 0:00','juliogabrielsm94@gmail.com'),
		(525910,'2024-3-22 12:02','dlindao997@gmail.com'),
		(533617,'2024-3-12 17:50','leonela-flores@hotmail.com'),
		(533620,'2024-1-30 0:01','elizaalcivarp9@outlook.com'),
		(533759,'2024-2-5 0:21','carlosdiazhumberto@gmail.com'),
		(533762,'2024-3-15 16:30','denissebanchon@gmail.com,daniel70@gmail.com'),
		(527488,'2024-2-7 16:11','cpaulcampuzano@gmail.com'),
		(532642,'2024-1-5 0:10','quirozzambranow@gmail.com,heroquiroz@hotmail.com'),
		(533801,'2024-3-15 15:30','YOLANDACALIPARAPI@YAHOO.COM,yanchacali@hotmail.com'),
		(531588,'2024-1-2 0:20','ruddyroxanar@gmail.com'),
		(532192,'2024-1-22 0:11','zambranoluiggi4@gmail.com'),
		(531435,'2024-1-29 0:02','robertomosqueramd@hotmail.com'),
		(531780,'2024-1-10 0:00','pedro.claro@cnel.gob.ec'),
		(533122,'2024-3-12 17:40','fabririera@hotmail.com'),
		(533123,'2024-1-15 0:01','fabririera@hotmail.com'),
		(532188,'2024-1-22 0:31','juangaonasolano61@gmail.com'),
		(531165,'2024-1-22 0:01','raulgomezuquillas@gmail.com,WP_ANDERSON@HOTMAIL.COM'),
		(531116,'2024-1-22 0:41','PONCEKARINA62@GMAIL.COM,yessypilay_55@hotmail.com'),
		(531414,'2024-1-29 0:11','m_andrade_s@hotmail.com,JAIMEBRAVOGAME@GMAIL.COM'),
		(531569,'2024-1-2 0:30','NAYROMERO92@GMAIL.COM'),
		(532633,'2024-2-5 0:11','danielchoez94@gmail.com'),
		(532617,'2024-1-5 0:01','ronaldhuila86@hotmail.com'),
		(530154,'2024-1-29 0:11','marquezjenny312@gmail.com'),
		(530165,'2024-1-29 0:21','allysonalemanv@gmail.com'),
		(528692,'2023-12-29 0:00','hueso01687@gmail.com'),
		(528697,'2023-12-29 0:10','hueso01687@gmail.com'),
		(528309,'2024-1-22 0:31','ARMANDOSABINOCASTROJIMENEZ@GMAIL.COM'),
		(531027,'2024-1-18 0:00','miguelpesantez@hotmail.com'),
		(527809,'2024-1-10 0:00','ab_ottomendoza_79@hotmail.com,leonardorc0707@hotmail.com'),
		(531156,'2024-1-22 0:31','darwin19731973v@gmail.com'),
		(533071,'2024-1-15 0:11','rafaelarevaloaguila101979@gmail.com'),
		(525790,'2024-1-2 0:40','alejandrojhonny34@gmail.com,junior28_alejandro@hotmail.com'),
		(526544,'2024-1-15 0:01','ariana-sant-1994@hotmail.com,JOSEREYESMORA1988@GMAIL.COM'),
		(531445,'2024-1-29 0:21','marioandrechang97@gmail.com'),
		(533006,'2024-1-12 0:11','ctp_transvimosa@hotmail.com,wil_wal_rodri@hotmail.com'),
		(533854,'2024-2-6 0:02','tandres1964@hotmail.com'),
		(531778,'2024-1-10 0:01','JCARLOSROSALES05@GMAIL.COM'),
		(531793,'2024-1-11 0:01','edsonruiz79@gmail.com'),
		(530887,'2024-1-15 0:31','linoortega_buendia@hotmail.com'),
		(483506,'2024-2-2 10:20','linoortega_buendia@hotmail.com'),
		(530927,'2024-1-15 0:10','drpeterpardo@hotmail.com'),
		(532259,'2024-1-23 0:01','cinthya_campanita@yahoo.com'),
		(532498,'2024-1-2 0:20','eduardo841@outlook.es'),
		(531313,'2024-3-11 9:50','GABY_SWEET_MARFIL@HOTMAIL.COM'),
		(532425,'2024-1-29 0:10','taxicolcaranqui@gmail.com,democracia1981@gmail.com'),
		(532776,'2024-1-17 15:04','carlosquiroz990@gmail.com'),
		(530427,'2024-1-2 0:10','chintojacinto3000@gmail.com'),
		(533397,'2024-1-22 0:02','luismi_manito@hotmail.com'),
		(533458,'2024-1-22 0:01','john.nando26@gmail.com'),
		(533460,'2024-1-22 0:11','randysantiagocerezomosquera@gmail.com'),
		(532510,'2024-1-30 0:02','stevenmezagomez@gmail.com,stevenmeza@hotmail.com'),
		(533486,'2024-1-22 0:01','kylvyn2010@hotmail.com'),
		(533800,'2024-2-6 0:01','YOLANDACALIPARAPI@YAHOO.COM,yanchacali@hotmail.com'),
		(531829,'2024-1-11 0:11','vaca_paguayluis@outlook.com'),
		(532553,'2024-1-2 0:30','lalyreyeso@hotmail.com'),
		(532009,'2024-1-16 0:00','jhon_bryan19@hotmail.com'),
		(532223,'2024-1-22 0:01','reluviac@hotmail.com,SERAZO.ARQ@GMAIL.COM'),
		(532962,'2024-1-12 0:11','jodydumealvarado@gmail.com'),
		(533269,'2024-1-16 0:10','GLAUBERMENDOZA71@HOTMAIL.COM'),
		(532679,'2024-2-6 0:01','alejo_salinas24@hotmail.com'),
		(532988,'2024-3-12 18:00','COOP.DRESTEBANAMADOR@HOTMAIL.COM,raulsamaniego197744@gmail.com'),
		(532987,'2024-1-12 0:01','COOP.DRESTEBANAMADOR@HOTMAIL.COM,raulsamaniego197744@gmail.com'),
		(532041,'2024-1-17 0:01','epiguave@autolasa.com.ec,cesarsanchez2649@gmail.com'),
		(457148,'2024-1-31 14:38','sandymacancela@gmail.com'),
		(533229,'2024-1-15 0:10','danielmedinaa@hotmail.es,manuelcabllero6@gmail.com'),
		(533240,'2024-3-12 17:40','PERZAMBRANO@GMAIL.COM'),
		(533248,'2024-1-15 0:30','decorandojuntos@outlook.es'),
		(532512,'2024-1-30 0:21','josuuvaleri22@gmail.com,manitochat4@gmail.com'),
		(532559,'2024-1-31 0:01','freddyveas41@gmail.com,cooperativadetaxisurltda@hotmail.com'),
		(531727,'2024-1-9 0:00','TRANSPORTESRIVERA20@GMAIL.COM'),
		(533776,'2024-2-6 0:01','zoticotaglez@hotmail.com,estudjuri1ge@gmail.com'),
		(533421,'2024-1-22 0:11','ginger_segura1994@hotmail.com,kevinquinonez766@gmail.com'),
		(531825,'2024-1-11 0:00','serviceeasytaxi@gmail.com'),
		(530401,'2024-1-2 0:40','MICHAELCHARCOPA@GMAIL.COM'),
		(533541,'2024-3-12 18:06','NARCISOHOLGUIN1986@OUTLOOK.ES'),
		(533862,'2024-2-6 0:02','algunos@yopmail.com,wilfridoespana@yahoo.com'),
		(533590,'2024-1-29 0:01','alexavt09@gmail.com'),
		(533222,'2024-1-15 0:01','arteaga_35@gmail.com'),
		(533226,'2024-1-15 0:10','melissacandelario67@gmail.com'),
		(533236,'2024-1-15 0:50','ferijanazareno@gmail.com'),
		(533239,'2024-1-15 0:50','jennybajana1@gmail.com'),
		(533252,'2024-3-12 17:40','BERNARDOCABRERA55@YAHOO.COM'),
		(532386,'2024-3-11 9:20','amerchan873@gmail.com'),
		(532406,'2024-1-29 0:21','briannaden1996@gmail.com'),
		(532569,'2024-1-31 0:15','elkangry17@hotmail.com'),
		(532601,'2024-1-2 0:50','zambv.danny@gmail.com'),
		(531180,'2024-1-22 0:00','FELIPE_GONZABAY@HOTMAIL.COM,felpe.gonzabay@mabe.com.ec'),
		(531797,'2024-1-11 0:10','jose01castroveliz@gmail.com'),
		(532479,'2024-1-29 0:21','bermeojeffer4@gmail.com'),
		(533044,'2024-3-12 17:40','ANGELICACHAVEZ1@HOTMAIL.ES'),
		(533811,'2024-2-6 0:01','jonnygonza70@gmail.com'),
		(533419,'2024-1-22 0:21','JLCASTILLO2425@GMAIL.COM'),
		(533444,'2024-3-12 17:40','matildamagna@hotmail.com'),
		(533449,'2024-1-22 0:31','MILTONFABARA1963@GMAIL.COM'),
		(527582,'2024-1-5 0:01','kleber.ruiz@gmail.com,ciberdonjose2019@gmail.com'),
		(532847,'2024-2-8 0:02','ISRAELCR97@OUTLOOK.COM,israelsalomon1997@gmail.com'),
		(532955,'2024-1-12 0:11','HIDROTRACK@HOTMAIL.COM,hierba88@hotmail.com'),
		(533293,'2024-1-16 0:01','j.c.d.veloz@gmail.com'),
		(533300,'2024-3-12 17:40','miguelmora2348@gmail.com,PATRICIO.JARAMILLO@HOTMAIL.COM'),
		(531021,'2024-1-18 12:20','isis_dender@hotmail.com'),
		(531837,'2024-1-11 0:10','ABIGAILYNOELIA_93@HOTMAIL.COM'),
		(532558,'2024-1-31 0:02','joffre.medinav@gmail.com,joffre.medinav@hotmail.com'),
		(523920,'2024-2-6 0:11','Jazminrendon@live.com'),
		(529736,'2024-1-22 0:01','patriciahilda93@gmail.com'),
		(532374,'2024-3-11 9:50','darwintriguero517@gmail.com'),
		(529144,'2024-2-7 0:01','chimboluis33@hotmail.com'),
		(531636,'2024-2-7 0:01','joaoquisphi@gmail.com'),
		(526703,'2024-1-19 10:20','gabriela_bazurto91@hotmail.com'),
		(533073,'2024-1-15 0:30','darkchuack110978@hotmail.com'),
		(526705,'2024-1-17 16:04','mjbejaranomacias@gmail.com'),
		(532631,'2024-1-5 0:10','construccionesmg26@gmail.com'),
		(526931,'2024-1-22 0:01','MCARRENO@SOLUFINSA.COM'),
		(530593,'2024-1-30 15:45','edisonandrade7@hotmail.com'),
		(533023,'2024-1-15 0:31','marce4angel@hotmail.com'),
		(528335,'2024-3-11 9:01','eecheverria1953@gmail.com,WILMERORTEGA@LEGALVAL.COM'),
		(528125,'2024-1-30 17:26','SORAYABARRETO26@HOTMAIL.COM,sorayabarreto48@gmail.com'),
		(532213,'2024-1-22 0:00','MARCOSBOSSANOJR@HOTMAIL.COM'),
		(520882,'2024-2-1 11:20','jeanbe18@hotmail.com,oscar_orellana83@hotmail.com'),
		(530457,'2024-1-3 0:00','nelsonalemonserratesanto@gmail.com'),
		(532381,'2024-3-27 12:19','marujitaelena2023@gmail.com,MARIOARNOLFO54@GMAIL.COM'),
		(518150,'2024-1-30 11:41','caag_90@hotmail.com'),
		(531134,'2024-1-22 0:21','byron.ronquillos@gmail.com,BYRONQUILLO_0310@HOTMAIL.COM'),
		(511433,'2024-2-2 11:20','miltonlaraguerrero@gmail.com'),
		(523544,'2024-2-2 11:48','juliorafaelpalmacabello@gmail.com'),
		(532467,'2023-12-29 0:09','eduardojaviervillonlindao@gmail.com'),
		(532474,'2023-12-29 0:01','vittori16_10@hotmail.com'),
		(526015,'2024-2-6 0:11','bry_re@outlook.es'),
		(526017,'2024-2-2 12:36','aureliomoreira91@gmail.com'),
		(526953,'2024-1-22 0:31','fabriciopincay@hotmail.es'),
		(533112,'2024-3-12 17:40','VALENCIA@HOTMAIL.COM'),
		(525844,'2024-2-7 16:11','jotafrank-92@hotmail.com'),
		(530754,'2024-1-11 0:01','thelexdj@hotmail.com,wilson_almeida@hotmail.com'),
		(532612,'2024-3-15 11:04','javegeorge_17@hotmail.com,georgejave_17@hotmail.com'),
		(532682,'2024-3-14 15:40','elcoloradost@hotmail.com'),
		(526920,'2024-1-22 0:02','milton76abadv@gmail.com,pincayk08@gmail.com'),
		(532397,'2024-1-29 0:01','DJFORMULAPOP@HOTMAIL.COM,djchapu_1993@hotmail.com'),
		(533335,'2024-3-12 17:40','CARLOSALBERTO_@HOTMAIL.COM,andyholguinllerena@hotmail.com'),
		(526481,'2024-1-15 0:01','OLGA2809GOMEZ@GMAIL.COM'),
		(533012,'2024-1-12 0:01','michellebwn2517@gmail.com,michellebwn25-@hotmail.com'),
		(529221,'2024-2-8 0:01','luciacandelario10@gmail.com'),
		(525709,'2024-1-30 0:01','guamanfalex1a@gmail.com,MARIOGUAMAN1978@HOTMAIL.COM'),
		(524105,'2024-2-2 12:36','nietoalvaro604@gmail.com'),
		(499902,'2024-1-4 15:04','alex_londres@hotmail.com'),
		(532575,'2024-1-2 0:10','mirnachica0@gmail.com'),
		(527943,'2024-1-30 15:57','anny.lopez1001@gmail.com,medinapr@ug.edu.ec'),
		(531498,'2024-1-2 0:10','elianjaviergc@gmail.com'),
		(528735,'2024-1-30 0:11','VMRV6043@GMAIL.COM,CPAOLIVERVASQUEZ@HOTMAIL.COM'),
		(527405,'2024-2-2 0:01','axelsimonpiguaveholguinu@gmail.com,EVERT.SPORT@HOTMAIL.COM'),
		(530653,'2024-2-7 0:01','anvalero1996@gmail.com'),
		(531795,'2024-1-11 0:10','carl.7@outlook.com'),
		(533382,'2024-1-19 0:11','aamaya17@hotmail.com'),
		(532495,'2023-12-29 0:00','GISSELLBM_15@HOTMAIL.COM,djeff85@hotmail.com'),
		(528983,'2024-3-11 9:21','jairocheme38@gmail.com'),
		(526830,'2024-1-22 0:41','carnepropia@hotmail.com,impoventas04@live.com'),
		(530448,'2024-1-3 0:00','HERNANJUN1945@GMAIL.COM'),
		(529600,'2024-1-16 0:01','pomaderelnegrito@gmail.com'),
		(532584,'2024-1-2 0:00','ikerrandres@hotmail.com'),
		(533020,'2024-1-15 0:21','karlasuarez2718@gmail.com'),
		(530794,'2024-1-12 0:10','fabriciovillafuerte2001@outlook.com'),
		(531773,'2024-1-10 0:00','larbito2782@gmail.com'),
		(531742,'2024-1-9 0:00','nahinzumba1990@hotmail.com'),
		(530541,'2024-2-5 0:02','dariovalente1843@gmail.com'),
		(531608,'2024-2-7 0:01','JODI.MINCHALA@GMAIL.COM,jordi.minchala@gmail.com'),
		(530432,'2024-1-30 0:01','poncesaenzjuanjose0@gmail.com'),
		(506943,'2024-2-1 18:21','www.fercarplua@hotmail.com'),
		(530487,'2024-1-4 0:00','fundacionguerrerosvencedores@gmail.com'),
		(492453,'2024-2-2 12:14','erikintriagoazul19@gmail.com'),
		(531466,'2024-1-31 13:40','magu_mafer@hotmailcom'),
		(531555,'2024-1-2 0:30','farfansocrete@gmail.com'),
		(526260,'2024-1-23 14:32','javierlucioruiz@hotmail.com'),
		(529945,'2024-1-23 0:01','mariaisabelamaguaya@hotmail.com'),
		(533705,'2024-3-12 17:50','eddercito1515@hotmail.com'),
		(533622,'2024-1-30 0:20','diegobermeo@hotmail.com'),
		(531792,'2024-1-11 0:10','carlos.severino2.77@gmail.com'),
		(530534,'2024-1-4 0:01','thony.panta1@gmail.com,priscy_guaranda@hotmail.com'),
		(532286,'2024-1-23 0:01','PABLOGARCIAALARCON@HOTMAIL.COM'),
		(532309,'2024-3-27 12:19','JOSEPHJACOMEE20@GMAIL.COM'),
		(532991,'2024-1-12 0:01','harryjacksongarciacadena@hotmail.com'),
		(533060,'2024-1-15 0:21','haray14@hotmail.com'),
		(533716,'2024-1-30 0:02','JLINDAO593@GMAIL.COM'),
		(531020,'2024-3-11 9:50','SISY_BB@HOTMAIL.COM'),
		(525928,'2024-1-5 0:01','suannygenesis@gmail.com'),
		(533081,'2024-1-15 0:01','electronicadarwinsupe@gmail.com'),
		(531550,'2024-2-1 0:02','ricardogallegos2018@hotmail.com'),
		(533341,'2024-1-19 0:01','eliza-pau2002@hotmail.com'),
		(530499,'2024-2-5 0:11','ddarwin_1983@hotmail.com'),
		(533313,'2024-1-19 0:04','ANDYCARL_1991@HOTMAIL.COM'),
		(527402,'2024-2-2 0:01','karentoala85@gmail.com'),
		(532880,'2024-3-15 16:30','fernan-s95@hotmail.com'),
		(521676,'2023-12-29 0:00','SUIRIS.1982@GMAIL.COM'),
		(530003,'2024-3-11 9:20','jcortez24977@gmail.com'),
		(533597,'2024-1-29 0:31','danielmurillo_@hotmail.com'),
		(531939,'2024-1-15 0:20','robertoaveigarodriguez79@gmail.com,martin121953@gmail.com'),
		(532133,'2024-3-11 9:40','XVIZCAINOCORDOVA@OUTLOOK.COM'),
		(528651,'2024-1-29 0:11','borisord.1958@gmail.com'),
		(528763,'2024-1-30 0:01','tributarios2012@gmail.com'),
		(532083,'2024-3-11 9:50','hrizzo@bio-laboratorio.com'),
		(532378,'2024-1-25 0:01','juanduquecantos1987@gmail.com'),
		(532504,'2024-1-2 0:30','cdlvilla@hotmail.com'),
		(532539,'2024-1-2 0:20','gata1792@hotmail.com'),
		(527747,'2024-1-26 12:15','NOBOA@HOTMAIL.COM'),
		(531295,'2024-4-1 10:27','loorlimber625@gmail.com,GENESALDARRIAGA@HOTMAIL.COM'),
		(532576,'2024-2-2 0:01','andres_olvera@hotmail.com'),
		(528675,'2024-1-29 0:30','kleberoalejandro@yahoo.com'),
		(533598,'2024-1-29 0:21','CDAVILA_16@HOTMAIL.COM'),
		(531942,'2024-1-15 0:00','robertcrespo@outlook.com'),
		(533396,'2024-1-22 0:31','eduardoocascas@gmail.com'),
		(533348,'2024-1-19 0:10','FS.MADERO@GMAIL.COM,jpaguilar_3a@hotmail.com'),
		(532284,'2024-1-23 0:01','svillamarc@gmail.com'),
		(530461,'2024-1-3 0:01','luisarreaga1966@gmail.com,ROMA20576@HOTMAIL.COM'),
		(533804,'2024-2-6 0:01','drapamelamontalvonv@gmail.com'),
		(533849,'2024-2-6 0:11','leonardcoopers17@gmail.com,jorgevergara0902@gmail.com'),
		(532830,'2024-3-11 16:40','edupiedra@hotmail.com'),
		(528718,'2024-1-2 0:10','joseantonio_pj@hotmail.com,chino.mendozab@gmail.com'),
		(532874,'2024-3-12 12:06','manuelveliz1968@hotmail.com,janina_cecibel@hotmail.com'),
		(532524,'2024-1-2 0:01','GABRIELAMARTILLOJORDAN@GMAIL.COM'),
		(533815,'2024-2-6 0:11','indira_miranda@hotmail.com,imiranda@geomedios.com.ec'),
		(527694,'2024-2-8 0:00','Framurpado6@gmail.com'),
		(533826,'2024-2-6 0:01','diogo241988@gmail.com'),
		(526994,'2024-3-27 12:19','cristalcristina2011@hotmail.com'),
		(507172,'2024-1-31 0:11','betod24@gmail.com,COOPRUTA77@GMAIL.COM'),
		(532144,'2024-3-11 9:01','joao199594_@hotmail.com'),
		(529793,'2024-1-22 0:21','garzonrafael585@gmail.com'),
		(532654,'2024-2-5 0:21','victor@gmail.com,bolivarcorazonnorris@hotmail.com'),
		(528780,'2024-1-2 0:10','MARLONSAMA360@GMAIL.COM'),
		(532873,'2024-3-12 12:05','lvidal341@gmail.com,abg.juliovillamar@hotmail.com'),
		(533379,'2024-1-19 0:11','ivanarturoo1987@gmail.com'),
		(530453,'2024-1-3 0:09','angelexchacon1983@gmail.com'),
		(528973,'2024-1-30 16:37','K_NDELITA@HOTMAIL.COM'),
		(526391,'2024-1-15 14:19','santiagomerchan31@gmail.com'),
		(527967,'2024-1-30 15:27','dixonsuarez2996@outlook.com,dixonsuarez2996@gmail.com'),
		(528606,'2024-1-12 14:00','galerialatorre@hotmail.com'),
		(533459,'2024-1-22 0:31','nandoperez0106@hotmail.com'),
		(532548,'2024-1-2 0:20','ladymurillo942@gmail.com'),
		(527751,'2024-1-9 0:01','DMARTINEZPICO@GMAIL.COM'),
		(529691,'2024-1-22 0:30','joseyunapanta977@gmail.com'),
		(531152,'2024-1-22 0:01','dhsvallejo@hotmail.com'),
		(533702,'2024-1-30 0:11','CARBLAN090@HOTMAIL.COM'),
		(531492,'2024-1-31 0:05','jorge.obando.lema@gmail.com'),
		(531509,'2024-1-2 0:10','leidyminaborja2408@gmail.com'),
		(533070,'2024-1-15 0:10','MAYRAESPEINOZA1811@GMAIL.COM,mayraespinoza1812@gmail.com'),
		(533655,'2024-1-30 0:11','EVELYNFIGUEROA@HOTMAIL.COM,FOT1989@HOTMAIL.COM'),
		(531142,'2024-1-22 0:31','krisbell24joel@gmail.com'),
		(533461,'2024-1-22 0:30','douglasric17@gmail.com'),
		(529491,'2024-1-15 0:31','manueljunasanchez080@gmail.com'),
		(531502,'2024-1-2 0:30','davidfernandodavilabayas@gmail.com,daviddavilac01@gmail.com'),
		(533718,'2024-1-30 0:11','SERVIREPUESTOLUIS@HOTMAIL.COM')
	end
-- select top 66 * from integracion_terceros.dbo.log_restauracion_financiacion order by fecha_hora_ejecucion desc

declare cursor_fin_inc cursor for

	select --top 100
	inc.NUMERO_FINANCIACION,
	inc.nro_cuotas,
	YEAR(inc.fecha_registro) AS anio,
	inc.fecha_anulacion,
	inc.agencia_transito AS codigo_organismo,
	inc.IDENTIFICACION as identificacion_persona,
	inc.ID_IDENTIFICACION as id_identificacion_persona,
	inc.FECHA_REGISTRO as fecha_registro
	--CASE
	--WHEN ID_MOTIVO_ANULACION = 'CFF'  THEN 'FINANCIACION MULTAS CORRIENTE'
	--WHEN ID_MOTIVO_ANULACION = 'RCF'  THEN 'FINANCIACION MULTAS COACTIVO' END TIPO_INCUMPLIMIENTO,
	--inc.SALDO_FINANCIACION, car.saldo_capital
	from integracion_terceros.dbo.v_financiaciones_incumplidos_rec inc
	inner join circulemos2.dbo.financiacion fin on fin.numero_financiacion = inc.NUMERO_FINANCIACION
	inner join circulemos2.dbo.proceso pro on pro.id_proceso = fin.id_proceso
	inner join circulemos2.dbo.cartera car on car.nombre=inc.NUMERO_FINANCIACION and car.codigo_tipo_obligacion=6
	--left join integracion_terceros.dbo.log_restauracion_financiacion loger on inc.NUMERO_FINANCIACION = loger.numero_financiacion
	--inner join #temp_fechas_y_correos tmp on tmp.numero_financiacion = inc.NUMERO_FINANCIACION
	where id_motivo_anulacion in ('RCF')
	and inc.SALDO_FINANCIACION=car.saldo_capital
	and pro.id_estado_proceso <> 19
	--and loger.numero_financiacion is null
	and inc.NUMERO_FINANCIACION in (
	526705
	)
	order by inc.NUMERO_FINANCIACION

	open cursor_fin_inc
		fetch next from cursor_fin_inc into @numero_financiacion, @numero_cuotas, @anio, @fecha_anulacion, @codigo_organismo, @identificacion_persona,
		@id_identificacion_persona,
		@fecha_fecha_registro
		while @@fetch_status = 0
			begin
				set @rollback = 0
				begin tran
				--VALIDAR PAGOS EN ESTADOS CORRECTOS
				if exists (select 1 from circulemos2.dbo.detalle_pago dp where dp.numero_obligacion = CONVERT(varchar,@numero_financiacion)
					and id_estado_pago <> 2)
					begin
						rollback
						INSERT INTO integracion_terceros.dbo.log_restauracion_financiacion (numero_financiacion, tipo_id, identificacion, mensaje)
						VALUES (@numero_financiacion, null, @identificacion_persona, 'Financiamiento_Incumplido tiene pagos con id_estado_pago diferente a 2');
						
						--Saltar a la siguiente iteración
						set @rollback = 1;
						begin tran
						goto siguienteIteracion
					end

				declare @fecha_notificacion smalldatetime
				select @fecha_notificacion = fecha_notificacion from #temp_fechas_y_correos where numero_financiacion = @numero_financiacion
				declare @fecha_validar smalldatetime
				declare @fecha_notificacion_insertar smalldatetime = null;
				
				if @fecha_notificacion is null or @fecha_notificacion > @fecha_anulacion
					begin
						set @fecha_validar = @fecha_anulacion
						declare @contador_dias int = 1;
						while @contador_dias <= 5
							begin
								set @fecha_validar = DATEADD(day, -1, @fecha_validar)
								declare @fecha_encontrada_no_habil date = null
								select @fecha_encontrada_no_habil = fecha from circulemos2.dbo.dia_no_habil where fecha = convert(date,@fecha_validar)
								--select @contador_dias as dias, @fecha_validar as fecha_validar, @fecha_encontrada_no_habil as fecha_encontrada ,convert(date,@fecha_validar) as convertida, @fecha_validar as fecha_normal
								if @fecha_encontrada_no_habil is null
									set @contador_dias = @contador_dias + 1;
							end
						set @fecha_notificacion_insertar = @fecha_validar
					end
				else
					set @fecha_notificacion_insertar = @fecha_notificacion
				
				--inserts
				--trazabilidad_financiacion_incumplida
				--declare id_estado
				
				declare @nro_cuota int
				declare @valor_cuota decimal(38,6)
				declare @fecha_pago_oportuno smalldatetime
				declare @id_financiacion int
				declare @id_trazabilidad_financiacion_incumplida bigint = null
				
				
				select top 1 @nro_cuota=NRO_CUOTA, @valor_cuota = VALOR_CUOTA from integracion_terceros.dbo.v_all_cuotasfinanciacion 
				where NUMERO_FINANCIACION=@numero_financiacion and SALDO_CUOTA > 0 order by NRO_CUOTA asc
				--VALIDACION CUOTAS
				--Validación Saldo_cuota cero
				/*
				if exists (select 1 from integracion_terceros.dbo.v_all_cuotasfinanciacion 
					where NUMERO_FINANCIACION=@numero_financiacion and SALDO_CUOTA > 0 and NRO_CUOTA = 0)
					begin
						rollback
						insert into integracion_terceros.dbo.log_restauracion_financiacion
						(numero_financiacion, tipo_id, identificacion, mensaje)
						values(@numero_financiacion,null,@identificacion_persona,'Cuota 0 con saldo mayor a 0')
						begin tran
						goto siguienteIteracion
					end
				*/ 
				--Validación otras cuotas con saldo zero
				/*
				if exists(select * from integracion_terceros.dbo.v_all_cuotasfinanciacion  where numero_financiacion=@numero_financiacion
					and nro_cuota > @nro_cuota and saldo_cuota = 0 )
					begin
						rollback
						insert into integracion_terceros.dbo.log_restauracion_financiacion
						(numero_financiacion, tipo_id, identificacion, mensaje)
						values(@numero_financiacion,null,@identificacion_persona,'Cuotas posteriores a la incumplida con saldo en 0')
						begin tran
						goto siguienteIteracion
					end
				*/
				declare @id_proceso_financiacion bigint

				select @id_financiacion = id_financiacion, @id_proceso_financiacion = id_proceso 
				from circulemos2.dbo.financiacion where numero_financiacion = @numero_financiacion

				select @fecha_pago_oportuno = fecha_pago_oportuno from circulemos2.dbo.detalle_financiacion 
				where id_financiacion = @id_financiacion and numero_cuota = @nro_cuota

				select @id_trazabilidad_financiacion_incumplida = id_trazabilidad_financiacion from circulemos2.dbo.trazabilidad_financiacion_incumplida
				where numero_de_convenio = @numero_financiacion and id_estado_de_incumplimiento = 2 and cuotas_incumplidas = @nro_cuota 
				
				if @id_trazabilidad_financiacion_incumplida is null
					insert into circulemos2.dbo.trazabilidad_financiacion_incumplida 
					(tipo_de_financiacion,numero_de_convenio,fecha_de_convenio,estado_de_convenio,id_estado_de_incumplimiento,cuotas_incumplidas,valor_cuotas_incumplidas,fecha_pago_oportuno,id_financiacion,id_coactivo,fecha_registro_marcacion)
					values(2, @numero_financiacion,null,'EN FIRME',2,@nro_cuota,@valor_cuota,@fecha_pago_oportuno,@id_financiacion,null,@fecha_notificacion_insertar)
				else
					update circulemos2.dbo.trazabilidad_financiacion_incumplida 
					set fecha_registro_marcacion = @fecha_notificacion_insertar 
					where id_trazabilidad_financiacion=@id_trazabilidad_financiacion_incumplida

				--trazabilidad_incumplimiento_email
				declare @cantidad_envios int
				select @cantidad_envios = COUNT(id_trazabilidad_incumplimiento_email) 
				from circulemos2.dbo.trazabilidad_incumplimiento_email where numero_financiacion = @numero_financiacion

				set @cantidad_envios = @cantidad_envios + 1

				--select top 100 * from circulemos2.dbo.trazabilidad_incumplimiento_email where cantidad_envios >=3 order by 1 desc
				declare @id_trazabilidad_incumplimiento_email bigint = null

				select @id_trazabilidad_incumplimiento_email = id_trazabilidad_incumplimiento_email from
				circulemos2.dbo.trazabilidad_incumplimiento_email where numero_financiacion = @numero_financiacion
				and numero_cuota = @nro_cuota
				--select top 10 * from circulemos2.dbo.trazabilidad_incumplimiento_email order by 1 desc
				
				if @id_trazabilidad_incumplimiento_email is null
					begin
						declare @correos_encontrados varchar(500)
						select @correos_encontrados = correos from #temp_fechas_y_correos where numero_financiacion = @numero_financiacion
						if @correos_encontrados is null
							insert into circulemos2.dbo.trazabilidad_incumplimiento_email 
							(correos,fecha_envio,cantidad_envios,id_estado_envio_incumplimiento,numero_financiacion,numero_cuota) values
							('Reconstruccion - Correo no encontrado',@fecha_notificacion_insertar,@cantidad_envios,1,@numero_financiacion,@nro_cuota)
						else
							insert into circulemos2.dbo.trazabilidad_incumplimiento_email 
							(correos,fecha_envio,cantidad_envios,id_estado_envio_incumplimiento,numero_financiacion,numero_cuota) values
							(@correos_encontrados,@fecha_notificacion_insertar,@cantidad_envios,3,@numero_financiacion,@nro_cuota)
					end
				else
					update circulemos2.dbo.trazabilidad_incumplimiento_email 
					set fecha_envio = @fecha_notificacion_insertar where id_trazabilidad_incumplimiento_email = @id_trazabilidad_incumplimiento_email

				--insertar liquidación
				insert into circulemos2.dbo.trazabilidad_financiacion_incumplida 
					(tipo_de_financiacion,numero_de_convenio,fecha_de_convenio,estado_de_convenio,id_estado_de_incumplimiento,cuotas_incumplidas,valor_cuotas_incumplidas,fecha_pago_oportuno,id_financiacion,id_coactivo,fecha_registro_marcacion)
					values(2, @numero_financiacion,null,'EN FIRME',1,@nro_cuota,@valor_cuota,@fecha_pago_oportuno,@id_financiacion,null,@fecha_anulacion)

				declare @cuotas_incumplidas int = @numero_cuotas - @nro_cuota + 1

				declare @saldo_capital decimal(16,2)
				declare @saldo_interes decimal(16,2)
				declare @saldo_costas_procesales decimal(16,2)
				declare @id_cartera_obligaciones bigint
				declare @cicomparendo bigint
				declare @id_coactivo bigint
				declare @valor_total_cartera_saldo_capital decimal(16,2);
				declare @id_proceso_coactivo bigint;
				
				declare @suma_saldo_costas_procesales numeric(16,2)
				declare @suma_@saldo_interes numeric(16,2)
				declare cursor_coactivos cursor for
					select co.id_coactivo, co.id_proceso from circulemos2.dbo.coactivo co 
					inner join circulemos2.dbo.obligacion_coactivo obco on obco.id_coactivo = co.id_coactivo
					inner join circulemos2.dbo.obligacion_financiacion obf on obf.numero_obligacion = obco.numero_obligacion
					where obf.id_financiacion = @id_financiacion group by co.id_coactivo, co.id_proceso

					open cursor_coactivos
						fetch next from cursor_coactivos into @id_coactivo, @id_proceso_coactivo
						while @@FETCH_STATUS = 0
						begin

							set @valor_total_cartera_saldo_capital = 0;
							set @suma_saldo_costas_procesales = 0;
							set @suma_@saldo_interes = 0;

							declare cursor_obligaciones cursor for
								select cart.saldo_capital, cart.saldo_costas_procesales, cart.saldo_interes from circulemos2.dbo.obligacion_coactivo obco 
								inner join circulemos2.dbo.obligacion_financiacion obf on obf.numero_obligacion = obco.numero_obligacion
								inner join circulemos2.dbo.cartera cart on cart.nombre = obf.numero_obligacion
								inner join circulemos2.dbo.comparendo comp on comp.id_factura_axis = obf.numero_obligacion
								where obco.id_coactivo = @id_coactivo
								
								open cursor_obligaciones
									fetch next from cursor_obligaciones into @saldo_capital, @saldo_costas_procesales, @saldo_interes
									while @@FETCH_STATUS = 0
									begin
										set @valor_total_cartera_saldo_capital = @valor_total_cartera_saldo_capital + @saldo_capital;
										set @suma_saldo_costas_procesales = @suma_saldo_costas_procesales + @saldo_costas_procesales;
										set @suma_@saldo_interes = @suma_@saldo_interes + @saldo_interes;
									fetch next from cursor_obligaciones into @saldo_capital, @saldo_costas_procesales, @saldo_interes
									end
								close cursor_obligaciones
							deallocate cursor_obligaciones

							insert into circulemos2.dbo.trazabilidad_financiacion_incumplida 
							(tipo_de_financiacion,numero_de_convenio,fecha_de_convenio,estado_de_convenio,id_estado_de_incumplimiento,cuotas_incumplidas,valor_cuotas_incumplidas,fecha_pago_oportuno,id_financiacion,id_coactivo,fecha_registro_marcacion)
							values(2, @numero_financiacion,null,'INCUMPLIDO',3,@cuotas_incumplidas,@valor_total_cartera_saldo_capital,@fecha_pago_oportuno,@id_financiacion,@id_coactivo,@fecha_anulacion)
							
							update circulemos2.dbo.proceso 
							set observacion = 'NOTIFICADO', id_estado_proceso = 23
							where id_proceso = @id_proceso_coactivo;

							update circulemos2.dbo.trazabilidad_proceso 
							set fecha_fin = @fecha_anulacion
							where fecha_fin is null and id_proceso = @id_proceso_coactivo;
							
							insert circulemos2.dbo.trazabilidad_proceso 
							(id_proceso, id_estado_proceso, fecha_inicio, fecha_fin,id_usuario, id_sede_proceso, id_sede_usuario) values
							(@id_proceso_coactivo, 23,@fecha_anulacion, null,1,2,1)

							update circulemos2.dbo.coactivo
							set valor_total_obligaciones = @valor_total_cartera_saldo_capital, valor_total_costas_procesales=@suma_saldo_costas_procesales,
							id_tipo_coactivo = 3
							where id_coactivo=@id_coactivo

						fetch next from cursor_coactivos into @id_coactivo, @id_proceso_coactivo
						end
					close cursor_coactivos
				deallocate cursor_coactivos
				--Cursor duplicado
				
				declare cursor_coactivos cursor for
					select co.id_coactivo from circulemos2.dbo.coactivo co 
					inner join circulemos2.dbo.obligacion_coactivo obco on obco.id_coactivo = co.id_coactivo
					inner join circulemos2.dbo.obligacion_financiacion obf on obf.numero_obligacion = obco.numero_obligacion
					where obf.id_financiacion = @id_financiacion group by co.id_coactivo, co.id_proceso
					
					open cursor_coactivos
						fetch next from cursor_coactivos into @id_coactivo
						while @@FETCH_STATUS = 0
						begin

							insert into circulemos2.dbo.trazabilidad_financiacion_incumplida 
							(tipo_de_financiacion,numero_de_convenio,fecha_de_convenio,estado_de_convenio,id_estado_de_incumplimiento,cuotas_incumplidas,valor_cuotas_incumplidas,fecha_pago_oportuno,id_financiacion,id_coactivo,fecha_registro_marcacion)
							values(2, @numero_financiacion,null,'INCUMPLIDO',1,@nro_cuota,@valor_cuota,@fecha_pago_oportuno,@id_financiacion,null,@fecha_anulacion)

						fetch next from cursor_coactivos into @id_coactivo
						end
					close cursor_coactivos
				deallocate cursor_coactivos

				declare @valor_costas_procesales_ini numeric(16,2) = null;
				declare @valor_capital_ini numeric(16,2) = null;
				declare @valor_intereses_ini numeric(16,2) = null;
				--Cursor 
				declare @error int = 0;
				declare cursor_obligaciones cursor for

					select c.id_cartera,c.saldo_capital, c.saldo_interes, c.saldo_costas_procesales, 
					comp.cicomparendo, ob.valor_obligacion, ob.valor_interes_moratorios, ob.valor_costas_procesales
					from circulemos2.dbo.obligacion_financiacion ob 
					inner join circulemos2.dbo.cartera c on ob.numero_obligacion = c.nombre
					inner join circulemos2.dbo.comparendo comp on ob.numero_obligacion = comp.id_factura_axis
					where id_financiacion = @id_financiacion and c.codigo_tipo_obligacion = 1

					open cursor_obligaciones 
						fetch next from cursor_obligaciones into @id_cartera_obligaciones, @saldo_capital, 
						@saldo_interes, @saldo_costas_procesales, @cicomparendo, @valor_capital_ini, @valor_intereses_ini, @valor_costas_procesales_ini
						while @@FETCH_STATUS = 0
						begin
							
							update circulemos2.dbo.cartera 
							set codigo_estado_obligacion = 2, fecha_actualizacion = @fecha_anulacion
							where id_cartera = @id_cartera_obligaciones

							insert circulemos2.dbo.trazabilidad_cartera 
							(fecha_registro,id_cartera,id_actividad_cartera,login_usuario,codigo_estado_obligacion)
							values (@fecha_anulacion,@id_cartera_obligaciones,36,'admin-c2',2)
							
							insert circulemos2.dbo.trazabilidad_comparendo
							(cicomparendo,id_actividad,fecha_ejecucion,fecha_registro,id_usuario,usuario_externo,activo,id_estado_comparendo,numero_acto_administrativo)
							values(@cicomparendo,31,@fecha_anulacion, @fecha_anulacion, 1, null, 1, 13, null)

							update circulemos2.dbo.obligacion_coactivo --pendiente validar si actualizar fecha obligacion 
							set valor_obligacion=@saldo_capital, valor_interes_moratorios=@saldo_interes,
							valor_costas_procesales = @saldo_costas_procesales, fecha_obligacion = @fecha_anulacion
							where id_cartera = @id_cartera_obligaciones

							declare @id_obligacion_coactivo bigint = null;
							select @id_obligacion_coactivo = id_obligacion_coactivo from circulemos2.dbo.obligacion_coactivo where id_cartera = @id_cartera_obligaciones

							if @id_obligacion_coactivo is null
								begin
									rollback
									insert into integracion_terceros.dbo.log_restauracion_financiacion
									(numero_financiacion, tipo_id, identificacion, mensaje)
									values(@numero_financiacion,null,@identificacion_persona,'Se encontro id_obligacion_coactivo en null para la cartera '+ cast(@id_cartera_obligaciones as varchar))
									set @error = 1;
									set @rollback = 1;
									begin tran
									--goto siguienteIteracion
									goto cerrarCursor_obligaciones;
								end
							--Convenios Incumplidos
							insert circulemos2.dbo.obligacion_coactivo_historico 
							(id_obligacion_coactivo, fecha_movimiento, proceso, saldo_intereses, saldo_costas_procesales, saldo_capital, id_usuario, id_tipo_valor_coactivo_historico)
							values
							(@id_obligacion_coactivo, @fecha_anulacion, 'Convenios Incumplidos', @valor_intereses_ini, @valor_costas_procesales_ini, @valor_capital_ini, 1, 1);
							--Convenios Incumplidos Saldos
							insert circulemos2.dbo.obligacion_coactivo_historico 
							(id_obligacion_coactivo, fecha_movimiento, proceso, saldo_intereses, saldo_costas_procesales, saldo_capital, id_usuario, id_tipo_valor_coactivo_historico)
							values
							(@id_obligacion_coactivo, @fecha_anulacion, 'Convenios Incumplidos Saldos', @saldo_interes, @saldo_costas_procesales, @saldo_capital, 1,2);

							fetch next from cursor_obligaciones into @id_cartera_obligaciones, @saldo_capital, 
							@saldo_interes, @saldo_costas_procesales, @cicomparendo, @valor_capital_ini, @valor_intereses_ini, @valor_costas_procesales_ini
						end
						cerrarCursor_obligaciones:
					close cursor_obligaciones
				deallocate cursor_obligaciones

				if @error > 0
					goto siguienteIteracion
				--actualizar -- updates
				--proceso de la financiacion
				--actualizar proceso a incumplido
				update circulemos2.dbo.proceso set fecha_fin = @fecha_anulacion, observacion = 'INCUMPLIDO', id_estado_proceso=19
				where id_proceso = @id_proceso_financiacion

				--cerrar el estado anterior
				update circulemos2.dbo.trazabilidad_proceso 
				set fecha_fin = @fecha_anulacion where id_proceso = @id_proceso_financiacion and fecha_fin is null and id_estado_proceso = 16

				--insert liquidacion
				insert into circulemos2.dbo.trazabilidad_proceso 
				(id_proceso,id_estado_proceso,fecha_inicio,fecha_fin,id_usuario,id_sede_proceso,id_sede_usuario) values
				(@id_proceso_financiacion,33,@fecha_anulacion,DATEADD(SECOND, +1, @fecha_anulacion),1,2,1)

				--insertar incumplimiento
				insert into circulemos2.dbo.trazabilidad_proceso 
				(id_proceso,id_estado_proceso,fecha_inicio,fecha_fin,id_usuario,id_sede_proceso,id_sede_usuario) values
				(@id_proceso_financiacion,19,DATEADD(SECOND, +1, @fecha_anulacion),DATEADD(SECOND, +2, @fecha_anulacion),1,2,1)

				--cartera anular cartera de la financiacion
				declare @id_cartera_financiacion bigint
				declare @saldo_capital_cartera numeric(16,2)

				select @id_cartera_financiacion = id_cartera, @saldo_capital_cartera = saldo_capital
				from circulemos2.dbo.cartera where nombre = @numero_financiacion and codigo_tipo_obligacion = 6

				update circulemos2.dbo.cartera 
				set codigo_estado_obligacion = 12, saldo_capital=0 , fecha_actualizacion = @fecha_anulacion
				where nombre = @numero_financiacion and id_cartera = @id_cartera_financiacion

				insert circulemos2.dbo.movimientos_cartera 
				(id_cartera,fecha_movimiento,id_concepto,valor_movimiento,fecha_creacion,observaciones,login_usuario)
				values(@id_cartera_financiacion,@fecha_anulacion,196,@saldo_capital_cartera,@fecha_anulacion,'CANCELADO_INCUMPLIMIENTO_FINANCIACION_CAPITAL','admin-c2')
				
				set @id_movimiento_cartera = SCOPE_IDENTITY();

				insert into circulemos2.dbo.saldo_cartera
				(id_cartera,saldo,fecha_registro,fecha_calculo,id_tipo_saldo,id_movimiento_cartera)
				values(@id_cartera_financiacion,0,@fecha_anulacion,@fecha_anulacion,1,@id_movimiento_cartera)

				insert into circulemos2.dbo.saldo_cartera
				(id_cartera,saldo,fecha_registro,fecha_calculo,id_tipo_saldo,id_movimiento_cartera)
				values(@id_cartera_financiacion,0,@fecha_anulacion,@fecha_anulacion,2,@id_movimiento_cartera)

				insert into circulemos2.dbo.saldo_cartera
				(id_cartera,saldo,fecha_registro,fecha_calculo,id_tipo_saldo,id_movimiento_cartera)
				values(@id_cartera_financiacion,0,@fecha_anulacion,@fecha_anulacion,3,@id_movimiento_cartera)

				insert circulemos2.dbo.trazabilidad_cartera 
				(fecha_registro,id_cartera,id_actividad_cartera,login_usuario,codigo_estado_obligacion)
				values (@fecha_anulacion,@id_cartera_financiacion,36,'admin-c2',12)

				--reactiva la de la multa

				UPDATE circulemos2.dbo.comparendo 
					SET    id_estado_comparendo = 13
					WHERE  id_factura_axis IN (SELECT [of].numero_obligacion 
						FROM   circulemos2.dbo.obligacion_financiacion [of] 
						WHERE  [of].id_financiacion = 
								(SELECT f.id_financiacion 
								FROM   circulemos2.dbo.financiacion f 
								WHERE f.numero_financiacion = @numero_financiacion ) 
						);
				
				set @contador_financiaciones_procesadas = @contador_financiaciones_procesadas + 1

				--set @rollback = 1
				--select @numero_financiacion as numero_financiacion, 'Pruebas' as statuss, @rollback as rollbaks
				siguienteIteracion:
				--set @rollback = 1;
				if @rollback = 0
					begin
						commit tran
						--select @numero_financiacion as numero_financiacion, 'Ejecutado correctamente' as statuss
					end
				else
					begin
						rollback tran
						--select @numero_financiacion as numero_financiacion, 'No ejecutado' as statuss
					end

				fetch next from cursor_fin_inc into @numero_financiacion, @numero_cuotas, @anio, @fecha_anulacion, @codigo_organismo, @identificacion_persona,
				@id_identificacion_persona,
				@fecha_fecha_registro
			end

	close cursor_fin_inc

deallocate cursor_fin_inc
select @contador_financiaciones_procesadas as 'financiaciones_procesadas'
