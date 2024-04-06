BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "company_allproduct" (
	"name"	varchar(100) NOT NULL,
	"price"	varchar(100) NOT NULL,
	"detail"	text,
	"instock"	bool NOT NULL,
	"image"	varchar(100),
	"quantity"	integer NOT NULL,
	"unit"	varchar(200) NOT NULL,
	"catname_id"	integer,
	"id"	varchar(100) NOT NULL,
	FOREIGN KEY("catname_id") REFERENCES "company_category"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "company_category" (
	"id"	integer NOT NULL,
	"catname"	varchar(200) NOT NULL,
	"detail"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "company_profile" (
	"id"	integer NOT NULL,
	"photo"	varchar(100),
	"usertype"	varchar(100) NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"cartquan"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "jango_sessions" (
	"id"	integer NOT NULL,
	"productid"	varchar(100) NOT NULL,
	"productidname"	varchar(100) NOT NULL,
	"price"	integer NOT NULL,
	"quantity"	integer NOT NULL,
	"total"	integer NOT NULL,
	"stamp"	datetime,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "company_cart" (
	"id"	integer NOT NULL,
	"productid"	varchar(100) NOT NULL,
	"productidname"	varchar(100) NOT NULL,
	"price"	integer NOT NULL,
	"quantity"	integer NOT NULL,
	"total"	integer NOT NULL,
	"stamp"	datetime,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "company_orderlist" (
	"id"	integer NOT NULL,
	"productid_id"	varchar(100),
	"quantity"	integer NOT NULL,
	"total"	integer NOT NULL,
	"orderid_id"	varchar(100),
	FOREIGN KEY("productid_id") REFERENCES "company_allproduct"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("orderid_id") REFERENCES "company_order"("orderid") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "company_order" (
	"name"	varchar(100) NOT NULL,
	"tel"	varchar(100) NOT NULL,
	"address"	text NOT NULL,
	"shipping"	varchar(100) NOT NULL,
	"payment"	varchar(100) NOT NULL,
	"other"	text,
	"stamp"	datetime,
	"paid"	bool NOT NULL,
	"confirmed"	bool NOT NULL,
	"slip"	varchar(100),
	"sliptime"	varchar(100),
	"trackingnumber"	varchar(100) NOT NULL,
	"orderid"	varchar(100) NOT NULL,
	"user_id"	integer,
	"order_timestamp"	datetime NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("orderid")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2021-09-19 09:25:54.884299');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2021-09-19 09:25:54.902401');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2021-09-19 09:25:54.928449');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2021-09-19 09:25:54.949856');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2021-09-19 09:25:54.962054');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2021-09-19 09:25:54.984621');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2021-09-19 09:25:54.996216');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2021-09-19 09:25:55.008193');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2021-09-19 09:25:55.016714');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2021-09-19 09:25:55.028634');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2021-09-19 09:25:55.030359');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2021-09-19 09:25:55.038958');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2021-09-19 09:25:55.051131');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2021-09-19 09:25:55.061647');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2021-09-19 09:25:55.072274');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2021-09-19 09:25:55.082116');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2021-09-19 09:25:55.092873');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2021-09-19 09:25:55.097802');
INSERT INTO "django_migrations" VALUES (19,'company','0001_initial','2021-09-25 10:57:38.503969');
INSERT INTO "django_migrations" VALUES (20,'company','0002_auto_20210925_1110','2021-09-25 11:11:10.043399');
INSERT INTO "django_migrations" VALUES (21,'company','0003_allproduct_imageurl','2021-09-26 10:48:50.187744');
INSERT INTO "django_migrations" VALUES (22,'company','0004_allproduct_instock','2021-10-08 12:52:31.440233');
INSERT INTO "django_migrations" VALUES (23,'company','0005_auto_20211008_1534','2021-10-08 15:35:08.065435');
INSERT INTO "django_migrations" VALUES (24,'company','0006_profile','2021-10-10 08:44:07.312031');
INSERT INTO "django_migrations" VALUES (25,'company','0007_cart','2021-10-13 12:23:01.958112');
INSERT INTO "django_migrations" VALUES (26,'company','0008_profile_cartquan','2021-10-18 20:19:55.939227');
INSERT INTO "django_migrations" VALUES (27,'company','0009_auto_20211019_1721','2021-10-19 17:21:50.269288');
INSERT INTO "django_migrations" VALUES (28,'company','0010_orderlist_orderpending','2021-10-21 21:41:40.039251');
INSERT INTO "django_migrations" VALUES (29,'company','0011_auto_20211022_1436','2021-10-22 14:36:42.033850');
INSERT INTO "django_migrations" VALUES (30,'company','0012_auto_20220110_0020','2022-01-10 00:20:25.187314');
INSERT INTO "django_migrations" VALUES (31,'company','0013_orderpending_trackingnumber','2022-01-10 00:24:05.178719');
INSERT INTO "django_migrations" VALUES (32,'company','0014_orderpending_confirmed','2022-01-20 23:27:07.653415');
INSERT INTO "django_migrations" VALUES (33,'company','0015_auto_20220212_1526','2022-02-12 15:26:22.256134');
INSERT INTO "django_migrations" VALUES (34,'company','0016_auto_20220212_1609','2022-02-12 16:09:11.058394');
INSERT INTO "django_migrations" VALUES (35,'company','0017_auto_20220212_1611','2022-02-12 16:11:18.276589');
INSERT INTO "django_migrations" VALUES (36,'jango','0001_initial','2022-03-25 20:54:22.625015');
INSERT INTO "django_migrations" VALUES (37,'company','0018_auto_20220325_2159','2022-03-25 21:59:36.618529');
INSERT INTO "django_migrations" VALUES (38,'company','0019_auto_20220325_2200','2022-03-25 22:00:42.744222');
INSERT INTO "django_migrations" VALUES (39,'company','0020_remove_allproduct_imageurl','2022-03-25 22:00:59.743679');
INSERT INTO "django_migrations" VALUES (40,'company','0021_delete_cart','2022-03-25 22:08:58.346372');
INSERT INTO "django_migrations" VALUES (41,'company','0022_auto_20220326_0000','2022-03-26 00:00:06.325803');
INSERT INTO "django_migrations" VALUES (42,'company','0023_delete_cart','2022-03-26 00:01:08.606422');
INSERT INTO "django_migrations" VALUES (43,'company','0024_auto_20220326_0004','2022-03-26 00:04:26.683514');
INSERT INTO "django_migrations" VALUES (44,'company','0025_remove_order_paymentid','2022-03-28 19:21:06.736993');
INSERT INTO "django_migrations" VALUES (45,'company','0026_auto_20220329_1111','2022-03-29 11:11:33.463431');
INSERT INTO "django_migrations" VALUES (46,'company','0027_alter_category_id_alter_orderlist_id_and_more','2023-01-13 09:54:02.609138');
INSERT INTO "django_migrations" VALUES (47,'jango','0002_alter_sessions_id','2023-01-13 09:54:02.624119');
INSERT INTO "django_migrations" VALUES (48,'company','0028_cart','2024-01-21 21:09:53.321476');
INSERT INTO "django_migrations" VALUES (49,'company','0029_orderlist_purchase_date','2024-01-21 21:22:44.674888');
INSERT INTO "django_migrations" VALUES (50,'company','0030_remove_orderlist_purchase_date','2024-01-21 21:27:40.764688');
INSERT INTO "django_migrations" VALUES (51,'company','0031_order_order_date','2024-01-21 21:29:58.594052');
INSERT INTO "django_migrations" VALUES (52,'company','0032_remove_order_order_date','2024-01-21 22:53:58.782961');
INSERT INTO "django_migrations" VALUES (53,'company','0033_order_order_timestamp','2024-01-21 23:20:06.960471');
INSERT INTO "django_admin_log" VALUES (1,'2021-09-19 09:47:16.075185','2','thanawat','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2021-09-19 09:52:21.375979','2','thanawat','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (3,'2021-09-25 11:12:32.414768','1','AllProduct object (1)','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2021-09-25 11:12:39.520405','1','AllProduct object (1)','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (5,'2021-09-25 11:13:24.317954','2','AllProduct object (2)','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2021-09-25 11:13:50.549450','3','AllProduct object (3)','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2021-09-26 14:05:07.187455','3','แอปเปิ้ล','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (8,'2021-09-26 14:05:27.601309','1','กล้วย','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (9,'2021-09-26 14:05:37.513142','2','มะม่วง','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (10,'2021-10-08 13:53:45.389633','5','มังคุด','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (11,'2021-10-08 13:53:57.524560','4','ส้ม','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (12,'2021-10-08 13:54:02.627723','3','แอปเปิ้ล','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (13,'2021-10-08 13:54:11.232894','2','มะม่วง','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (14,'2021-10-08 13:54:15.243274','1','กล้วย','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (15,'2021-10-08 13:59:06.800964','3','แอปเปิ้ล','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (16,'2021-10-08 14:08:57.441250','5','มังคุด','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (17,'2021-10-08 15:38:45.204125','7','สตอเบอรี่','[{"changed": {"fields": ["Imageurl", "Quantity", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (18,'2021-10-08 15:40:12.828614','7','สตอเบอรี่','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (19,'2021-10-08 15:40:26.176361','7','สตอเบอรี่','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (20,'2021-10-08 15:40:41.547605','7','สตอเบอรี่','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (21,'2021-10-08 15:41:06.993132','7','สตอเบอรี่','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (22,'2021-10-08 15:41:23.718127','7','สตอเบอรี่','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (23,'2021-10-08 15:41:49.899785','7','สตอเบอรี่','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (24,'2021-10-08 15:42:22.498713','7','สตอเบอรี่','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (25,'2021-10-08 15:42:43.421840','7','สตอเบอรี่','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (26,'2021-10-08 15:58:52.666615','6','องุ่น','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (27,'2021-10-08 16:04:23.694099','6','องุ่น','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (28,'2021-10-08 16:09:28.282201','6','องุ่น','[{"changed": {"fields": ["Quantity", "Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (29,'2021-10-08 16:09:35.549812','7','สตอเบอรี่','[{"changed": {"fields": ["Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (30,'2021-10-08 16:09:54.270461','5','มังคุด','[{"changed": {"fields": ["Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (31,'2021-10-08 16:10:03.996085','3','แอปเปิ้ล','[{"changed": {"fields": ["Quantity", "Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (32,'2021-10-08 16:10:13.921487','2','มะม่วง','[{"changed": {"fields": ["Quantity", "Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (33,'2021-10-08 16:10:29.345881','1','กล้วย','[{"changed": {"fields": ["Quantity", "Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (34,'2021-10-08 16:10:35.674932','7','สตอเบอรี่','[{"changed": {"fields": ["Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (35,'2021-10-08 16:11:05.443100','4','ส้ม','[{"changed": {"fields": ["Quantity", "Unit"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (36,'2021-10-08 16:11:22.465123','4','ส้ม','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (37,'2021-10-08 16:11:29.502872','2','มะม่วง','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (38,'2021-10-08 16:11:33.705109','1','กล้วย','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (39,'2021-10-08 16:11:56.632154','3','แอปเปิ้ล','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (40,'2021-10-08 16:12:08.301359','1','กล้วย','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (41,'2021-10-08 16:12:23.401038','1','กล้วย','[{"changed": {"fields": ["Imageurl"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (42,'2021-10-08 16:12:44.257141','5','มังคุด','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (43,'2021-10-08 16:17:38.729776','7','สตอเบอรี่','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (44,'2021-10-09 07:38:33.448999','7','สตอเบอรี่','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (45,'2021-10-09 08:31:04.570162','8','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (46,'2021-10-09 08:31:49.562762','9','ลูกพีช','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (47,'2021-10-09 08:32:18.387460','9','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (48,'2021-10-09 08:33:06.983041','10','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (49,'2021-10-09 08:38:49.199726','11','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (50,'2021-10-09 08:41:04.329097','12','ลูกพีช','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (51,'2021-10-09 08:41:15.912883','12','ลูกพีช','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (52,'2021-10-09 08:41:55.014540','12','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (53,'2021-10-09 08:43:36.184249','13','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (54,'2021-10-10 08:12:41.823212','1','admin','[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (55,'2021-10-10 08:12:48.656616','3','esso@gmail.com','[{"changed": {"fields": ["First name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (56,'2021-10-10 08:12:55.863159','4','somchai@gmail.com','[{"changed": {"fields": ["First name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (57,'2021-10-10 08:46:57.375159','1','Esso','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (58,'2021-10-10 08:47:17.762634','2','','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (59,'2021-10-10 08:47:29.885636','1','Esso','[]',8,1,2);
INSERT INTO "django_admin_log" VALUES (60,'2021-10-10 08:47:56.618903','3','สมชาย','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (61,'2021-10-10 08:48:32.224399','2','thanawat','[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (62,'2021-10-10 08:48:41.983216','2','thanawat','[{"changed": {"fields": ["First name"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (63,'2021-10-10 09:09:54.880126','4','','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (64,'2021-10-12 12:45:44.422495','8','aaa@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (65,'2021-10-12 12:45:51.691622','10','nnn@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (66,'2021-10-12 12:45:56.319222','9','zzz@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (67,'2021-10-12 12:46:02.778159','11','ppp@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (68,'2021-10-12 12:49:01.861390','1','Esso','[{"changed": {"fields": ["Photo"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (69,'2021-10-13 21:07:52.008412','10','Cart object (10)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (70,'2021-10-13 21:07:56.237288','9','Cart object (9)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (71,'2021-10-13 21:07:58.866283','8','Cart object (8)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (72,'2021-10-13 21:08:02.532228','7','Cart object (7)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (73,'2021-10-13 21:08:05.412670','6','Cart object (6)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (74,'2021-10-13 21:08:08.941001','5','Cart object (5)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (75,'2021-10-13 21:08:11.816198','4','Cart object (4)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (76,'2021-10-13 21:08:14.481228','3','Cart object (3)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (77,'2021-10-13 21:08:18.132422','2','Cart object (2)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (78,'2021-10-13 21:08:21.229252','1','Cart object (1)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (79,'2021-10-18 20:10:22.012276','11','Cart object (11)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (80,'2021-10-18 20:30:03.043551','17','Cart object (17)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (81,'2021-10-18 20:30:03.045596','16','Cart object (16)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (82,'2021-10-18 20:30:03.046866','15','Cart object (15)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (83,'2021-10-18 20:30:03.048018','14','Cart object (14)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (84,'2021-10-18 20:30:03.049174','13','Cart object (13)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (85,'2021-10-18 20:30:03.050355','12','Cart object (12)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (86,'2021-10-18 20:38:22.982551','23','Cart object (23)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (87,'2021-10-18 20:38:22.984572','22','Cart object (22)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (88,'2021-10-18 20:38:22.985953','21','Cart object (21)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (89,'2021-10-18 20:38:22.987305','20','Cart object (20)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (90,'2021-10-18 20:38:22.988539','19','Cart object (19)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (91,'2021-10-18 20:38:22.989877','18','Cart object (18)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (92,'2021-10-19 17:25:49.841166','17','ลูกพีช','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (93,'2021-10-19 17:31:46.216698','16','ลูกพีช','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (94,'2021-10-19 17:32:10.528349','17','ลูกพีช','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (95,'2021-10-19 17:55:07.037065','18','มะม่วง','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (96,'2021-10-21 15:29:16.635342','18','มะม่วง','',7,1,3);
INSERT INTO "django_admin_log" VALUES (97,'2021-10-21 15:29:16.638902','17','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (98,'2021-10-21 15:29:16.640120','16','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (99,'2021-10-21 17:32:09.114885','33','Cart object (33)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (100,'2021-10-21 17:35:12.224183','15','ทุเรียน','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (101,'2021-10-21 17:35:21.241420','14','ลูกพีช','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (102,'2021-10-21 17:40:48.981477','53','Cart object (53)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (103,'2021-10-21 17:40:48.983290','52','Cart object (52)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (104,'2021-10-21 17:40:48.984574','51','Cart object (51)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (105,'2021-10-21 17:40:48.985720','50','Cart object (50)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (106,'2021-10-21 17:40:48.986869','49','Cart object (49)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (107,'2021-10-21 17:40:48.987997','48','Cart object (48)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (108,'2021-10-21 17:40:48.989117','47','Cart object (47)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (109,'2021-10-21 17:42:27.398124','57','Cart object (57)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (110,'2021-10-21 17:42:27.400472','56','Cart object (56)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (111,'2021-10-21 17:42:27.402472','55','Cart object (55)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (112,'2021-10-21 17:42:27.403963','54','Cart object (54)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (113,'2021-10-21 18:01:09.262747','60','Cart object (60)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (114,'2021-10-21 22:48:49.634019','1','OrderList object (1)','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (115,'2021-10-21 22:53:12.592488','2','OrderList object (2)','[]',10,1,2);
INSERT INTO "django_admin_log" VALUES (116,'2021-10-21 23:02:22.908602','3','OrderPending object (3)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (117,'2021-10-21 23:02:22.925365','2','OrderPending object (2)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (118,'2021-10-21 23:02:22.927011','1','OrderPending object (1)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (119,'2021-10-21 23:06:38.077755','4','OrderList object (4)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (120,'2021-10-21 23:06:38.096068','3','OrderList object (3)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (121,'2021-10-21 23:06:38.097523','2','OrderList object (2)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (122,'2021-10-21 23:06:38.098836','1','OrderList object (1)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (123,'2021-10-21 23:06:57.052376','4','OrderPending object (4)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (124,'2021-10-21 23:12:09.837456','5','OrderList object (5)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (125,'2021-10-21 23:12:19.924894','5','OrderPending object (5)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (126,'2021-10-22 14:21:40.179652','7','OrderPending object (7)','[{"changed": {"fields": ["Other", "Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (127,'2021-10-22 14:21:47.957503','6','OrderPending object (6)','[{"changed": {"fields": ["Other", "Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (128,'2021-10-22 15:34:25.204097','7','OrderPending object (7)','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (129,'2021-10-22 15:34:30.143972','8','OrderPending object (8)','[]',11,1,2);
INSERT INTO "django_admin_log" VALUES (130,'2021-10-22 15:34:33.382872','7','OrderPending object (7)','[]',11,1,2);
INSERT INTO "django_admin_log" VALUES (131,'2021-10-22 15:34:38.564926','6','OrderPending object (6)','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (132,'2021-10-22 15:34:49.731112','8','OrderPending object (8)','[{"changed": {"fields": ["Slip"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (133,'2021-10-22 17:38:34.291089','90','Cart object (90)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (134,'2021-10-22 17:38:34.293044','89','Cart object (89)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (135,'2021-10-22 17:38:34.294709','88','Cart object (88)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (136,'2021-10-22 17:38:34.296209','87','Cart object (87)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (137,'2021-10-22 17:38:34.297503','86','Cart object (86)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (138,'2021-10-22 17:38:34.298703','85','Cart object (85)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (139,'2021-10-22 17:38:34.299894','84','Cart object (84)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (140,'2021-10-22 17:38:34.301002','83','Cart object (83)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (141,'2021-10-22 17:38:34.302090','82','Cart object (82)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (142,'2021-10-22 17:38:34.303170','81','Cart object (81)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (143,'2021-10-22 17:38:34.304251','80','Cart object (80)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (144,'2021-10-22 17:38:34.305346','79','Cart object (79)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (145,'2021-10-22 18:03:01.452173','102','Cart object (102)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (146,'2021-10-22 18:05:04.892367','103','Cart object (103)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (147,'2021-10-22 18:35:07.169502','107','Cart object (107)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (148,'2021-10-22 18:35:07.171333','106','Cart object (106)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (149,'2021-10-22 18:36:38.363127','15','ทุเรียน','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (150,'2021-10-22 18:36:56.185787','108','Cart object (108)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (151,'2021-10-22 18:39:46.201266','15','ทุเรียน','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (152,'2021-10-22 18:39:46.203810','14','ลูกพีช','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (153,'2021-10-22 18:39:56.668210','110','Cart object (110)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (154,'2021-10-22 18:39:56.670018','109','Cart object (109)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (155,'2021-10-27 16:57:48.206195','15','ทุเรียน','',7,1,3);
INSERT INTO "django_admin_log" VALUES (156,'2021-10-27 16:57:48.209022','14','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (157,'2021-10-27 16:57:48.211343','7','สตอเบอรี่','',7,1,3);
INSERT INTO "django_admin_log" VALUES (158,'2021-10-27 16:57:48.212965','6','องุ่น','',7,1,3);
INSERT INTO "django_admin_log" VALUES (159,'2021-10-27 16:57:48.214484','5','มังคุด','',7,1,3);
INSERT INTO "django_admin_log" VALUES (160,'2021-10-27 16:57:48.216022','4','ส้ม','',7,1,3);
INSERT INTO "django_admin_log" VALUES (161,'2021-10-27 16:57:48.218224','3','แอปเปิ้ล','',7,1,3);
INSERT INTO "django_admin_log" VALUES (162,'2021-10-27 16:57:48.220546','2','มะม่วง','',7,1,3);
INSERT INTO "django_admin_log" VALUES (163,'2021-10-28 20:46:11.974327','12','OrderPending object (12)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (164,'2021-10-28 20:46:11.978832','11','OrderPending object (11)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (165,'2021-10-28 20:46:11.980029','10','OrderPending object (10)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (166,'2021-10-28 20:46:11.981168','9','OrderPending object (9)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (167,'2021-10-28 20:46:11.982342','8','OrderPending object (8)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (168,'2021-10-28 20:46:11.983456','7','OrderPending object (7)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (169,'2021-10-28 20:46:11.984555','6','OrderPending object (6)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (170,'2021-10-28 20:46:36.925399','14','OrderList object (14)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (171,'2021-10-28 20:46:36.927034','13','OrderList object (13)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (172,'2021-10-28 20:46:36.928467','12','OrderList object (12)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (173,'2021-10-28 20:46:36.930152','11','OrderList object (11)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (174,'2021-10-28 20:46:36.931617','10','OrderList object (10)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (175,'2021-10-28 20:46:36.932783','9','OrderList object (9)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (176,'2021-10-28 20:46:36.933915','8','OrderList object (8)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (177,'2021-10-28 20:46:36.935086','7','OrderList object (7)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (178,'2021-10-28 20:46:36.936239','6','OrderList object (6)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (179,'2021-10-28 20:47:57.385814','116','Cart object (116)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (180,'2021-10-28 20:47:57.387405','115','Cart object (115)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (181,'2021-10-28 20:47:57.388638','114','Cart object (114)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (182,'2021-10-29 02:25:44.648479','13','OrderPending object (13)','[]',11,1,2);
INSERT INTO "django_admin_log" VALUES (183,'2021-10-29 22:56:59.984479','130','Cart object (130)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (184,'2021-10-29 22:56:59.986410','129','Cart object (129)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (185,'2021-10-29 22:56:59.987782','128','Cart object (128)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (186,'2021-10-29 22:57:12.765010','25','OrderList object (25)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (187,'2021-10-29 22:57:12.766577','24','OrderList object (24)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (188,'2021-10-29 22:57:12.767864','23','OrderList object (23)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (189,'2021-10-29 22:57:12.769101','22','OrderList object (22)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (190,'2021-10-29 22:57:12.770399','21','OrderList object (21)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (191,'2021-10-29 22:57:12.771619','20','OrderList object (20)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (192,'2021-10-29 22:57:12.772648','19','OrderList object (19)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (193,'2021-10-29 22:57:12.773608','18','OrderList object (18)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (194,'2021-10-29 22:57:12.774502','17','OrderList object (17)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (195,'2021-10-29 22:57:12.775382','16','OrderList object (16)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (196,'2021-10-29 22:57:12.776248','15','OrderList object (15)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (197,'2021-10-29 22:57:50.785120','15','zzz','',8,1,3);
INSERT INTO "django_admin_log" VALUES (198,'2021-10-29 22:57:50.786919','14','ดวง','',8,1,3);
INSERT INTO "django_admin_log" VALUES (199,'2021-10-29 22:57:50.788317','13','jib','',8,1,3);
INSERT INTO "django_admin_log" VALUES (200,'2021-10-29 22:57:50.789578','12','zzz','',8,1,3);
INSERT INTO "django_admin_log" VALUES (201,'2021-10-29 22:57:50.791060','6','','',8,1,3);
INSERT INTO "django_admin_log" VALUES (202,'2021-10-29 22:57:50.792424','5','','',8,1,3);
INSERT INTO "django_admin_log" VALUES (203,'2021-10-29 22:57:50.793868','4','','',8,1,3);
INSERT INTO "django_admin_log" VALUES (204,'2021-10-29 22:57:50.795301','3','สมชาย','',8,1,3);
INSERT INTO "django_admin_log" VALUES (205,'2021-10-29 22:57:50.796666','2','เอส','',8,1,3);
INSERT INTO "django_admin_log" VALUES (206,'2021-10-29 22:57:50.798008','1','Esso','',8,1,3);
INSERT INTO "django_admin_log" VALUES (207,'2021-10-29 22:58:05.913504','16','OrderPending object (16)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (208,'2021-10-29 22:58:05.915121','15','OrderPending object (15)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (209,'2021-10-29 22:58:05.916436','14','OrderPending object (14)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (210,'2021-10-29 22:58:05.918002','13','OrderPending object (13)','',11,1,3);
INSERT INTO "django_admin_log" VALUES (211,'2021-10-29 23:05:25.854636','1','admin','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (212,'2021-10-29 23:06:02.956811','1','admin','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (213,'2021-10-29 23:06:27.417624','16','asdfsdf@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (214,'2021-10-29 23:06:27.419258','6','bung@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (215,'2021-10-29 23:06:27.420579','15','duangg@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (216,'2021-10-29 23:06:27.421730','3','esso@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (217,'2021-10-29 23:06:27.423096','14','jib2@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (218,'2021-10-29 23:06:27.424310','5','jib@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (219,'2021-10-29 23:06:27.425426','7','kong@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (220,'2021-10-29 23:06:27.426567','4','somchai@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (221,'2021-10-29 23:06:27.427778','2','thanawat','',4,1,3);
INSERT INTO "django_admin_log" VALUES (222,'2021-10-29 23:06:27.428951','13','zzz@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (223,'2021-10-29 23:06:34.544232','1','admin','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (224,'2021-10-29 23:13:01.686671','16','Esso','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (225,'2021-10-30 00:45:40.875899','12','aaa@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (226,'2021-10-30 00:46:07.689352','16','Esso','',8,1,3);
INSERT INTO "django_admin_log" VALUES (227,'2021-10-30 01:27:07.209588','18','Esso','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (228,'2021-11-03 19:14:50.932428','18','somsri@gmail.com','',4,1,3);
INSERT INTO "django_admin_log" VALUES (229,'2021-11-03 20:15:55.659558','19','OrderPending object (19)','[]',11,1,2);
INSERT INTO "django_admin_log" VALUES (230,'2021-12-20 23:07:32.234081','19','OrderPending object (19)','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (231,'2021-12-20 23:07:54.239100','20','OrderPending object (20)','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (232,'2022-01-10 19:19:18.687918','1','Category object (1)','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (233,'2022-01-10 19:20:04.404776','2','ผลไม้นำเข้า','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (234,'2022-01-10 19:20:15.405228','3','ผลไม้ขายดี','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (235,'2022-01-10 19:20:34.864049','4','ผลไม้หายาก','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (236,'2022-01-10 20:22:06.182397','41','แคนตาลูป','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (237,'2022-01-10 20:22:12.151236','40','ลูกพีช','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (238,'2022-01-10 20:22:16.885272','39','มะม่วง','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (239,'2022-01-10 20:22:24.123248','36','อะโวคาโด','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (240,'2022-01-10 20:22:31.014029','35','เนคทารีน','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (241,'2022-01-10 20:22:36.469776','34','เชอรี่แคนาดา','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (242,'2022-01-10 20:22:41.217155','31','สตอเบอรี่','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (243,'2022-01-10 20:22:46.960467','30','พลับญี่ปุ่น','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (244,'2022-01-10 20:22:51.805521','29','ทับทิม อินเดีย','[{"changed": {"fields": ["Catname"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (245,'2022-01-10 20:22:56.357631','27','มังคุด','[{"changed": {"fields": ["Catname", "Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (246,'2022-01-10 20:23:00.426763','24','มะม่วงน้ำดอกไม้','[{"changed": {"fields": ["Catname", "Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (247,'2022-01-10 20:23:04.529924','23','แอปเปิ้ล','[{"changed": {"fields": ["Catname", "Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (248,'2022-01-10 20:23:14.503225','19','ทุเรียน','[{"changed": {"fields": ["Catname", "Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (249,'2022-01-10 20:28:29.891309','40','ลูกพีช','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (250,'2022-01-12 22:56:43.311890','2','ทุเรียน','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (251,'2022-01-12 22:57:17.440144','2','ทุเรียน','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (252,'2022-01-12 22:57:53.593871','2','ทุเรียน','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (253,'2022-01-12 22:58:52.241633','2','ทุเรียน','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (254,'2022-01-12 23:00:22.317026','2','ทุเรียน','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (255,'2022-01-12 23:20:58.048718','41','แคนตาลูป','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (256,'2022-01-12 23:22:18.131278','41','แคนตาลูป','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (257,'2022-01-12 23:22:47.339452','41','แคนตาลูป','[{"changed": {"fields": ["Detail"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (258,'2022-01-21 02:34:02.437789','1','กล้วย','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (259,'2022-01-21 02:37:00.905239','1','กล้วย','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (260,'2022-01-21 02:49:03.182341','2','ทุเรียน','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (261,'2022-01-21 18:06:31.607826','41','แคนตาลูป','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (262,'2022-01-22 00:16:34.600046','41','แคนตาลูป','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (263,'2022-01-22 00:18:59.390710','41','แคนตาลูป','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (264,'2022-01-22 00:19:15.849362','41','แคนตาลูป','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (265,'2022-01-22 01:13:17.515278','41','แคนตาลูป','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (266,'2022-01-22 01:17:13.249961','41','แคนตาลูป','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (267,'2022-01-22 01:17:13.252948','40','ลูกพีช','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (268,'2022-01-22 01:17:13.255978','38','กล้วยหอม','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (269,'2022-01-22 01:17:28.913182','39','มะม่วง','[{"changed": {"fields": ["Quantity"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (270,'2022-01-22 15:10:40.284186','43','OrderList object (43)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (271,'2022-01-22 15:10:40.286924','42','OrderList object (42)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (272,'2022-01-22 15:10:40.288144','41','OrderList object (41)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (273,'2022-01-22 15:10:40.289361','40','OrderList object (40)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (274,'2022-01-22 15:10:40.290617','39','OrderList object (39)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (275,'2022-01-22 15:10:40.291820','38','OrderList object (38)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (276,'2022-01-22 15:10:40.293091','37','OrderList object (37)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (277,'2022-01-22 15:10:40.300163','36','OrderList object (36)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (278,'2022-01-22 15:10:40.301515','35','OrderList object (35)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (279,'2022-01-22 15:10:40.302795','34','OrderList object (34)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (280,'2022-01-22 15:10:40.304041','33','OrderList object (33)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (281,'2022-01-22 15:10:40.305280','32','OrderList object (32)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (282,'2022-01-22 15:10:40.306409','31','OrderList object (31)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (283,'2022-01-22 15:10:40.307573','30','OrderList object (30)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (284,'2022-01-22 15:10:40.308671','29','OrderList object (29)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (285,'2022-01-22 15:10:40.309701','28','OrderList object (28)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (286,'2022-01-22 15:10:40.310902','27','OrderList object (27)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (287,'2022-01-22 15:10:40.311948','26','OrderList object (26)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (288,'2022-01-22 15:10:52.875555','26','OD001920220122142656','',11,1,3);
INSERT INTO "django_admin_log" VALUES (289,'2022-01-22 15:10:52.877647','25','OD001920220121021358','',11,1,3);
INSERT INTO "django_admin_log" VALUES (290,'2022-01-22 15:10:52.878932','24','OD001920220121020828','',11,1,3);
INSERT INTO "django_admin_log" VALUES (291,'2022-01-22 15:10:52.880096','23','OD001920220120233143','',11,1,3);
INSERT INTO "django_admin_log" VALUES (292,'2022-01-22 15:10:52.881298','22','OD001920220110002743','',11,1,3);
INSERT INTO "django_admin_log" VALUES (293,'2022-01-22 15:10:52.882459','21','OD001920211220200514','',11,1,3);
INSERT INTO "django_admin_log" VALUES (294,'2022-01-22 15:10:52.883637','20','OD001920211220195819','',11,1,3);
INSERT INTO "django_admin_log" VALUES (295,'2022-01-22 15:10:52.884805','19','OD001920211103201359','',11,1,3);
INSERT INTO "django_admin_log" VALUES (296,'2022-01-22 15:10:52.886059','18','OD001720211030222954','',11,1,3);
INSERT INTO "django_admin_log" VALUES (297,'2022-01-22 15:10:52.887401','17','OD001720211030011517','',11,1,3);
INSERT INTO "django_admin_log" VALUES (298,'2022-01-24 21:53:39.033227','172','Cart object (172)','[{"changed": {"fields": ["Quantity"]}}]',9,1,2);
INSERT INTO "django_admin_log" VALUES (299,'2022-01-24 21:54:42.462830','21','bam','[]',8,1,2);
INSERT INTO "django_admin_log" VALUES (300,'2022-01-24 21:55:05.432757','18','Esso','[{"changed": {"fields": ["Cartquan"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (301,'2022-01-26 09:36:44.460893','170','Cart object (170)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (302,'2022-01-26 09:36:44.462729','169','Cart object (169)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (303,'2022-01-26 09:36:44.464122','163','Cart object (163)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (304,'2022-01-26 09:36:44.465409','162','Cart object (162)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (305,'2022-01-26 09:36:44.466602','161','Cart object (161)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (306,'2022-01-26 09:36:44.467779','153','Cart object (153)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (307,'2022-01-26 09:36:44.469090','152','Cart object (152)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (308,'2022-01-26 09:36:44.470290','151','Cart object (151)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (309,'2022-01-26 09:36:44.471453','137','Cart object (137)','',9,1,3);
INSERT INTO "django_admin_log" VALUES (310,'2022-01-26 09:36:58.573842','47','OrderList object (47)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (311,'2022-01-26 09:36:58.575790','46','OrderList object (46)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (312,'2022-01-26 09:36:58.577357','45','OrderList object (45)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (313,'2022-01-26 09:36:58.578614','44','OrderList object (44)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (314,'2022-01-26 10:15:39.303657','27','OD001920220122151156','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (315,'2022-01-26 10:15:56.907219','28','OD002020220124215732','[{"changed": {"fields": ["Paid"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (316,'2022-01-26 10:16:08.817725','28','OD002020220124215732','[{"changed": {"fields": ["Confirmed"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (317,'2022-01-26 10:16:18.888468','28','OD002020220124215732','[{"changed": {"fields": ["Paid", "Confirmed"]}}]',11,1,2);
INSERT INTO "django_admin_log" VALUES (318,'2022-01-26 10:17:43.116209','28','OD002020220124215732','[]',11,1,2);
INSERT INTO "django_admin_log" VALUES (319,'2022-02-12 15:24:01.785968','49','OrderList object (49)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (320,'2022-02-12 15:24:01.788046','48','OrderList object (48)','',10,1,3);
INSERT INTO "django_admin_log" VALUES (321,'2022-02-12 15:24:08.564601','29','OD002020220126105006','',11,1,3);
INSERT INTO "django_admin_log" VALUES (322,'2022-02-12 15:24:08.566439','28','OD002020220124215732','',11,1,3);
INSERT INTO "django_admin_log" VALUES (323,'2022-02-12 15:24:08.567619','27','OD001920220122151156','',11,1,3);
INSERT INTO "django_admin_log" VALUES (324,'2022-02-12 16:03:38.818228','OD001920220212152922','OD001920220212152922','',13,1,3);
INSERT INTO "django_admin_log" VALUES (325,'2022-02-12 16:03:50.035200','42','ลำไย','',7,1,3);
INSERT INTO "django_admin_log" VALUES (326,'2022-02-12 16:03:50.037274','41','แคนตาลูป','',7,1,3);
INSERT INTO "django_admin_log" VALUES (327,'2022-02-12 16:03:50.038726','40','ลูกพีช','',7,1,3);
INSERT INTO "django_admin_log" VALUES (328,'2022-02-12 16:03:50.040182','39','มะม่วง','',7,1,3);
INSERT INTO "django_admin_log" VALUES (329,'2022-02-12 16:03:50.041618','38','กล้วยหอม','',7,1,3);
INSERT INTO "django_admin_log" VALUES (330,'2022-02-12 16:03:50.042896','37','ลูกพีช ','',7,1,3);
INSERT INTO "django_admin_log" VALUES (331,'2022-02-12 16:03:50.044278','36','อะโวคาโด','',7,1,3);
INSERT INTO "django_admin_log" VALUES (332,'2022-02-12 16:03:50.045788','35','เนคทารีน','',7,1,3);
INSERT INTO "django_admin_log" VALUES (333,'2022-02-12 16:03:50.047114','34','เชอรี่แคนาดา ด้า ดา','',7,1,3);
INSERT INTO "django_admin_log" VALUES (334,'2022-02-12 16:03:50.048284','33','องุ่น','',7,1,3);
INSERT INTO "django_admin_log" VALUES (335,'2022-02-12 16:03:50.049415','32','ส้มเเมนดาริน','',7,1,3);
INSERT INTO "django_admin_log" VALUES (336,'2022-02-12 16:03:50.050628','31','สตอเบอรี่','',7,1,3);
INSERT INTO "django_admin_log" VALUES (337,'2022-02-12 16:03:50.051877','30','พลับญี่ปุ่น','',7,1,3);
INSERT INTO "django_admin_log" VALUES (338,'2022-02-12 16:03:50.053101','29','ทับทิม อินเดีย','',7,1,3);
INSERT INTO "django_admin_log" VALUES (339,'2022-02-12 16:03:50.054353','28','บลูเบอรี่ ','',7,1,3);
INSERT INTO "django_admin_log" VALUES (340,'2022-02-12 16:03:50.055528','27','มังคุด','',7,1,3);
INSERT INTO "django_admin_log" VALUES (341,'2022-02-12 16:03:50.056657','26','สาลี่ทอง','',7,1,3);
INSERT INTO "django_admin_log" VALUES (342,'2022-02-12 16:03:50.057783','25','สับปะรด','',7,1,3);
INSERT INTO "django_admin_log" VALUES (343,'2022-02-12 16:03:50.058910','24','มะม่วงน้ำดอกไม้','',7,1,3);
INSERT INTO "django_admin_log" VALUES (344,'2022-02-12 16:03:50.060088','23','แอปเปิ้ล','',7,1,3);
INSERT INTO "django_admin_log" VALUES (345,'2022-02-12 16:03:50.061202','22','ส้ม','',7,1,3);
INSERT INTO "django_admin_log" VALUES (346,'2022-02-12 16:03:50.062297','21','ลองกอง','',7,1,3);
INSERT INTO "django_admin_log" VALUES (347,'2022-02-12 16:03:50.063394','20','ส้มโอทับทิมสยาม','',7,1,3);
INSERT INTO "django_admin_log" VALUES (348,'2022-02-12 16:03:50.064494','2','ทุเรียน','',7,1,3);
INSERT INTO "django_admin_log" VALUES (349,'2022-02-12 16:03:50.065681','1','กล้วย','',7,1,3);
INSERT INTO "django_admin_log" VALUES (350,'2022-02-12 16:10:05.268224','P01','P01','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (351,'2022-02-12 16:15:01.443092','P02','P02','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (352,'2022-02-12 16:20:05.587832','P02','P02','',7,1,3);
INSERT INTO "django_admin_log" VALUES (353,'2022-02-12 16:30:01.327653','1','1','[{"changed": {"fields": ["Id"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (354,'2022-02-12 16:30:09.791916','P01','P01','',7,1,3);
INSERT INTO "django_admin_log" VALUES (355,'2022-02-12 16:30:52.434491','P01','P01','[{"changed": {"fields": ["Id"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (356,'2022-02-12 16:45:50.439844','OD001920220212164532','OD001920220212164532','',13,1,3);
INSERT INTO "django_admin_log" VALUES (357,'2022-02-12 16:45:50.441518','OD001920220212163952','OD001920220212163952','',13,1,3);
INSERT INTO "django_admin_log" VALUES (358,'2022-02-12 16:45:50.442851','OD001920220212163948','OD001920220212163948','',13,1,3);
INSERT INTO "django_admin_log" VALUES (359,'2022-02-12 16:45:50.444239','OD001920220212163831','OD001920220212163831','',13,1,3);
INSERT INTO "django_admin_log" VALUES (360,'2022-02-12 16:45:50.445546','OD001920220212163821','OD001920220212163821','',13,1,3);
INSERT INTO "django_admin_log" VALUES (361,'2022-02-12 16:45:50.446915','OD001920220212163747','OD001920220212163747','',13,1,3);
INSERT INTO "django_admin_log" VALUES (362,'2022-02-12 16:45:50.448342','OD001920220212163723','OD001920220212163723','',13,1,3);
INSERT INTO "django_admin_log" VALUES (363,'2022-02-12 16:45:50.449761','OD001920220212163441','OD001920220212163441','',13,1,3);
INSERT INTO "django_admin_log" VALUES (364,'2022-02-12 16:46:32.409372','OD001920220212164605','OD001920220212164605','',13,1,3);
INSERT INTO "django_admin_log" VALUES (365,'2022-02-15 18:02:21.948199','8','OD001920220215175941','',10,1,3);
INSERT INTO "django_admin_log" VALUES (366,'2022-02-15 18:02:21.950725','7','OD001920220215175941','',10,1,3);
INSERT INTO "django_admin_log" VALUES (367,'2022-02-15 18:02:21.951986','6','OD001920220212164650','',10,1,3);
INSERT INTO "django_admin_log" VALUES (368,'2022-02-15 18:02:21.953064','5','OD001920220212164650','',10,1,3);
INSERT INTO "django_admin_log" VALUES (369,'2022-02-15 18:02:27.061482','OD001920220215175941','OD001920220215175941','',13,1,3);
INSERT INTO "django_admin_log" VALUES (370,'2022-02-15 18:02:27.078160','OD001920220212164650','OD001920220212164650','',13,1,3);
INSERT INTO "django_admin_log" VALUES (371,'2022-02-15 18:02:48.404652','P01','P01','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (372,'2022-02-15 18:16:50.731565','10','OD001920220215180259','',10,1,3);
INSERT INTO "django_admin_log" VALUES (373,'2022-02-15 18:16:50.733291','9','OD001920220215180259','',10,1,3);
INSERT INTO "django_admin_log" VALUES (374,'2022-02-15 18:17:00.365738','OD001920220215180259','OD001920220215180259','',13,1,3);
INSERT INTO "django_admin_log" VALUES (375,'2022-02-15 18:19:26.552942','OD001920220215181910','OD001920220215181910','',13,1,3);
INSERT INTO "django_admin_log" VALUES (376,'2022-02-15 18:19:26.554986','OD001920220215181718','OD001920220215181718','',13,1,3);
INSERT INTO "django_admin_log" VALUES (377,'2022-02-15 21:17:41.746138','21','jib','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" VALUES (378,'2022-02-15 21:40:20.487026','14','OD001920220215181936','[{"changed": {"fields": ["Price"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (379,'2022-02-15 21:40:28.012944','13','OD001920220215181936','[{"changed": {"fields": ["Price"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (380,'2022-02-15 21:41:45.595583','14','OD001920220215181936','[{"changed": {"fields": ["Productidname"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (381,'2022-02-15 21:42:33.542816','14','OD001920220215181936','[{"changed": {"fields": ["Productidname"]}}]',10,1,2);
INSERT INTO "django_admin_log" VALUES (382,'2022-02-16 19:19:43.819960','P01','P01','[{"changed": {"fields": ["Instock"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (383,'2022-02-17 15:27:29.680491','P02','P02','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (384,'2022-03-25 21:54:36.391728','21','bam','',8,1,3);
INSERT INTO "django_admin_log" VALUES (385,'2022-03-25 21:54:36.393790','20','somsri','',8,1,3);
INSERT INTO "django_admin_log" VALUES (386,'2022-03-25 21:54:36.395265','18','Esso','',8,1,3);
INSERT INTO "django_admin_log" VALUES (387,'2022-03-25 21:54:36.396745','17','thanawat','',8,1,3);
INSERT INTO "django_admin_log" VALUES (388,'2022-03-25 21:54:43.127602','P02','P02','',7,1,3);
INSERT INTO "django_admin_log" VALUES (389,'2022-03-25 21:54:43.129186','P01','P01','',7,1,3);
INSERT INTO "django_admin_log" VALUES (390,'2022-03-25 21:54:43.130403','1','1','',7,1,3);
INSERT INTO "django_admin_log" VALUES (391,'2022-03-25 21:54:47.904872','4','ผลไม้หายาก','',12,1,3);
INSERT INTO "django_admin_log" VALUES (392,'2022-03-25 21:54:47.907281','3','ผลไม้ขายดี','',12,1,3);
INSERT INTO "django_admin_log" VALUES (393,'2022-03-25 21:54:47.908907','2','ผลไม้นำเข้า','',12,1,3);
INSERT INTO "django_admin_log" VALUES (394,'2022-03-25 21:54:47.910568','1','ผลไม้เมืองหนาว','',12,1,3);
INSERT INTO "django_admin_log" VALUES (395,'2022-03-25 21:54:59.632096','OD001920220325210048','OD001920220325210048','',13,1,3);
INSERT INTO "django_admin_log" VALUES (396,'2022-03-25 21:54:59.633899','OD001920220227134026','OD001920220227134026','',13,1,3);
INSERT INTO "django_admin_log" VALUES (397,'2022-03-25 21:54:59.635122','OD001920220216110522','OD001920220216110522','',13,1,3);
INSERT INTO "django_admin_log" VALUES (398,'2022-03-25 21:54:59.636291','OD001920220215181936','OD001920220215181936','',13,1,3);
INSERT INTO "django_admin_log" VALUES (399,'2022-03-25 22:09:34.659343','P01','P01','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (400,'2022-03-25 22:10:13.543125','P02','P02','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (401,'2022-03-25 22:13:09.258579','P02','P02','',7,1,3);
INSERT INTO "django_admin_log" VALUES (402,'2022-03-25 22:13:09.260277','P01','P01','',7,1,3);
INSERT INTO "django_admin_log" VALUES (403,'2022-03-25 22:13:29.790119','1','1','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (404,'2022-03-25 22:19:10.544323','22','somsri','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (405,'2022-03-25 22:20:13.973999','22','somsri','[]',8,1,2);
INSERT INTO "django_admin_log" VALUES (406,'2022-03-25 23:58:22.246439','1','1','',7,1,3);
INSERT INTO "django_admin_log" VALUES (407,'2022-03-26 00:14:37.584588','24','Esso','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (408,'2022-03-26 01:32:02.066099','5','เสื้อนักศึกษาชายแขนยาว','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (409,'2022-03-26 01:33:05.924883','6','กระโปรงพลีท','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (410,'2022-03-26 01:33:27.031306','7','กระโปรงทรงเอ','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (411,'2022-03-26 01:33:46.563824','8','กางเกงนักศึกษาชาย','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (412,'2022-03-26 01:35:16.163966','9','รองเท้าคัตชูชาย','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (413,'2022-03-26 01:36:02.322029','10','รองเท้าคัทชูหญิง','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (414,'2022-03-26 01:36:14.724729','9','รองเท้าคัตชูชาย','',12,1,3);
INSERT INTO "django_admin_log" VALUES (415,'2022-03-26 01:36:35.105887','11','รองเท้าคัทชูชาย','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (416,'2022-03-26 01:37:22.961578','12','เสื้อนักศึกษาหญิงแขนสั้น','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (417,'2022-03-26 01:45:58.947342','P01','P01','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (418,'2022-03-26 01:48:05.021550','P02','P02','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (419,'2022-03-26 01:48:51.839965','P02','P02','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (420,'2022-03-26 01:49:04.088684','P01','P01','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (421,'2022-03-26 01:50:12.342515','P03','P03','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (422,'2022-03-26 01:52:04.338220','P04','P04','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (423,'2022-03-26 01:54:05.238940','P06','P06','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (424,'2022-03-26 01:54:58.893072','P07','P07','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (425,'2022-03-26 01:56:05.321703','P08','P08','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (426,'2022-03-26 01:58:17.514715','P09','P09','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (427,'2022-03-26 01:59:02.545876','P09','P09','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (428,'2022-03-26 01:59:09.823276','P09','P09','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (429,'2022-03-26 02:00:11.327496','P010','P010','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (430,'2022-03-26 02:01:09.694509','P011','P011','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (431,'2022-03-26 02:02:06.360357','P012','P012','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (432,'2022-03-26 02:03:08.197469','P013','P013','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (433,'2022-03-26 02:04:04.620366','P014','P014','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (434,'2022-03-26 02:05:18.815768','P015','P015','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (435,'2022-03-26 02:12:41.700702','P016','P016','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (436,'2022-03-26 02:13:44.896875','P017','P017','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (437,'2022-03-26 02:14:16.224425','P018','P018','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (438,'2022-03-26 02:14:48.404250','P019','P019','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (439,'2022-03-26 02:15:37.479656','P020','P020','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (440,'2022-03-26 02:16:21.661795','P021','P021','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (441,'2022-03-26 02:16:51.845974','P022','P022','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (442,'2022-03-26 02:17:20.932702','P023','P023','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (443,'2022-03-26 02:18:34.595659','P024','P024','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (444,'2022-03-26 02:19:12.374062','P025','P025','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (445,'2022-03-26 02:19:43.350129','P026','P026','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (446,'2022-03-26 02:20:10.480716','P027','P027','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (447,'2022-03-26 02:20:59.911771','P028','P028','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (448,'2022-03-26 02:21:28.591247','P029','P029','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (449,'2022-03-26 02:22:08.393611','P030','P030','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (450,'2022-03-26 02:22:44.378146','P030','P030','[{"changed": {"fields": ["Price", "Detail", "Quantity", "Unit", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (451,'2022-03-26 02:23:10.662589','P031','P031','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (452,'2022-03-26 02:27:11.252215','P032','P032','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (453,'2022-03-26 02:27:57.077583','P032','P032','[{"changed": {"fields": ["Name", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (454,'2022-03-26 02:28:11.221150','P032','P032','[{"changed": {"fields": ["Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (455,'2022-03-26 02:30:24.700258','P033','P033','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (456,'2022-03-26 02:31:23.848308','P034','P034','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (457,'2022-03-26 02:32:25.770604','P035','P035','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (458,'2022-03-26 02:33:44.826461','P036','P036','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (459,'2022-03-26 02:35:15.291376','P37','P37','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (460,'2022-03-26 02:36:25.406661','P038','P038','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (461,'2022-03-26 02:37:46.560850','P038','P038','[{"changed": {"fields": ["Name", "Price", "Detail", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (462,'2022-03-26 02:38:47.295619','P039','P039','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (463,'2022-03-26 02:45:54.347870','P040','P040','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (464,'2022-03-26 02:46:40.610469','P041','P041','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (465,'2022-03-26 02:47:36.421029','P042','P042','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (466,'2022-03-26 02:48:14.711073','P043','P043','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (467,'2022-03-26 02:48:56.248748','P043','P043','[{"changed": {"fields": ["Price", "Detail", "Quantity", "Unit", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (468,'2022-03-26 02:49:55.629396','P044','P044','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (469,'2022-03-26 02:51:18.971382','P045','P045','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (470,'2022-03-26 02:55:01.173075','P046','P046','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (471,'2022-03-26 02:56:38.483168','P047','P047','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (472,'2022-03-26 02:57:02.361499','P046','P046','[{"changed": {"fields": ["Name"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (473,'2022-03-26 02:57:13.901406','P047','P047','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (474,'2022-03-26 02:58:18.933799','P048','P048','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (475,'2022-03-26 02:59:22.334694','P049','P049','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (476,'2022-03-26 03:00:23.426845','P050','P050','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (477,'2022-03-26 03:02:42.220854','P051','P051','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (478,'2022-03-26 03:04:32.964366','P052','P052','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (479,'2022-03-26 03:04:57.644871','P052','P052','[{"changed": {"fields": ["Unit", "Image"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (480,'2022-03-26 03:06:27.855891','P053','P053','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (481,'2022-03-26 03:07:33.071985','P054','P054','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (482,'2022-03-26 03:08:45.248653','P055','P055','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (483,'2022-03-26 03:10:11.666450','P056','P056','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (484,'2022-03-26 03:11:16.546027','P057','P057','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (485,'2022-03-26 03:12:35.560975','P058','P058','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (486,'2022-03-26 18:26:29.802804','OD002220220325224002','OD002220220325224002','',13,1,3);
INSERT INTO "django_admin_log" VALUES (487,'2022-03-26 18:26:29.804594','OD002220220325223946','OD002220220325223946','',13,1,3);
INSERT INTO "django_admin_log" VALUES (488,'2022-03-26 18:26:29.805940','OD002220220325223917','OD002220220325223917','',13,1,3);
INSERT INTO "django_admin_log" VALUES (489,'2022-03-26 18:26:29.807264','OD001920220326040106','OD001920220326040106','',13,1,3);
INSERT INTO "django_admin_log" VALUES (490,'2022-03-28 19:20:25.528555','OD002620220328190045','OD002620220328190045','',13,1,3);
INSERT INTO "django_admin_log" VALUES (491,'2022-03-28 19:20:25.530689','OD001920220326230558','OD001920220326230558','',13,1,3);
INSERT INTO "django_admin_log" VALUES (492,'2022-03-28 19:20:25.531919','OD001920220326220844','OD001920220326220844','',13,1,3);
INSERT INTO "django_admin_log" VALUES (493,'2022-03-28 19:20:25.533103','OD001920220326183234','OD001920220326183234','',13,1,3);
INSERT INTO "django_admin_log" VALUES (494,'2022-03-28 22:17:04.478752','19','somsri@gmail.com','[{"changed": {"fields": ["Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (495,'2022-03-28 22:23:46.544621','19','somsri@gmail.com','[]',4,1,2);
INSERT INTO "django_admin_log" VALUES (496,'2022-03-28 22:25:00.047092','17','thanawat@gmail.com','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (497,'2022-03-28 22:25:37.241581','17','thanawat@gmail.com','[{"changed": {"fields": ["Superuser status"]}}]',4,17,2);
INSERT INTO "django_admin_log" VALUES (498,'2022-03-28 22:26:12.836679','22','jib@gmail.com','[{"changed": {"fields": ["Active"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (499,'2022-03-28 22:26:42.010240','22','jib@gmail.com','[{"changed": {"fields": ["Active"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (500,'2022-03-28 22:31:10.358043','19','somsri@gmail.com','[{"changed": {"fields": ["Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (501,'2022-03-28 22:31:46.728158','19','somsri@gmail.com','[{"changed": {"fields": ["Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (502,'2022-03-28 22:33:01.266891','19','somsri@gmail.com','[{"changed": {"fields": ["Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (503,'2022-03-28 22:59:16.439596','23','bam2@gmail.com','[{"changed": {"fields": ["Active", "Last login"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (504,'2022-03-28 22:59:46.190068','23','bam2@gmail.com','[{"changed": {"fields": ["Active", "Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (505,'2022-03-28 23:00:32.172109','23','bam2@gmail.com','[{"changed": {"fields": ["Staff status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (506,'2022-03-28 23:00:47.118916','23','bam2@gmail.com','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (507,'2022-03-28 23:01:35.706243','23','bam2@gmail.com','[{"changed": {"fields": ["Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (508,'2022-03-28 23:01:54.618735','23','bam2@gmail.com','[{"changed": {"fields": ["Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (509,'2022-03-28 23:02:18.968948','23','bam2@gmail.com','[{"changed": {"fields": ["Staff status", "Superuser status"]}}]',4,1,2);
INSERT INTO "django_admin_log" VALUES (510,'2022-03-28 23:43:01.559451','aa','aa','',7,1,3);
INSERT INTO "django_admin_log" VALUES (511,'2022-03-29 11:01:26.297949','P02d','P02d','',7,1,3);
INSERT INTO "django_admin_log" VALUES (512,'2022-03-29 11:03:26.856075','1','1','',7,1,3);
INSERT INTO "django_admin_log" VALUES (513,'2022-03-29 11:16:20.074780','P060','P060','',7,1,3);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'company','allproduct');
INSERT INTO "django_content_type" VALUES (8,'company','profile');
INSERT INTO "django_content_type" VALUES (9,'company','cart');
INSERT INTO "django_content_type" VALUES (10,'company','orderlist');
INSERT INTO "django_content_type" VALUES (11,'company','orderpending');
INSERT INTO "django_content_type" VALUES (12,'company','category');
INSERT INTO "django_content_type" VALUES (13,'company','order');
INSERT INTO "django_content_type" VALUES (14,'jango','sessions');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_allpeoduct','Can add all peoduct');
INSERT INTO "auth_permission" VALUES (26,7,'change_allpeoduct','Can change all peoduct');
INSERT INTO "auth_permission" VALUES (27,7,'delete_allpeoduct','Can delete all peoduct');
INSERT INTO "auth_permission" VALUES (28,7,'view_allpeoduct','Can view all peoduct');
INSERT INTO "auth_permission" VALUES (29,7,'add_allproduct','Can add all product');
INSERT INTO "auth_permission" VALUES (30,7,'change_allproduct','Can change all product');
INSERT INTO "auth_permission" VALUES (31,7,'delete_allproduct','Can delete all product');
INSERT INTO "auth_permission" VALUES (32,7,'view_allproduct','Can view all product');
INSERT INTO "auth_permission" VALUES (33,8,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (34,8,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (35,8,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (36,8,'view_profile','Can view profile');
INSERT INTO "auth_permission" VALUES (37,9,'add_cart','Can add cart');
INSERT INTO "auth_permission" VALUES (38,9,'change_cart','Can change cart');
INSERT INTO "auth_permission" VALUES (39,9,'delete_cart','Can delete cart');
INSERT INTO "auth_permission" VALUES (40,9,'view_cart','Can view cart');
INSERT INTO "auth_permission" VALUES (41,10,'add_orderlist','Can add order list');
INSERT INTO "auth_permission" VALUES (42,10,'change_orderlist','Can change order list');
INSERT INTO "auth_permission" VALUES (43,10,'delete_orderlist','Can delete order list');
INSERT INTO "auth_permission" VALUES (44,10,'view_orderlist','Can view order list');
INSERT INTO "auth_permission" VALUES (45,11,'add_orderpending','Can add order pending');
INSERT INTO "auth_permission" VALUES (46,11,'change_orderpending','Can change order pending');
INSERT INTO "auth_permission" VALUES (47,11,'delete_orderpending','Can delete order pending');
INSERT INTO "auth_permission" VALUES (48,11,'view_orderpending','Can view order pending');
INSERT INTO "auth_permission" VALUES (49,12,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (50,12,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (51,12,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (52,12,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (53,13,'add_delivery','Can add delivery');
INSERT INTO "auth_permission" VALUES (54,13,'change_delivery','Can change delivery');
INSERT INTO "auth_permission" VALUES (55,13,'delete_delivery','Can delete delivery');
INSERT INTO "auth_permission" VALUES (56,13,'view_delivery','Can view delivery');
INSERT INTO "auth_permission" VALUES (57,14,'add_sessions','Can add sessions');
INSERT INTO "auth_permission" VALUES (58,14,'change_sessions','Can change sessions');
INSERT INTO "auth_permission" VALUES (59,14,'delete_sessions','Can delete sessions');
INSERT INTO "auth_permission" VALUES (60,14,'view_sessions','Can view sessions');
INSERT INTO "auth_permission" VALUES (61,8,'add_customer','Can add customer');
INSERT INTO "auth_permission" VALUES (62,8,'change_customer','Can change customer');
INSERT INTO "auth_permission" VALUES (63,8,'delete_customer','Can delete customer');
INSERT INTO "auth_permission" VALUES (64,8,'view_customer','Can view customer');
INSERT INTO "auth_permission" VALUES (65,13,'add_order','Can add order');
INSERT INTO "auth_permission" VALUES (66,13,'change_order','Can change order');
INSERT INTO "auth_permission" VALUES (67,13,'delete_order','Can delete order');
INSERT INTO "auth_permission" VALUES (68,13,'view_order','Can view order');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$390000$2yLRbmO3SsHnnOR8oRiDkH$2AgYYD8TeudRNu8MqYZUymZ5SxWR7R0+/GYWUrOCtpc=','2024-01-21 22:52:58.940863',1,'admin','Hello','',1,1,'2021-09-19 09:39:50','Esso');
INSERT INTO "auth_user" VALUES (17,'pbkdf2_sha256$216000$lUmKBNHw9Utm$yL7j+nqH3h5H8Y8T0n9wmpYcwIsfZZWKwr+r/qs9wbo=','2022-03-28 22:25:21',0,'thanawat@gmail.com','saiyota','thanawat@gmail.com',1,1,'2021-10-30 00:26:16','thanawat');
INSERT INTO "auth_user" VALUES (19,'pbkdf2_sha256$216000$9HBDriG0tpCi$DEbTnZ6FHfLkgBDKhqjcxY8ONupw0rHZeUuaVH0gUwE=','2022-09-27 14:41:01.792976',0,'somsri@gmail.com','srisom','somsri@gmail.com',0,1,'2021-11-03 20:07:29','somsri');
INSERT INTO "auth_user" VALUES (20,'pbkdf2_sha256$180000$s3Hr1EBeffLM$apNquw07a8gIaHHNDkYlNdJoh08dXuE06deO61CK1H4=','2022-01-24 21:50:11.398680',0,'bam@gmail.com','bambam','bam@gmail.com',0,1,'2022-01-24 21:50:06.573996','bam');
INSERT INTO "auth_user" VALUES (21,'pbkdf2_sha256$216000$sRz544yvTjGG$TtZKutaCugxsrLOCQ5RaYMQKqCGnv7b/e19ebEHHmA8=',NULL,0,'kkk','','',0,1,'2022-02-15 21:17:41.633414','');
INSERT INTO "auth_user" VALUES (22,'pbkdf2_sha256$216000$9PDmimCXO4si$Ru/aLlfJP9c5J0jh56Gdoe1iXpi0D2qv090lkVVk+1w=','2022-03-28 22:26:58.287044',0,'kkk@gmail.com','saiyota','safa@gmail.com',0,1,'2022-03-25 22:20:49','thanawat');
INSERT INTO "auth_user" VALUES (23,'pbkdf2_sha256$216000$ixSWgq5zrRPH$TLLiGhMPl2zpxOA6tb/fXb1B6tkSvpdFG7i+VaO6WuY=','2022-03-28 23:00:53',0,'bam2@gmail.com','bam','bam2@gmail.com',0,1,'2022-03-28 18:43:51','bam');
INSERT INTO "auth_user" VALUES (24,'pbkdf2_sha256$216000$PwhucWq9vcp0$oRWupcQlDA6s9wyQ9hjEZf0LVVhII4o5fqj0cwHQdSQ=','2022-03-28 18:44:37.446150',0,'er@gmail.com','er','er@gmail.com',0,1,'2022-03-28 18:44:33.338315','er');
INSERT INTO "auth_user" VALUES (25,'pbkdf2_sha256$216000$oS21THStkovK$FJYuuEywc+3y82HuFvqVuuCm4M8ljG0iyukDJT6uDNE=','2022-03-28 18:45:00.287317',0,'tt2@gmail.com','tt','tt2@gmail.com',0,1,'2022-03-28 18:44:56.473963','tt');
INSERT INTO "auth_user" VALUES (26,'pbkdf2_sha256$216000$cjrwzP0wubuI$Pfz6JR6PHAhXjbZgKnOQko16elgYTC8vIeIwJfEtGW4=','2022-03-28 18:57:57.513267',0,'ddd@gmail.com','ddd','ddd@gmail.com',0,1,'2022-03-28 18:57:53.556316','ddd');
INSERT INTO "auth_user" VALUES (27,'pbkdf2_sha256$216000$VwBBjc0pMZpo$MHVdMMVgnj1OuGSsEU+JadWlpfxi6w5FHIN5i/HQL58=','2022-03-29 12:27:14.408977',0,'mama@gmail.com','yaya','mama@gmail.com',0,1,'2022-03-29 12:27:10.147519','mama');
INSERT INTO "auth_user" VALUES (28,'pbkdf2_sha256$216000$gdT8LHSuqD0z$a2hafqpz7uObmY7IDyq1iZnapHYvVD9Og6NIVtczq4s=','2022-03-29 12:40:30.270685',0,'kapom@email.com','kapom','kapom@email.com',0,1,'2022-03-29 12:40:26.093749','kapom');
INSERT INTO "auth_user" VALUES (29,'pbkdf2_sha256$390000$vaLfBhoZMvI3PzgtIxGpyj$sjZZa0mkogeEc+zu3l3eWmwqZ81CMsZJuMn3Qmlcesg=','2024-01-21 16:36:25.502027',0,'eee@gmail.com','eee','eee@gmail.com',0,1,'2022-09-27 14:39:48.684369','eee');
INSERT INTO "auth_user" VALUES (30,'pbkdf2_sha256$216000$2enYtQQK59Hm$RMsuVC9saOt0X0xuuBpjpos23Qe1VDwQA5WxjDDNfCU=',NULL,0,'eee2544@gmail.com','eee','eee2544@gmail.com',0,1,'2022-09-27 14:40:23.654678','eee2544');
INSERT INTO "auth_user" VALUES (31,'pbkdf2_sha256$390000$0SXByvDMr4uzpTDU7m1MwY$35jSDKVweFqRnoQXUAOmoqigGLKOWL8Y6ENQPtNcBHo=','2022-11-30 22:42:20.807984',0,'thanawat2@gmail.com','saiyota2','thanawat2@gmail.com',0,1,'2022-11-30 22:41:03.289435','thanawat2');
INSERT INTO "auth_user" VALUES (32,'pbkdf2_sha256$390000$dsG6kX67PX9VZjOjLKdcSP$PofVC2Y2GQrsol+3Zs+7se+SVYUXpJWuOXUG3la/Z6w=','2023-01-13 09:56:20.311351',0,'et@gmail.com','et','et@gmail.com',0,1,'2023-01-13 09:54:31.624398','et');
INSERT INTO "auth_user" VALUES (33,'pbkdf2_sha256$390000$Fd3LdOcUX7KrwqNfN2aRNX$X4OmymGKHpfcS9XuiixLozBRxHNKzv3jy3lyR4tJ7ow=','2024-01-21 16:12:58.624842',0,'ttt@gmail.com','ttt','ttt@gmail.com',0,1,'2024-01-18 00:43:37.424522','ttt');
INSERT INTO "auth_user" VALUES (34,'pbkdf2_sha256$390000$O0fsFPzCXvTKTZ34J4jTz5$4oCWl/mSY7GFxvGeuBXMBHVAXrTVlCQVhDw1TsX8k8o=',NULL,0,'aaa@gmail.com','ttt','aaa@gmail.com',0,1,'2024-01-18 00:43:46.997054','ttt');
INSERT INTO "auth_user" VALUES (35,'pbkdf2_sha256$390000$3cof9HRdy6auqQeOclo9CV$MNmUeo7s+U7PNIenu+tT+DDJETf/QMRVZ6xiPClI7FM=',NULL,0,'aaa2@gmail.com','aaa2','aaa2@gmail.com',0,1,'2024-01-18 00:44:07.152057','aaa2');
INSERT INTO "auth_user" VALUES (36,'pbkdf2_sha256$390000$PEonvY0RwrQOa2Mnq3ldjw$4bdP8T1ZD33faomrUJXKoT6xCugfXJVFQ6AbFxTVa9w=',NULL,0,'asd@gmail.com','asd','asd@gmail.com',0,1,'2024-01-21 15:44:27.801081','asd');
INSERT INTO "django_session" VALUES ('cdqutrhpwd2ownw3xjun2dzwwmfp49tp','.eJxVjEEOwiAQRe_C2pDOVBBcuu8ZCDMMUjU0Ke3KeHfbpAvd_vfef6sQ16WEtckcxqSuCtTpd6PIT6k7SI9Y75PmqS7zSHpX9EGbHqYkr9vh_h2U2MpWC2YQMUDZ9GzgnF3nwV_IIiFl9hYciNsok7MpZbSZWKJHcIxd79TnC_bNOGo:1mRtKj:ff72o1r7xCGCwqXm6xRUkPF9irribmqUfp-lKzZz2cQ','2021-10-03 09:42:01.486150');
INSERT INTO "django_session" VALUES ('mgo37hhvv4ec5sz82ivy0d273022u50l','MGVjNzA2YWM0Y2Y0ODNiYWQ2MDA1ZDcxNjdlNGFhNmRkYTliMWU3Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZjVlYWYxNzQ4YTg0YTg5MDk4YjI4MGE4MDE3OWQ0Yjk2YTA3MDFhIn0=','2021-11-17 19:14:37.615000');
INSERT INTO "django_session" VALUES ('wn4bilyw5t2zwrtklanwu9try1la6bre','MGVjNzA2YWM0Y2Y0ODNiYWQ2MDA1ZDcxNjdlNGFhNmRkYTliMWU3Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZjVlYWYxNzQ4YTg0YTg5MDk4YjI4MGE4MDE3OWQ0Yjk2YTA3MDFhIn0=','2021-11-17 20:16:21.193363');
INSERT INTO "django_session" VALUES ('q2hsmrbegq4swumhdocgafeaxse426sj','ODdhZDNlYzE4MThkOTlkNTRkYjE3ZjJlZjFmNzllMWNjMzc1ODM2Mjp7Il9hdXRoX3VzZXJfaWQiOiIxOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMWIwYzlhMDdhNzFkYjhmZGUyNDQ2M2U4NzA1YzhkOThhZTBmZjk5MCJ9','2021-12-31 23:37:54.771809');
INSERT INTO "django_session" VALUES ('c4uc7db42mxq0cmgqxpefvcrwhrqbfvp','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-01-03 23:28:08.437974');
INSERT INTO "django_session" VALUES ('ijpapuqbcd40n6wo98urs9k1plrwxrw7','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-01-19 23:13:15.218216');
INSERT INTO "django_session" VALUES ('5gxmj5azhgsr82tlfwqqwh1eiybo7ioz','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-01-24 00:32:55.822289');
INSERT INTO "django_session" VALUES ('pxirdpgsgu6nzwjh76u7l93nxd5ef1w0','ODdhZDNlYzE4MThkOTlkNTRkYjE3ZjJlZjFmNzllMWNjMzc1ODM2Mjp7Il9hdXRoX3VzZXJfaWQiOiIxOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMWIwYzlhMDdhNzFkYjhmZGUyNDQ2M2U4NzA1YzhkOThhZTBmZjk5MCJ9','2022-01-24 00:33:17.254419');
INSERT INTO "django_session" VALUES ('x1jeo0x1r7u4337kmr0z2dysv2vl98pl','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-01-24 19:18:10.838747');
INSERT INTO "django_session" VALUES ('tyueudg9kmzzfwq2tjzxq19hff2sglat','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-01-26 23:20:25.572290');
INSERT INTO "django_session" VALUES ('0yflwa3x4pnpz58gptgebd3qr873xieh','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-02-04 23:58:42.161329');
INSERT INTO "django_session" VALUES ('rmk0pukqbobv2aozgc6v3ym5vtkkvqid','ZDNlMDlkZWU3Y2IzODY3YzgwNjM2YzA5ZTdlNmExM2Q2YWFjYTAxNzp7Il9hdXRoX3VzZXJfaWQiOiIyMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNGUyZDQ2MGUwNjJiZDAyNWJiNmQzODJjYWVlNzYyZGVhM2RlYzUxOSJ9','2022-02-07 21:50:11.406882');
INSERT INTO "django_session" VALUES ('zrdbwrz63b6c8bgcx77zmobon9cu2gc4','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-02-07 21:50:25.983148');
INSERT INTO "django_session" VALUES ('hujm5qvitpk56ab9bvkje1kyjfvqg5iu','MmIxZWUwMzgyNzBiOGZiNTg3OWRiZmU2MDNhYjY5MzM2MGY2NzQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDhiN2NkMjUwZDlmNDIzMGVjZWRlM2RjMzNjMjQwYmY3YWZjYTYwIn0=','2022-02-09 09:36:06.167200');
INSERT INTO "django_session" VALUES ('uig95865yrn2sap262wlh6il6kv887zv','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nInhC:Az25YiyDq8S59r9JpSs61od9K6NFMxES3inn3DFLqNs','2022-02-26 15:23:54.564193');
INSERT INTO "django_session" VALUES ('cdv0efo6pxi86u1mgo5blc8do8z5zr6o','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nInm5:qYp9Hnh6oFsCtCzBA41f0NjNh9uwpLZIwL5aVxP2R5M','2022-02-26 15:28:57.874418');
INSERT INTO "django_session" VALUES ('ds6lw9z3ez0ex2or86brqz82wez4vv6r','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nIolN:A6Bb-MzcwhUm80Znx4WiOo3n77G94qRDSZrjbFtfCgQ','2022-02-26 16:32:17.335986');
INSERT INTO "django_session" VALUES ('ojiry3ujt3j04nge0qjl2gh5kdblgogm','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nJvYf:LhMaJa8S_1corbbLfo6dVsMgkIpv7erqDZ9Tu2A9hj8','2022-03-01 17:59:45.400692');
INSERT INTO "django_session" VALUES ('mcnf8g0fb7sg1ncgstgsx5bbfgsvk3mu','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nJvar:Kr66p8aGgkpW9vISM3ZgLBVbUq0kAVl9ytfa3A9mLvI','2022-03-01 18:02:01.557962');
INSERT INTO "django_session" VALUES ('935lhvqbi12tloww67v4j0f9ta7jt7ns','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nJvow:Q1WU0-9URZOWnkGH-4jNzPBXejHtHFEVgGYfcsz2fg4','2022-03-01 18:16:34.987538');
INSERT INTO "django_session" VALUES ('bzjvx40wfa42vqxhkiq1i6t34qqht141','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nJvpW:wzuX51dsGzF5f2AIHDq_lAO5_xDLMOjXjZP-Uk_bYF0','2022-03-01 18:17:10.211295');
INSERT INTO "django_session" VALUES ('xmhh2plsr50mauyv14yrxp4ydmhqudtc','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nJwlI:875k8Ov1CRw4yBNK4nuAaS44HYOvdBMJD2UcMMfOwmQ','2022-03-01 19:16:52.799634');
INSERT INTO "django_session" VALUES ('dtg21mh65wdy71gwt2ai8j20gta1snsv','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nLIh2:ED0qZDFxgt2vQJlaRTg-AWVnGecwU67ewnH8ZHxb0kk','2022-03-05 12:54:04.297601');
INSERT INTO "django_session" VALUES ('hg11url1ymamdxpyfdkp80bjt76me9kn','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nODE5:PXJ71p0myJqe8rC8IFCg3sNKc-5RF237j1x7wjFOTas','2022-03-13 13:40:13.786985');
INSERT INTO "django_session" VALUES ('ij90u98jmjzjq4qw4weerno8koidtwat','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nOp3r:C5RZSfSGh_T9OB9-L5qNrxtAskiZIK0g41FldZ_7vXc','2022-03-15 06:04:11.785530');
INSERT INTO "django_session" VALUES ('x74g3vjdt65zyyibv9brxbj318o1erjr','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nQk7g:jskz8yNVXrtBH9X4HqPE5Cs3nTnVi4G2ISCgBQ_NUaI','2022-03-20 13:12:04.213794');
INSERT INTO "django_session" VALUES ('0qt8j38gwx74vl5p7yjqixzl053kzhnb','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nXlKh:2m7RSsptFrgAeteCr24Egn17RLQR-kE9JrNMCi88YrY','2022-04-08 21:54:31.245868');
INSERT INTO "django_session" VALUES ('e4y30cdellu1sv5pnoqmrqn1vglk8u3q','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nXncS:Kk8twrp7kzYr9xlnGh8xquCdlBgwSvMEvw8xd9WbiXI','2022-04-09 00:21:00.205199');
INSERT INTO "django_session" VALUES ('l1fwatsz4u28p6vi3qdl7i0alj92bsoa','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nXodk:IVAMmbqjLqbw5bk_5Jue-d-yX321qY7CEtwn7Wo-20I','2022-04-09 01:26:24.147057');
INSERT INTO "django_session" VALUES ('711dlohqpym75neledsa2ie0pq7bghmv','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nY4HA:sb1kiS8VUeGxUg1IjH-QxJvaVSmXnPNXMu9TJDbtzr0','2022-04-09 18:08:08.415683');
INSERT INTO "django_session" VALUES ('ide6v9yz7375r76whdkanivwgxvgdhbt','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nY4T9:AXJprTywf9C_YT_onzCVad75zu8bpIYkmeB0gKJHbKE','2022-04-09 18:20:31.416598');
INSERT INTO "django_session" VALUES ('ijhvrdzcmwuhwtqjehwam5zkvil01ecm','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nY4eA:S42tnUOJY8WXV3mnVrx5dlmy88xkMwlKK7422U-kg8w','2022-04-09 18:31:54.803171');
INSERT INTO "django_session" VALUES ('gkhfm7ohdk1rs4etx7fzx908gkraop8a','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nY7vY:0iPS1g_bVQVV_CMvehlo_hYw_YYdzMHPd9hU2r6vwMw','2022-04-09 22:02:04.357778');
INSERT INTO "django_session" VALUES ('t45snq4apy9gvil4is12fzmd9ftccbua','.eJxVjDsOwjAQBe_iGln-bJwsJT1nsNbeNQ6gRIqTCnF3iJQC2jcz76UibWuNW5MljqzOynl1-h0T5YdMO-E7TbdZ53lalzHpXdEHbfo6szwvh_t3UKnVbx3IcQCDWIC7ZLEwYBZAyijQsfVGBsmuoLFAhTEEXwj7ZNnbHmRQ7w8TpDhQ:1nYnmu:sSrIck4AFnV1IdLwOKjDJCtYPMcga1_lZYy9-mb7qKI','2022-04-11 18:43:56.928358');
INSERT INTO "django_session" VALUES ('t48z70k56rk2lr0mx4ug6odf1umss49w','.eJxVjDsOwyAQBe9CHSHAhmVTpvcZ0PILTiKQjF1FuXtsyUXSzsx7b-ZoW4vbelrcHNmVKcMuv9BTeKZ6mPigem88tLous-dHwk_b-dRiet3O9u-gUC_7GmEcVNIKRUxSCa0HgRk8WUAbbI6AWinpA5HI5A3sXEvMYxQaDBGyzxfkdTdi:1nYo0T:EUfFFR1_oZb0KuT6BPAxvprmu_KcBeLoTnrBHGJqrkU','2022-04-11 18:57:57.519053');
INSERT INTO "django_session" VALUES ('ca4kqawuwpml916sdtea8faemucoxoyx','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nYp1H:nkTiYlF6iI9SBNilcFlk4TemmBwzhqGphM3jJoWnxqw','2022-04-11 20:02:51.036971');
INSERT INTO "django_session" VALUES ('1dhl3fd7q7nz7xu3a93oi8th2u99anrk','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nYpf7:ufPgXmr1jYkeyRgXxdb2M4HvczXoG2AO-JnyJboukDg','2022-04-11 20:44:01.914753');
INSERT INTO "django_session" VALUES ('trbg278z4xnxo1uv9ikr8o0ewee06hl7','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nYqgz:XMNs6s15Hm-jl6xrt_pUXVTvVIXjSczxEci9HI6XTCQ','2022-04-11 21:50:01.952522');
INSERT INTO "django_session" VALUES ('kviyg9x4wmd92nwpj8mro1l6k6g8ccxc','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nYrMD:b9wmyKAfc2bwgkjQNHoN4qv-lCi9GhZcBrYX8X0NCug','2022-04-11 22:32:37.013753');
INSERT INTO "django_session" VALUES ('0mvl5kxgqgu6mvqtiw6oq0mc5jk4ecuc','.eJxVjDsOwjAQBe_iGln-bJwsJT1nsNbeNQ6gRIqTCnF3iJQC2jcz76UibWuNW5MljqzOynl1-h0T5YdMO-E7TbdZ53lalzHpXdEHbfo6szwvh_t3UKnVbx3IcQCDWIC7ZLEwYBZAyijQsfVGBsmuoLFAhTEEXwj7ZNnbHmRQ7w8TpDhQ:1nYrnZ:hxWJr26VxWfSb8enD7vOeW3Qg1L02VEHVJVxhh291mQ','2022-04-11 23:00:53.773864');
INSERT INTO "django_session" VALUES ('zjifkb1y45jm5le7u7gf7ezxbokw8tqz','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nZ2YS:WWRsor4MAr8jYLS9P2sv_Wk0S5lCaBs9qwlc3y0AGYE','2022-04-12 10:30:00.289536');
INSERT INTO "django_session" VALUES ('gf0jwuc61ylwx2k7bjt3kgi3rr24q7vl','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1nZ3ZG:03hGCEDK_kzLSzHt1CgQPiILtbhBzcm6HugvLCca7I0','2022-04-12 11:34:54.255126');
INSERT INTO "django_session" VALUES ('3ksj5yk4x3o4q2dhhb0ezzumprk966wy','.eJxVjDsOwjAQBe_iGlnxJ14vJT1niNbrNQmgWIqTCnF3iJQC2jcz76UG2tZx2Josw5TVWdmoTr9jIn7IvJN8p_lWNdd5Xaakd0UftOlrzfK8HO7fwUht_NaYAL0FGyO6jsQ7G7gQdtiDYQZruhKMj-RK6UFSYBucCZQRhDEAqvcH4SM3PQ:1nZ4ak:MmIn5kezesN1waJpv4O6vogkLTmnDnsOmuBkJs_N6v8','2022-04-12 12:40:30.279792');
INSERT INTO "django_session" VALUES ('fvmz6b7vf5ob1zrowidrxm9y4qpc2ihh','.eJxVjDsOwjAQRO_iGlmJ_6akzxms3bWNA8iW4qRC3J1ESgHNFPPezJsF2NYStp6WMEd2ZaNnl98SgZ6pHiQ-oN4bp1bXZUZ-KPyknU8tptftdP8OCvSyr63KBGZUkEh44QehvEFN1mQtjJQaCdMeoCI4jSk7jyZnsj5KpwgH9vkCFlY42Q:1naulK:KYcsjoEt2auQ0zhpDGqRouIn3GOvnB1J5F7V9qURbPg','2022-04-17 14:35:02.434617');
INSERT INTO "django_session" VALUES ('503q7dklmrdwie2n6t6lsc81alr3psci','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1niWuJ:7XOxgFTrmfSF-8_j0TCNmz7-Nn3SecsjuZrPNpsBEMs','2022-05-08 14:43:47.647735');
INSERT INTO "django_session" VALUES ('p2j0mch7a6fyc8sm1c3gvovcoprnpy1o','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1nnLOR:JdXbARM3jqzaPj1gFOy80oj8OBk6cEl5Ip95h-2V9Nc','2022-05-21 21:26:47.180625');
INSERT INTO "django_session" VALUES ('zrufrygsftmnfr8rfg0vcclktaipj2o1','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1oMRta:Yw6276Bs4v3AlBZtp1Yif1nuf73GyNbSTCWUt28_qG8','2022-08-26 17:28:02.268999');
INSERT INTO "django_session" VALUES ('wsf9titmg5u8yroex3kzr3fgtj6uzef9','.eJxVjDsOwjAQRO_iGlnxP6akzxmstXeNA8iR4qRC3B1HSgHVSPPezJsF2LcS9kZrmJFdmWCX3y5CelI9AD6g3heelrqtc-SHwk_a-LQgvW6n-3dQoJW-NuikUgbtmI12xoI3WvUktApdJJvyOGgPgxOSukIpZi1JgfFeWKvZ5wvEaTcz:1od5Dv:D4CsWhRUxx2tXuPB0_MvP9OSDdjvTU1ON3AnMjqj2Wo','2022-10-11 14:41:47.529724');
INSERT INTO "django_session" VALUES ('kzgf538h4eteebdvsu1zvncjgmv088z3','.eJxVjMsOwiAURP-FtSG3vHHp3m8gXLhI1dCktCvjvytJF7qbzDkzLxbivtWwd1rDnNmZyYmdfkuM6UFtkHyP7bbwtLRtnZEPhR-08-uS6Xk53L-DGnsd62QlokAka75ZW6UVJXIAWmpAcqIYmKTzCQsWIbM3IJTxXhRCUMTeHxmRODk:1p0PE4:aco4IRHRdJik0fXsyauSPrptt-80fXEaNRaWR5rPBow','2022-12-14 22:42:20.810451');
INSERT INTO "django_session" VALUES ('f01x22gqkck5wrbwhrrs3p109a4jeo3q','.eJxVjEEOwiAQRe_C2hBAyoBL9z0DGYZBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXERWpx-t4T04LaDfMd2myXNbV2mJHdFHrTLcc78vB7u30HFXr_1mRIyOyrgjAWtChUHEIzyoOzANPhsMhhfnFXBa2VJJcbgAXMxlEi8P-SIOA4:1p0PG4:Aj8eczh1oKUeZ4lUAiRQ6oRcd3gN22b4AhUVcQUeFfI','2022-12-14 22:44:24.089658');
INSERT INTO "django_session" VALUES ('1ut2uagi67ut4s8hgg3a84ovkx1nqe0a','.eJxVjMsOwiAQRf-FtSEMTGBw6d5vIMNLqoYmpV0Z_12bdKHbe865LxF4W1vYRlnClMVZGC1Ov2Pk9Ch9J_nO_TbLNPd1maLcFXnQIa9zLs_L4f4dNB7tW9tSTYSK4DGjI_Ck0QASo8vKUQIEy8pYzUV7cLGiVTGTJasUeefF-wPXNzZn:1pGAEu:gjX5LWFDf11LWrmE9AlDsAIegrgKe-S38F_kPuQI3kY','2023-01-27 09:56:20.313272');
INSERT INTO "django_session" VALUES ('hwk6ym1v7z89phr0s6fngm1ygrf4w4en','.eJxVjEEOwiAQRe_C2hBAyoBL9z0DGYZBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXERWpx-t4T04LaDfMd2myXNbV2mJHdFHrTLcc78vB7u30HFXr_1mRIyOyrgjAWtChUHEIzyoOzANPhsMhhfnFXBa2VJJcbgAXMxlEi8P-SIOA4:1rRTe8:4jVo36HAsrqhZAMrkEgaRvjAADzUbJsfjMW3A3omuzQ','2024-02-04 15:57:40.538199');
INSERT INTO "django_session" VALUES ('duprhoact8br20h4rbdwlsox48nrr5ru','.eJxVjEEOwiAQRe_C2hBAyoBL9z0DGYZBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXERWpx-t4T04LaDfMd2myXNbV2mJHdFHrTLcc78vB7u30HFXr_1mRIyOyrgjAWtChUHEIzyoOzANPhsMhhfnFXBa2VJJcbgAXMxlEi8P-SIOA4:1rRTsP:nwaFzDMyi4CTyWOqu7EcZBQbf03EviHGGcA_1b0-MHU','2024-02-04 16:12:25.127622');
INSERT INTO "django_session" VALUES ('8sxlnajhbnhie3s3sar4di8zdbnzfi73','.eJxVjMsOwiAQRf-FtSEyQ3m4dN9vIAwMUjU0Ke3K-O_apAvd3nPOfYkQt7WGrfMSpiwuArw4_Y4U04PbTvI9ttss09zWZSK5K_KgXY5z5uf1cP8Oauz1W_vCFrkoh0DGM5Ox2lpSxZVidFYJ0SAjO-c1gQPAjNrDgOfiBqYk3h8NgjfQ:1rRUFd:5mg03DtFW0IB5seAETIgoGYJXzDZwo4Qo6H6LN5GsWA','2024-02-04 16:36:25.503850');
INSERT INTO "django_session" VALUES ('th44pcozzvt9j2pp5m3fb9jkp0sxcb89','.eJxVjEEOwiAQRe_C2hBAyoBL9z0DGYZBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXERWpx-t4T04LaDfMd2myXNbV2mJHdFHrTLcc78vB7u30HFXr_1mRIyOyrgjAWtChUHEIzyoOzANPhsMhhfnFXBa2VJJcbgAXMxlEi8P-SIOA4:1rRa82:aYaNcZacpO7fFRIg2_xQ1whwIT9hXMmuT1MxMB04zaY','2024-02-04 22:52:58.942080');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (S)','200','Size S 
รอบอก 40 
ความยาว 28 
ความยาวแขน 23.5 
รอบคอ 38',1,'products/เสอชายแขนยาว.png',100,'ตัว',5,'P01');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (M)','210','Size M
รอบอก 42 
ความยาว 29 
ความยาวแขน 24.5 
รอบคอ 39',1,'products/เสอชายแขนยาว_b7FU2kN.png',100,'ตัว',5,'P02');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (L)','220','Size L 
รอบอก 44
ความยาว 29.5 
ความยาวแขน 25.5
รอบคอ 40',1,'products/เสอชายแขนยาว_BIQcFHl.png',100,'ตัว',5,'P03');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (XL)','240','Size XL
รอบอก 46 
ความยาว 30.5 
ความยาวแขน 26 
รอบคอ 41',1,'products/เสอชายแขนยาว_rep3GhR.png',100,'ตัว',5,'P04');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (2XL)','280','Size 2XL
รอบอก 48 
ความยาว 31
ความยาวแขน 27
รอบคอ 42',1,'products/เสอชายแขนยาว_pm3cDuW.png',97,'ตัว',5,'P06');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (3XL)','300','Size 3XL
รอบอก 50 
ความยาว 32 
ความยาวแขน 28
รอบคอ 43',1,'products/เสอชายแขนยาว_xkjDl76.png',99,'ตัว',5,'P07');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาชายแขนยาว (4XL)','320','Size 4XL
รอบอก 52
ความยาว 33.5 
ความยาวแขน 28.5 
รอบคอ 44',1,'products/เสอชายแขนยาว_svUwxZz.png',71,'ตัว',5,'P08');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (SS)','170','Size SS
รอบอก 34
ความยาว 24.5',1,'products/เสอหญงแขนสน.jpg',90,'ตัว',12,'P09');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (S)','170','Size S
รอบอก 36
ความยาว 25',1,'products/เสอหญงแขนสน_igzpT4d.jpg',100,'ตัว',12,'P010');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (M)','180','Size M
รอบอก 38
ความยาว 25.5',1,'products/เสอหญงแขนสน_kXfuePy.jpg',100,'ตัว',12,'P011');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (L)','190','Size L
รอบอก 40
ความยาว 26',1,'products/เสอหญงแขนสน_qOprrFS.jpg',100,'ตัว',12,'P012');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (XL)','200','Size XL
รอบอก 42
ความยาว 26.5',1,'products/เสอหญงแขนสน_22nI7bZ.jpg',100,'ตัว',12,'P013');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (2XL)','210','Size 2XL
รอบอก 44
ความยาว 28.5',1,'products/เสอหญงแขนสน_ZP5cHyA.jpg',100,'ตัว',12,'P014');
INSERT INTO "company_allproduct" VALUES ('เสื้อนักศึกษาหญิงแขนสั้น (3XL)','220','Size 3XL
รอบอก 46
ความยาว 29.5',1,'products/เสอหญงแขนสน_Y4bgfqj.jpg',100,'ตัว',12,'P015');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (14")','200','ความยาว 14 นิ้ว
เอว 24',1,'products/A14.png',100,'ตัว',7,'P016');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (14")','200','ความยาว 14 นิ้ว
เอว 25',1,'products/A14_VYEKpP7.png',100,'ตัว',7,'P017');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (14")','200','ความยาว 14 นิ้ว
เอว 26',1,'products/A14_Dh9iUOv.png',100,'ตัว',7,'P018');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (14")','200','ความยาว 14 นิ้ว
เอว 27',1,'products/A14_xBiQwun.png',100,'ตัว',7,'P019');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (16")','210','ความยาว 16 นิ้ว
เอว 24',1,'products/A16.png',100,'ตัว',7,'P020');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (16")','210','ความยาว 16 นิ้ว
เอว 25',1,'products/A16_ZAWniEx.png',100,'ตัว',7,'P021');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (16")','210','ความยาว 16 นิ้ว
เอว 26',1,'products/A16_tpOHjiG.png',100,'ตัว',7,'P022');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (16")','210','ความยาว 16 นิ้ว
เอว 27',1,'products/A16_cAdqaX9.png',100,'ตัว',7,'P023');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (18")','220','ความยาว 18 นิ้ว
เอว 24',1,'products/A18.png',100,'ตัว',7,'P024');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (18")','220','ความยาว 18 นิ้ว
เอว 25',1,'products/A18_FhTHnq5.png',100,'ตัว',7,'P025');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (18")','220','ความยาว 18 นิ้ว
เอว 26',1,'products/A18_KMAHwjk.png',100,'คัว',7,'P026');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (18")','220','ความยาว 18 นิ้ว
เอว 27',1,'products/A18_vIE24LO.png',100,'ตัว',7,'P027');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (20")','240','ความยาว 20 นิ้ว
เอว 24',1,'products/A20.png',100,'ตัว',7,'P028');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (20")','240','ความยาว 20 นิ้ว
เอว 25',1,'products/A20_uQsbraL.png',100,'ตัว',7,'P029');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (20")','240','ความยาว 20 นิ้ว
เอว 26',1,'products/A20_vX4yHiQ.png',100,'ตัว',7,'P030');
INSERT INTO "company_allproduct" VALUES ('กระโปรงทรงเอ (20")','240','ความยาว 20 นิ้ว
เอว 27',1,'products/A20_oOMPrJK.png',100,'ตัว',7,'P031');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (14")','180','ความยาว 14 นิ้ว
เอว Freesize',1,'products/P14_ywt5viO.png',100,'ตัว',6,'P032');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (16")','200','ความยาว 16 นิ้ว
เอว Freesize',1,'products/P16.png',100,'ตัว',6,'P033');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (18")','220','ความยาว 18 นิ้ว
เอว Freesize',1,'products/P18.png',100,'ตัว',6,'P034');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (20")','240','ความยาว 20 นิ้ว
เอว Freesize',1,'products/P20.png',100,'ตัว',6,'P035');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (22")','240','ความยาว 22 นิ้ว
เอว Freesize',1,'products/P22.png',100,'ตัว',6,'P036');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (24")','260','ความยาว 24 นิ้ว
เอว Freesize',1,'products/P24.png',34,'ตัว',6,'P37');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (26")','270','ความยาว 26 นิ้ว
เอว Freesize',1,'products/P26.png',98,'ตัว',6,'P038');
INSERT INTO "company_allproduct" VALUES ('กระโปรงพลีท (28")','280','ความยาว 28 นิ้ว
เอว Freesize',1,'products/P28_JcBWGb8.png',100,'ตัว',6,'P039');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (30)','350','รอบเอว 30 นิ้ว',1,'products/กางเกง.jpg',100,'ตัว',8,'P040');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (32)','350','รอบเอว 32 นิ้ว',1,'products/กางเกง_vBxdGSv.jpg',100,'ตัว',8,'P041');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (34)','350','รอบเอว 34 นิ้ว',1,'products/กางเกง_7oR3KCu.jpg',100,'ตัว',8,'P042');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (36)','350','รอบเอว 36 นิ้ว',1,'products/กางเกง_PoP3QQm.jpg',100,'ตัว',8,'P043');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (38)','360','รอบเอว 38 นิ้ว',1,'products/กางเกง_CZy4RRS.jpg',1003,'ตัว',8,'P044');
INSERT INTO "company_allproduct" VALUES ('กางเกงนักศึกษาชาย (40)','380','รอบเอว 40 นิ้ว',1,'products/กางเกง_AYcy4UN.jpg',100,'ตัว',8,'P045');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูชาย (46)','350','size 46
ความยาวเท้า (cm) 27
ความกว้าง (cm) 10.5',1,'products/รองเทาชาย.jpg',100,'คู่',11,'P046');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูชาย (47)','350','size 47
ความยาวเท้า (cm) 28
ความกว้าง (cm) 10.5',1,'products/รองเทาชาย_xfyTOvm.jpg',100,'คู่',11,'P047');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูชาย (48)','350','size 48
ความยาวเท้า (cm) 29
ความกว้าง (cm) 10.5',1,'products/รองเทาชาย_PpEBnFQ.jpg',100,'คู่',11,'P048');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูชาย (49)','350','size 49
ความยาวเท้า (cm) 30
ความกว้าง (cm) 10.5',1,'products/รองเทาชาย_fISVIic.jpg',100,'คุ่',11,'P049');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูชาย (50)','350','size 50
ความยาวเท้า (cm) 31
ความกว้าง (cm) 10.5',1,'products/รองเทาชาย_KE3RIn0.jpg',100,'คู่',11,'P050');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (34)','250','size 34
ความยาวเท้า (cm) 22
ความกว้าง (cm) 8.5',1,'products/รองเทาหญง.jpg',100,'คู่',10,'P051');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (35)','250','size 35
ความยาวเท้า (cm) 22.5
ความกว้าง (cm) 8.5',1,'products/รองเทาหญง_q2vDc0q.jpg',100,'คู่',10,'P052');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (36)','250','size 36
ความยาวเท้า (cm) 23
ความกว้าง (cm) 9',1,'products/รองเทาหญง_JCMeZJe.jpg',100,'คู่',10,'P053');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (37)','250','size 37
ความยาวเท้า (cm) 23.5
ความกว้าง (cm) 9',1,'products/รองเทาหญง_1nm6s9a.jpg',100,'คู่',10,'P054');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (38)','250','size 38
ความยาวเท้า (cm) 24
ความกว้าง (cm) 9.5',1,'products/รองเทาหญง_nWfUD5e.jpg',100,'คู่',10,'P055');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (39)','250','size 39
ความยาวเท้า (cm) 24.5
ความกว้าง (cm) 9.5',1,'products/รองเทาหญง_lEdpCiq.jpg',100,'คู่',10,'P056');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (40)','250','size 40
ความยาวเท้า (cm) 25
ความกว้าง (cm) 10',1,'products/รองเทาหญง_N2CYfaL.jpg',100,'คู่',10,'P057');
INSERT INTO "company_allproduct" VALUES ('รองเท้าคัทชูหญิง (41)','250','size 41
ความยาวเท้า (cm) 25.5
ความกว้าง (cm) 10',1,'products/รองเทาหญง_XZxEXcA.jpg',98,'คู่',10,'P058');
INSERT INTO "company_allproduct" VALUES ('กระโปรง','300','ไซต์ยักกกกกก',1,'/P14_MgaJJpd.png',50,'ตัว',5,'P0011');
INSERT INTO "company_category" VALUES (5,'เสื้อนักศึกษาชายแขนยาว','');
INSERT INTO "company_category" VALUES (6,'กระโปรงพลีท','');
INSERT INTO "company_category" VALUES (7,'กระโปรงทรงเอ','');
INSERT INTO "company_category" VALUES (8,'กางเกงนักศึกษาชาย','');
INSERT INTO "company_category" VALUES (10,'รองเท้าคัทชูหญิง','');
INSERT INTO "company_category" VALUES (11,'รองเท้าคัทชูชาย','');
INSERT INTO "company_category" VALUES (12,'เสื้อนักศึกษาหญิงแขนสั้น','');
INSERT INTO "company_profile" VALUES (22,'photoprofile/rose.jpeg','member',19,0);
INSERT INTO "company_profile" VALUES (23,'default.png','member',22,0);
INSERT INTO "company_profile" VALUES (24,'default.png','admin',1,0);
INSERT INTO "company_profile" VALUES (25,'default.png','member',23,0);
INSERT INTO "company_profile" VALUES (26,'default.png','member',24,0);
INSERT INTO "company_profile" VALUES (27,'default.png','member',25,0);
INSERT INTO "company_profile" VALUES (28,'default.png','member',26,0);
INSERT INTO "company_profile" VALUES (29,'default.png','member',27,0);
INSERT INTO "company_profile" VALUES (30,'default.png','member',28,0);
INSERT INTO "company_profile" VALUES (31,'default.png','member',29,0);
INSERT INTO "company_profile" VALUES (32,'default.png','member',33,0);
INSERT INTO "jango_sessions" VALUES (64,'P37','กระโปรงพลีท (24")',260,1,260,'2022-11-30 22:42:52.648915',31);
INSERT INTO "jango_sessions" VALUES (65,'P09','เสื้อนักศึกษาหญิงแขนสั้น (SS)',170,1,170,'2022-11-30 22:42:55.803477',31);
INSERT INTO "jango_sessions" VALUES (66,'P08','เสื้อนักศึกษาชายแขนยาว (4XL)',320,1,320,'2022-11-30 22:42:57.853163',31);
INSERT INTO "jango_sessions" VALUES (67,'P031','กระโปรงทรงเอ (20")',240,2,480,'2022-11-30 22:43:26.809425',31);
INSERT INTO "jango_sessions" VALUES (68,'P031','กระโปรงทรงเอ (20")',240,1,240,'2022-11-30 22:44:46.429572',31);
INSERT INTO "jango_sessions" VALUES (69,'P030','กระโปรงทรงเอ (20")',240,1,240,'2022-12-03 14:10:41.691845',31);
INSERT INTO "jango_sessions" VALUES (70,'P37','กระโปรงพลีท (24")',260,1,260,'2023-01-13 09:56:26.926051',32);
INSERT INTO "jango_sessions" VALUES (82,'P37','กระโปรงพลีท (24")',260,4,1040,'2024-01-21 16:39:05.039768',29);
INSERT INTO "jango_sessions" VALUES (83,'P09','เสื้อนักศึกษาหญิงแขนสั้น (SS)',170,1,170,'2024-01-21 16:39:10.083625',29);
INSERT INTO "jango_sessions" VALUES (84,'P08','เสื้อนักศึกษาชายแขนยาว (4XL)',320,1,320,'2024-01-21 16:39:13.660613',29);
INSERT INTO "company_orderlist" VALUES (5,'P37',10,2600,'OD001920220329121558');
INSERT INTO "company_orderlist" VALUES (6,'P09',1,170,'OD001920220329121558');
INSERT INTO "company_orderlist" VALUES (7,'P08',3,960,'OD001920220329121558');
INSERT INTO "company_orderlist" VALUES (8,'P37',1,260,'OD002820220329124137');
INSERT INTO "company_orderlist" VALUES (9,'P09',-1,-170,'OD002820220329124137');
INSERT INTO "company_orderlist" VALUES (10,'P08',10,3200,'OD002820220329124137');
INSERT INTO "company_orderlist" VALUES (11,'P058',1,250,'OD002820220329124137');
INSERT INTO "company_orderlist" VALUES (12,'P37',8,2080,'OD002820220329211330');
INSERT INTO "company_orderlist" VALUES (13,'P37',1,260,'OD001920220403143512');
INSERT INTO "company_orderlist" VALUES (14,'P09',1,170,'OD001920220403143512');
INSERT INTO "company_orderlist" VALUES (15,'P37',4,1040,'OD002920240121160624');
INSERT INTO "company_orderlist" VALUES (16,'P038',1,270,'OD002920240121160624');
INSERT INTO "company_orderlist" VALUES (17,'P37',1,260,'OD002920240121160624');
INSERT INTO "company_orderlist" VALUES (18,'P06',1,280,'OD002920240121160624');
INSERT INTO "company_orderlist" VALUES (19,'P09',1,170,'OD002920240121160624');
INSERT INTO "company_orderlist" VALUES (20,'P031',1,240,'OD002920240121160949');
INSERT INTO "company_orderlist" VALUES (21,'P09',1,170,'OD002920240121160949');
INSERT INTO "company_orderlist" VALUES (22,'P08',1,320,'OD002920240121160949');
INSERT INTO "company_orderlist" VALUES (23,'P06',1,280,'OD002920240121160949');
INSERT INTO "company_orderlist" VALUES (24,'P08',1,320,'OD002920240121161210');
INSERT INTO "company_orderlist" VALUES (25,'P039',1,280,'OD003320240121161312');
INSERT INTO "company_orderlist" VALUES (26,'P09',3,510,'OD002920240121211024');
INSERT INTO "company_order" VALUES ('thanawat','0928531478','123 kku','ems','transfer','','2022-03-29 12:15:58.345243',1,1,'/slip.jpg','2021/2/13 12:13','','OD001920220329121558',19,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('kapom','123454','123 kku','ems','transfer','','2022-03-29 12:41:37.561391',1,1,'/slip_9Q1TLL2.jpg','2021/2/13 12:13','5555555','OD002820220329124137',28,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('','','','None','None','','2022-03-29 21:13:30.818611',0,0,'/slip_wrF4m24.jpg','2021/2/13 12:13','','OD002820220329211330',28,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('','','','None','None','','2022-04-03 14:35:12.657839',0,0,'',NULL,'','OD001920220403143512',19,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('ฟฟฟ','232323','asdfasfd','ems','transfer','','2024-01-21 16:06:24.669105',1,1,'/image.jpg','','','OD002920240121160624',29,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('sgsdgf','2313132','asdfsdfsdf','ems','transfer','','2024-01-21 16:09:49.917560',0,0,'/sosad.png','','ส่งแล้ว','OD002920240121160949',29,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('wewef','1241','sdff','ems','transfer','','2024-01-21 16:12:10.041524',1,1,'/%E0%B8%A3%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%97%E0%B9%89%E0%B8%B2%E0%B8%8A%E0%B8%B2%E0%B8%A2.jpg','','','OD002920240121161210',29,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('asdfsfsf','asdfsadf','asdfasdf','ems','transfer','','2024-01-21 16:13:12.816308',0,0,'',NULL,'','OD003320240121161312',33,'2024-01-21 23:20:06.951441');
INSERT INTO "company_order" VALUES ('','','','None','None','','2024-01-21 21:10:24.384615',0,0,'/P22.png','','','OD002920240121211024',29,'2024-01-21 23:20:06.951441');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "company_allproduct_catname_id_0b31f02d" ON "company_allproduct" (
	"catname_id"
);
CREATE INDEX IF NOT EXISTS "jango_sessions_user_id_2fc53027" ON "jango_sessions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "company_cart_user_id_8bad92b9" ON "company_cart" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "company_orderlist_productid_id_eb05f594" ON "company_orderlist" (
	"productid_id"
);
CREATE INDEX IF NOT EXISTS "company_orderlist_orderid_id_b93d13d5" ON "company_orderlist" (
	"orderid_id"
);
CREATE INDEX IF NOT EXISTS "company_order_user_id_0e6f4d5d" ON "company_order" (
	"user_id"
);
COMMIT;
