BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "migrations_lock" (
	"lock_key"	varchar(191) NOT NULL,
	"locked"	boolean DEFAULT '0',
	"acquired_at"	datetime,
	"released_at"	datetime
);
CREATE TABLE IF NOT EXISTS "migrations" (
	"id"	integer NOT NULL,
	"name"	varchar(255),
	"version"	varchar(255),
	"currentVersion"	varchar(255),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "posts" (
	"id"	varchar(24) NOT NULL,
	"uuid"	varchar(36) NOT NULL,
	"title"	varchar(2000) NOT NULL,
	"slug"	varchar(191) NOT NULL,
	"mobiledoc"	text,
	"html"	text,
	"comment_id"	varchar(50),
	"plaintext"	text,
	"feature_image"	varchar(2000),
	"featured"	boolean NOT NULL DEFAULT '0',
	"type"	varchar(50) NOT NULL DEFAULT 'post',
	"status"	varchar(50) NOT NULL DEFAULT 'draft',
	"locale"	varchar(6),
	"visibility"	varchar(50) NOT NULL DEFAULT 'public',
	"send_email_when_published"	boolean DEFAULT '0',
	"author_id"	varchar(24) NOT NULL,
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	"published_at"	datetime,
	"published_by"	varchar(24),
	"custom_excerpt"	varchar(2000),
	"codeinjection_head"	text,
	"codeinjection_foot"	text,
	"custom_template"	varchar(100),
	"canonical_url"	text,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "posts_meta" (
	"id"	varchar(24) NOT NULL,
	"post_id"	varchar(24) NOT NULL,
	"og_image"	varchar(2000),
	"og_title"	varchar(300),
	"og_description"	varchar(500),
	"twitter_image"	varchar(2000),
	"twitter_title"	varchar(300),
	"twitter_description"	varchar(500),
	"meta_title"	varchar(2000),
	"meta_description"	varchar(2000),
	"email_subject"	varchar(300),
	PRIMARY KEY("id"),
	FOREIGN KEY("post_id") REFERENCES "posts"("id")
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	varchar(24) NOT NULL,
	"name"	varchar(191) NOT NULL,
	"slug"	varchar(191) NOT NULL,
	"password"	varchar(60) NOT NULL,
	"email"	varchar(191) NOT NULL,
	"profile_image"	varchar(2000),
	"cover_image"	varchar(2000),
	"bio"	text,
	"website"	varchar(2000),
	"location"	text,
	"facebook"	varchar(2000),
	"twitter"	varchar(2000),
	"accessibility"	text,
	"status"	varchar(50) NOT NULL DEFAULT 'active',
	"locale"	varchar(6),
	"visibility"	varchar(50) NOT NULL DEFAULT 'public',
	"meta_title"	varchar(2000),
	"meta_description"	varchar(2000),
	"tour"	text,
	"last_seen"	datetime,
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "posts_authors" (
	"id"	varchar(24) NOT NULL,
	"post_id"	varchar(24) NOT NULL,
	"author_id"	varchar(24) NOT NULL,
	"sort_order"	integer NOT NULL DEFAULT '0',
	PRIMARY KEY("id"),
	FOREIGN KEY("author_id") REFERENCES "users"("id"),
	FOREIGN KEY("post_id") REFERENCES "posts"("id")
);
CREATE TABLE IF NOT EXISTS "roles" (
	"id"	varchar(24) NOT NULL,
	"name"	varchar(50) NOT NULL,
	"description"	varchar(2000),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "roles_users" (
	"id"	varchar(24) NOT NULL,
	"role_id"	varchar(24) NOT NULL,
	"user_id"	varchar(24) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "permissions" (
	"id"	varchar(24) NOT NULL,
	"name"	varchar(50) NOT NULL,
	"object_type"	varchar(50) NOT NULL,
	"action_type"	varchar(50) NOT NULL,
	"object_id"	varchar(24),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "permissions_users" (
	"id"	varchar(24) NOT NULL,
	"user_id"	varchar(24) NOT NULL,
	"permission_id"	varchar(24) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "permissions_roles" (
	"id"	varchar(24) NOT NULL,
	"role_id"	varchar(24) NOT NULL,
	"permission_id"	varchar(24) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "permissions_apps" (
	"id"	varchar(24) NOT NULL,
	"app_id"	varchar(24) NOT NULL,
	"permission_id"	varchar(24) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "settings" (
	"id"	varchar(24) NOT NULL,
	"key"	varchar(50) NOT NULL,
	"value"	text,
	"type"	varchar(50) NOT NULL DEFAULT 'core',
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "tags" (
	"id"	varchar(24) NOT NULL,
	"name"	varchar(191) NOT NULL,
	"slug"	varchar(191) NOT NULL,
	"description"	text,
	"feature_image"	varchar(2000),
	"parent_id"	varchar(191),
	"visibility"	varchar(50) NOT NULL DEFAULT 'public',
	"meta_title"	varchar(2000),
	"meta_description"	varchar(2000),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "posts_tags" (
	"id"	varchar(24) NOT NULL,
	"post_id"	varchar(24) NOT NULL,
	"tag_id"	varchar(24) NOT NULL,
	"sort_order"	integer NOT NULL DEFAULT '0',
	PRIMARY KEY("id"),
	FOREIGN KEY("post_id") REFERENCES "posts"("id"),
	FOREIGN KEY("tag_id") REFERENCES "tags"("id")
);
CREATE TABLE IF NOT EXISTS "apps" (
	"id"	varchar(24) NOT NULL,
	"name"	varchar(191) NOT NULL,
	"slug"	varchar(191) NOT NULL,
	"version"	varchar(50) NOT NULL,
	"status"	varchar(50) NOT NULL DEFAULT 'inactive',
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "app_settings" (
	"id"	varchar(24) NOT NULL,
	"key"	varchar(50) NOT NULL,
	"value"	text,
	"app_id"	varchar(24) NOT NULL,
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id"),
	FOREIGN KEY("app_id") REFERENCES "apps"("id")
);
CREATE TABLE IF NOT EXISTS "app_fields" (
	"id"	varchar(24) NOT NULL,
	"key"	varchar(50) NOT NULL,
	"value"	text,
	"type"	varchar(50) NOT NULL DEFAULT 'html',
	"app_id"	varchar(24) NOT NULL,
	"relatable_id"	varchar(24) NOT NULL,
	"relatable_type"	varchar(50) NOT NULL DEFAULT 'posts',
	"active"	boolean NOT NULL DEFAULT '1',
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id"),
	FOREIGN KEY("app_id") REFERENCES "apps"("id")
);
CREATE TABLE IF NOT EXISTS "invites" (
	"id"	varchar(24) NOT NULL,
	"role_id"	varchar(24) NOT NULL,
	"status"	varchar(50) NOT NULL DEFAULT 'pending',
	"token"	varchar(191) NOT NULL,
	"email"	varchar(191) NOT NULL,
	"expires"	bigint NOT NULL,
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "brute" (
	"key"	varchar(191) NOT NULL,
	"firstRequest"	bigint NOT NULL,
	"lastRequest"	bigint NOT NULL,
	"lifetime"	bigint NOT NULL,
	"count"	integer NOT NULL
);
CREATE TABLE IF NOT EXISTS "webhooks" (
	"id"	varchar(24) NOT NULL,
	"event"	varchar(50) NOT NULL,
	"target_url"	varchar(2000) NOT NULL,
	"name"	varchar(191),
	"secret"	varchar(191),
	"api_version"	varchar(50) NOT NULL DEFAULT 'v2',
	"integration_id"	varchar(24),
	"status"	varchar(50) NOT NULL DEFAULT 'available',
	"last_triggered_at"	datetime,
	"last_triggered_status"	varchar(50),
	"last_triggered_error"	varchar(50),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "sessions" (
	"id"	varchar(24) NOT NULL,
	"session_id"	varchar(32) NOT NULL,
	"user_id"	varchar(24) NOT NULL,
	"session_data"	varchar(2000) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "integrations" (
	"id"	varchar(24) NOT NULL,
	"type"	varchar(50) NOT NULL DEFAULT 'custom',
	"name"	varchar(191) NOT NULL,
	"slug"	varchar(191) NOT NULL,
	"icon_image"	varchar(2000),
	"description"	varchar(2000),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "api_keys" (
	"id"	varchar(24) NOT NULL,
	"type"	varchar(50) NOT NULL,
	"secret"	varchar(191) NOT NULL,
	"role_id"	varchar(24),
	"integration_id"	varchar(24),
	"last_seen_at"	datetime,
	"last_seen_version"	varchar(50),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "mobiledoc_revisions" (
	"id"	varchar(24) NOT NULL,
	"post_id"	varchar(24) NOT NULL,
	"mobiledoc"	text,
	"created_at_ts"	bigint NOT NULL,
	"created_at"	datetime NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "members" (
	"id"	varchar(24) NOT NULL,
	"uuid"	varchar(36),
	"email"	varchar(191) NOT NULL,
	"name"	varchar(191),
	"note"	varchar(2000),
	"subscribed"	boolean DEFAULT '1',
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "members_stripe_customers" (
	"id"	varchar(24) NOT NULL,
	"member_id"	varchar(24) NOT NULL,
	"customer_id"	varchar(255) NOT NULL,
	"name"	varchar(191),
	"email"	varchar(191),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "members_stripe_customers_subscriptions" (
	"id"	varchar(24) NOT NULL,
	"customer_id"	varchar(255) NOT NULL,
	"subscription_id"	varchar(255) NOT NULL,
	"plan_id"	varchar(255) NOT NULL,
	"status"	varchar(50) NOT NULL,
	"cancel_at_period_end"	boolean NOT NULL DEFAULT '0',
	"current_period_end"	datetime NOT NULL,
	"start_date"	datetime NOT NULL,
	"default_payment_card_last4"	varchar(4),
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	"plan_nickname"	varchar(50) NOT NULL,
	"plan_interval"	varchar(50) NOT NULL,
	"plan_amount"	integer NOT NULL,
	"plan_currency"	varchar(191) NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "actions" (
	"id"	varchar(24) NOT NULL,
	"resource_id"	varchar(24),
	"resource_type"	varchar(50) NOT NULL,
	"actor_id"	varchar(24) NOT NULL,
	"actor_type"	varchar(50) NOT NULL,
	"event"	varchar(50) NOT NULL,
	"context"	text,
	"created_at"	datetime NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "emails" (
	"id"	varchar(24) NOT NULL,
	"post_id"	varchar(24) NOT NULL,
	"uuid"	varchar(36) NOT NULL,
	"status"	varchar(50) NOT NULL DEFAULT 'pending',
	"error"	varchar(2000),
	"error_data"	text,
	"meta"	text,
	"stats"	text,
	"email_count"	integer NOT NULL DEFAULT '0',
	"subject"	varchar(300),
	"html"	text,
	"plaintext"	text,
	"submitted_at"	datetime NOT NULL,
	"created_at"	datetime NOT NULL,
	"created_by"	varchar(24) NOT NULL,
	"updated_at"	datetime,
	"updated_by"	varchar(24),
	PRIMARY KEY("id")
);
INSERT INTO "migrations_lock" VALUES ('km01',0,'2021-04-11 03:13:04','2021-04-11 03:13:09');
INSERT INTO "migrations" VALUES (1,'1-create-tables.js','init','3.3');
INSERT INTO "migrations" VALUES (2,'2-create-fixtures.js','init','3.3');
INSERT INTO "migrations" VALUES (3,'1-post-excerpt.js','1.3','3.3');
INSERT INTO "migrations" VALUES (4,'1-codeinjection-post.js','1.4','3.3');
INSERT INTO "migrations" VALUES (5,'1-og-twitter-post.js','1.5','3.3');
INSERT INTO "migrations" VALUES (6,'1-add-backup-client.js','1.7','3.3');
INSERT INTO "migrations" VALUES (7,'1-add-permissions-redirect.js','1.9','3.3');
INSERT INTO "migrations" VALUES (8,'1-custom-template-post.js','1.13','3.3');
INSERT INTO "migrations" VALUES (9,'2-theme-permissions.js','1.13','3.3');
INSERT INTO "migrations" VALUES (10,'1-add-webhooks-table.js','1.18','3.3');
INSERT INTO "migrations" VALUES (11,'1-webhook-permissions.js','1.19','3.3');
INSERT INTO "migrations" VALUES (12,'1-remove-settings-keys.js','1.20','3.3');
INSERT INTO "migrations" VALUES (13,'1-add-contributor-role.js','1.21','3.3');
INSERT INTO "migrations" VALUES (14,'1-multiple-authors-DDL.js','1.22','3.3');
INSERT INTO "migrations" VALUES (15,'1-multiple-authors-DML.js','1.22','3.3');
INSERT INTO "migrations" VALUES (16,'1-update-koenig-beta-html.js','1.25','3.3');
INSERT INTO "migrations" VALUES (17,'2-demo-post.js','1.25','3.3');
INSERT INTO "migrations" VALUES (18,'1-rename-amp-column.js','2.0','3.3');
INSERT INTO "migrations" VALUES (19,'2-update-posts.js','2.0','3.3');
INSERT INTO "migrations" VALUES (20,'3-remove-koenig-labs.js','2.0','3.3');
INSERT INTO "migrations" VALUES (21,'4-permalink-setting.js','2.0','3.3');
INSERT INTO "migrations" VALUES (22,'5-remove-demo-post.js','2.0','3.3');
INSERT INTO "migrations" VALUES (23,'6-replace-fixture-posts.js','2.0','3.3');
INSERT INTO "migrations" VALUES (24,'1-add-sessions-table.js','2.2','3.3');
INSERT INTO "migrations" VALUES (25,'2-add-integrations-and-api-key-tables.js','2.2','3.3');
INSERT INTO "migrations" VALUES (26,'3-insert-admin-integration-role.js','2.2','3.3');
INSERT INTO "migrations" VALUES (27,'4-insert-integration-and-api-key-permissions.js','2.2','3.3');
INSERT INTO "migrations" VALUES (28,'5-add-mobiledoc-revisions-table.js','2.2','3.3');
INSERT INTO "migrations" VALUES (29,'1-add-webhook-columns.js','2.3','3.3');
INSERT INTO "migrations" VALUES (30,'2-add-webhook-edit-permission.js','2.3','3.3');
INSERT INTO "migrations" VALUES (31,'1-add-webhook-permission-roles.js','2.6','3.3');
INSERT INTO "migrations" VALUES (32,'1-add-members-table.js','2.8','3.3');
INSERT INTO "migrations" VALUES (33,'1-remove-empty-strings.js','2.13','3.3');
INSERT INTO "migrations" VALUES (34,'1-add-actions-table.js','2.14','3.3');
INSERT INTO "migrations" VALUES (35,'2-add-actions-permissions.js','2.14','3.3');
INSERT INTO "migrations" VALUES (36,'1-add-type-column-to-integrations.js','2.15','3.3');
INSERT INTO "migrations" VALUES (37,'2-insert-zapier-integration.js','2.15','3.3');
INSERT INTO "migrations" VALUES (38,'1-add-members-perrmissions.js','2.16','3.3');
INSERT INTO "migrations" VALUES (39,'1-normalize-settings.js','2.17','3.3');
INSERT INTO "migrations" VALUES (40,'2-posts-add-canonical-url.js','2.17','3.3');
INSERT INTO "migrations" VALUES (41,'1-restore-settings-from-backup.js','2.18','3.3');
INSERT INTO "migrations" VALUES (42,'1-update-editor-permissions.js','2.21','3.3');
INSERT INTO "migrations" VALUES (43,'1-add-member-permissions-to-roles.js','2.22','3.3');
INSERT INTO "migrations" VALUES (44,'1-insert-ghost-db-backup-role.js','2.27','3.3');
INSERT INTO "migrations" VALUES (45,'2-insert-db-backup-integration.js','2.27','3.3');
INSERT INTO "migrations" VALUES (46,'3-add-subdirectory-to-relative-canonical-urls.js','2.27','3.3');
INSERT INTO "migrations" VALUES (47,'1-add-db-backup-content-permission.js','2.28','3.3');
INSERT INTO "migrations" VALUES (48,'2-add-db-backup-content-permission-to-roles.js','2.28','3.3');
INSERT INTO "migrations" VALUES (49,'3-insert-ghost-scheduler-role.js','2.28','3.3');
INSERT INTO "migrations" VALUES (50,'4-insert-scheduler-integration.js','2.28','3.3');
INSERT INTO "migrations" VALUES (51,'5-add-scheduler-permission-to-roles.js','2.28','3.3');
INSERT INTO "migrations" VALUES (52,'6-add-type-column.js','2.28','3.3');
INSERT INTO "migrations" VALUES (53,'7-populate-type-column.js','2.28','3.3');
INSERT INTO "migrations" VALUES (54,'8-remove-page-column.js','2.28','3.3');
INSERT INTO "migrations" VALUES (55,'1-add-post-page-column.js','2.29','3.3');
INSERT INTO "migrations" VALUES (56,'2-populate-post-page-column.js','2.29','3.3');
INSERT INTO "migrations" VALUES (57,'3-remove-page-type-column.js','2.29','3.3');
INSERT INTO "migrations" VALUES (58,'1-remove-name-and-password-from-members-table.js','2.31','3.3');
INSERT INTO "migrations" VALUES (59,'01-add-members-stripe-customers-table.js','2.32','3.3');
INSERT INTO "migrations" VALUES (60,'02-add-name-to-members-table.js','2.32','3.3');
INSERT INTO "migrations" VALUES (61,'01-correct-members-stripe-customers-table.js','2.33','3.3');
INSERT INTO "migrations" VALUES (62,'01-add-stripe-customers-subscriptions-table.js','2.34','3.3');
INSERT INTO "migrations" VALUES (63,'02-add-email-to-members-stripe-customers-table.js','2.34','3.3');
INSERT INTO "migrations" VALUES (64,'03-add-name-to-members-stripe-customers-table.js','2.34','3.3');
INSERT INTO "migrations" VALUES (65,'01-add-note-to-members-table.js','2.35','3.3');
INSERT INTO "migrations" VALUES (66,'01-add-self-signup-and-from address-to-members-settings.js','2.37','3.3');
INSERT INTO "migrations" VALUES (67,'01-remove-user-ghost-auth-columns.js','3.0','3.3');
INSERT INTO "migrations" VALUES (68,'02-drop-token-auth-tables.js','3.0','3.3');
INSERT INTO "migrations" VALUES (69,'03-drop-client-auth-tables.js','3.0','3.3');
INSERT INTO "migrations" VALUES (70,'04-add-posts-meta-table.js','3.0','3.3');
INSERT INTO "migrations" VALUES (71,'05-populate-posts-meta-table.js','3.0','3.3');
INSERT INTO "migrations" VALUES (72,'06-remove-posts-meta-columns.js','3.0','3.3');
INSERT INTO "migrations" VALUES (73,'07-add-posts-type-column.js','3.0','3.3');
INSERT INTO "migrations" VALUES (74,'08-populate-posts-type-column.js','3.0','3.3');
INSERT INTO "migrations" VALUES (75,'09-remove-posts-page-column.js','3.0','3.3');
INSERT INTO "migrations" VALUES (76,'10-remove-empty-strings.js','3.0','3.3');
INSERT INTO "migrations" VALUES (77,'11-update-posts-html.js','3.0','3.3');
INSERT INTO "migrations" VALUES (78,'12-populate-members-table-from-subscribers.js','3.0','3.3');
INSERT INTO "migrations" VALUES (79,'13-drop-subscribers-table.js','3.0','3.3');
INSERT INTO "migrations" VALUES (80,'14-remove-subscribers-flag.js','3.0','3.3');
INSERT INTO "migrations" VALUES (81,'01-add-send-email-when-published-to-posts.js','3.1','3.3');
INSERT INTO "migrations" VALUES (82,'02-add-email-subject-to-posts-meta.js','3.1','3.3');
INSERT INTO "migrations" VALUES (83,'03-add-email-preview-permissions.js','3.1','3.3');
INSERT INTO "migrations" VALUES (84,'04-add-subscribed-flag-to-members.js','3.1','3.3');
INSERT INTO "migrations" VALUES (85,'05-add-emails-table.js','3.1','3.3');
INSERT INTO "migrations" VALUES (86,'06-add-email-permissions.js','3.1','3.3');
INSERT INTO "migrations" VALUES (87,'07-add-uuid-field-to-members.js','3.1','3.3');
INSERT INTO "migrations" VALUES (88,'08-add-uuid-values-to-members.js','3.1','3.3');
INSERT INTO "migrations" VALUES (89,'09-add-further-email-permissions.js','3.1','3.3');
INSERT INTO "migrations" VALUES (90,'10-add-email-error-data-column.js','3.1','3.3');
INSERT INTO "migrations" VALUES (91,'01-add-cancel-at-period-end-to-subscriptions.js','3.2','3.3');
INSERT INTO "posts" VALUES ('6072694359ab05118c755223','ce3a4b7a-21e8-4e27-a344-cb145906899e','Creating a custom theme','themes','{"version":"0.3.1","atoms":[["soft-return","",{}]],"cards":[["image",{"src":"https://static.ghost.org/v3.0.0/images/theme-marketplace.png","caption":"Anyone can write a completely custom Ghost theme with some solid knowledge of HTML and CSS","alt":"Ghost theme marketplace screenshot"}]],"markups":[["a",["href","https://ghost.org/marketplace/"]],["code"],["a",["href","https://github.com/TryGhost/Casper"]],["a",["href","https://ghost.org/docs/api/handlebars-themes/"]],["a",["href","https://github.com/TryGhost/Starter/"]],["strong"],["a",["href","https://forum.ghost.org/c/themes"]]],"sections":[[1,"h2",[[0,[],0,"Ghost themes"]]],[1,"p",[[0,[],0,"Ghost comes with a default theme called Casper, which is designed to be a clean, readable publication layout and can be easily adapted for most purposes."]]],[1,"p",[[0,[],0,"If you need something a little more customised, it''s entirely possible to build on top of existing open source themes, or to build your own from scratch. Rather than giving you a few basic settings which act as a poor proxy for code, we just let you write code."]]],[1,"h2",[[0,[],0,"Marketplace"]]],[1,"p",[[0,[],0,"There are a huge range of both free and premium pre-built themes which you can download from the "],[0,[0],1,"Ghost Theme Marketplace"],[0,[],0,":"]]],[10,0],[1,"h2",[[0,[],0,"Theme development"]]],[1,"p",[[0,[],0,"Ghost themes are written with a templating language called handlebars, which has a set of dynamic helpers to insert your data into template files. For example: "],[0,[1],1,"{{author.name}}"],[0,[],0," outputs the name of the current author."]]],[1,"p",[[0,[],0,"The best way to learn how to write your own Ghost theme is to have a look at "],[0,[2],1,"the source code for Casper"],[0,[],0,", which is heavily commented and should give you a sense of how everything fits together."],[1,[],0,0]]],[3,"ul",[[[0,[1],1,"default.hbs"],[0,[],0," is the main template file, all contexts will load inside this file unless specifically told to use a different template."]],[[0,[1],1,"post.hbs"],[0,[],0," is the file used in the context of viewing a post."]],[[0,[1],1,"index.hbs"],[0,[],0," is the file u"]],[[0,[],0,"cused in the context of viewing the home page."]],[[0,[],0,"and so on"]]]],[1,"p",[[0,[],0,"We''ve got "],[0,[3],1,"full and extensive theme documentation"],[0,[],0," which outlines every template file, context and helper that you can use. You can also get started with our useful "],[0,[4],1,"starter theme"],[0,[],0,", which includes the most common foundations and components required to build your own theme."]]],[1,"blockquote",[[0,[],0,"If you want to chat with other people making Ghost themes to get any advice or help, there''s also a "],[0,[5],1,"themes"],[0,[],0," section on our "],[0,[6],1,"public Ghost forum"],[0,[],0,"."]]]]}','<h2 id="ghost-themes">Ghost themes</h2><p>Ghost comes with a default theme called Casper, which is designed to be a clean, readable publication layout and can be easily adapted for most purposes.</p><p>If you need something a little more customised, it''s entirely possible to build on top of existing open source themes, or to build your own from scratch. Rather than giving you a few basic settings which act as a poor proxy for code, we just let you write code.</p><h2 id="marketplace">Marketplace</h2><p>There are a huge range of both free and premium pre-built themes which you can download from the <a href="https://ghost.org/marketplace/">Ghost Theme Marketplace</a>:</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="https://static.ghost.org/v3.0.0/images/theme-marketplace.png" class="kg-image" alt="Ghost theme marketplace screenshot"><figcaption>Anyone can write a completely custom Ghost theme with some solid knowledge of HTML and CSS</figcaption></figure><h2 id="theme-development">Theme development</h2><p>Ghost themes are written with a templating language called handlebars, which has a set of dynamic helpers to insert your data into template files. For example: <code>{{author.name}}</code> outputs the name of the current author.</p><p>The best way to learn how to write your own Ghost theme is to have a look at <a href="https://github.com/TryGhost/Casper">the source code for Casper</a>, which is heavily commented and should give you a sense of how everything fits together.<br></p><ul><li><code>default.hbs</code> is the main template file, all contexts will load inside this file unless specifically told to use a different template.</li><li><code>post.hbs</code> is the file used in the context of viewing a post.</li><li><code>index.hbs</code> is the file u</li><li>cused in the context of viewing the home page.</li><li>and so on</li></ul><p>We''ve got <a href="https://ghost.org/docs/api/handlebars-themes/">full and extensive theme documentation</a> which outlines every template file, context and helper that you can use. You can also get started with our useful <a href="https://github.com/TryGhost/Starter/">starter theme</a>, which includes the most common foundations and components required to build your own theme.</p><blockquote>If you want to chat with other people making Ghost themes to get any advice or help, there''s also a <strong>themes</strong> section on our <a href="https://forum.ghost.org/c/themes">public Ghost forum</a>.</blockquote>','6072694359ab05118c755223','Ghost themes
Ghost comes with a default theme called Casper, which is designed to be a clean,
readable publication layout and can be easily adapted for most purposes.

If you need something a little more customised, it''s entirely possible to build
on top of existing open source themes, or to build your own from scratch. Rather
than giving you a few basic settings which act as a poor proxy for code, we just
let you write code.

Marketplace
There are a huge range of both free and premium pre-built themes which you can
download from the Ghost Theme Marketplace [https://ghost.org/marketplace/]:

Anyone can write a completely custom Ghost theme with some solid knowledge of
HTML and CSSTheme development
Ghost themes are written with a templating language called handlebars, which has
a set of dynamic helpers to insert your data into template files. For example: 
{{author.name}} outputs the name of the current author.

The best way to learn how to write your own Ghost theme is to have a look at 
the
source code for Casper [https://github.com/TryGhost/Casper], which is heavily
commented and should give you a sense of how everything fits together.


 * default.hbs is the main template file, all contexts will load inside this
   file unless specifically told to use a different template.
 * post.hbs is the file used in the context of viewing a post.
 * index.hbs is the file u
 * cused in the context of viewing the home page.
 * and so on

We''ve got full and extensive theme documentation
[https://ghost.org/docs/api/handlebars-themes/] which outlines every template
file, context and helper that you can use. You can also get started with our
useful starter theme [https://github.com/TryGhost/Starter/], which includes the
most common foundations and components required to build your own theme.

> If you want to chat with other people making Ghost themes to get any advice or
help, there''s also a themes section on our public Ghost forum
[https://forum.ghost.org/c/themes].','https://static.ghost.org/v3.0.0/images/creating-a-custom-theme.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','Ghost comes with a beautiful default theme designed for publishers which can easily be adapted for most purposes, or you can build a custom theme to suit your needs.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694359ab05118c755225','21ce896b-98f9-4da8-8c43-7b6ef0a47301','Apps & integrations','apps-integrations','{"version":"0.3.1","atoms":[],"cards":[["image",{"src":"https://static.ghost.org/v3.0.0/images/integrations-icons.png","cardWidth":"full"}],["markdown",{"markdown":"<script src=\"https://zapier.com/apps/embed/widget.js?services=Ghost&container=true&limit=8\"></script>\n"}],["image",{"src":"https://static.ghost.org/v3.0.0/images/integrations-and-webhooks-in-ghost.png","alt":"Screenshot of custom integrations with webhooks in Ghost Admin","cardWidth":""}]],"markups":[["a",["href","https://ghost.org/integrations/"]],["a",["href","https://zapier.com"]],["strong"],["a",["href","https://ghost.org/docs/api/"]],["a",["href","/themes/"]]],"sections":[[1,"h2",[[0,[],0,"Work with your existing tools"]]],[1,"p",[[0,[],0,"It''s possible to connect your Ghost site to hundreds of the most popular apps and tools using integrations that take no more than a few minutes to setup."]]],[1,"p",[[0,[],0,"Whether you need to automate workflows, connect your email list, build a community or embed products from your ecommerce store, our "],[0,[0],1,"integrations library"],[0,[],0," has got it all covered with hundreds of tutorials."]]],[10,0],[1,"h2",[[0,[],0,"Zapier"]]],[1,"p",[[0,[],0,"On top of this, you can connect your Ghost site to more than 1,000 external services using the official integration with "],[0,[1],1,"Zapier"],[0,[],0,"."]]],[1,"p",[[0,[],0,"Zapier sets up automations with Triggers and Actions, which allows you to create and customise a wide range of connected applications."]]],[1,"blockquote",[[0,[2],1,"Example"],[0,[],0,": When someone new subscribes to a newsletter on a Ghost site (Trigger) then the contact information is automatically pushed into MailChimp (Action)."]]],[1,"p",[[0,[2],1,"Here are the most popular Ghost<>Zapier automation templates:"],[0,[],0," "]]],[10,1],[1,"h2",[[0,[],0,"Custom integrations"]]],[1,"p",[[0,[],0,"At the heart of Ghost sits a robust JSON API – designed to create, manage and retrieve content with ease. "]]],[1,"p",[[0,[],0,"It''s possible to create custom Ghost integrations with dedicated API keys and webhooks from the Integrations page within Ghost Admin. "]]],[10,2],[1,"p",[[0,[],0,"Beyond that, the API allows you to build entirely custom publishing apps. You can send content from your favourite desktop editor, build a custom interface for handling editorial workflow or use Ghost as a full headless CMS with a custom front-end."]]],[1,"p",[[0,[],0,"The Ghost API is "],[0,[3],1,"thoroughly documented"],[0,[],0," and straightforward to work with for developers of almost any level. "]]],[1,"h2",[[0,[],0,"Final step: Themes"]]],[1,"p",[[0,[],0,"Alright, on to the last post in our welcome-series! If you''re curious about creating your own Ghost theme from scratch, "],[0,[4],1,"find out how that works"],[0,[],0,"."]]]]}','<h2 id="work-with-your-existing-tools">Work with your existing tools</h2><p>It''s possible to connect your Ghost site to hundreds of the most popular apps and tools using integrations that take no more than a few minutes to setup.</p><p>Whether you need to automate workflows, connect your email list, build a community or embed products from your ecommerce store, our <a href="https://ghost.org/integrations/">integrations library</a> has got it all covered with hundreds of tutorials.</p><figure class="kg-card kg-image-card kg-width-full"><img src="https://static.ghost.org/v3.0.0/images/integrations-icons.png" class="kg-image"></figure><h2 id="zapier">Zapier</h2><p>On top of this, you can connect your Ghost site to more than 1,000 external services using the official integration with <a href="https://zapier.com">Zapier</a>.</p><p>Zapier sets up automations with Triggers and Actions, which allows you to create and customise a wide range of connected applications.</p><blockquote><strong>Example</strong>: When someone new subscribes to a newsletter on a Ghost site (Trigger) then the contact information is automatically pushed into MailChimp (Action).</blockquote><p><strong>Here are the most popular Ghost&lt;&gt;Zapier automation templates:</strong> </p><!--kg-card-begin: markdown--><script src="https://zapier.com/apps/embed/widget.js?services=Ghost&container=true&limit=8"></script>
<!--kg-card-end: markdown--><h2 id="custom-integrations">Custom integrations</h2><p>At the heart of Ghost sits a robust JSON API – designed to create, manage and retrieve content with ease. </p><p>It''s possible to create custom Ghost integrations with dedicated API keys and webhooks from the Integrations page within Ghost Admin. </p><figure class="kg-card kg-image-card"><img src="https://static.ghost.org/v3.0.0/images/integrations-and-webhooks-in-ghost.png" class="kg-image" alt="Screenshot of custom integrations with webhooks in Ghost Admin"></figure><p>Beyond that, the API allows you to build entirely custom publishing apps. You can send content from your favourite desktop editor, build a custom interface for handling editorial workflow or use Ghost as a full headless CMS with a custom front-end.</p><p>The Ghost API is <a href="https://ghost.org/docs/api/">thoroughly documented</a> and straightforward to work with for developers of almost any level. </p><h2 id="final-step-themes">Final step: Themes</h2><p>Alright, on to the last post in our welcome-series! If you''re curious about creating your own Ghost theme from scratch, <a href="/themes/">find out how that works</a>.</p>','6072694359ab05118c755225','Work with your existing tools
It''s possible to connect your Ghost site to hundreds of the most popular apps
and tools using integrations that take no more than a few minutes to setup.

Whether you need to automate workflows, connect your email list, build a
community or embed products from your ecommerce store, our integrations library
[https://ghost.org/integrations/] has got it all covered with hundreds of
tutorials.

Zapier
On top of this, you can connect your Ghost site to more than 1,000 external
services using the official integration with Zapier [https://zapier.com].

Zapier sets up automations with Triggers and Actions, which allows you to create
and customise a wide range of connected applications.

> Example: When someone new subscribes to a newsletter on a Ghost site (Trigger)
then the contact information is automatically pushed into MailChimp (Action).
Here are the most popular Ghost<>Zapier automation templates: 

Custom integrations
At the heart of Ghost sits a robust JSON API – designed to create, manage and
retrieve content with ease. 

It''s possible to create custom Ghost integrations with dedicated API keys and
webhooks from the Integrations page within Ghost Admin. 

Beyond that, the API allows you to build entirely custom publishing apps. You
can send content from your favourite desktop editor, build a custom interface
for handling editorial workflow or use Ghost as a full headless CMS with a
custom front-end.

The Ghost API is thoroughly documented [https://ghost.org/docs/api/] and
straightforward to work with for developers of almost any level. 

Final step: Themes
Alright, on to the last post in our welcome-series! If you''re curious about
creating your own Ghost theme from scratch, find out how that works [/themes/].','https://static.ghost.org/v3.0.0/images/app-integrations.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','2021-04-11 03:13:08','1','Work with all your favourite apps and tools or create your own custom integrations using the Ghost API.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694359ab05118c755227','69656c22-26bd-4710-a379-8c33426a9f74','Organising your content','organising-content','{"version":"0.3.1","atoms":[["soft-return","",{}]],"cards":[],"markups":[["code"],["em"],["strong"],["a",["href","https://ghost.org/docs/api/handlebars-themes/"]],["a",["href","http://yaml.org/spec/1.2/spec.html","rel","noreferrer nofollow noopener"]],["a",["href","https://ghost.org/docs/api/handlebars-themes/routing/"]],["a",["href","/apps-integrations/"]]],"sections":[[1,"h2",[[0,[],0,"Sensible tagging"]]],[1,"p",[[0,[],0,"You can think of tags like Gmail labels. By tagging posts with one or more keyword, you can organise articles into buckets of related content."]]],[1,"p",[[0,[],0,"When you create content for your publication you can assign tags to help differentiate between categories of content. "]]],[1,"p",[[0,[],0,"For example you may tag some content with News and other content with Podcast, which would create two distinct categories of content listed on "],[0,[0],1,"/tag/news/"],[0,[],0," and "],[0,[0],1,"/tag/podcast/"],[0,[],0,", respectively."]]],[1,"p",[[0,[],0,"If you tag a post with both "],[0,[0],1,"News"],[0,[],0," "],[0,[1],1,"and"],[0,[],0," "],[0,[0],1,"Podcast"],[0,[],0," - then it appears in both sections. Tag archives are like dedicated home-pages for each category of content that you have. They have their own pages, their own RSS feeds, and can support their own cover images and meta data."]]],[1,"h3",[[0,[],0,"The primary tag"]]],[1,"p",[[0,[],0,"Inside the Ghost editor, you can drag and drop tags into a specific order. The first tag in the list is always given the most importance, and some themes will only display the primary tag (the first tag in the list) by default. "]]],[1,"blockquote",[[0,[1,2],1,"News"],[0,[],1,", Technology, Startup"]]],[1,"p",[[0,[],0,"So you can add the most important tag which you want to show up in your theme, but also add related tags which are less important."]]],[1,"h3",[[0,[],0,"Private tags"]]],[1,"p",[[0,[],0,"Sometimes you may want to assign a post a specific tag, but you don''t necessarily want that tag appearing in the theme or creating an archive page. In Ghost, hashtags are private and can be used for special styling."]]],[1,"p",[[0,[],0,"For example, if you sometimes publish posts with video content - you might want your theme to adapt and get rid of the sidebar for these posts, to give more space for an embedded video to fill the screen. In this case, you could use private tags to tell your theme what to do."]]],[1,"blockquote",[[0,[1,2],1,"News"],[0,[],1,", #video"]]],[1,"p",[[0,[],0,"Here, the theme would assign the post publicly displayed tags of News - but it would also keep a private record of the post being tagged with #video. In your theme, you could then look for private tags conditionally and give them special formatting. "]]],[1,"blockquote",[[0,[1],0,"You can find documentation for theme development techniques like this and many more over on Ghost''s extensive "],[0,[3],1,"theme docs"],[0,[],1,"."]]],[1,"h2",[[0,[],0,"Dynamic routing"]]],[1,"p",[[0,[],0,"Dynamic routing gives you the ultimate freedom to build a custom publication to suit your needs. Routes are rules that map URL patterns to your content and templates. "]]],[1,"p",[[0,[],0,"You may not want content tagged with "],[0,[0],1,"News"],[0,[],0," to exist on: "],[0,[0],1,"example.com/tag/news"],[0,[],0,". Instead, you want it to exist on "],[0,[0],1,"example.com/news"],[0,[],0," ."]]],[1,"p",[[0,[],0,"In this case you can use dynamic routes to create customised collections of content on your site. It''s also possible to use multiple templates in your theme to render each content type differently."]]],[1,"p",[[0,[],0,"There are lots of use cases for dynamic routing with Ghost, here are a few common examples: "]]],[3,"ul",[[[0,[],0,"Setting a custom home page with its own template"]],[[0,[],0,"Having separate content hubs for blog and podcast, that render differently, and have custom RSS feeds to support two types of content"]],[[0,[],0,"Creating a founders column as a unique view, by filtering content created by specific authors"]],[[0,[],0,"Including dates in permalinks for your posts"]],[[0,[],0,"Setting posts to have a URL relative to their primary tag like "],[0,[0],1,"example.com/europe/story-title/"],[1,[],0,0]]]],[1,"blockquote",[[0,[1],0,"Dynamic routing can be configured in Ghost using "],[0,[4],1,"YAML"],[0,[],0," files. Read our dynamic routing "],[0,[5],1,"documentation"],[0,[],1," for further details."]]],[1,"h2",[[0,[],0,"Next: Apps & Integrations"]]],[1,"p",[[0,[],0,"Work with all your favourite apps and tools using our "],[0,[6],1,"integrations"],[0,[],0,", or create your own custom integrations with webhooks."]]],[1,"p",[]]]}','<h2 id="sensible-tagging">Sensible tagging</h2><p>You can think of tags like Gmail labels. By tagging posts with one or more keyword, you can organise articles into buckets of related content.</p><p>When you create content for your publication you can assign tags to help differentiate between categories of content. </p><p>For example you may tag some content with News and other content with Podcast, which would create two distinct categories of content listed on <code>/tag/news/</code> and <code>/tag/podcast/</code>, respectively.</p><p>If you tag a post with both <code>News</code> <em>and</em> <code>Podcast</code> - then it appears in both sections. Tag archives are like dedicated home-pages for each category of content that you have. They have their own pages, their own RSS feeds, and can support their own cover images and meta data.</p><h3 id="the-primary-tag">The primary tag</h3><p>Inside the Ghost editor, you can drag and drop tags into a specific order. The first tag in the list is always given the most importance, and some themes will only display the primary tag (the first tag in the list) by default. </p><blockquote><em><strong>News</strong>, Technology, Startup</em></blockquote><p>So you can add the most important tag which you want to show up in your theme, but also add related tags which are less important.</p><h3 id="private-tags">Private tags</h3><p>Sometimes you may want to assign a post a specific tag, but you don''t necessarily want that tag appearing in the theme or creating an archive page. In Ghost, hashtags are private and can be used for special styling.</p><p>For example, if you sometimes publish posts with video content - you might want your theme to adapt and get rid of the sidebar for these posts, to give more space for an embedded video to fill the screen. In this case, you could use private tags to tell your theme what to do.</p><blockquote><em><strong>News</strong>, #video</em></blockquote><p>Here, the theme would assign the post publicly displayed tags of News - but it would also keep a private record of the post being tagged with #video. In your theme, you could then look for private tags conditionally and give them special formatting. </p><blockquote><em>You can find documentation for theme development techniques like this and many more over on Ghost''s extensive <a href="https://ghost.org/docs/api/handlebars-themes/">theme docs</a>.</em></blockquote><h2 id="dynamic-routing">Dynamic routing</h2><p>Dynamic routing gives you the ultimate freedom to build a custom publication to suit your needs. Routes are rules that map URL patterns to your content and templates. </p><p>You may not want content tagged with <code>News</code> to exist on: <code>example.com/tag/news</code>. Instead, you want it to exist on <code>example.com/news</code> .</p><p>In this case you can use dynamic routes to create customised collections of content on your site. It''s also possible to use multiple templates in your theme to render each content type differently.</p><p>There are lots of use cases for dynamic routing with Ghost, here are a few common examples: </p><ul><li>Setting a custom home page with its own template</li><li>Having separate content hubs for blog and podcast, that render differently, and have custom RSS feeds to support two types of content</li><li>Creating a founders column as a unique view, by filtering content created by specific authors</li><li>Including dates in permalinks for your posts</li><li>Setting posts to have a URL relative to their primary tag like <code>example.com/europe/story-title/</code><br></li></ul><blockquote><em>Dynamic routing can be configured in Ghost using <a href="http://yaml.org/spec/1.2/spec.html" rel="noreferrer nofollow noopener">YAML</a> files. Read our dynamic routing <a href="https://ghost.org/docs/api/handlebars-themes/routing/">documentation</a> for further details.</em></blockquote><h2 id="next-apps-integrations">Next: Apps &amp; Integrations</h2><p>Work with all your favourite apps and tools using our <a href="/apps-integrations/">integrations</a>, or create your own custom integrations with webhooks.</p>','6072694359ab05118c755227','Sensible tagging
You can think of tags like Gmail labels. By tagging posts with one or more
keyword, you can organise articles into buckets of related content.

When you create content for your publication you can assign tags to help
differentiate between categories of content. 

For example you may tag some content with News and other content with Podcast,
which would create two distinct categories of content listed on /tag/news/ and 
/tag/podcast/, respectively.

If you tag a post with both News and Podcast - then it appears in both sections.
Tag archives are like dedicated home-pages for each category of content that you
have. They have their own pages, their own RSS feeds, and can support their own
cover images and meta data.

The primary tag
Inside the Ghost editor, you can drag and drop tags into a specific order. The
first tag in the list is always given the most importance, and some themes will
only display the primary tag (the first tag in the list) by default. 

> News, Technology, Startup
So you can add the most important tag which you want to show up in your theme,
but also add related tags which are less important.

Private tags
Sometimes you may want to assign a post a specific tag, but you don''t
necessarily want that tag appearing in the theme or creating an archive page. In
Ghost, hashtags are private and can be used for special styling.

For example, if you sometimes publish posts with video content - you might want
your theme to adapt and get rid of the sidebar for these posts, to give more
space for an embedded video to fill the screen. In this case, you could use
private tags to tell your theme what to do.

> News, #video
Here, the theme would assign the post publicly displayed tags of News - but it
would also keep a private record of the post being tagged with #video. In your
theme, you could then look for private tags conditionally and give them special
formatting. 

> You can find documentation for theme development techniques like this and many
more over on Ghost''s extensive theme docs
[https://ghost.org/docs/api/handlebars-themes/].
Dynamic routing
Dynamic routing gives you the ultimate freedom to build a custom publication to
suit your needs. Routes are rules that map URL patterns to your content and
templates. 

You may not want content tagged with News to exist on: example.com/tag/news.
Instead, you want it to exist on example.com/news .

In this case you can use dynamic routes to create customised collections of
content on your site. It''s also possible to use multiple templates in your theme
to render each content type differently.

There are lots of use cases for dynamic routing with Ghost, here are a few
common examples: 

 * Setting a custom home page with its own template
 * Having separate content hubs for blog and podcast, that render differently,
   and have custom RSS feeds to support two types of content
 * Creating a founders column as a unique view, by filtering content created by
   specific authors
 * Including dates in permalinks for your posts
 * Setting posts to have a URL relative to their primary tag like 
   example.com/europe/story-title/
   

> Dynamic routing can be configured in Ghost using YAML
[http://yaml.org/spec/1.2/spec.html] files. Read our dynamic routing 
documentation [https://ghost.org/docs/api/handlebars-themes/routing/] for
further details.
Next: Apps & Integrations
Work with all your favourite apps and tools using our integrations
[/apps-integrations/], or create your own custom integrations with webhooks.','https://static.ghost.org/v3.0.0/images/organising-your-content.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','2021-04-11 03:13:09','1','Ghost has a flexible organisational taxonomy called tags and the ability to create custom site structures using dynamic routes.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694359ab05118c755229','a7249ab8-b9d6-4b87-8281-5726860727d7','Managing admin settings','admin-settings','{"version":"0.3.1","atoms":[["soft-return","",{}],["soft-return","",{}],["soft-return","",{}],["soft-return","",{}],["soft-return","",{}],["soft-return","",{}],["soft-return","",{}]],"cards":[["image",{"src":"https://static.ghost.org/v1.0.0/images/private.png"}]],"markups":[["em"],["strong"],["a",["href","https://ghost.org/pricing/"]],["a",["href","/organising-content/"]]],"sections":[[1,"h2",[[0,[],0,"Make your site private"]]],[1,"p",[[0,[],0,"If you''ve got a publication that you don''t want the world to see yet because it''s not ready to launch, you can hide your Ghost site behind a basic shared pass-phrase."]]],[1,"p",[[0,[],0,"You can toggle this preference on at the bottom of Ghost''s General Settings:"]]],[10,0],[1,"p",[[0,[],0,"Ghost will give you a short, randomly generated pass-phrase which you can share with anyone who needs access to the site while you''re working on it. While this setting is enabled, all search engine optimisation features will be switched off to help keep your site under the radar."]]],[1,"p",[[0,[],0,"Do remember though, this is "],[0,[0],1,"not"],[0,[],0," secure authentication. You shouldn''t rely on this feature for protecting important private data. It''s just a simple, shared pass-phrase for some very basic privacy."]]],[1,"h2",[[0,[],0,"Invite your team "]]],[1,"p",[[0,[],0,"Ghost has a number of different user roles for your team:"]]],[1,"p",[[0,[1],1,"Contributors"],[1,[],0,0],[0,[],0,"This is the base user level in Ghost. Contributors can create and edit their own draft posts, but they are unable to edit drafts of others or publish posts. Contributors are "],[0,[1],1,"untrusted"],[0,[],0," users with the most basic access to your publication."]]],[1,"p",[[0,[1],1,"Authors"],[1,[],0,1],[0,[],0,"Authors are the 2nd user level in Ghost. Authors can write, edit  and publish their own posts. Authors are "],[0,[1],1,"trusted"],[0,[],0," users. If you don''t trust users to be allowed to publish their own posts, they should be set as Contributors."]]],[1,"p",[[0,[1],1,"Editors"],[1,[],0,2],[0,[],0,"Editors are the 3rd user level in Ghost. Editors can do everything that an Author can do, but they can also edit and publish the posts of others - as well as their own. Editors can also invite new Contributors & Authors to the site."]]],[1,"p",[[0,[1],1,"Administrators"],[1,[],0,3],[0,[],0,"The top user level in Ghost is Administrator. Again, administrators can do everything that Authors and Editors can do, but they can also edit all site settings and data, not just content. Additionally, administrators have full access to invite, manage or remove any other user of the site."],[1,[],0,4],[1,[],0,5],[0,[1],1,"The Owner"],[1,[],0,6],[0,[],0,"There is only ever one owner of a Ghost site. The owner is a special user which has all the same permissions as an Administrator, but with two exceptions: The Owner can never be deleted. And in some circumstances the owner will have access to additional special settings if applicable. For example: billing details, if using "],[0,[2,1],2,"Ghost(Pro)"],[0,[],0,"."]]],[1,"blockquote",[[0,[0],1,"It''s a good idea to ask all of your users to fill out their user profiles, including bio and social links. These will populate rich structured data for posts and generally create more opportunities for themes to fully populate their design."]]],[1,"h2",[[0,[],0,"Next: Organising content"]]],[1,"p",[[0,[],0,"Find out how to "],[0,[3],1,"organise your content"],[0,[],0," with sensible tags and authors, or for more advanced configurations, how to create custom content structures using dynamic routing."]]]]}','<h2 id="make-your-site-private">Make your site private</h2><p>If you''ve got a publication that you don''t want the world to see yet because it''s not ready to launch, you can hide your Ghost site behind a basic shared pass-phrase.</p><p>You can toggle this preference on at the bottom of Ghost''s General Settings:</p><figure class="kg-card kg-image-card"><img src="https://static.ghost.org/v1.0.0/images/private.png" class="kg-image"></figure><p>Ghost will give you a short, randomly generated pass-phrase which you can share with anyone who needs access to the site while you''re working on it. While this setting is enabled, all search engine optimisation features will be switched off to help keep your site under the radar.</p><p>Do remember though, this is <em>not</em> secure authentication. You shouldn''t rely on this feature for protecting important private data. It''s just a simple, shared pass-phrase for some very basic privacy.</p><h2 id="invite-your-team">Invite your team </h2><p>Ghost has a number of different user roles for your team:</p><p><strong>Contributors</strong><br>This is the base user level in Ghost. Contributors can create and edit their own draft posts, but they are unable to edit drafts of others or publish posts. Contributors are <strong>untrusted</strong> users with the most basic access to your publication.</p><p><strong>Authors</strong><br>Authors are the 2nd user level in Ghost. Authors can write, edit  and publish their own posts. Authors are <strong>trusted</strong> users. If you don''t trust users to be allowed to publish their own posts, they should be set as Contributors.</p><p><strong>Editors</strong><br>Editors are the 3rd user level in Ghost. Editors can do everything that an Author can do, but they can also edit and publish the posts of others - as well as their own. Editors can also invite new Contributors &amp; Authors to the site.</p><p><strong>Administrators</strong><br>The top user level in Ghost is Administrator. Again, administrators can do everything that Authors and Editors can do, but they can also edit all site settings and data, not just content. Additionally, administrators have full access to invite, manage or remove any other user of the site.<br><br><strong>The Owner</strong><br>There is only ever one owner of a Ghost site. The owner is a special user which has all the same permissions as an Administrator, but with two exceptions: The Owner can never be deleted. And in some circumstances the owner will have access to additional special settings if applicable. For example: billing details, if using <a href="https://ghost.org/pricing/"><strong>Ghost(Pro)</strong></a>.</p><blockquote><em>It''s a good idea to ask all of your users to fill out their user profiles, including bio and social links. These will populate rich structured data for posts and generally create more opportunities for themes to fully populate their design.</em></blockquote><h2 id="next-organising-content">Next: Organising content</h2><p>Find out how to <a href="/organising-content/">organise your content</a> with sensible tags and authors, or for more advanced configurations, how to create custom content structures using dynamic routing.</p>','6072694359ab05118c755229','Make your site private
If you''ve got a publication that you don''t want the world to see yet because
it''s not ready to launch, you can hide your Ghost site behind a basic shared
pass-phrase.

You can toggle this preference on at the bottom of Ghost''s General Settings:

Ghost will give you a short, randomly generated pass-phrase which you can share
with anyone who needs access to the site while you''re working on it. While this
setting is enabled, all search engine optimisation features will be switched off
to help keep your site under the radar.

Do remember though, this is not secure authentication. You shouldn''t rely on
this feature for protecting important private data. It''s just a simple, shared
pass-phrase for some very basic privacy.

Invite your team 
Ghost has a number of different user roles for your team:

Contributors
This is the base user level in Ghost. Contributors can create and edit their own
draft posts, but they are unable to edit drafts of others or publish posts.
Contributors are untrusted users with the most basic access to your publication.

Authors
Authors are the 2nd user level in Ghost. Authors can write, edit  and publish
their own posts. Authors are trusted users. If you don''t trust users to be
allowed to publish their own posts, they should be set as Contributors.

Editors
Editors are the 3rd user level in Ghost. Editors can do everything that an
Author can do, but they can also edit and publish the posts of others - as well
as their own. Editors can also invite new Contributors & Authors to the site.

Administrators
The top user level in Ghost is Administrator. Again, administrators can do
everything that Authors and Editors can do, but they can also edit all site
settings and data, not just content. Additionally, administrators have full
access to invite, manage or remove any other user of the site.

The Owner
There is only ever one owner of a Ghost site. The owner is a special user which
has all the same permissions as an Administrator, but with two exceptions: The
Owner can never be deleted. And in some circumstances the owner will have access
to additional special settings if applicable. For example: billing details, if
using Ghost(Pro) [https://ghost.org/pricing/].

> It''s a good idea to ask all of your users to fill out their user profiles,
including bio and social links. These will populate rich structured data for
posts and generally create more opportunities for themes to fully populate their
design.
Next: Organising content
Find out how to organise your content [/organising-content/] with sensible tags
and authors, or for more advanced configurations, how to create custom content
structures using dynamic routing.','https://static.ghost.org/v3.0.0/images/admin-settings.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','2021-04-11 03:13:10','1','There are a couple of things to do next while you''re getting set up: making your site private and inviting your team.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694359ab05118c75522b','3d04c0eb-7974-4552-9a2a-8c4ee1df6e29','Publishing options','publishing-options','{"version":"0.3.1","atoms":[],"cards":[["code",{"code":"{\n    \"@context\": \"https://schema.org\",\n    \"@type\": \"Article\",\n    \"publisher\": {\n        \"@type\": \"Organization\",\n        \"name\": \"Publishing options\",\n        \"logo\": \"https://static.ghost.org/ghost-logo.svg\"\n    },\n    \"author\": {\n        \"@type\": \"Person\",\n        \"name\": \"Ghost\",\n        \"url\": \"http://demo.ghost.io/author/ghost/\",\n        \"sameAs\": []\n    },\n    \"headline\": \"Publishing options\",\n    \"url\": \"http://demo.ghost.io/publishing-options\",\n    \"datePublished\": \"2018-08-08T11:44:00.000Z\",\n    \"dateModified\": \"2018-08-09T12:06:21.000Z\",\n    \"keywords\": \"Getting Started\",\n    \"description\": \"The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.\",\n    }\n}\n    "}]],"markups":[["strong"],["a",["href","https://schema.org/"]],["a",["href","https://search.google.com/structured-data/testing-tool","rel","noreferrer nofollow noopener"]],["a",["href","/admin-settings/"]]],"sections":[[1,"h2",[[0,[],0,"Distribute your content"]]],[1,"p",[[0,[],0,"Access the post settings menu by clicking the settings icon in the top right hand corner of the editor and discover everything you need to get your content ready for publishing. This is where you can edit things like tags, post URL, publish date and custom meta data."]]],[1,"h2",[[0,[],0,"Feature images, URL & excerpts"]]],[1,"p",[[0,[],0,"Insert your post feature image from the very top of the post settings menu. Consider resizing or optimising your image first to ensure it''s an appropriate size. Below this, you can set your post URL, publish date and add a custom excerpt."]]],[1,"h2",[[0,[],0,"Tags & authors"]]],[1,"p",[[0,[],0,"You can easily add multiple tags and authors to any post to filter and organise the relationships between your content in Ghost."]]],[1,"h2",[[0,[],0,"Structured data & SEO"]]],[1,"p",[[0,[],0,"There''s no need to hard code your meta data. In fact, Ghost will generate default meta data automatically using the content in your post."]]],[1,"p",[[0,[],0,"Alternatively, you can override this by adding a custom meta title and description, as well as unique information for social media sharing cards on Facebook and Twitter."]]],[1,"p",[[0,[],0,"It''s also possible to set custom canonicals, which is useful for guest posts or curated lists of external links."]]],[1,"p",[[0,[],0,"Ghost will automatically implement "],[0,[0],1,"structured data"],[0,[],0," for your publication using JSON-LD to further optimise your content."]]],[10,0],[1,"p",[[0,[],0,"You can test that the structured data "],[0,[1],1,"schema"],[0,[],0," on your site is working as it should using "],[0,[2],1,"Google’s structured data tool"],[0,[],0,". "]]],[1,"h2",[[0,[],0,"Code injection"]]],[1,"p",[[0,[],0,"This tool allows you to inject code on a per post or page basis, or across your entire site. This means you can modify CSS, add unique tracking codes, or add other scripts to the head or foot of your publication without making edits to your theme files. "]]],[1,"p",[[0,[0],1,"To add code site-wide"],[0,[],0,", use the code injection tool in the main admin menu. This is useful for adding a Google Analytics tracking code, or to start tracking with any other analytics tool."]]],[1,"p",[[0,[0],1,"To add code to a post or page"],[0,[],0,", use the code injection tool within the post settings menu. This is useful if you want to add art direction, scripts or styles that are only applicable to one post or page."]]],[1,"h2",[[0,[],0,"Next: Admin settings"]]],[1,"p",[[0,[],0,"Now you understand how to create and optimise content, let''s explore some "],[0,[3],1,"admin settings"],[0,[],0," so you can invite your team and start collaborating."]]]]}','<h2 id="distribute-your-content">Distribute your content</h2><p>Access the post settings menu by clicking the settings icon in the top right hand corner of the editor and discover everything you need to get your content ready for publishing. This is where you can edit things like tags, post URL, publish date and custom meta data.</p><h2 id="feature-images-url-excerpts">Feature images, URL &amp; excerpts</h2><p>Insert your post feature image from the very top of the post settings menu. Consider resizing or optimising your image first to ensure it''s an appropriate size. Below this, you can set your post URL, publish date and add a custom excerpt.</p><h2 id="tags-authors">Tags &amp; authors</h2><p>You can easily add multiple tags and authors to any post to filter and organise the relationships between your content in Ghost.</p><h2 id="structured-data-seo">Structured data &amp; SEO</h2><p>There''s no need to hard code your meta data. In fact, Ghost will generate default meta data automatically using the content in your post.</p><p>Alternatively, you can override this by adding a custom meta title and description, as well as unique information for social media sharing cards on Facebook and Twitter.</p><p>It''s also possible to set custom canonicals, which is useful for guest posts or curated lists of external links.</p><p>Ghost will automatically implement <strong>structured data</strong> for your publication using JSON-LD to further optimise your content.</p><pre><code>{
    "@context": "https://schema.org",
    "@type": "Article",
    "publisher": {
        "@type": "Organization",
        "name": "Publishing options",
        "logo": "https://static.ghost.org/ghost-logo.svg"
    },
    "author": {
        "@type": "Person",
        "name": "Ghost",
        "url": "http://demo.ghost.io/author/ghost/",
        "sameAs": []
    },
    "headline": "Publishing options",
    "url": "http://demo.ghost.io/publishing-options",
    "datePublished": "2018-08-08T11:44:00.000Z",
    "dateModified": "2018-08-09T12:06:21.000Z",
    "keywords": "Getting Started",
    "description": "The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.",
    }
}
    </code></pre><p>You can test that the structured data <a href="https://schema.org/">schema</a> on your site is working as it should using <a href="https://search.google.com/structured-data/testing-tool" rel="noreferrer nofollow noopener">Google’s structured data tool</a>. </p><h2 id="code-injection">Code injection</h2><p>This tool allows you to inject code on a per post or page basis, or across your entire site. This means you can modify CSS, add unique tracking codes, or add other scripts to the head or foot of your publication without making edits to your theme files. </p><p><strong>To add code site-wide</strong>, use the code injection tool in the main admin menu. This is useful for adding a Google Analytics tracking code, or to start tracking with any other analytics tool.</p><p><strong>To add code to a post or page</strong>, use the code injection tool within the post settings menu. This is useful if you want to add art direction, scripts or styles that are only applicable to one post or page.</p><h2 id="next-admin-settings">Next: Admin settings</h2><p>Now you understand how to create and optimise content, let''s explore some <a href="/admin-settings/">admin settings</a> so you can invite your team and start collaborating.</p>','6072694359ab05118c75522b','Distribute your content
Access the post settings menu by clicking the settings icon in the top right
hand corner of the editor and discover everything you need to get your content
ready for publishing. This is where you can edit things like tags, post URL,
publish date and custom meta data.

Feature images, URL & excerpts
Insert your post feature image from the very top of the post settings menu.
Consider resizing or optimising your image first to ensure it''s an appropriate
size. Below this, you can set your post URL, publish date and add a custom
excerpt.

Tags & authors
You can easily add multiple tags and authors to any post to filter and organise
the relationships between your content in Ghost.

Structured data & SEO
There''s no need to hard code your meta data. In fact, Ghost will generate
default meta data automatically using the content in your post.

Alternatively, you can override this by adding a custom meta title and
description, as well as unique information for social media sharing cards on
Facebook and Twitter.

It''s also possible to set custom canonicals, which is useful for guest posts or
curated lists of external links.

Ghost will automatically implement structured data for your publication using
JSON-LD to further optimise your content.

{
    "@context": "https://schema.org",
    "@type": "Article",
    "publisher": {
        "@type": "Organization",
        "name": "Publishing options",
        "logo": "https://static.ghost.org/ghost-logo.svg"
    },
    "author": {
        "@type": "Person",
        "name": "Ghost",
        "url": "http://demo.ghost.io/author/ghost/",
        "sameAs": []
    },
    "headline": "Publishing options",
    "url": "http://demo.ghost.io/publishing-options",
    "datePublished": "2018-08-08T11:44:00.000Z",
    "dateModified": "2018-08-09T12:06:21.000Z",
    "keywords": "Getting Started",
    "description": "The Ghost editor has everything you need to fully optimise your content. This is where you can add tags and authors, feature a post, or turn a post into a page.",
    }
}
    

You can test that the structured data schema [https://schema.org/] on your site
is working as it should using Google’s structured data tool
[https://search.google.com/structured-data/testing-tool]. 

Code injection
This tool allows you to inject code on a per post or page basis, or across your
entire site. This means you can modify CSS, add unique tracking codes, or add
other scripts to the head or foot of your publication without making edits to
your theme files. 

To add code site-wide, use the code injection tool in the main admin menu. This
is useful for adding a Google Analytics tracking code, or to start tracking with
any other analytics tool.

To add code to a post or page, use the code injection tool within the post
settings menu. This is useful if you want to add art direction, scripts or
styles that are only applicable to one post or page.

Next: Admin settings
Now you understand how to create and optimise content, let''s explore some admin
settings [/admin-settings/] so you can invite your team and start collaborating.','https://static.ghost.org/v3.0.0/images/publishing-options.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:07','1','2021-04-11 03:13:07','1','2021-04-11 03:13:11','1','The Ghost editor post settings menu has everything you need to fully optimise and distribute your content effectively.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694459ab05118c75522d','e3079644-eba4-49b8-b1d8-46435875f4be','Writing posts with Ghost ✍️','the-editor','{"version":"0.3.1","atoms":[],"cards":[["image",{"src":"https://static.ghost.org/v2.0.0/images/formatting-editor-demo.gif"}],["code",{"code":"<header class=\"site-header outer\">\n    <div class=\"inner\">\n        {{> \"site-nav\"}}\n    </div>\n</header>"}],["bookmark",{"type":"bookmark","url":"https://ghost.org/","metadata":{"url":"https://ghost.org","title":"Ghost: The #1 open source headless Node.js CMS","description":"The world’s most popular modern open source publishing platform. A headless Node.js CMS used by Apple, Sky News, Tinder and thousands more. MIT licensed, with 30k+ stars on Github.","author":null,"publisher":"Ghost","thumbnail":"https://ghost.org/images/meta/Ghost.png","icon":"https://ghost.org/icons/icon-512x512.png?v=188b8b6d743c6338ba2eab2e35bab4f5"}}],["image",{"src":"https://static.ghost.org/v3.0.0/images/image-sizes-ghost-editor.png"}],["gallery",{"images":[{"fileName":"gallery-sample-1.jpg","row":0,"width":6000,"height":4000,"src":"https://static.ghost.org/v3.0.0/images/gallery-sample-1.jpg"},{"fileName":"gallery-sample-2.jpg","row":0,"width":5746,"height":3831,"src":"https://static.ghost.org/v3.0.0/images/gallery-sample-2.jpg"},{"fileName":"gallery-sample-3.jpg","row":0,"width":5872,"height":3915,"src":"https://static.ghost.org/v3.0.0/images/gallery-sample-3.jpg"}]}]],"markups":[["strong"],["code"],["a",["href","/publishing-options/"]]],"sections":[[1,"h2",[[0,[],0,"Just start writing"]]],[1,"p",[[0,[],0,"Ghost has a powerful visual editor with familiar formatting options, as well as the ability to add dynamic content."]]],[1,"p",[[0,[],0,"Select your text to add formatting such as headers or to create links. Or use Markdown shortcuts to do the work for you - if that''s your thing. "]]],[10,0],[1,"h2",[[0,[],0,"Rich editing at your fingertips"]]],[1,"p",[[0,[],0,"The editor can also handle rich media objects, called "],[0,[0],1,"cards"],[0,[],0,", which can be organised and re-ordered using drag and drop. "]]],[1,"p",[[0,[],0,"You can insert a card either by clicking the  "],[0,[1],1,"+"],[0,[],0,"  button, or typing  "],[0,[1],1,"/"],[0,[],0,"  on a new line to search for a particular card. This allows you to efficiently insert"],[0,[0],1," images"],[0,[],0,", "],[0,[0],1,"markdown"],[0,[],0,", "],[0,[0],1,"html, embeds "],[0,[],0,"and more."]]],[1,"p",[[0,[0],1,"For example"],[0,[],0,":"]]],[3,"ul",[[[0,[],0,"Insert a video from YouTube directly by pasting the URL"]],[[0,[],0,"Create unique content like buttons or forms using the HTML card"]],[[0,[],0,"Need to share some code? Embed code blocks directly "]]]],[10,1],[1,"p",[[0,[],0,"It''s also possible to share links from across the web in a visual way using bookmark cards that automatically render information from a websites meta data. Paste any URL to try it out: "]]],[10,2],[1,"h2",[[0,[],0,"Working with images in posts"]]],[1,"p",[[0,[],0,"You can add images to your posts in many ways:"]]],[3,"ul",[[[0,[],0,"Upload from your computer"]],[[0,[],0,"Click and drag an image into the browser"]],[[0,[],0,"Paste directly into the editor from your clipboard"]],[[0,[],0,"Insert using a URL"]]]],[1,"h3",[[0,[],0,"Image sizes"]]],[1,"p",[[0,[],0,"Once inserted you can blend images beautifully into your content at different sizes and add captions and alt tags wherever needed."]]],[10,3],[1,"h3",[[0,[],0,"Image galleries"]]],[1,"p",[[0,[],0,"Tell visual stories using the gallery card to add up to 9 images that will display as a responsive image gallery: "]]],[10,4],[1,"h3",[[0,[],0,"Image optimisation"]]],[1,"p",[[0,[],0,"Ghost will automatically resize and optimise your images with lossless compression. Your posts will be fully optimised for the web without any extra effort on your part."]]],[1,"h2",[[0,[],0,"Next: Publishing Options"]]],[1,"p",[[0,[],0,"Once your post is looking good, you''ll want to use the "],[0,[2],1,"publishing options"],[0,[],0," to ensure it gets distributed in the right places, with custom meta data, feature images and more."]]],[1,"p",[]]]}','<h2 id="just-start-writing">Just start writing</h2><p>Ghost has a powerful visual editor with familiar formatting options, as well as the ability to add dynamic content.</p><p>Select your text to add formatting such as headers or to create links. Or use Markdown shortcuts to do the work for you - if that''s your thing. </p><figure class="kg-card kg-image-card"><img src="https://static.ghost.org/v2.0.0/images/formatting-editor-demo.gif" class="kg-image"></figure><h2 id="rich-editing-at-your-fingertips">Rich editing at your fingertips</h2><p>The editor can also handle rich media objects, called <strong>cards</strong>, which can be organised and re-ordered using drag and drop. </p><p>You can insert a card either by clicking the  <code>+</code>  button, or typing  <code>/</code>  on a new line to search for a particular card. This allows you to efficiently insert<strong> images</strong>, <strong>markdown</strong>, <strong>html, embeds </strong>and more.</p><p><strong>For example</strong>:</p><ul><li>Insert a video from YouTube directly by pasting the URL</li><li>Create unique content like buttons or forms using the HTML card</li><li>Need to share some code? Embed code blocks directly </li></ul><pre><code>&lt;header class="site-header outer"&gt;
    &lt;div class="inner"&gt;
        {{&gt; "site-nav"}}
    &lt;/div&gt;
&lt;/header&gt;</code></pre><p>It''s also possible to share links from across the web in a visual way using bookmark cards that automatically render information from a websites meta data. Paste any URL to try it out: </p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://ghost.org"><div class="kg-bookmark-content"><div class="kg-bookmark-title">Ghost: The #1 open source headless Node.js CMS</div><div class="kg-bookmark-description">The world’s most popular modern open source publishing platform. A headless Node.js CMS used by Apple, Sky News, Tinder and thousands more. MIT licensed, with 30k+ stars on Github.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://ghost.org/icons/icon-512x512.png?v=188b8b6d743c6338ba2eab2e35bab4f5"><span class="kg-bookmark-publisher">Ghost</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://ghost.org/images/meta/Ghost.png"></div></a></figure><h2 id="working-with-images-in-posts">Working with images in posts</h2><p>You can add images to your posts in many ways:</p><ul><li>Upload from your computer</li><li>Click and drag an image into the browser</li><li>Paste directly into the editor from your clipboard</li><li>Insert using a URL</li></ul><h3 id="image-sizes">Image sizes</h3><p>Once inserted you can blend images beautifully into your content at different sizes and add captions and alt tags wherever needed.</p><figure class="kg-card kg-image-card"><img src="https://static.ghost.org/v3.0.0/images/image-sizes-ghost-editor.png" class="kg-image"></figure><h3 id="image-galleries">Image galleries</h3><p>Tell visual stories using the gallery card to add up to 9 images that will display as a responsive image gallery: </p><figure class="kg-card kg-gallery-card kg-width-wide"><div class="kg-gallery-container"><div class="kg-gallery-row"><div class="kg-gallery-image"><img src="https://static.ghost.org/v3.0.0/images/gallery-sample-1.jpg" width="6000" height="4000"></div><div class="kg-gallery-image"><img src="https://static.ghost.org/v3.0.0/images/gallery-sample-2.jpg" width="5746" height="3831"></div><div class="kg-gallery-image"><img src="https://static.ghost.org/v3.0.0/images/gallery-sample-3.jpg" width="5872" height="3915"></div></div></div></figure><h3 id="image-optimisation">Image optimisation</h3><p>Ghost will automatically resize and optimise your images with lossless compression. Your posts will be fully optimised for the web without any extra effort on your part.</p><h2 id="next-publishing-options">Next: Publishing Options</h2><p>Once your post is looking good, you''ll want to use the <a href="/publishing-options/">publishing options</a> to ensure it gets distributed in the right places, with custom meta data, feature images and more.</p>','6072694459ab05118c75522d','Just start writing
Ghost has a powerful visual editor with familiar formatting options, as well as
the ability to add dynamic content.

Select your text to add formatting such as headers or to create links. Or use
Markdown shortcuts to do the work for you - if that''s your thing. 

Rich editing at your fingertips
The editor can also handle rich media objects, called cards, which can be
organised and re-ordered using drag and drop. 

You can insert a card either by clicking the+ button, or typing/ on a new line
to search for a particular card. This allows you to efficiently insert images, 
markdown, html, embeds and more.

For example:

 * Insert a video from YouTube directly by pasting the URL
 * Create unique content like buttons or forms using the HTML card
 * Need to share some code? Embed code blocks directly 

<header class="site-header outer">
    <div class="inner">
        {{> "site-nav"}}
    </div>
</header>

It''s also possible to share links from across the web in a visual way using
bookmark cards that automatically render information from a websites meta data.
Paste any URL to try it out: 

Ghost: The #1 open source headless Node.js CMSThe world’s most popular modern
open source publishing platform. A headless Node.js CMS used by Apple, Sky
News,
Tinder and thousands more. MIT licensed, with 30k+ stars on Github.Ghost
[https://ghost.org]Working with images in posts
You can add images to your posts in many ways:

 * Upload from your computer
 * Click and drag an image into the browser
 * Paste directly into the editor from your clipboard
 * Insert using a URL

Image sizes
Once inserted you can blend images beautifully into your content at different
sizes and add captions and alt tags wherever needed.

Image galleries
Tell visual stories using the gallery card to add up to 9 images that will
display as a responsive image gallery: 

Image optimisation
Ghost will automatically resize and optimise your images with lossless
compression. Your posts will be fully optimised for the web without any extra
effort on your part.

Next: Publishing Options
Once your post is looking good, you''ll want to use the publishing options
[/publishing-options/] to ensure it gets distributed in the right places, with
custom meta data, feature images and more.','https://static.ghost.org/v3.0.0/images/writing-posts-with-ghost.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:08','1','2021-04-11 03:13:08','1','2021-04-11 03:13:12','1','Discover familiar formatting options in a functional toolbar and the ability to add dynamic content seamlessly.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6072694459ab05118c75522f','7d93b8a4-d53a-4e28-b3c6-1fea07154d92','Welcome to Ghost','welcome','{"version":"0.3.1","atoms":[],"cards":[],"markups":[["strong"],["a",["href","https://ghost.org/pricing"]],["a",["href","https://github.com/TryGhost"]],["a",["href","/the-editor/"]]],"sections":[[1,"h2",[[0,[0],1,"A few things you should know"]]],[3,"ol",[[[0,[],0,"Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That''s who it works best for. "]],[[0,[],0,"The entire platform can be modified and customised to suit your needs. It''s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. "]],[]]],[1,"h2",[[0,[],0,"Behind the scenes"]]],[1,"p",[[0,[],0,"Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our "],[0,[1],1,"Ghost(Pro)"],[0,[],0," service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing."]]],[1,"p",[[0,[],0,"The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source "],[0,[2],1,"community"],[0,[],0,"."]]],[1,"h2",[[0,[],0,"Next up, the editor"]]],[1,"p",[[0,[],0,"The main thing you''ll want to read about next is probably: "],[0,[3],1,"the Ghost editor"],[0,[],0,". This is where the good stuff happens."]]],[1,"blockquote",[[0,[],0,"By the way, once you''re done reading, you can simply delete the default Ghost user from your team to remove all of these introductory posts! "]]]]}','<h2 id="a-few-things-you-should-know"><strong>A few things you should know</strong></h2><ol><li>Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That''s who it works best for. </li><li>The entire platform can be modified and customised to suit your needs. It''s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. </li><li></li></ol><h2 id="behind-the-scenes">Behind the scenes</h2><p>Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our <a href="https://ghost.org/pricing">Ghost(Pro)</a> service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing.</p><p>The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source <a href="https://github.com/TryGhost">community</a>.</p><h2 id="next-up-the-editor">Next up, the editor</h2><p>The main thing you''ll want to read about next is probably: <a href="/the-editor/">the Ghost editor</a>. This is where the good stuff happens.</p><blockquote>By the way, once you''re done reading, you can simply delete the default Ghost user from your team to remove all of these introductory posts! </blockquote>','6072694459ab05118c75522f','A few things you should know
 1. Ghost is designed for ambitious, professional publishers who want to
    actively build a business around their content. That''s who it works best
    for. 
 2. The entire platform can be modified and customised to suit your needs. It''s
    very powerful, but does require some knowledge of code. Ghost is not
    necessarily a good platform for beginners or people who just want a simple
    personal blog. 
 3. 

Behind the scenes
Ghost is made by an independent non-profit organisation called the Ghost
Foundation. We are 100% self funded by revenue from our Ghost(Pro)
[https://ghost.org/pricing] service, and every penny we make is re-invested into
funding further development of free, open source technology for modern
publishing.

The version of Ghost you are looking at right now would not have been made
possible without generous contributions from the open source community
[https://github.com/TryGhost].

Next up, the editor
The main thing you''ll want to read about next is probably: the Ghost editor
[/the-editor/]. This is where the good stuff happens.

> By the way, once you''re done reading, you can simply delete the default Ghost
user from your team to remove all of these introductory posts!','https://static.ghost.org/v3.0.0/images/welcome-to-ghost.png',0,'post','published',NULL,'public',0,'5951f5fca366002ebd5dbef7','2021-04-11 03:13:08','1','2021-04-11 17:57:19','1','2021-04-11 03:13:13','1','Welcome, it''s great to have you here.
We know that first impressions are important, so we''ve populated your new site with some initial getting started posts that will help you get familiar with everything in no time.',NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('60730f3159ab05118c755334','1e22a3d1-af7b-4d88-9d90-8a213913fafd','Prueba de Post','prueba-de-post','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Se realiza la primera prueba del postp"]]]]}','<p>Se realiza la primera prueba del postp</p>','60730f3159ab05118c755334','Se realiza la primera prueba del postp',NULL,0,'post','published',NULL,'public',0,'1','2021-04-11 15:01:05','1','2021-04-11 15:01:16','1','2021-04-11 15:01:17','1',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6073249659ab05118c755346','f3259d8e-85b6-43dd-8b11-1269eb70755a','Página de prueba inicial','pagina-de-prueba-inicial','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Prueba exploratoria para verificar el creado de la página"]]]]}','<p>Prueba exploratoria para verificar el creado de la página</p>','6073249659ab05118c755346','Prueba exploratoria para verificar el creado de la página',NULL,0,'page','published',NULL,'public',0,'1','2021-04-11 16:32:22','1','2021-04-11 16:32:41','1','2021-04-11 16:32:41','1',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6073280a59ab05118c75534d','dc4bd0fa-9958-450e-8a67-4439f1581929','Página sin contenido','pagina-sin-contenido','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',NULL,'6073280a59ab05118c75534d',NULL,NULL,0,'page','published',NULL,'public',0,'1','2021-04-11 16:47:06','1','2021-04-11 16:47:12','1','2021-04-11 16:47:12','1',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('60733a5c59ab05118c755360','375e1af6-266a-4925-9459-0800182233b4','Prueba post vacío','prueba-post-vacio','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',NULL,'60733a5c59ab05118c755360',NULL,NULL,0,'post','published',NULL,'public',0,'1','2021-04-11 18:05:16','1','2021-04-11 18:05:23','1','2021-04-11 18:05:23','1',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('60733cb359ab05118c75536f','af59184a-a5dd-4bbe-952d-bd198aa94bff','Post Movil','post-movil','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Prueba de botón More"]]]]}','<p>Prueba de botón More</p>','60733cb359ab05118c75536f','Prueba de botón More',NULL,0,'post','draft',NULL,'public',0,'1','2021-04-11 18:15:15','1','2021-04-11 18:15:28','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('6073848559ab05118c755378','b2f1c8ad-5f69-4b7a-99a0-4382301d9879','(Untitled)','untitled','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Creo post sde ejmplo "]]]]}','<p>Creo post sde ejmplo </p>','6073848559ab05118c755378','Creo post sde ejmplo',NULL,0,'post','draft',NULL,'public',0,'1','2021-04-11 23:21:41','1','2021-04-11 23:21:47','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "posts" VALUES ('607384dc59ab05118c75537e','cd76ffc2-dd9b-41d2-9f17-07e9bc6baa0f','Nuevo post','nuevo-post','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',NULL,'607384dc59ab05118c75537e',NULL,NULL,0,'post','published',NULL,'public',0,'1','2021-04-11 23:23:08','1','2021-04-11 23:23:12','1','2021-04-11 23:23:12','1',NULL,NULL,NULL,NULL,NULL);
INSERT INTO "users" VALUES ('1','Jhon Jairo Moreno Trujillo','jhon','$2a$10$U.fQUzEEADZPpSos4jCBKeQWkR8q6avKX1LZWnVM5LQ/z6zSLLmQ2','pruebas@pruebas.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{"whatsNew":{"lastSeenDate":"2021-04-05T16:01:11.000+00:00"}}','active',NULL,'public',NULL,NULL,'["getting-started"]','2021-04-11 22:49:03','2021-04-11 03:13:06','1','2021-04-11 22:49:03','1');
INSERT INTO "users" VALUES ('5951f5fca366002ebd5dbef7','Ghost','ghost','$2a$10$28tuiEqBhfS2k1vJiAUGzeN18NNr1AqIAz//d5aSaYFC3WufQQg/O','ghost-author@example.com','https://static.ghost.org/v3.0.0/images/ghost.png',NULL,'You can delete this user to remove all the welcome posts','https://ghost.org','The Internet','ghost','ghost',NULL,'active',NULL,'public',NULL,NULL,NULL,NULL,'2021-04-11 03:13:07','1','2021-04-11 03:13:07','1');
INSERT INTO "posts_authors" VALUES ('6072694359ab05118c755224','6072694359ab05118c755223','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694359ab05118c755226','6072694359ab05118c755225','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694359ab05118c755228','6072694359ab05118c755227','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694359ab05118c75522a','6072694359ab05118c755229','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694459ab05118c75522c','6072694359ab05118c75522b','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694459ab05118c75522e','6072694459ab05118c75522d','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('6072694459ab05118c755230','6072694459ab05118c75522f','5951f5fca366002ebd5dbef7',0);
INSERT INTO "posts_authors" VALUES ('60730f3159ab05118c755335','60730f3159ab05118c755334','1',0);
INSERT INTO "posts_authors" VALUES ('6073249659ab05118c755347','6073249659ab05118c755346','1',0);
INSERT INTO "posts_authors" VALUES ('6073280a59ab05118c75534e','6073280a59ab05118c75534d','1',0);
INSERT INTO "posts_authors" VALUES ('60733a5c59ab05118c755361','60733a5c59ab05118c755360','1',0);
INSERT INTO "posts_authors" VALUES ('60733cb359ab05118c755370','60733cb359ab05118c75536f','1',0);
INSERT INTO "posts_authors" VALUES ('6073848559ab05118c755379','6073848559ab05118c755378','1',0);
INSERT INTO "posts_authors" VALUES ('607384dc59ab05118c75537f','607384dc59ab05118c75537e','1',0);
INSERT INTO "roles" VALUES ('6072694259ab05118c7551d7','Administrator','Administrators','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551d8','Editor','Editors','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551d9','Author','Authors','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551da','Contributor','Contributors','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551db','Owner','Blog Owner','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551dc','Admin Integration','External Apps','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551dd','DB Backup Integration','Internal DB Backup Client','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles" VALUES ('6072694259ab05118c7551de','Scheduler Integration','Internal Scheduler Client','2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "roles_users" VALUES ('6072694359ab05118c755222','6072694259ab05118c7551d9','5951f5fca366002ebd5dbef7');
INSERT INTO "roles_users" VALUES ('6072694459ab05118c7552fb','6072694259ab05118c7551db','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551df','Export database','db','exportContent',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e0','Import database','db','importContent',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e1','Delete all content','db','deleteAllContent',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e2','Send mail','mail','send',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e3','Browse notifications','notification','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e4','Add notifications','notification','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e5','Delete notifications','notification','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e6','Browse posts','post','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e7','Read posts','post','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e8','Edit posts','post','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551e9','Add posts','post','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ea','Delete posts','post','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551eb','Browse settings','setting','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ec','Read settings','setting','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ed','Edit settings','setting','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ee','Generate slugs','slug','generate',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ef','Browse tags','tag','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f0','Read tags','tag','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f1','Edit tags','tag','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f2','Add tags','tag','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f3','Delete tags','tag','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f4','Browse themes','theme','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f5','Edit themes','theme','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f6','Activate themes','theme','activate',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f7','Upload themes','theme','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f8','Download themes','theme','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551f9','Delete themes','theme','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551fa','Browse users','user','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551fb','Read users','user','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551fc','Edit users','user','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551fd','Add users','user','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551fe','Delete users','user','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c7551ff','Assign a role','role','assign',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755200','Browse roles','role','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755201','Browse invites','invite','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755202','Read invites','invite','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755203','Edit invites','invite','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755204','Add invites','invite','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755205','Delete invites','invite','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755206','Download redirects','redirect','download',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755207','Upload redirects','redirect','upload',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755208','Add webhooks','webhook','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755209','Edit webhooks','webhook','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520a','Delete webhooks','webhook','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520b','Browse integrations','integration','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520c','Read integrations','integration','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520d','Edit integrations','integration','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520e','Add integrations','integration','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75520f','Delete integrations','integration','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755210','Browse API keys','api_key','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755211','Read API keys','api_key','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755212','Edit API keys','api_key','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755213','Add API keys','api_key','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755214','Delete API keys','api_key','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755215','Browse Actions','action','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755216','Browse Members','member','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755217','Read Members','member','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755218','Edit Members','member','edit',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755219','Add Members','member','add',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521a','Delete Members','member','destroy',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521b','Publish posts','post','publish',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521c','Backup database','db','backupContent',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521d','Email preview','email_preview','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521e','Send test email','email_preview','sendTestEmail',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c75521f','Browse emails','email','browse',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755220','Read emails','email','read',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions" VALUES ('6072694259ab05118c755221','Retry emails','email','retry',NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755237','6072694259ab05118c7551d7','6072694259ab05118c7551df');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755238','6072694259ab05118c7551d7','6072694259ab05118c7551e0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755239','6072694259ab05118c7551d7','6072694259ab05118c7551e1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523a','6072694259ab05118c7551d7','6072694259ab05118c75521c');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523b','6072694259ab05118c7551d7','6072694259ab05118c7551e2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523c','6072694259ab05118c7551d7','6072694259ab05118c7551e3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523d','6072694259ab05118c7551d7','6072694259ab05118c7551e4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523e','6072694259ab05118c7551d7','6072694259ab05118c7551e5');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75523f','6072694259ab05118c7551d7','6072694259ab05118c7551e6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755240','6072694259ab05118c7551d7','6072694259ab05118c7551e7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755241','6072694259ab05118c7551d7','6072694259ab05118c7551e8');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755242','6072694259ab05118c7551d7','6072694259ab05118c7551e9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755243','6072694259ab05118c7551d7','6072694259ab05118c7551ea');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755244','6072694259ab05118c7551d7','6072694259ab05118c75521b');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755245','6072694259ab05118c7551d7','6072694259ab05118c7551eb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755246','6072694259ab05118c7551d7','6072694259ab05118c7551ec');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755247','6072694259ab05118c7551d7','6072694259ab05118c7551ed');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755248','6072694259ab05118c7551d7','6072694259ab05118c7551ee');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755249','6072694259ab05118c7551d7','6072694259ab05118c7551ef');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524a','6072694259ab05118c7551d7','6072694259ab05118c7551f0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524b','6072694259ab05118c7551d7','6072694259ab05118c7551f1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524c','6072694259ab05118c7551d7','6072694259ab05118c7551f2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524d','6072694259ab05118c7551d7','6072694259ab05118c7551f3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524e','6072694259ab05118c7551d7','6072694259ab05118c7551f4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75524f','6072694259ab05118c7551d7','6072694259ab05118c7551f5');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755250','6072694259ab05118c7551d7','6072694259ab05118c7551f6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755251','6072694259ab05118c7551d7','6072694259ab05118c7551f7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755252','6072694259ab05118c7551d7','6072694259ab05118c7551f8');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755253','6072694259ab05118c7551d7','6072694259ab05118c7551f9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755254','6072694259ab05118c7551d7','6072694259ab05118c7551fa');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755255','6072694259ab05118c7551d7','6072694259ab05118c7551fb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755256','6072694259ab05118c7551d7','6072694259ab05118c7551fc');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755257','6072694259ab05118c7551d7','6072694259ab05118c7551fd');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755258','6072694259ab05118c7551d7','6072694259ab05118c7551fe');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755259','6072694259ab05118c7551d7','6072694259ab05118c7551ff');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525a','6072694259ab05118c7551d7','6072694259ab05118c755200');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525b','6072694259ab05118c7551d7','6072694259ab05118c755201');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525c','6072694259ab05118c7551d7','6072694259ab05118c755202');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525d','6072694259ab05118c7551d7','6072694259ab05118c755203');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525e','6072694259ab05118c7551d7','6072694259ab05118c755204');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75525f','6072694259ab05118c7551d7','6072694259ab05118c755205');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755260','6072694259ab05118c7551d7','6072694259ab05118c755206');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755261','6072694259ab05118c7551d7','6072694259ab05118c755207');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755262','6072694259ab05118c7551d7','6072694259ab05118c755208');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755263','6072694259ab05118c7551d7','6072694259ab05118c755209');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755264','6072694259ab05118c7551d7','6072694259ab05118c75520a');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755265','6072694259ab05118c7551d7','6072694259ab05118c75520b');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755266','6072694259ab05118c7551d7','6072694259ab05118c75520c');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755267','6072694259ab05118c7551d7','6072694259ab05118c75520d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755268','6072694259ab05118c7551d7','6072694259ab05118c75520e');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755269','6072694259ab05118c7551d7','6072694259ab05118c75520f');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526a','6072694259ab05118c7551d7','6072694259ab05118c755210');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526b','6072694259ab05118c7551d7','6072694259ab05118c755211');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526c','6072694259ab05118c7551d7','6072694259ab05118c755212');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526d','6072694259ab05118c7551d7','6072694259ab05118c755213');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526e','6072694259ab05118c7551d7','6072694259ab05118c755214');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75526f','6072694259ab05118c7551d7','6072694259ab05118c755215');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755270','6072694259ab05118c7551d7','6072694259ab05118c755216');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755271','6072694259ab05118c7551d7','6072694259ab05118c755217');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755272','6072694259ab05118c7551d7','6072694259ab05118c755218');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755273','6072694259ab05118c7551d7','6072694259ab05118c755219');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755274','6072694259ab05118c7551d7','6072694259ab05118c75521a');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755275','6072694259ab05118c7551d7','6072694259ab05118c75521d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755276','6072694259ab05118c7551d7','6072694259ab05118c75521e');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755277','6072694259ab05118c7551d7','6072694259ab05118c75521f');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755278','6072694259ab05118c7551d7','6072694259ab05118c755220');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755279','6072694259ab05118c7551d7','6072694259ab05118c755221');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527a','6072694259ab05118c7551dd','6072694259ab05118c7551df');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527b','6072694259ab05118c7551dd','6072694259ab05118c7551e0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527c','6072694259ab05118c7551dd','6072694259ab05118c7551e1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527d','6072694259ab05118c7551dd','6072694259ab05118c75521c');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527e','6072694259ab05118c7551de','6072694259ab05118c75521b');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75527f','6072694259ab05118c7551dc','6072694259ab05118c7551e2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755280','6072694259ab05118c7551dc','6072694259ab05118c7551e3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755281','6072694259ab05118c7551dc','6072694259ab05118c7551e4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755282','6072694259ab05118c7551dc','6072694259ab05118c7551e5');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755283','6072694259ab05118c7551dc','6072694259ab05118c7551e6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755284','6072694259ab05118c7551dc','6072694259ab05118c7551e7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755285','6072694259ab05118c7551dc','6072694259ab05118c7551e8');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755286','6072694259ab05118c7551dc','6072694259ab05118c7551e9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755287','6072694259ab05118c7551dc','6072694259ab05118c7551ea');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755288','6072694259ab05118c7551dc','6072694259ab05118c75521b');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755289','6072694259ab05118c7551dc','6072694259ab05118c7551eb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528a','6072694259ab05118c7551dc','6072694259ab05118c7551ec');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528b','6072694259ab05118c7551dc','6072694259ab05118c7551ed');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528c','6072694259ab05118c7551dc','6072694259ab05118c7551ee');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528d','6072694259ab05118c7551dc','6072694259ab05118c7551ef');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528e','6072694259ab05118c7551dc','6072694259ab05118c7551f0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75528f','6072694259ab05118c7551dc','6072694259ab05118c7551f1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755290','6072694259ab05118c7551dc','6072694259ab05118c7551f2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755291','6072694259ab05118c7551dc','6072694259ab05118c7551f3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755292','6072694259ab05118c7551dc','6072694259ab05118c7551f4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755293','6072694259ab05118c7551dc','6072694259ab05118c7551f5');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755294','6072694259ab05118c7551dc','6072694259ab05118c7551f6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755295','6072694259ab05118c7551dc','6072694259ab05118c7551f7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755296','6072694259ab05118c7551dc','6072694259ab05118c7551f8');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755297','6072694259ab05118c7551dc','6072694259ab05118c7551f9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755298','6072694259ab05118c7551dc','6072694259ab05118c7551fa');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c755299','6072694259ab05118c7551dc','6072694259ab05118c7551fb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529a','6072694259ab05118c7551dc','6072694259ab05118c7551fc');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529b','6072694259ab05118c7551dc','6072694259ab05118c7551fd');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529c','6072694259ab05118c7551dc','6072694259ab05118c7551fe');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529d','6072694259ab05118c7551dc','6072694259ab05118c7551ff');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529e','6072694259ab05118c7551dc','6072694259ab05118c755200');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c75529f','6072694259ab05118c7551dc','6072694259ab05118c755201');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a0','6072694259ab05118c7551dc','6072694259ab05118c755202');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a1','6072694259ab05118c7551dc','6072694259ab05118c755203');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a2','6072694259ab05118c7551dc','6072694259ab05118c755204');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a3','6072694259ab05118c7551dc','6072694259ab05118c755205');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a4','6072694259ab05118c7551dc','6072694259ab05118c755206');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a5','6072694259ab05118c7551dc','6072694259ab05118c755207');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a6','6072694259ab05118c7551dc','6072694259ab05118c755208');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a7','6072694259ab05118c7551dc','6072694259ab05118c755209');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a8','6072694259ab05118c7551dc','6072694259ab05118c75520a');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552a9','6072694259ab05118c7551dc','6072694259ab05118c755215');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552aa','6072694259ab05118c7551dc','6072694259ab05118c755216');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ab','6072694259ab05118c7551dc','6072694259ab05118c755217');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ac','6072694259ab05118c7551dc','6072694259ab05118c755218');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ad','6072694259ab05118c7551dc','6072694259ab05118c755219');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ae','6072694259ab05118c7551dc','6072694259ab05118c75521a');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552af','6072694259ab05118c7551dc','6072694259ab05118c75521d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b0','6072694259ab05118c7551dc','6072694259ab05118c75521e');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b1','6072694259ab05118c7551dc','6072694259ab05118c75521f');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b2','6072694259ab05118c7551dc','6072694259ab05118c755220');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b3','6072694259ab05118c7551dc','6072694259ab05118c755221');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b4','6072694259ab05118c7551d8','6072694259ab05118c7551e3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b5','6072694259ab05118c7551d8','6072694259ab05118c7551e4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b6','6072694259ab05118c7551d8','6072694259ab05118c7551e5');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b7','6072694259ab05118c7551d8','6072694259ab05118c7551e6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b8','6072694259ab05118c7551d8','6072694259ab05118c7551e7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552b9','6072694259ab05118c7551d8','6072694259ab05118c7551e8');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ba','6072694259ab05118c7551d8','6072694259ab05118c7551e9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552bb','6072694259ab05118c7551d8','6072694259ab05118c7551ea');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552bc','6072694259ab05118c7551d8','6072694259ab05118c75521b');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552bd','6072694259ab05118c7551d8','6072694259ab05118c7551eb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552be','6072694259ab05118c7551d8','6072694259ab05118c7551ec');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552bf','6072694259ab05118c7551d8','6072694259ab05118c7551ee');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c0','6072694259ab05118c7551d8','6072694259ab05118c7551ef');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c1','6072694259ab05118c7551d8','6072694259ab05118c7551f0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c2','6072694259ab05118c7551d8','6072694259ab05118c7551f1');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c3','6072694259ab05118c7551d8','6072694259ab05118c7551f2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c4','6072694259ab05118c7551d8','6072694259ab05118c7551f3');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c5','6072694259ab05118c7551d8','6072694259ab05118c7551fa');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c6','6072694259ab05118c7551d8','6072694259ab05118c7551fb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c7','6072694259ab05118c7551d8','6072694259ab05118c7551fc');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c8','6072694259ab05118c7551d8','6072694259ab05118c7551fd');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552c9','6072694259ab05118c7551d8','6072694259ab05118c7551fe');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ca','6072694259ab05118c7551d8','6072694259ab05118c7551ff');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552cb','6072694259ab05118c7551d8','6072694259ab05118c755200');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552cc','6072694259ab05118c7551d8','6072694259ab05118c755201');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552cd','6072694259ab05118c7551d8','6072694259ab05118c755202');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ce','6072694259ab05118c7551d8','6072694259ab05118c755203');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552cf','6072694259ab05118c7551d8','6072694259ab05118c755204');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d0','6072694259ab05118c7551d8','6072694259ab05118c755205');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d1','6072694259ab05118c7551d8','6072694259ab05118c7551f4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d2','6072694259ab05118c7551d8','6072694259ab05118c75521d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d3','6072694259ab05118c7551d8','6072694259ab05118c75521e');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d4','6072694259ab05118c7551d8','6072694259ab05118c75521f');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d5','6072694259ab05118c7551d8','6072694259ab05118c755220');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d6','6072694259ab05118c7551d8','6072694259ab05118c755221');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d7','6072694259ab05118c7551d9','6072694259ab05118c7551e6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d8','6072694259ab05118c7551d9','6072694259ab05118c7551e7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552d9','6072694259ab05118c7551d9','6072694259ab05118c7551e9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552da','6072694259ab05118c7551d9','6072694259ab05118c7551eb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552db','6072694259ab05118c7551d9','6072694259ab05118c7551ec');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552dc','6072694259ab05118c7551d9','6072694259ab05118c7551ee');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552dd','6072694259ab05118c7551d9','6072694259ab05118c7551ef');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552de','6072694259ab05118c7551d9','6072694259ab05118c7551f0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552df','6072694259ab05118c7551d9','6072694259ab05118c7551f2');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e0','6072694259ab05118c7551d9','6072694259ab05118c7551fa');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e1','6072694259ab05118c7551d9','6072694259ab05118c7551fb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e2','6072694259ab05118c7551d9','6072694259ab05118c755200');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e3','6072694259ab05118c7551d9','6072694259ab05118c7551f4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e4','6072694259ab05118c7551d9','6072694259ab05118c75521d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e5','6072694259ab05118c7551d9','6072694259ab05118c755220');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e6','6072694259ab05118c7551da','6072694259ab05118c7551e6');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e7','6072694259ab05118c7551da','6072694259ab05118c7551e7');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e8','6072694259ab05118c7551da','6072694259ab05118c7551e9');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552e9','6072694259ab05118c7551da','6072694259ab05118c7551eb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ea','6072694259ab05118c7551da','6072694259ab05118c7551ec');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552eb','6072694259ab05118c7551da','6072694259ab05118c7551ee');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ec','6072694259ab05118c7551da','6072694259ab05118c7551ef');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ed','6072694259ab05118c7551da','6072694259ab05118c7551f0');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ee','6072694259ab05118c7551da','6072694259ab05118c7551fa');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552ef','6072694259ab05118c7551da','6072694259ab05118c7551fb');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552f0','6072694259ab05118c7551da','6072694259ab05118c755200');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552f1','6072694259ab05118c7551da','6072694259ab05118c7551f4');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552f2','6072694259ab05118c7551da','6072694259ab05118c75521d');
INSERT INTO "permissions_roles" VALUES ('6072694459ab05118c7552f3','6072694259ab05118c7551da','6072694259ab05118c755220');
INSERT INTO "settings" VALUES ('6072694659ab05118c7552fc','db_hash','8644e74f-4e31-4b8d-9ec1-f231859505c1','core','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c7552fd','next_update_check','1618200659','core','2021-04-11 03:13:10','1','2021-04-11 04:10:58','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c7552fe','notifications','[{"dismissible":true,"location":"bottom","status":"alert","id":"130f7c24-113a-4768-a698-12a8b34223f5","custom":true,"createdAt":"2021-03-16T12:55:20.000Z","type":"info","top":true,"message":"<strong>Ghost 4.0 is now available</strong> - You are using an old version of Ghost, which means you don''t have access to the latest features. <a href=\"https://ghost.org/changelog/4/\" target=\"_blank\" rel=\"noopener\">Read more!</a>","seen":true,"addedAt":"2021-04-11T04:10:58.738Z","seenBy":["1"]}]','core','2021-04-11 03:13:10','1','2021-04-11 13:27:17','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c7552ff','session_secret','ec26d1d6ed1bc375dabd0e6e4bd6d305697e674d6e372d2c419a21daa709fae5','core','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755300','theme_session_secret','7a4b43022866b0d5dc1dc7742c9c5781459d0d657657cb83f05e050d03d8372c','core','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755301','title','Pruebas automatizadas','blog','2021-04-11 03:13:10','1','2021-04-11 12:38:24','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755302','description','Thoughts, stories and ideas.','blog','2021-04-11 03:13:10','1','2021-04-11 12:38:24','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755303','logo','https://static.ghost.org/v1.0.0/images/ghost-logo.svg','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755304','cover_image','https://static.ghost.org/v3.0.0/images/publication-cover.png','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755305','icon',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755306','brand','{"primaryColor":""}','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755307','default_locale','en','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755308','active_timezone','Etc/UTC','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755309','force_i18n','true','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530a','permalinks','/:slug/','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530b','amp','true','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530c','ghost_head',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530d','ghost_foot',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530e','facebook','ghost','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75530f','twitter','tryghost','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755310','labs','{}','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755311','navigation','[{"label":"Home", "url":"/"},{"label":"Tag", "url":"/tag/getting-started/"}, {"label":"Author", "url":"/author/ghost/"},{"label":"Help", "url":"https://ghost.org/docs/"}]','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755312','secondary_navigation','[]','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755313','slack','[{"url":"", "username":"Ghost"}]','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755314','unsplash','{"isActive": true}','blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755315','meta_title',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755316','meta_description',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755317','og_image',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755318','og_title',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755319','og_description',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531a','twitter_image',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531b','twitter_title',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531c','twitter_description',NULL,'blog','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531d','active_theme','casper','theme','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531e','is_private','false','private','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c75531f','password',NULL,'private','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755320','public_hash','d97b7a4d23dc87bf10a9fcbe7bb532','private','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755321','members_public_key','-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBALrFlp0XmJ2Ymrf36dT7GCuhATXProoHd0PG6EeQj9Hh/VZn7NEqfcgOqLSAeeG1
kw4Js3Lsb0TbPfTeHB7eN/NdNCIAk3neFvW4IbnbOiBokBpe6u1AV992eqpKf3IZ/uV9ZMSt
oS+qCrWZa2Z5E4H3BjUY4mTXoF2l/hAni/3nAgMBAAE=
-----END RSA PUBLIC KEY-----
','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755322','members_private_key','-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQC6xZadF5idmJq39+nU+xgroQE1z66KB3dDxuhHkI/R4f1WZ+zRKn3IDqi0
gHnhtZMOCbNy7G9E2z303hwe3jfzXTQiAJN53hb1uCG52zogaJAaXurtQFffdnqqSn9yGf7l
fWTEraEvqgq1mWtmeROB9wY1GOJk16Bdpf4QJ4v95wIDAQABAoGBAA/cCV8LiuUO+UxX294+
+B10TYMBQKPt4F27/StehiffVcDJkF1ui0G6pO623iKhZXxSrI88rnIdX9R0K9UfL4bwmGqr
U6JvLRxwea2vG75UJkOxwtPcXE+Mo3eANplRetjqQiQByDkRIAnG/4fL1CEw4tOeqGIt4U94
9QIITyOhAkEA50yrxId19nZ3sukLUd3YCFuuMK+La8PQOHMD5jEFhlWYF+ZJJ0gA/dRZBHV1
o9MayxLVr2mBl3DwaIDV5koJlwJBAM63m5mN+zga3+5mK5RKC8AXW0v4mt0sPNUZWrAFTYWf
iCLJ9ZI0zUVY9aDQpIum8Kua14vhpCuNzmI49hyWGDECQHMHxXES8U6mcjcvASswyiy187ZQ
x2TL2HUKdkj33kiFrwNLytvXSm7yOWcnR183MN8Hue/n58Q6LcW7NSW3cncCQAOiNpn8ZO4X
itgl854nrw0xW+l59T7uCCO2zmFJtpMiusHhyu9G/lS5u5eYE0xhItnhXuiWjsw1MeuIFMtr
2AECQF2w5v5Ip72pJqu8o2E+/kuJbW0ZnEb8XHttkrlYyr3IKNFfVN0oxb5ZPONlf0c1tSOt
UQRIsGGs+0LZduvvPZQ=
-----END RSA PRIVATE KEY-----
','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755323','members_session_secret','e5f7376f489c3e49de341456277bf00c1dfef0843001750abce702201044e516','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755324','members_email_auth_secret','313aaf5df4758bdc55051d0e0134b1790734b2d28c7aa3c83999171d768a449cdfc1e9f0c3fe85481083280f04c0f3ea0110073e46207c38ee99adc3326922b4','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755325','default_content_visibility','public','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755326','members_subscription_settings','{"isPaid":false,"fromAddress":"noreply","allowSelfSignup":true,"paymentProcessors":[{"adapter":"stripe","config":{"secret_token":"","public_token":"","product":{"name":"Ghost Subscription"},"plans":[{"name":"Monthly","currency":"usd","interval":"month","amount":""},{"name":"Yearly","currency":"usd","interval":"year","amount":""}]}}]}','members','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "settings" VALUES ('6072694659ab05118c755327','bulk_email_settings','{"provider":"mailgun", "apiKey": "", "domain": "", "baseUrl": ""}','bulk_email','2021-04-11 03:13:10','1','2021-04-11 03:13:10','1');
INSERT INTO "tags" VALUES ('6072694259ab05118c7551d6','Getting Started','getting-started',NULL,NULL,NULL,'public',NULL,NULL,'2021-04-11 03:13:06','1','2021-04-11 03:13:06','1');
INSERT INTO "tags" VALUES ('60732b7b59ab05118c755352','Tag de prueba','tag-de-prueba','Se crea tag de prueba',NULL,NULL,'public',NULL,NULL,'2021-04-11 17:01:47','1','2021-04-11 17:01:47','1');
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f4','6072694359ab05118c755223','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f5','6072694359ab05118c755225','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f6','6072694359ab05118c755227','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f7','6072694359ab05118c755229','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f8','6072694359ab05118c75522b','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552f9','6072694459ab05118c75522d','6072694259ab05118c7551d6',0);
INSERT INTO "posts_tags" VALUES ('6072694459ab05118c7552fa','6072694459ab05118c75522f','6072694259ab05118c7551d6',0);
INSERT INTO "invites" VALUES ('6073321f59ab05118c755359','6072694259ab05118c7551d9','pending','MTYxODc2NzAwNzAzOHx1c3VhcmlvMUB1c3VhcmlvMS5jb218dHZLV3NMaVNlLy9YZ2w0dU91ZnJORHRJczhxbUQ0dEh5VFp3V1RtODlOWT0=','usuario1@usuario1.com',1618767007038,'2021-04-11 17:30:07','1','2021-04-11 17:30:07','1');
INSERT INTO "invites" VALUES ('60733b0e59ab05118c755365','6072694259ab05118c7551d9','pending','MTYxODc2OTI5NDkyMXx1c3VhcmlvMkB1c3VhcmlvMi5jb218aUQvc0hPenJWV3ZjV3FsYTZYODdUUkJweTYzUWhSSGJ4TzBWQXpiVkdBND0=','usuario2@usuario2.com',1618769294921,'2021-04-11 18:08:14','1','2021-04-11 18:08:14','1');
INSERT INTO "invites" VALUES ('607372de59ab05118c755376','6072694259ab05118c7551d9','pending','MTYxODc4MzU4MjI0MnxwcnVlYmE2QHBydWViYTYuY29tfGRRNlBlNy9CSmpsRFN0c1BHb2t3OVljNlBycHVNMThaVXNLdG51SStrNm89','prueba6@prueba6.com',1618783582242,'2021-04-11 22:06:22','1','2021-04-11 22:06:22','1');
INSERT INTO "invites" VALUES ('607372e359ab05118c755377','6072694259ab05118c7551d9','pending','MTYxODc4MzU4NzIxMHxqaG9udHJ1amlsbG8xMkBnbWFpbC5jb218OWNTV2ZtYklTOTM5SnFIbUorZkkvdW5LSkRCN0FCTG1FN3RYVngwcFlWQT0=','jhontrujillo12@gmail.com',1618783587210,'2021-04-11 22:06:27','1','2021-04-11 22:06:27','1');
INSERT INTO "brute" VALUES ('oHUubZQTM66eOWJCFaoi+8dO/eXPG5zwBOW8P5YAuKM=',1618144704341,1618146044462,1618149644466,4);
INSERT INTO "sessions" VALUES ('6072f2fc59ab05118c75532c','x8vWSwDqSGI_AKU5OAzIVpeG_6dkI7b5','1','{"cookie":{"originalMaxAge":15768000000,"expires":"2021-10-11T01:00:44.841Z","secure":false,"httpOnly":true,"path":"/ghost","sameSite":"lax"},"user_id":"1","origin":"http://localhost:2368","user_agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36","ip":"127.0.0.1"}',1618146044846,1618146044846);
INSERT INTO "integrations" VALUES ('6072694459ab05118c755231','builtin','Zapier','zapier',NULL,'Built-in Zapier integration','2021-04-11 03:13:08','1','2021-04-11 03:13:08','1');
INSERT INTO "integrations" VALUES ('6072694459ab05118c755233','internal','Ghost Backup','ghost-backup',NULL,'Internal DB Backup integration','2021-04-11 03:13:08','1','2021-04-11 03:13:08','1');
INSERT INTO "integrations" VALUES ('6072694459ab05118c755235','internal','Ghost Scheduler','ghost-scheduler',NULL,'Internal Scheduler integration','2021-04-11 03:13:08','1','2021-04-11 03:13:08','1');
INSERT INTO "api_keys" VALUES ('6072694459ab05118c755232','admin','b3e353c6be1455e797bf00670db197c1dc91c2b8ec131188782ae3276ca4e6b5','6072694259ab05118c7551dc','6072694459ab05118c755231',NULL,NULL,1618110788092,'1',1618110788092,'1');
INSERT INTO "api_keys" VALUES ('6072694459ab05118c755234','admin','77df498d75113d9bd0c3bd10356cdbd8db014302abbd9100ab3d3c29b5e3cf2c','6072694259ab05118c7551dd','6072694459ab05118c755233',NULL,NULL,1618110788123,'1',1618110788123,'1');
INSERT INTO "api_keys" VALUES ('6072694459ab05118c755236','admin','1a2f43e11b22e1f7f57232f8caadeab8b08d76649fe640519c298e3ad00f56b2','6072694259ab05118c7551de','6072694459ab05118c755235',NULL,NULL,1618110788139,'1',1618110788139,'1');
INSERT INTO "mobiledoc_revisions" VALUES ('60730f3159ab05118c755336','60730f3159ab05118c755334','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618153265143,'2021-04-11 15:01:05');
INSERT INTO "mobiledoc_revisions" VALUES ('60730f3a59ab05118c755338','60730f3159ab05118c755334','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Se realiza la primera prueba del postp"]]]]}',1618153274545,'2021-04-11 15:01:14');
INSERT INTO "mobiledoc_revisions" VALUES ('6073249659ab05118c755348','6073249659ab05118c755346','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618158742943,'2021-04-11 16:32:22');
INSERT INTO "mobiledoc_revisions" VALUES ('607324a759ab05118c75534a','6073249659ab05118c755346','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Prueba exploratoria para verificar el creado de la página"]]]]}',1618158759041,'2021-04-11 16:32:39');
INSERT INTO "mobiledoc_revisions" VALUES ('6073280a59ab05118c75534f','6073280a59ab05118c75534d','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618159626855,'2021-04-11 16:47:06');
INSERT INTO "mobiledoc_revisions" VALUES ('6073387f59ab05118c75535d','6072694459ab05118c75522f','{"version":"0.3.1","atoms":[],"cards":[],"markups":[["strong"],["a",["href","https://ghost.org/integrations/"]],["a",["href","https://ghost.org/pricing"]],["a",["href","https://github.com/TryGhost"]],["a",["href","/the-editor/"]]],"sections":[[1,"h2",[[0,[0],1,"A few things you should know"]]],[3,"ol",[[[0,[],0,"Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That''s who it works best for. "]],[[0,[],0,"The entire platform can be modified and customised to suit your needs. It''s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. "]],[[0,[],0,"It''s possible to work with all your favourite tools and apps with hundreds of "],[0,[1],1,"integrations"],[0,[],0," to speed up your workflows, connect email lists, build communities and much more."]]]],[1,"h2",[[0,[],0,"Behind the scenes"]]],[1,"p",[[0,[],0,"Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our "],[0,[2],1,"Ghost(Pro)"],[0,[],0," service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing."]]],[1,"p",[[0,[],0,"The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source "],[0,[3],1,"community"],[0,[],0,"."]]],[1,"h2",[[0,[],0,"Next up, the editor"]]],[1,"p",[[0,[],0,"The main thing you''ll want to read about next is probably: "],[0,[4],1,"the Ghost editor"],[0,[],0,". This is where the good stuff happens."]]],[1,"blockquote",[[0,[],0,"By the way, once you''re done reading, you can simply delete the default Ghost user from your team to remove all of these introductory posts! "]]]]}',1618163839600,'2021-04-11 17:57:19');
INSERT INTO "mobiledoc_revisions" VALUES ('6073387f59ab05118c75535e','6072694459ab05118c75522f','{"version":"0.3.1","atoms":[],"cards":[],"markups":[["strong"],["a",["href","https://ghost.org/pricing"]],["a",["href","https://github.com/TryGhost"]],["a",["href","/the-editor/"]]],"sections":[[1,"h2",[[0,[0],1,"A few things you should know"]]],[3,"ol",[[[0,[],0,"Ghost is designed for ambitious, professional publishers who want to actively build a business around their content. That''s who it works best for. "]],[[0,[],0,"The entire platform can be modified and customised to suit your needs. It''s very powerful, but does require some knowledge of code. Ghost is not necessarily a good platform for beginners or people who just want a simple personal blog. "]],[]]],[1,"h2",[[0,[],0,"Behind the scenes"]]],[1,"p",[[0,[],0,"Ghost is made by an independent non-profit organisation called the Ghost Foundation. We are 100% self funded by revenue from our "],[0,[1],1,"Ghost(Pro)"],[0,[],0," service, and every penny we make is re-invested into funding further development of free, open source technology for modern publishing."]]],[1,"p",[[0,[],0,"The version of Ghost you are looking at right now would not have been made possible without generous contributions from the open source "],[0,[2],1,"community"],[0,[],0,"."]]],[1,"h2",[[0,[],0,"Next up, the editor"]]],[1,"p",[[0,[],0,"The main thing you''ll want to read about next is probably: "],[0,[3],1,"the Ghost editor"],[0,[],0,". This is where the good stuff happens."]]],[1,"blockquote",[[0,[],0,"By the way, once you''re done reading, you can simply delete the default Ghost user from your team to remove all of these introductory posts! "]]]]}',1618163839601,'2021-04-11 17:57:19');
INSERT INTO "mobiledoc_revisions" VALUES ('60733a5c59ab05118c755362','60733a5c59ab05118c755360','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618164316364,'2021-04-11 18:05:16');
INSERT INTO "mobiledoc_revisions" VALUES ('60733cb359ab05118c755371','60733cb359ab05118c75536f','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618164915348,'2021-04-11 18:15:15');
INSERT INTO "mobiledoc_revisions" VALUES ('60733cc059ab05118c755373','60733cb359ab05118c75536f','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Prueba de botón More"]]]]}',1618164928846,'2021-04-11 18:15:28');
INSERT INTO "mobiledoc_revisions" VALUES ('6073848559ab05118c75537a','6073848559ab05118c755378','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"C"]]]]}',1618183301611,'2021-04-11 23:21:41');
INSERT INTO "mobiledoc_revisions" VALUES ('6073848b59ab05118c75537c','6073848559ab05118c755378','{"version":"0.3.1","atoms":[],"cards":[],"markups":[],"sections":[[1,"p",[[0,[],0,"Creo post sde ejmplo "]]]]}',1618183307286,'2021-04-11 23:21:47');
INSERT INTO "mobiledoc_revisions" VALUES ('607384dc59ab05118c755380','607384dc59ab05118c75537e','{"version":"0.3.1","markups":[],"atoms":[],"cards":[],"sections":[[1,"p",[[0,[],0,""]]]]}',1618183388314,'2021-04-11 23:23:08');
INSERT INTO "actions" VALUES ('6073075e59ab05118c755330','6073075e59ab05118c75532d','post','1','user','added',NULL,'2021-04-11 14:27:42');
INSERT INTO "actions" VALUES ('6073076659ab05118c755332','6073075e59ab05118c75532d','post','1','user','edited',NULL,'2021-04-11 14:27:50');
INSERT INTO "actions" VALUES ('607309b759ab05118c755333','6073075e59ab05118c75532d','post','1','user','deleted',NULL,'2021-04-11 14:37:43');
INSERT INTO "actions" VALUES ('60730f3159ab05118c755337','60730f3159ab05118c755334','post','1','user','added',NULL,'2021-04-11 15:01:05');
INSERT INTO "actions" VALUES ('60730f3a59ab05118c755339','60730f3159ab05118c755334','post','1','user','edited',NULL,'2021-04-11 15:01:14');
INSERT INTO "actions" VALUES ('60730f3d59ab05118c75533a','60730f3159ab05118c755334','post','1','user','edited',NULL,'2021-04-11 15:01:17');
INSERT INTO "actions" VALUES ('6073222659ab05118c75533e','6073222659ab05118c75533b','post','1','user','added',NULL,'2021-04-11 16:21:58');
INSERT INTO "actions" VALUES ('6073223259ab05118c75533f','6073222659ab05118c75533b','post','1','user','edited',NULL,'2021-04-11 16:22:10');
INSERT INTO "actions" VALUES ('6073223459ab05118c755340','6073222659ab05118c75533b','post','1','user','edited',NULL,'2021-04-11 16:22:12');
INSERT INTO "actions" VALUES ('607322ff59ab05118c755341','6073222659ab05118c75533b','post','1','user','deleted',NULL,'2021-04-11 16:25:35');
INSERT INTO "actions" VALUES ('6073232b59ab05118c755345','6073232a59ab05118c755342','post','1','user','added',NULL,'2021-04-11 16:26:19');
INSERT INTO "actions" VALUES ('6073249759ab05118c755349','6073249659ab05118c755346','post','1','user','added',NULL,'2021-04-11 16:32:23');
INSERT INTO "actions" VALUES ('607324a759ab05118c75534b','6073249659ab05118c755346','post','1','user','edited',NULL,'2021-04-11 16:32:39');
INSERT INTO "actions" VALUES ('607324a959ab05118c75534c','6073249659ab05118c755346','post','1','user','edited',NULL,'2021-04-11 16:32:41');
INSERT INTO "actions" VALUES ('6073280a59ab05118c755350','6073280a59ab05118c75534d','post','1','user','added',NULL,'2021-04-11 16:47:06');
INSERT INTO "actions" VALUES ('6073281059ab05118c755351','6073280a59ab05118c75534d','post','1','user','edited',NULL,'2021-04-11 16:47:12');
INSERT INTO "actions" VALUES ('60732b7b59ab05118c755353','60732b7b59ab05118c755352','tag','1','user','added',NULL,'2021-04-11 17:01:47');
INSERT INTO "actions" VALUES ('6073368959ab05118c75535b','1','user','1','user','edited',NULL,'2021-04-11 17:48:57');
INSERT INTO "actions" VALUES ('607336a559ab05118c75535c','1','user','1','user','edited',NULL,'2021-04-11 17:49:25');
INSERT INTO "actions" VALUES ('6073387f59ab05118c75535f','6072694459ab05118c75522f','post','1','user','edited',NULL,'2021-04-11 17:57:19');
INSERT INTO "actions" VALUES ('60733a5c59ab05118c755363','60733a5c59ab05118c755360','post','1','user','added',NULL,'2021-04-11 18:05:16');
INSERT INTO "actions" VALUES ('60733a6359ab05118c755364','60733a5c59ab05118c755360','post','1','user','edited',NULL,'2021-04-11 18:05:23');
INSERT INTO "actions" VALUES ('60733c1659ab05118c755369','60733c1659ab05118c755366','post','1','user','added',NULL,'2021-04-11 18:12:38');
INSERT INTO "actions" VALUES ('60733c1b59ab05118c75536b','60733c1659ab05118c755366','post','1','user','edited',NULL,'2021-04-11 18:12:43');
INSERT INTO "actions" VALUES ('60733c2059ab05118c75536c','60733c1659ab05118c755366','post','1','user','edited',NULL,'2021-04-11 18:12:48');
INSERT INTO "actions" VALUES ('60733c8e59ab05118c75536d','60733c1659ab05118c755366','post','1','user','deleted',NULL,'2021-04-11 18:14:38');
INSERT INTO "actions" VALUES ('60733c9659ab05118c75536e','6073232a59ab05118c755342','post','1','user','deleted',NULL,'2021-04-11 18:14:46');
INSERT INTO "actions" VALUES ('60733cb359ab05118c755372','60733cb359ab05118c75536f','post','1','user','added',NULL,'2021-04-11 18:15:15');
INSERT INTO "actions" VALUES ('60733cc059ab05118c755374','60733cb359ab05118c75536f','post','1','user','edited',NULL,'2021-04-11 18:15:28');
INSERT INTO "actions" VALUES ('6073848559ab05118c75537b','6073848559ab05118c755378','post','1','user','added',NULL,'2021-04-11 23:21:41');
INSERT INTO "actions" VALUES ('6073848b59ab05118c75537d','6073848559ab05118c755378','post','1','user','edited',NULL,'2021-04-11 23:21:47');
INSERT INTO "actions" VALUES ('607384dc59ab05118c755381','607384dc59ab05118c75537e','post','1','user','added',NULL,'2021-04-11 23:23:08');
INSERT INTO "actions" VALUES ('607384e159ab05118c755382','607384dc59ab05118c75537e','post','1','user','edited',NULL,'2021-04-11 23:23:13');
CREATE UNIQUE INDEX IF NOT EXISTS "migrations_lock_lock_key_unique" ON "migrations_lock" (
	"lock_key"
);
CREATE UNIQUE INDEX IF NOT EXISTS "migrations_name_version_unique" ON "migrations" (
	"name",
	"version"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_slug_unique" ON "posts" (
	"slug"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_meta_post_id_unique" ON "posts_meta" (
	"post_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "users_slug_unique" ON "users" (
	"slug"
);
CREATE UNIQUE INDEX IF NOT EXISTS "users_email_unique" ON "users" (
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "roles_name_unique" ON "roles" (
	"name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "permissions_name_unique" ON "permissions" (
	"name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "settings_key_unique" ON "settings" (
	"key"
);
CREATE UNIQUE INDEX IF NOT EXISTS "tags_slug_unique" ON "tags" (
	"slug"
);
CREATE UNIQUE INDEX IF NOT EXISTS "apps_name_unique" ON "apps" (
	"name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "apps_slug_unique" ON "apps" (
	"slug"
);
CREATE UNIQUE INDEX IF NOT EXISTS "app_settings_key_unique" ON "app_settings" (
	"key"
);
CREATE UNIQUE INDEX IF NOT EXISTS "invites_token_unique" ON "invites" (
	"token"
);
CREATE UNIQUE INDEX IF NOT EXISTS "invites_email_unique" ON "invites" (
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "sessions_session_id_unique" ON "sessions" (
	"session_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "integrations_slug_unique" ON "integrations" (
	"slug"
);
CREATE UNIQUE INDEX IF NOT EXISTS "api_keys_secret_unique" ON "api_keys" (
	"secret"
);
CREATE INDEX IF NOT EXISTS "mobiledoc_revisions_post_id_index" ON "mobiledoc_revisions" (
	"post_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "members_uuid_unique" ON "members" (
	"uuid"
);
CREATE UNIQUE INDEX IF NOT EXISTS "members_email_unique" ON "members" (
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "emails_post_id_unique" ON "emails" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "emails_post_id_index" ON "emails" (
	"post_id"
);
COMMIT;
