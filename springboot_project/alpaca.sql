CREATE TABLE `Untitled` (
	`id`	varchar(40)	NOT NULL,
	`password`	varchar(100)	NOT NULL,
	`name`	varchar(20)	NOT NULL,
	`nick_name`	varchar(40)	NOT NULL,
	`call`	varchar(20)	NOT NULL,
	`email`	varchar(50)	NOT NULL,
	`address`	varchar(60)	NOT NULL,
	`created_date`	date	NOT NULL,
	`del`	char(1)	NOT NULL	DEFAULT n,
	`authority`	char(1)	NULL	DEFAULT n,
	`age`	varchar(10)	NOT NULL	DEFAULT 20대,
	`gender`	char(1)	NOT NULL	DEFAULT m
);

CREATE TABLE `auction_item` (
	`auction_no`	number(10)	NOT NULL,
	`item_name`	varchar(20)	NOT NULL,
	`item_contents`	varchar(300)	NOT NULL,
	`item_img`	varchar(200)	NOT NULL,
	`start_date`	date	NOT NULL,
	`end_date`	date	NOT NULL,
	`start_price`	number(10)	NOT NULL,
	`min_bid`	number(10)	NOT NULL,
	`view_cnt`	number(10)	NOT NULL,
	`del`	char(1)	NOT NULL,
	`reg_date`	date	NOT NULL,
	`id`	varchar(40)	NOT NULL,
	`tag_no`	number(10)	NOT NULL
);

CREATE TABLE `review_board` (
	`review_no`	number(10)	NOT NULL,
	`title`	varchar(40)	NOT NULL,
	`contents`	varchar(300)	NOT NULL,
	`review_img`	varchar(200)	NOT NULL,
	`read_cnt`	number(10)	NOT NULL,
	`del`	char(1)	NOT NULL,
	`reg_date`	date	NOT NULL,
	`rating`	number(5)	NOT NULL,
	`id`	varchar(40)	NOT NULL,
	`auction_no`	number(10)	NOT NULL
);

CREATE TABLE `interest` (
	`interest_no`	number(10)	NOT NULL,
	`id`	varchar(40)	NOT NULL,
	`auction_no`	number(10)	NOT NULL
);

CREATE TABLE `bidding` (
	`bid_no`	number(10)	NOT NULL,
	`bid_price`	number(10)	NOT NULL,
	`bid_date`	number(10)	NOT NULL,
	`id`	varchar(40)	NOT NULL,
	`auction_no`	number(10)	NOT NULL
);

CREATE TABLE `interest_tag` (
	`it_tag_no`	number(10)	NOT NULL,
	`id`	varchar(40)	NOT NULL,
	`tag_no`	number(10)	NOT NULL
);

CREATE TABLE `tag` (
	`tag_no`	number(10)	NOT NULL,
	`tag_name`	varchar(20)	NOT NULL
);

CREATE TABLE `review_reply` (
	`re_reply_no`	number(10)	NOT NULL,
	`reply_contents`	varchar(100)	NOT NULL,
	`del`	char(1)	NOT NULL	DEFAULT n,
	`reg_date`	date	NOT NULL,
	`up`	char(1)	NOT NULL	DEFAULT n,
	`id`	varchar(40)	NOT NULL,
	`review_no`	number(10)	NOT NULL
);

ALTER TABLE `Untitled` ADD CONSTRAINT `PK_UNTITLED` PRIMARY KEY (
	`id`
);

ALTER TABLE `auction_item` ADD CONSTRAINT `PK_AUCTION_ITEM` PRIMARY KEY (
	`auction_no`
);

ALTER TABLE `review_board` ADD CONSTRAINT `PK_REVIEW_BOARD` PRIMARY KEY (
	`review_no`
);

ALTER TABLE `interest` ADD CONSTRAINT `PK_INTEREST` PRIMARY KEY (
	`interest_no`
);

ALTER TABLE `bidding` ADD CONSTRAINT `PK_BIDDING` PRIMARY KEY (
	`bid_no`
);

ALTER TABLE `interest_tag` ADD CONSTRAINT `PK_INTEREST_TAG` PRIMARY KEY (
	`it_tag_no`
);

ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (
	`tag_no`
);

ALTER TABLE `review_reply` ADD CONSTRAINT `PK_REVIEW_REPLY` PRIMARY KEY (
	`re_reply_no`
);

