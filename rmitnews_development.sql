-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 17, 2018 at 08:49 PM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.1.16-1+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rmitnews_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `ar_internal_metadata`
--

CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ar_internal_metadata`
--

INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`) VALUES
('environment', 'development', '2018-04-17 14:08:17', '2018-04-17 14:08:17');

-- --------------------------------------------------------

--
-- Table structure for table `mst_blog_categories`
--

CREATE TABLE `mst_blog_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `category_name_ch` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_categories`
--

CREATE TABLE `mst_categories` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_contactus`
--

CREATE TABLE `mst_contactus` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_content_pages`
--

CREATE TABLE `mst_content_pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `meta_keyword` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `lang_id` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_content_pages`
--

INSERT INTO `mst_content_pages` (`id`, `title`, `slug`, `content`, `meta_keyword`, `meta_description`, `active`, `lang_id`, `created_at`, `updated_at`) VALUES
(1, 'About us', 'about-us', '<p><span style="color:#800000;"><span style="font-size:16px;"><strong>About us</strong></span></span><br />\r\n<br />\r\nNow in some cases, designers may use squares and rectangles to help you visualize what should and may be in a particular location.<br />\r\n', 'asasas', 'sdsd sdsd sdsd sds sdsds sadas erer ', '1', '17', '2016-09-06 06:11:23', '2016-10-22 07:05:34'),
(2, 'Terms and Condition', 'terms-of-use', '<h1><span style="color:#800000;"><em><strong>Terms &amp; Conditions</strong></em></span></h1>\r\n\r\n<p><em><span style="color:#0000ff;">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standar', 'Terms of Use', 'Terms of Use Terms of Use Terms of Use Terms of Use', '1', '17', '2016-09-06 06:11:23', '2016-10-27 12:24:25'),
(3, 'Privacy Policy', 'privacy', '<p><span style="font-size:16px;"><strong><em><span style="color:#800000;">Privacy Policy</span></em></strong></span></p>\r\n\r\n<p><span style="color:#0000ff;"><em>This is dummy text. This text is for display purposes only. Actual text will be placed here aft', 'Privacy Privacy Privacy', 'Privacy Privacy Privacy', '1', '17', '2016-09-06 06:11:23', '2016-10-25 09:19:27');

-- --------------------------------------------------------

--
-- Table structure for table `mst_email_templates`
--

CREATE TABLE `mst_email_templates` (
  `id` int(11) NOT NULL,
  `email_template_title` varchar(255) DEFAULT NULL,
  `email_template_subject` varchar(255) DEFAULT NULL,
  `email_template_content` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_email_templates`
--

INSERT INTO `mst_email_templates` (`id`, `email_template_title`, `email_template_subject`, `email_template_content`, `lang_id`, `active`, `created_at`, `updated_at`) VALUES
(1, 'admin-added', 'You Have Been Added As Admin User', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>You have been added as admin user on ||SITE_TITLE||, your log in details are as follows</p>\r\n\r\n<p>Email ID: ||USER_EMAIL||</p>\r\n\r\n<p>Password: ||PASSWORD||</p>\r\n\r\n<p>You can ||LOGIN_URL|| here to login.</p>\r\n\r\n<p>Thank you', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:53:20'),
(2, 'admin-updated', 'Your Account Has Been Updated', '<p>Dear ||ADMIN_NAME||,</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Your account has been updated on ||SITE_TITLE||,&nbsp; your log in details are as follows</p>\r\n\r\n<p>Username:||USER_NAME||</p>\r\n\r\n<p>Password:||PASSWORD||</p>\r\n\r\n<p>Click on Following link to Log in.</p>\r', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:56:19'),
(3, 'admin-deleted', 'Your Account Has Been Deleted', '<p>Dear ||ADMIN_NAME||,</p>\r\n\r\n<p>Your admin account has been deleted on ||SITE_TITLE||</p>\r\n\r\n<p>You may contact with site administrator for more details.</p>\r\n\r\n<p>Thank you,</p>\r\n\r\n<p><a href="||SITE_PATH||">||SITE_TITLE||</a></p>\r\n', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:55:11'),
(4, 'admin-forgot-password', 'Admin Login Credentials', '<p>Dear ||ADMIN_NAME||,</p>\r\n\r\n<p>Your login credential for your admin account on ||SITE_TITLE|| are as below.</p>\r\n\r\n<p>Username: ||USER_NAME||</p>\r\n\r\n<p>Password: ||PASSWORD||</p>\r\n\r\n<p>Thank you,</p>\r\n\r\n<p><a hreh="||SITE_PATH||">||SITE_TITLE||</a></p>', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:55:49'),
(5, 'admin-email-updated', 'Verify Updated Account', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Your account has been updated on ||SITE_TITLE||,&nbsp; your log in details are as follows</p>\r\n\r\n<p>Username:||USER_NAME||</p>\r\n\r\n<p>Password:||PASSWORD||</p>\r\n\r\n<p>Click on Following link to verif</p>\r\n', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:55:28'),
(6, 'user-registration-successful', 'You Have Successfully Registered', '<p style="line-height: 20.8px;">Dear ||USER_NAME||,</p>\r\n\r\n<p style="line-height: 20.8px;">Thank you for Choosing ||SITE_TITLE||. Please click ||LOGIN_URL|| and&nbsp;use the following system generated LOGIN information,</p>\r\n\r\n<p style="line-height: 20.8p', 17, '1', '2016-06-22 12:36:35', '2017-02-10 10:01:10'),
(7, 'registration-successful-to-admin', 'New User Registered', '<p>Dear Admin,</p>\r\n\r\n<p>New user as ||USER_TYPE||&nbsp;has been registered successfully.</p>\r\n\r\n<p>Following are the User Details,<br />\r\n<br />\r\nUser email : ||USER_EMAIL||</p>\r\n\r\n<p>Zip Code : ||ZIP_CODE||</p>\r\n\r\n<p>Regards,</p>\r\n\r\n<p>&nbsp;</p>\r\n', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:58:55'),
(8, 'forgot-password', 'Recover Your Password', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>Click the link below to set a new password on&nbsp; ||SITE_TITLE||.</p>\r\n\r\n<p>||RESET_PASSWORD_LINK||</p>\r\n\r\n<p>If you don&#39;t want to change your password or did not request a password change, just ignore this message.<', 17, '1', '2016-06-22 12:36:35', '2017-02-10 09:58:04'),
(9, 'user-added', 'You Have Been Added As User', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>You have been added as user on ||SITE_TITLE||, your log in details are as follows</p>\r\n\r\n<p>Email: ||USER_EMAIL||</p>\r\n\r\n<p>Password: ||PASSWORD||</p>\r\n\r\n<p style="line-height: 20.7999992370605px;">Click on Following link<', 17, '1', '2016-04-27 07:16:18', '2017-02-10 10:00:02'),
(10, 'user-updated', 'Your Account Has Been Updated', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>Your account has been updated on ||SITE_TITLE|| ,your log in details are as follows</p>\r\n\r\n<p>Email: ||USER_EMAIL||</p>\r\n\r\n<p>Password: ||PASSWORD||</p>\r\n\r\n<p>Your account is deactivated now, you can access your account af', 17, '1', '2016-06-22 12:36:35', '2017-02-10 10:01:55'),
(11, 'user-deleted', 'Your Account Has Been Deleted', '<p style="line-height: 20.7999992370605px;">Dear ||USER_NAME||,</p>\r\n\r\n<p style="line-height: 20.7999992370605px;">Your account has been deleted on ||SITE_TITLE||</p>\r\n\r\n<p style="line-height: 20.7999992370605px;">You may contact with site administrator f', 17, '1', '2016-06-22 12:36:35', '2017-02-10 10:00:41'),
(12, 'email-changed', 'You Have Changed Your Email Address', '<p>Dear ||USER_NAME||,</p>\r\n\r\n<p>You have changed your email id successfully.</p>\r\n\r\n<p>Here are the credentials for your account.</p>\r\n\r\n<p>Email:-&nbsp;||USER_EMAIL||</p>\r\n\r\n<p>Password:- ||PASSWORD||</p>\r\n\r\n<p>Please ||ACTIVATION_LINK|| to access your<', 17, '1', '2015-08-21 00:00:00', '2017-02-10 09:57:47');

-- --------------------------------------------------------

--
-- Table structure for table `mst_faqs`
--

CREATE TABLE `mst_faqs` (
  `id` int(11) NOT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_how_it_works`
--

CREATE TABLE `mst_how_it_works` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_newletters`
--

CREATE TABLE `mst_newletters` (
  `id` int(11) NOT NULL,
  `newsletter_subject` varchar(255) DEFAULT NULL,
  `newsletter_content` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_news`
--

CREATE TABLE `mst_news` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` longtext,
  `url` varchar(255) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mst_permissions`
--

CREATE TABLE `mst_permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_permissions`
--

INSERT INTO `mst_permissions` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Manage Roles', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(2, 'Manage Users', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(3, 'Manage CMS', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(4, 'Manage Emailtemplate', '2018-04-17 14:08:42', '2018-04-17 14:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `mst_roles`
--

CREATE TABLE `mst_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_roles`
--

INSERT INTO `mst_roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'SuperAdmin', 'Site Owner, who has all permissions.', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(2, 'RegisteredUser', 'A frontend user', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(3, 'SubAdmin', 'A backend user, who can work as per assign task by SuperAdmin', '2018-04-17 14:08:42', '2018-04-17 14:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `mst_settings`
--

CREATE TABLE `mst_settings` (
  `id` int(11) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `lang_id` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_settings`
--

INSERT INTO `mst_settings` (`id`, `key`, `name`, `description`, `value`, `field`, `active`, `lang_id`, `created_at`, `updated_at`) VALUES
(1, 'site-title', 'Site Title', NULL, 'MyAdmin', NULL, '1', '17', '2018-04-17 14:08:41', '2018-04-17 14:08:41'),
(2, 'site-email', 'Site Email', NULL, 'ramesh@panaceatek.com', NULL, '1', '17', '2018-04-17 14:08:41', '2018-04-17 14:08:41'),
(3, 'contact-email', 'Contact Email', NULL, 'grace@panaceatek.com', NULL, '1', '17', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(4, 'date-format', 'Date Format', NULL, '%d.%m.%Y %T', NULL, '1', '17', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(5, 'address', 'Address', NULL, 'kalyani nagar', NULL, '1', '17', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(6, 'zip-code', 'Zip Code', NULL, '411015', NULL, '1', '17', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(7, 'contact-number', 'Contact Number', NULL, '9762137636', NULL, '1', '17', '2018-04-17 14:08:42', '2018-04-17 14:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `mst_users`
--

CREATE TABLE `mst_users` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mst_users`
--

INSERT INTO `mst_users` (`id`, `user_email`, `user_password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'ramesh@panaceatek.com', 'UGFzc0AxMjM=\n', '1', '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(2, 'abhishek.m@panaceatek.com', 'UGFzc0AxMjM=\n', '2', '2018-04-17 14:24:45', '2018-04-17 14:24:45'),
(3, 'uistacks@gmail.com', 'UGFzc0AxMjM=\n', '3', '2018-04-17 14:29:47', '2018-04-17 14:29:47');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20160902122311'),
('20160902122410'),
('20160902122426'),
('20160902122458'),
('20160902122517'),
('20160902122526'),
('20160902122613'),
('20160902124254'),
('20160902124645'),
('20160905063452'),
('20160916105721'),
('20160916110038'),
('20160919085822'),
('20160919122032'),
('20160919122119'),
('20160919122149'),
('20160921063621'),
('20160921093207'),
('20160921100834'),
('20160928085801'),
('20160929084940'),
('20180417145551');

-- --------------------------------------------------------

--
-- Table structure for table `trans_blog_comments`
--

CREATE TABLE `trans_blog_comments` (
  `id` int(11) NOT NULL,
  `post_id` int(11) DEFAULT NULL,
  `commented_by` varchar(255) DEFAULT NULL,
  `commented_user_id` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_blog_posts`
--

CREATE TABLE `trans_blog_posts` (
  `id` int(11) NOT NULL,
  `post_title` varchar(255) DEFAULT NULL,
  `seo_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `post_short_description` varchar(255) DEFAULT NULL,
  `post_content` varchar(255) DEFAULT NULL,
  `page_title` varchar(255) DEFAULT NULL,
  `post_tags` varchar(255) DEFAULT NULL,
  `post_keyword` varchar(255) DEFAULT NULL,
  `posted_by` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `blog_image` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_categories`
--

CREATE TABLE `trans_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `category_name_ch` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category_icon` varchar(255) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `category_id_fk` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_newsletter_sends`
--

CREATE TABLE `trans_newsletter_sends` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `newsletter_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_newsletter_subscriptions`
--

CREATE TABLE `trans_newsletter_subscriptions` (
  `id` int(11) NOT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `user_subscription_code` varchar(255) DEFAULT NULL,
  `is_subscribe_for_daily` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_permission_roles`
--

CREATE TABLE `trans_permission_roles` (
  `id` int(11) NOT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_permission_users`
--

CREATE TABLE `trans_permission_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trans_role_users`
--

CREATE TABLE `trans_role_users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trans_role_users`
--

INSERT INTO `trans_role_users` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(2, 3, 3, '2018-04-17 14:29:48', '2018-04-17 14:29:48');

-- --------------------------------------------------------

--
-- Table structure for table `trans_user_informations`
--

CREATE TABLE `trans_user_informations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_mobile` varchar(255) DEFAULT NULL,
  `user_birth_date` varchar(255) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_zipcode` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `cover_picture` varchar(255) DEFAULT NULL,
  `about_me` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `user_status` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trans_user_informations`
--

INSERT INTO `trans_user_informations` (`id`, `user_id`, `first_name`, `last_name`, `user_name`, `user_mobile`, `user_birth_date`, `user_address`, `user_zipcode`, `profile_picture`, `cover_picture`, `about_me`, `gender`, `user_type`, `user_status`, `activation_code`, `company_name`, `designation`, `provider`, `provider_id`, `promo_code`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ramesh', 'Kumar', 'admin', '1234567890', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '1', NULL, NULL, NULL, NULL, NULL, '2018-04-17 14:08:42', '2018-04-17 14:08:42'),
(2, 2, 'ab', 'M', 'abhishek.m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', '0', 'ZXI5OHRmaW8=\n', NULL, NULL, NULL, NULL, NULL, '2018-04-17 14:24:45', '2018-04-17 14:24:45'),
(3, 3, 'UI', 'Stacks', 'uistacks', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2018-04-17 19:59:47 +0530', NULL, NULL, NULL, NULL, NULL, '2018-04-17 14:29:47', '2018-04-17 14:29:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ar_internal_metadata`
--
ALTER TABLE `ar_internal_metadata`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `mst_blog_categories`
--
ALTER TABLE `mst_blog_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_categories`
--
ALTER TABLE `mst_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_contactus`
--
ALTER TABLE `mst_contactus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_content_pages`
--
ALTER TABLE `mst_content_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_email_templates`
--
ALTER TABLE `mst_email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_faqs`
--
ALTER TABLE `mst_faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_how_it_works`
--
ALTER TABLE `mst_how_it_works`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_newletters`
--
ALTER TABLE `mst_newletters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_news`
--
ALTER TABLE `mst_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_permissions`
--
ALTER TABLE `mst_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_roles`
--
ALTER TABLE `mst_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_settings`
--
ALTER TABLE `mst_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mst_users`
--
ALTER TABLE `mst_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `trans_blog_comments`
--
ALTER TABLE `trans_blog_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_blog_posts`
--
ALTER TABLE `trans_blog_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_categories`
--
ALTER TABLE `trans_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_newsletter_sends`
--
ALTER TABLE `trans_newsletter_sends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_newsletter_subscriptions`
--
ALTER TABLE `trans_newsletter_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_permission_roles`
--
ALTER TABLE `trans_permission_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_permission_users`
--
ALTER TABLE `trans_permission_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_role_users`
--
ALTER TABLE `trans_role_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trans_user_informations`
--
ALTER TABLE `trans_user_informations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `mst_blog_categories`
--
ALTER TABLE `mst_blog_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_categories`
--
ALTER TABLE `mst_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_contactus`
--
ALTER TABLE `mst_contactus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_content_pages`
--
ALTER TABLE `mst_content_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `mst_email_templates`
--
ALTER TABLE `mst_email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `mst_faqs`
--
ALTER TABLE `mst_faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_how_it_works`
--
ALTER TABLE `mst_how_it_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_newletters`
--
ALTER TABLE `mst_newletters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_news`
--
ALTER TABLE `mst_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mst_permissions`
--
ALTER TABLE `mst_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `mst_roles`
--
ALTER TABLE `mst_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `mst_settings`
--
ALTER TABLE `mst_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `mst_users`
--
ALTER TABLE `mst_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `trans_blog_comments`
--
ALTER TABLE `trans_blog_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_blog_posts`
--
ALTER TABLE `trans_blog_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_categories`
--
ALTER TABLE `trans_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_newsletter_sends`
--
ALTER TABLE `trans_newsletter_sends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_newsletter_subscriptions`
--
ALTER TABLE `trans_newsletter_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_permission_roles`
--
ALTER TABLE `trans_permission_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_permission_users`
--
ALTER TABLE `trans_permission_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `trans_role_users`
--
ALTER TABLE `trans_role_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `trans_user_informations`
--
ALTER TABLE `trans_user_informations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
