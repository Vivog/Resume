START TRANSACTION;
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
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
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
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
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
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
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
CREATE TABLE IF NOT EXISTS "site_app_interests" (
	"id"	integer NOT NULL,
	"interest"	varchar(25) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_languages" (
	"id"	integer NOT NULL,
	"language"	varchar(2) NOT NULL,
	"level"	varchar(1) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_locations_country" (
	"id"	integer NOT NULL,
	"country"	varchar(25) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_locations_sity" (
	"id"	integer NOT NULL,
	"sity"	varchar(25) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_whyme" (
	"id"	integer NOT NULL,
	"type"	varchar(50) NOT NULL,
	"about"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_interests" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"interests_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("interests_id") REFERENCES "site_app_interests"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_languages" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"languages_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("languages_id") REFERENCES "site_app_languages"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_location_country" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"locations_country_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("locations_country_id") REFERENCES "site_app_locations_country"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_location_sity" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"locations_sity_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("locations_sity_id") REFERENCES "site_app_locations_sity"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_work_hour" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"workhours_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("workhours_id") REFERENCES "site_app_workhours"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_educations" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"educations_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("educations_id") REFERENCES "site_app_educations"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo" (
	"id"	integer NOT NULL,
	"fio"	varchar(50) NOT NULL,
	"slug"	varchar(100) NOT NULL UNIQUE,
	"position"	varchar(50) NOT NULL,
	"about"	text NOT NULL,
	"age"	integer NOT NULL,
	"birthday"	date NOT NULL,
	"phone"	varchar(18) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"photo"	varchar(100) NOT NULL,
	"published"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_workplaces" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"workplaces_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("workplaces_id") REFERENCES "site_app_workplaces"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_whyme" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"whyme_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("whyme_id") REFERENCES "site_app_whyme"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_workhours" (
	"id"	integer NOT NULL,
	"hours"	varchar(1) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_maininfo_skills" (
	"id"	integer NOT NULL,
	"maininfo_id"	bigint NOT NULL,
	"skills_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("maininfo_id") REFERENCES "site_app_maininfo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("skills_id") REFERENCES "site_app_skills"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_skills" (
	"id"	integer NOT NULL,
	"skill"	varchar(50) NOT NULL,
	"shortly"	text NOT NULL,
	"logo"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_skills_stages" (
	"id"	integer NOT NULL,
	"skills_id"	bigint NOT NULL,
	"skillhistory_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("skills_id") REFERENCES "site_app_skills"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("skillhistory_id") REFERENCES "site_app_skillhistory"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "site_app_educations" (
	"id"	integer NOT NULL,
	"univer"	varchar(100) NOT NULL,
	"spec"	varchar(50) NOT NULL,
	"degree"	varchar(3) NOT NULL,
	"about"	text NOT NULL,
	"date_over"	integer NOT NULL,
	"date_start"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_skillhistory" (
	"id"	integer NOT NULL,
	"about"	text NOT NULL,
	"date_over"	integer NOT NULL,
	"stage"	varchar(50) NOT NULL,
	"date_start"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_workplaces" (
	"id"	integer NOT NULL,
	"firma"	varchar(50) NOT NULL,
	"prof"	varchar(50) NOT NULL,
	"about"	text NOT NULL,
	"date_over"	integer NOT NULL,
	"date_start"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "site_app_portfolio" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"teh"	varchar(50) NOT NULL,
	"url"	varchar(50) NOT NULL,
	"pic"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-06-29 08:28:44.429771');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2022-06-29 08:28:44.729771');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2022-06-29 08:28:44.959772');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2022-06-29 08:28:45.089772');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2022-06-29 08:28:45.279772');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2022-06-29 08:28:45.449772');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2022-06-29 08:28:45.579773');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2022-06-29 08:28:45.719773');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2022-06-29 08:28:45.849773');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2022-06-29 08:28:45.979773');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2022-06-29 08:28:46.099773');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2022-06-29 08:28:46.229774');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2022-06-29 08:28:46.369774');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2022-06-29 08:28:46.499774');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2022-06-29 08:28:46.649774');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2022-06-29 08:28:46.779774');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2022-06-29 08:28:46.899775');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2022-06-29 08:28:47.169775');
INSERT INTO "django_migrations" VALUES (19,'site_app','0001_initial','2022-06-29 08:28:47.419775');
INSERT INTO "django_migrations" VALUES (20,'site_app','0002_alter_maininfo_about_remove_maininfo_educations_and_more','2022-06-29 09:59:15.751575');
INSERT INTO "django_migrations" VALUES (21,'site_app','0003_maininfo_whyme_alter_educations_univer_and_more','2022-06-30 09:25:39.272009');
INSERT INTO "django_migrations" VALUES (22,'site_app','0004_skills_maininfo_skills','2022-07-01 08:27:44.653787');
INSERT INTO "django_migrations" VALUES (23,'site_app','0005_remove_skills_about_skills_logo_skillhistory_and_more','2022-07-01 08:52:54.230709');
INSERT INTO "django_migrations" VALUES (24,'site_app','0006_remove_skillhistory_skill','2022-07-01 11:57:00.710059');
INSERT INTO "django_migrations" VALUES (25,'site_app','0007_rename_stages_skillhistory_stage_remove_skills_stage_and_more','2022-07-01 12:03:18.465863');
INSERT INTO "django_migrations" VALUES (26,'site_app','0008_alter_skillhistory_options_and_more','2022-07-03 18:15:57.894719');
INSERT INTO "django_migrations" VALUES (27,'site_app','0009_alter_skillhistory_date_over_and_more','2022-07-03 18:20:44.529150');
INSERT INTO "django_migrations" VALUES (28,'site_app','0010_alter_skillhistory_options','2022-07-04 10:56:41.675897');
INSERT INTO "django_migrations" VALUES (29,'site_app','0011_portfolio','2022-07-07 12:01:30.495792');
INSERT INTO "django_admin_log" VALUES (1,'2022-06-29 08:34:13.585366','1','f','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2022-06-29 08:34:18.610584','2','h','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (3,'2022-06-29 08:34:23.454792','3','o','[{"added": {}}]',13,1,1);
INSERT INTO "django_admin_log" VALUES (4,'2022-06-29 08:34:37.466401','1','Миколаїв','[{"added": {}}]',11,1,1);
INSERT INTO "django_admin_log" VALUES (5,'2022-06-29 08:34:41.304578','1','Україна','[{"added": {}}]',10,1,1);
INSERT INTO "django_admin_log" VALUES (6,'2022-06-29 08:34:47.426840','1','ua - n','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (7,'2022-06-29 08:34:55.016099','2','en - m','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (8,'2022-06-29 08:35:01.179395','1','Спорт','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (9,'2022-06-29 08:35:04.952585','2','Кіно','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (10,'2022-06-29 08:35:08.867768','3','Компьютерні ігри','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (11,'2022-06-29 08:35:16.195032','4','Програмування','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" VALUES (12,'2022-06-29 08:35:48.156797','1','Універ','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (13,'2022-06-29 08:36:08.917386','1','ГП НПКГ «Зоря» — «Машпроект»','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" VALUES (14,'2022-06-29 08:36:15.651593','1','Савушкін Віталій','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" VALUES (15,'2022-06-29 08:37:28.999534','1','Савушкін Віталій','[]',15,1,2);
INSERT INTO "django_admin_log" VALUES (16,'2022-06-29 09:36:22.418363','1','Савушкін Віталій','[{"changed": {"fields": ["\u041f\u0440\u043e \u0441\u0435\u0431\u0435"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (17,'2022-06-29 09:39:01.405249','1','Савушкін Віталій','[{"changed": {"fields": ["\u041f\u0440\u043e \u0441\u0435\u0431\u0435"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (18,'2022-06-29 10:13:19.038579','1','ДП НВКГ "Зоря"-"Машпроект"','[{"changed": {"fields": ["\u041a\u043e\u043c\u043f\u0430\u043d\u0456\u044f", "\u0421\u043f\u0435\u0446\u0456\u0430\u043b\u044c\u043d\u0456\u0441\u0442\u044c", "\u0413\u043e\u043b\u043e\u0432\u043d\u0435"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (19,'2022-06-29 10:21:51.428987','2','ДП НВКГ "Зоря"-"Машпроект"','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" VALUES (20,'2022-06-29 10:25:56.834338','3','ПАТ ІНТЕРПАЙП НТЗ','[{"added": {}}]',14,1,1);
INSERT INTO "django_admin_log" VALUES (21,'2022-06-29 10:30:32.438650','1','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u041d\u0430\u0432\u0447\u0430\u043b\u044c\u043d\u0438\u0439 \u0437\u0430\u043a\u043b\u0430\u0434", "\u0421\u043f\u0435\u0446\u0456\u0430\u043b\u044c\u043d\u0456\u0441\u0442\u044c"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (22,'2022-06-29 11:14:54.434157','1','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u0421\u043f\u0435\u0446\u0456\u0430\u043b\u044c\u043d\u0456\u0441\u0442\u044c", "\u0413\u043e\u043b\u043e\u0432\u043d\u0435"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (23,'2022-06-29 11:26:09.823116','2','Національний університет кораблебудування імені адмірала Макарова','[{"added": {}}]',7,1,1);
INSERT INTO "django_admin_log" VALUES (24,'2022-06-29 11:26:22.644527','2','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u0421\u0442\u0443\u043f\u0456\u043d\u044c \u043e\u0441\u0432\u0456\u0442\u0438"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (25,'2022-06-29 11:33:55.963325','1','Савушкін Віталій','[{"changed": {"fields": ["\u041e\u0441\u0432\u0456\u0442\u0430", "\u041f\u043e\u043f\u0435\u0440\u0435\u0434\u043d\u0456 \u043c\u0456\u0441\u0446\u044f \u0440\u043e\u0431\u043e\u0442\u0438"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (26,'2022-06-30 06:12:11.102883','1','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (27,'2022-06-30 07:15:06.606858','1','Савушкін Віталій','[{"changed": {"fields": ["\u0417\u0430\u0445\u043e\u043f\u043b\u0435\u043d\u043d\u044f"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (28,'2022-06-30 07:29:14.839327','3','en - l','[{"added": {}}]',9,1,1);
INSERT INTO "django_admin_log" VALUES (29,'2022-06-30 07:29:52.192013','2','Ірина Савушкіна','[{"added": {}}]',15,1,1);
INSERT INTO "django_admin_log" VALUES (30,'2022-06-30 07:43:23.583204','2','Ірина Савушкіна','',15,1,3);
INSERT INTO "django_admin_log" VALUES (31,'2022-06-30 09:28:47.186174','1','Креативність','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (32,'2022-06-30 09:32:37.266720','2','Працьовитість','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (33,'2022-06-30 09:35:52.051163','3','Командний гравець','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (34,'2022-06-30 09:35:54.590287','1','Савушкін Віталій','[{"changed": {"fields": ["\u0427\u043e\u043c\u0443 \u044f"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (35,'2022-06-30 12:19:07.057262','1','Савушкін Віталій','[{"changed": {"fields": ["\u041f\u0440\u043e \u0441\u0435\u0431\u0435"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (36,'2022-07-01 05:22:48.193458','1','Савушкін Віталій','[{"changed": {"fields": ["\u0424\u043e\u0442\u043e"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (37,'2022-07-01 08:31:07.972603','1','Python developer','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" VALUES (38,'2022-07-01 08:31:36.248926','2','Web development','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" VALUES (39,'2022-07-01 08:31:59.210035','3','Розробка додатків','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" VALUES (40,'2022-07-01 08:32:34.822209','4','Робота з базами даних','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" VALUES (41,'2022-07-01 08:35:32.679798','1','Савушкін Віталій','[{"changed": {"fields": ["\u0412\u043c\u0456\u043d\u043d\u044f"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (42,'2022-07-01 09:10:46.222867','1','С++','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (43,'2022-07-01 09:11:25.034806','1','С++','[]',17,1,2);
INSERT INTO "django_admin_log" VALUES (44,'2022-07-01 09:17:25.251301','2','С#','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (45,'2022-07-01 09:24:40.467788','3','Python','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (46,'2022-07-01 09:25:46.147150','1','Python developer','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443", "\u0417\u043d\u0430\u0447\u043e\u043a"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (47,'2022-07-01 09:26:48.313549','2','Web development','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443", "\u0417\u043d\u0430\u0447\u043e\u043a"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (48,'2022-07-01 09:27:49.508059','4','Робота з базами даних','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443", "\u0417\u043d\u0430\u0447\u043e\u043a"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (49,'2022-07-01 09:28:11.280486','3','Розробка додатків','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443", "\u0417\u043d\u0430\u0447\u043e\u043a"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (50,'2022-07-01 11:27:53.944919','4','HTML5','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (51,'2022-07-01 11:31:37.216434','5','CSS','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (52,'2022-07-01 11:34:17.010072','6','Django','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (53,'2022-07-01 12:05:25.906425','6','Django','[]',17,1,2);
INSERT INTO "django_admin_log" VALUES (54,'2022-07-01 12:05:49.862583','1','Python developer','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (55,'2022-07-01 12:05:58.079923','2','Web development','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (56,'2022-07-03 18:15:09.780624','1','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (57,'2022-07-03 18:16:37.726021','2','Національний університет кораблебудування імені адмірала Макарова','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',7,1,2);
INSERT INTO "django_admin_log" VALUES (58,'2022-07-03 18:16:41.748855','2','Національний університет кораблебудування імені адмірала Макарова','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (59,'2022-07-03 18:16:45.430415','1','Національний університет кораблебудування імені адмірала Макарова','[]',7,1,2);
INSERT INTO "django_admin_log" VALUES (60,'2022-07-03 18:21:29.891779','1','ДП НВКГ "Зоря"-"Машпроект"','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (61,'2022-07-03 18:21:41.631924','3','ПАТ ІНТЕРПАЙП НТЗ','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (62,'2022-07-03 18:22:01.092731','2','ДП НВКГ "Зоря"-"Машпроект"','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',14,1,2);
INSERT INTO "django_admin_log" VALUES (63,'2022-07-03 18:23:50.101752','1','С++','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (64,'2022-07-03 18:24:10.041456','2','С#','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (65,'2022-07-03 18:24:20.964330','3','Python','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (66,'2022-07-03 18:24:31.676332','4','HTML5','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (67,'2022-07-03 18:24:41.690209','5','CSS','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (68,'2022-07-03 18:24:50.456561','6','Django','[{"changed": {"fields": ["\u0417", "\u041f\u043e"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (69,'2022-07-03 18:24:58.351991','6','Django','[{"changed": {"fields": ["\u0417"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (70,'2022-07-04 03:24:39.408692','6','Django','[{"changed": {"fields": ["\u0417"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (71,'2022-07-04 06:02:15.893120','7','SQL','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (72,'2022-07-04 06:05:05.980128','8','Sqlite 3','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (73,'2022-07-04 06:08:36.927601','9','PostgreSQL та MySQL','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (74,'2022-07-04 06:08:55.848432','4','Робота з базами даних','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (75,'2022-07-04 06:12:29.584716','5','HTML5 та CSS','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443"]}}]',17,1,2);
INSERT INTO "django_admin_log" VALUES (76,'2022-07-04 06:15:11.859213','10','WindowsForms','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (77,'2022-07-04 06:17:17.777653','11','Tkinter','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (78,'2022-07-04 06:19:25.707150','12','Kivy','[{"added": {}}]',17,1,1);
INSERT INTO "django_admin_log" VALUES (79,'2022-07-04 06:19:42.544873','3','Розробка додатків','[{"changed": {"fields": ["\u0415\u0442\u0430\u043f \u0440\u043e\u0437\u0432\u0438\u0442\u043a\u0443"]}}]',16,1,2);
INSERT INTO "django_admin_log" VALUES (80,'2022-07-06 11:06:07.548825','1','Савушкін Віталій','[{"changed": {"fields": ["\u041f\u043e\u0448\u0442\u0430"]}}]',15,1,2);
INSERT INTO "django_admin_log" VALUES (81,'2022-07-06 11:07:09.056112','1','Савушкін Віталій','[]',15,1,2);
INSERT INTO "django_admin_log" VALUES (82,'2022-07-07 12:08:43.674712','1','ПРОЕКТ 01','[{"added": {}}]',18,1,1);
INSERT INTO "django_admin_log" VALUES (83,'2022-07-07 12:09:24.650438','2','ПРОЕКТ 02','[{"added": {}}]',18,1,1);
INSERT INTO "django_admin_log" VALUES (84,'2022-07-07 12:09:54.755189','3','ПРОЕКТ 03','[{"added": {}}]',18,1,1);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'site_app','educations');
INSERT INTO "django_content_type" VALUES (8,'site_app','interests');
INSERT INTO "django_content_type" VALUES (9,'site_app','languages');
INSERT INTO "django_content_type" VALUES (10,'site_app','locations_country');
INSERT INTO "django_content_type" VALUES (11,'site_app','locations_sity');
INSERT INTO "django_content_type" VALUES (12,'site_app','whyme');
INSERT INTO "django_content_type" VALUES (13,'site_app','workhours');
INSERT INTO "django_content_type" VALUES (14,'site_app','workplaces');
INSERT INTO "django_content_type" VALUES (15,'site_app','maininfo');
INSERT INTO "django_content_type" VALUES (16,'site_app','skills');
INSERT INTO "django_content_type" VALUES (17,'site_app','skillhistory');
INSERT INTO "django_content_type" VALUES (18,'site_app','portfolio');
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
INSERT INTO "auth_permission" VALUES (25,7,'add_educations','Can add Освіта');
INSERT INTO "auth_permission" VALUES (26,7,'change_educations','Can change Освіта');
INSERT INTO "auth_permission" VALUES (27,7,'delete_educations','Can delete Освіта');
INSERT INTO "auth_permission" VALUES (28,7,'view_educations','Can view Освіта');
INSERT INTO "auth_permission" VALUES (29,8,'add_interests','Can add Захоплення');
INSERT INTO "auth_permission" VALUES (30,8,'change_interests','Can change Захоплення');
INSERT INTO "auth_permission" VALUES (31,8,'delete_interests','Can delete Захоплення');
INSERT INTO "auth_permission" VALUES (32,8,'view_interests','Can view Захоплення');
INSERT INTO "auth_permission" VALUES (33,9,'add_languages','Can add Мова');
INSERT INTO "auth_permission" VALUES (34,9,'change_languages','Can change Мова');
INSERT INTO "auth_permission" VALUES (35,9,'delete_languages','Can delete Мова');
INSERT INTO "auth_permission" VALUES (36,9,'view_languages','Can view Мова');
INSERT INTO "auth_permission" VALUES (37,10,'add_locations_country','Can add Країна');
INSERT INTO "auth_permission" VALUES (38,10,'change_locations_country','Can change Країна');
INSERT INTO "auth_permission" VALUES (39,10,'delete_locations_country','Can delete Країна');
INSERT INTO "auth_permission" VALUES (40,10,'view_locations_country','Can view Країна');
INSERT INTO "auth_permission" VALUES (41,11,'add_locations_sity','Can add Місто');
INSERT INTO "auth_permission" VALUES (42,11,'change_locations_sity','Can change Місто');
INSERT INTO "auth_permission" VALUES (43,11,'delete_locations_sity','Can delete Місто');
INSERT INTO "auth_permission" VALUES (44,11,'view_locations_sity','Can view Місто');
INSERT INTO "auth_permission" VALUES (45,12,'add_whyme','Can add Якості');
INSERT INTO "auth_permission" VALUES (46,12,'change_whyme','Can change Якості');
INSERT INTO "auth_permission" VALUES (47,12,'delete_whyme','Can delete Якості');
INSERT INTO "auth_permission" VALUES (48,12,'view_whyme','Can view Якості');
INSERT INTO "auth_permission" VALUES (49,13,'add_workhours','Can add Ступінь зайнятості');
INSERT INTO "auth_permission" VALUES (50,13,'change_workhours','Can change Ступінь зайнятості');
INSERT INTO "auth_permission" VALUES (51,13,'delete_workhours','Can delete Ступінь зайнятості');
INSERT INTO "auth_permission" VALUES (52,13,'view_workhours','Can view Ступінь зайнятості');
INSERT INTO "auth_permission" VALUES (53,14,'add_workplaces','Can add Місце роботи');
INSERT INTO "auth_permission" VALUES (54,14,'change_workplaces','Can change Місце роботи');
INSERT INTO "auth_permission" VALUES (55,14,'delete_workplaces','Can delete Місце роботи');
INSERT INTO "auth_permission" VALUES (56,14,'view_workplaces','Can view Місце роботи');
INSERT INTO "auth_permission" VALUES (57,15,'add_maininfo','Can add Резюме');
INSERT INTO "auth_permission" VALUES (58,15,'change_maininfo','Can change Резюме');
INSERT INTO "auth_permission" VALUES (59,15,'delete_maininfo','Can delete Резюме');
INSERT INTO "auth_permission" VALUES (60,15,'view_maininfo','Can view Резюме');
INSERT INTO "auth_permission" VALUES (61,16,'add_skills','Can add Вміння');
INSERT INTO "auth_permission" VALUES (62,16,'change_skills','Can change Вміння');
INSERT INTO "auth_permission" VALUES (63,16,'delete_skills','Can delete Вміння');
INSERT INTO "auth_permission" VALUES (64,16,'view_skills','Can view Вміння');
INSERT INTO "auth_permission" VALUES (65,17,'add_skillhistory','Can add Історія розвитку');
INSERT INTO "auth_permission" VALUES (66,17,'change_skillhistory','Can change Історія розвитку');
INSERT INTO "auth_permission" VALUES (67,17,'delete_skillhistory','Can delete Історія розвитку');
INSERT INTO "auth_permission" VALUES (68,17,'view_skillhistory','Can view Історія розвитку');
INSERT INTO "auth_permission" VALUES (69,18,'add_portfolio','Can add Портфоліо');
INSERT INTO "auth_permission" VALUES (70,18,'change_portfolio','Can change Портфоліо');
INSERT INTO "auth_permission" VALUES (71,18,'delete_portfolio','Can delete Портфоліо');
INSERT INTO "auth_permission" VALUES (72,18,'view_portfolio','Can view Портфоліо');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$320000$DCkRYG3PSEGgUWU4NJMC34$8EFj32mKZVpCawTs7mmER78646DhwFjx6cFDEnk/TXU=','2022-07-07 12:07:18.463588',1,'vivog','','vivog2017@gmail.com',1,1,'2022-06-29 08:29:47.909866','');
INSERT INTO "django_session" VALUES ('518hl2i1d0yjvggysdi65zhp1gqi49zc','.eJxVjEEOwiAQRe_C2pCMQwVcuvcMZGAYqRpISrtqvLtt0oVu33v_ryrQMpew9DyFkdVVgTr9skjplesu-En10XRqdZ7GqPdEH7bre-P8vh3t30GhXra1ccZ5lkGE2CfJIECRiF2M7uIpSTpvCDNwsojZWIviHaKBQRgjqM8XIdE4_g:1o6T5P:8uqiUCsks3pCS2VAEAHI1pEhj2LCAWp7JekxJHrEuwQ','2022-07-13 08:30:11.237257');
INSERT INTO "django_session" VALUES ('92ylf3xk2se6rp8mhxmkllg38tst4d0q','.eJxVjEEOwiAQRe_C2pCMQwVcuvcMZGAYqRpISrtqvLtt0oVu33v_ryrQMpew9DyFkdVVgTr9skjplesu-En10XRqdZ7GqPdEH7bre-P8vh3t30GhXra1ccZ5lkGE2CfJIECRiF2M7uIpSTpvCDNwsojZWIviHaKBQRgjqM8XIdE4_g:1o7C0S:tKVnWD4xzhmFIczSYYQhddmkbH0dNIv2yTu11kdZgBw','2022-07-15 08:28:04.814255');
INSERT INTO "django_session" VALUES ('ekkx11c6y96th3hkv2vdk5su1fz2y6eh','.eJxVjEEOwiAQRe_C2pCMQwVcuvcMZGAYqRpISrtqvLtt0oVu33v_ryrQMpew9DyFkdVVgTr9skjplesu-En10XRqdZ7GqPdEH7bre-P8vh3t30GhXra1ccZ5lkGE2CfJIECRiF2M7uIpSTpvCDNwsojZWIviHaKBQRgjqM8XIdE4_g:1o7Ytg:nXCnwKiwW2RyZWGNFrbrZjP0-XPYxu8CcemXFwlo4NQ','2022-07-16 08:54:36.435226');
INSERT INTO "django_session" VALUES ('4r8oqyly237fu6qdee8on40vqj8hrafi','.eJxVjEEOwiAQRe_C2pCMQwVcuvcMZGAYqRpISrtqvLtt0oVu33v_ryrQMpew9DyFkdVVgTr9skjplesu-En10XRqdZ7GqPdEH7bre-P8vh3t30GhXra1ccZ5lkGE2CfJIECRiF2M7uIpSTpvCDNwsojZWIviHaKBQRgjqM8XIdE4_g:1o9QHu:HYbYyRiBn1K0wA5flH_4rWpEMOIzsHQEime3y7rSr8g','2022-07-21 12:07:18.522591');
INSERT INTO "site_app_interests" VALUES (1,'Спорт');
INSERT INTO "site_app_interests" VALUES (2,'Кіно');
INSERT INTO "site_app_interests" VALUES (3,'Компьютерні ігри');
INSERT INTO "site_app_interests" VALUES (4,'Програмування');
INSERT INTO "site_app_languages" VALUES (1,'ua','n');
INSERT INTO "site_app_languages" VALUES (2,'en','m');
INSERT INTO "site_app_languages" VALUES (3,'en','l');
INSERT INTO "site_app_locations_country" VALUES (1,'Україна');
INSERT INTO "site_app_locations_sity" VALUES (1,'Миколаїв');
INSERT INTO "site_app_whyme" VALUES (1,'Креативність','Знаходжу нестандартні рішення при розв''язанні різноманітних завдань');
INSERT INTO "site_app_whyme" VALUES (2,'Працьовитість','Віддаю себе трудовому процесу. Якщо є мета, то її треба досягати і швидко і максимально ефективно');
INSERT INTO "site_app_whyme" VALUES (3,'Командний гравець','Усі в команді створюють цілісність загального ланцюгу. Загальна кооперація - це найкоротший шлях до виконання поставлених завдань');
INSERT INTO "site_app_maininfo_interests" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_interests" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_interests" VALUES (4,1,4);
INSERT INTO "site_app_maininfo_languages" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_languages" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_location_country" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_location_sity" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_work_hour" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_work_hour" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_work_hour" VALUES (3,1,3);
INSERT INTO "site_app_maininfo_educations" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_educations" VALUES (2,1,2);
INSERT INTO "site_app_maininfo" VALUES (1,'Савушкін Віталій','savushkin-vitalij','Python / Django Developer','І я  дуже перспективний програміст. Досвід у програмуванні більше 3 років. Вивчав мови: С+ та С#. Вивчення на рівні виконання робочих завдань для автоматизації процесів. Потім була пауза та перехід на Python 3. Вивчаю самостійно за підручниками, технічною документацією та різними курсами. Останнім часом (6 місяців) вивчаю фреймворк Django та паралельно HTML 5, CSS, SQL sqlite3.

Із захопленням вивчаю усе нове. Із задоволенням пізнаю техніки та способи кодування. Шукаю потенційних роботодавців...',37,'1985-03-29','+38(066) 719-05-67','vivog2022@ukr.net','workers_foto/1656590944083.jpg','2022-06-29 08:36:15.641592');
INSERT INTO "site_app_maininfo_workplaces" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_workplaces" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_workplaces" VALUES (3,1,3);
INSERT INTO "site_app_maininfo_whyme" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_whyme" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_whyme" VALUES (3,1,3);
INSERT INTO "site_app_workhours" VALUES (1,'f');
INSERT INTO "site_app_workhours" VALUES (2,'h');
INSERT INTO "site_app_workhours" VALUES (3,'o');
INSERT INTO "site_app_maininfo_skills" VALUES (1,1,1);
INSERT INTO "site_app_maininfo_skills" VALUES (2,1,2);
INSERT INTO "site_app_maininfo_skills" VALUES (3,1,3);
INSERT INTO "site_app_maininfo_skills" VALUES (4,1,4);
INSERT INTO "site_app_skills" VALUES (1,'Python developer','Добре розумію базові принципи Python3. Більше 1000 годин напрацювань. Добре знання ООП.','logo/python.png');
INSERT INTO "site_app_skills" VALUES (2,'Web development','Освоїв Django framework. Є знання HTML5 та CSS. Розумію структуру шаблонів.','logo/html.png');
INSERT INTO "site_app_skills" VALUES (3,'Розробка додатків','Є досвід розробки додатків за допомогою графічної бібліотеки Tkinter','logo/application-settings.png');
INSERT INTO "site_app_skills" VALUES (4,'Робота з базами даних','Знання SQL sqlite3. Базові знання MySQL, PostgreSQL та інших','logo/sql.png');
INSERT INTO "site_app_skills_stages" VALUES (1,1,1);
INSERT INTO "site_app_skills_stages" VALUES (2,1,2);
INSERT INTO "site_app_skills_stages" VALUES (3,1,3);
INSERT INTO "site_app_skills_stages" VALUES (4,2,4);
INSERT INTO "site_app_skills_stages" VALUES (5,2,5);
INSERT INTO "site_app_skills_stages" VALUES (6,2,6);
INSERT INTO "site_app_skills_stages" VALUES (7,4,8);
INSERT INTO "site_app_skills_stages" VALUES (8,4,9);
INSERT INTO "site_app_skills_stages" VALUES (9,4,7);
INSERT INTO "site_app_skills_stages" VALUES (10,3,10);
INSERT INTO "site_app_skills_stages" VALUES (11,3,11);
INSERT INTO "site_app_skills_stages" VALUES (12,3,12);
INSERT INTO "site_app_educations" VALUES (1,'Національний університет кораблебудування імені адмірала Макарова','Облік та аудит','hl','Підготовка інноваційно мислячих фахівців, які володітимуть поглибленими знаннями та 

 практичною підготовкою щодо організації обліку та звітності за національними та міжнародними стандартами; прийняття рішень в сфері оподаткування в умовах глобалізації світової економіки; підготовки, обробки аналітичної інформації та прийняття своєчасних й ефективних рішень в умовах змінюваного зовнішнього середовища; аналітичних методів та контрольних процедур виявлення та усунення деструктивних явищ в діяльності підприємств.',2016,2014);
INSERT INTO "site_app_educations" VALUES (2,'Національний університет кораблебудування імені адмірала Макарова','Електромеханічні системи автоматизації','hl','Вивчення науково-теоретичних основ і методів щодо процесів у складних електротехнічних i електромеханічних установках та системах, які складаються з взаємозв''язаного комплексу

електротехнічних та електромеханічних пристроїв, систем керування ними, засобів підвищення ефективності та продуктивності установок, методів їх математичного та фізичного моделювання, оптимізації та синтезу з метою створення нових та вдосконалення існуючих систем та пристроїв, забезпечення їх ефективного та безпечного функціонування, дослідження можливостей покращення параметрів та характеристик з метою забезпечення їх оптимального проєктування i більш ефективної роботи',2008,2002);
INSERT INTO "site_app_skillhistory" VALUES (1,'Знайомство з мовами програмування.  Вивчення типів даних. Знайомлення в ООП. Розуміння побудови класів та їх атрибутів.

Створення різноманітних скриптів.',2013,'С++',2011);
INSERT INTO "site_app_skillhistory" VALUES (2,'Поглиблення у ОПП. Класи, інтерфейси, наслідування. Розробка настільних додатків. Використання графічних бібліотек та Visual Studio та Windows Forms',2020,'С#',2018);
INSERT INTO "site_app_skillhistory" VALUES (3,'Глибоке вивчення базових відмінностей від C#. Поглиблення в ООП. 

Розробка проектів за допомогою графічної бібліотеки  Tkinter.

Впровадження власних проектів. 

Ознайомлення з системою контролю версії Git, реєстрація на GitHub. Публікація коду різноманітних виконаних власноруч завдань з платформ типу Codewars та інших.

Вивчення книг та документації по тематиці',2022,'Python',2020);
INSERT INTO "site_app_skillhistory" VALUES (4,'Вивчення структури мови та етапів формування веб-сторінки. Вивчення різноманітних тегів. Написання простих сторінок Блокнот та у середовищі ПО PyCharm. Повторення проекту аналогічному, тому що виконувався за допомогою бібліотеки Tkinter Python',2022,'HTML5',2021);
INSERT INTO "site_app_skillhistory" VALUES (5,'Разом з вивченням HTML5 ознайомився зі структурою побудови таблиць стилів. Розібрався у формуванні стилів як окремих елементів, так і класів, і сторінок загалом. Навчився створювати окремі css файли та вбудовувати їх у шаблони сторінок',2022,'HTML5 та CSS',2021);
INSERT INTO "site_app_skillhistory" VALUES (6,'Пройшов базовий курс навчання зі створювання сайтів за допомогою цього фреймворку. Навчився створювати власні проекти, додатки, шаблони, контролери та маршрутизатори. Самостійно розробив декілька проектів.',2022,'Django',2022);
INSERT INTO "site_app_skillhistory" VALUES (7,'Виконання проектів С# з використанням SQL-запитів. Обробка даних, запис та виведення значень у формах WindowsForms',2020,'SQL',2018);
INSERT INTO "site_app_skillhistory" VALUES (8,'Вивчення та використання під час засвоювання Python та Django. Використання у проектах Python разом з бібліотекою Tkinter',2022,'Sqlite 3',2020);
INSERT INTO "site_app_skillhistory" VALUES (9,'Вивчення основ роботи під час засвоювання фреймворку Django. Ознайомлення з відмінностями від Sqlite 3',2022,'PostgreSQL та MySQL',2022);
INSERT INTO "site_app_skillhistory" VALUES (10,'Розробка та впровадження додатків на мові С#. Ознайомлення з різноманітними фреймворками.',2020,'WindowsForms',2018);
INSERT INTO "site_app_skillhistory" VALUES (11,'Розробка додатків з використанням бібліотеки Tkinter. Побудова табличних інтерфейсів. Публікація додатків. Супроводження проектів',2021,'Tkinter',2020);
INSERT INTO "site_app_skillhistory" VALUES (12,'Ознайомлення з можливостями. Спроби перенесення проектів з Tkinter на Kivy. Спроби розробки додатків для ОС Android.',2022,'Kivy',2021);
INSERT INTO "site_app_workplaces" VALUES (1,'ДП НВКГ "Зоря"-"Машпроект"','Начальник лабораторії','Керівництво персоналом до 40 чоловік. Встановлення виробничих задач. Контроль технології. Розробка виробничих планів. Підготовка звітності.



Розробка та участь у наукових та дослідницьких роботах. Розробка та публікації наукових робіт та досліджень. Патентування винаходів.',2022,2015);
INSERT INTO "site_app_workplaces" VALUES (2,'ДП НВКГ "Зоря"-"Машпроект"','Інженер-дослідник','Організація та проведення наукових досліджень. Проведення контрольних вимірювань. Розробка технічної та експлуатаційної документації. Публікація звітів, довідок, протоколів випробувань. Керування робочим персоналом, кількістю до 10 чоловік.',2015,2011);
INSERT INTO "site_app_workplaces" VALUES (3,'ПАТ ІНТЕРПАЙП НТЗ','Електромонтер 5 розряду','Обслуговування та ремонт цехового електрообладнання. Розробка електричних схем. Керування бригадою до 5 чоловік.',2011,2008);
INSERT INTO "site_app_portfolio" VALUES (1,'ПРОЕКТ 01','Tkinter Python','https://github.com/Vivog/LabStaff32','portfolio/project1.png');
INSERT INTO "site_app_portfolio" VALUES (2,'ПРОЕКТ 02','Django Python','https://github.com/Vivog/PortalNDV','portfolio/project2.png');
INSERT INTO "site_app_portfolio" VALUES (3,'ПРОЕКТ 03','Django Python','https://github.com/Vivog/Resume','portfolio/project3.png');
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
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_interests_maininfo_id_interests_id_46ca82dd_uniq" ON "site_app_maininfo_interests" (
	"maininfo_id",
	"interests_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_interests_maininfo_id_a82e8de2" ON "site_app_maininfo_interests" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_interests_interests_id_495fe125" ON "site_app_maininfo_interests" (
	"interests_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_languages_maininfo_id_languages_id_d19b64e7_uniq" ON "site_app_maininfo_languages" (
	"maininfo_id",
	"languages_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_languages_maininfo_id_46b3179e" ON "site_app_maininfo_languages" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_languages_languages_id_4b22e7be" ON "site_app_maininfo_languages" (
	"languages_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_location_country_maininfo_id_locations_country_id_d7b18a80_uniq" ON "site_app_maininfo_location_country" (
	"maininfo_id",
	"locations_country_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_location_country_maininfo_id_f5dc92bf" ON "site_app_maininfo_location_country" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_location_country_locations_country_id_ca78d35d" ON "site_app_maininfo_location_country" (
	"locations_country_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_location_sity_maininfo_id_locations_sity_id_fa6fef68_uniq" ON "site_app_maininfo_location_sity" (
	"maininfo_id",
	"locations_sity_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_location_sity_maininfo_id_9f2e0ea4" ON "site_app_maininfo_location_sity" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_location_sity_locations_sity_id_60d6fcba" ON "site_app_maininfo_location_sity" (
	"locations_sity_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_work_hour_maininfo_id_workhours_id_679fb1eb_uniq" ON "site_app_maininfo_work_hour" (
	"maininfo_id",
	"workhours_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_work_hour_maininfo_id_6462196a" ON "site_app_maininfo_work_hour" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_work_hour_workhours_id_8b75c276" ON "site_app_maininfo_work_hour" (
	"workhours_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_educations_maininfo_id_educations_id_00d3fa0c_uniq" ON "site_app_maininfo_educations" (
	"maininfo_id",
	"educations_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_educations_maininfo_id_91eef7fe" ON "site_app_maininfo_educations" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_educations_educations_id_b8d8d09f" ON "site_app_maininfo_educations" (
	"educations_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_workplaces_maininfo_id_workplaces_id_af0bd802_uniq" ON "site_app_maininfo_workplaces" (
	"maininfo_id",
	"workplaces_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_workplaces_maininfo_id_cff36293" ON "site_app_maininfo_workplaces" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_workplaces_workplaces_id_92ba237b" ON "site_app_maininfo_workplaces" (
	"workplaces_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_whyme_maininfo_id_whyme_id_9417d6ce_uniq" ON "site_app_maininfo_whyme" (
	"maininfo_id",
	"whyme_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_whyme_maininfo_id_88205612" ON "site_app_maininfo_whyme" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_whyme_whyme_id_0b6cf578" ON "site_app_maininfo_whyme" (
	"whyme_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_maininfo_skills_maininfo_id_skills_id_5e8788eb_uniq" ON "site_app_maininfo_skills" (
	"maininfo_id",
	"skills_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_skills_maininfo_id_9ab74589" ON "site_app_maininfo_skills" (
	"maininfo_id"
);
CREATE INDEX IF NOT EXISTS "site_app_maininfo_skills_skills_id_349064ca" ON "site_app_maininfo_skills" (
	"skills_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "site_app_skills_stages_skills_id_skillhistory_id_a882c52c_uniq" ON "site_app_skills_stages" (
	"skills_id",
	"skillhistory_id"
);
CREATE INDEX IF NOT EXISTS "site_app_skills_stages_skills_id_70627660" ON "site_app_skills_stages" (
	"skills_id"
);
CREATE INDEX IF NOT EXISTS "site_app_skills_stages_skillhistory_id_bb7c3a39" ON "site_app_skills_stages" (
	"skillhistory_id"
);
COMMIT;