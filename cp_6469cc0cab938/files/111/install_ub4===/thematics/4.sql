-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 18 2022 г., 22:30
-- Версия сервера: 5.7.38-0ubuntu0.18.04.1
-- Версия PHP: 7.3.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `testing`
--

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters`
--

CREATE TABLE `uni_ads_filters` (
  `ads_filters_id` int(11) NOT NULL,
  `ads_filters_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_visible` int(1) NOT NULL DEFAULT '1',
  `ads_filters_type` varchar(50) CHARACTER SET utf8 NOT NULL,
  `ads_filters_position` int(11) NOT NULL DEFAULT '0',
  `ads_filters_podcat` int(1) NOT NULL DEFAULT '1',
  `ads_filters_id_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_required` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_alias`
--

CREATE TABLE `uni_ads_filters_alias` (
  `ads_filters_alias_id` int(11) NOT NULL,
  `ads_filters_alias_id_filter_item` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_title` varchar(255) DEFAULT NULL,
  `ads_filters_alias_alias` varchar(255) DEFAULT NULL,
  `ads_filters_alias_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_alias_desc` text,
  `ads_filters_alias_h1` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_category`
--

CREATE TABLE `uni_ads_filters_category` (
  `ads_filters_category_id` int(11) NOT NULL,
  `ads_filters_category_id_cat` int(11) NOT NULL DEFAULT '0',
  `ads_filters_category_id_filter` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_ads_filters_items`
--

CREATE TABLE `uni_ads_filters_items` (
  `ads_filters_items_id` int(11) NOT NULL,
  `ads_filters_items_id_filter` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_value` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_id_item_parent` int(11) NOT NULL DEFAULT '0',
  `ads_filters_items_alias` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ads_filters_items_sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `uni_category_board`
--

CREATE TABLE `uni_category_board` (
  `category_board_id` int(11) NOT NULL,
  `category_board_name` varchar(150) CHARACTER SET utf8 NOT NULL,
  `category_board_visible` int(11) NOT NULL DEFAULT '1',
  `category_board_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_id_position` int(11) NOT NULL DEFAULT '0',
  `category_board_text` text CHARACTER SET utf8,
  `category_board_id_parent` int(11) NOT NULL DEFAULT '0',
  `category_board_image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `category_board_description` text CHARACTER SET utf8,
  `category_board_alias` varchar(255) CHARACTER SET utf8 NOT NULL,
  `category_board_count_view` int(11) NOT NULL DEFAULT '0',
  `category_board_date_view` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_board_price` float NOT NULL DEFAULT '0',
  `category_board_count_free` int(11) NOT NULL DEFAULT '0',
  `category_board_status_paid` int(11) NOT NULL DEFAULT '0',
  `category_board_display_price` int(1) NOT NULL DEFAULT '1',
  `category_board_auction` int(11) NOT NULL DEFAULT '0',
  `category_board_secure` int(11) NOT NULL DEFAULT '0',
  `category_board_h1` varchar(255) DEFAULT NULL,
  `category_board_auto_title` int(1) NOT NULL DEFAULT '0',
  `category_board_online_view` int(1) NOT NULL DEFAULT '0',
  `category_board_auto_title_template` varchar(255) DEFAULT NULL,
  `category_board_show_index` int(1) NOT NULL DEFAULT '0',
  `category_board_marketplace` int(1) NOT NULL DEFAULT '0',
  `category_board_booking` int(1) NOT NULL DEFAULT '0',
  `category_board_booking_variant` int(1) NOT NULL DEFAULT '0',
  `category_board_variant_price_id` int(11) NOT NULL DEFAULT '0',
  `category_board_measures_price` text,
  `category_board_rules` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `uni_category_board`
--

INSERT INTO `uni_category_board` (`category_board_id`, `category_board_name`, `category_board_visible`, `category_board_title`, `category_board_id_position`, `category_board_text`, `category_board_id_parent`, `category_board_image`, `category_board_description`, `category_board_alias`, `category_board_count_view`, `category_board_date_view`, `category_board_price`, `category_board_count_free`, `category_board_status_paid`, `category_board_display_price`, `category_board_auction`, `category_board_secure`, `category_board_h1`, `category_board_auto_title`, `category_board_online_view`, `category_board_auto_title_template`, `category_board_show_index`, `category_board_marketplace`, `category_board_booking`, `category_board_booking_variant`, `category_board_variant_price_id`, `category_board_measures_price`, `category_board_rules`) VALUES
(1, 'Автовышки', 1, 'Автовышки', 0, '', 0, NULL, '', 'avtovyshki', 0, '2020-10-12 16:41:34', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(2, 'Автокраны', 1, 'Автокраны', 0, '', 0, NULL, '', 'avtokrany', 0, '2020-10-12 16:41:44', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(3, 'Бульдозеры', 1, 'Бульдозеры', 0, '', 0, NULL, '', 'buldozery', 0, '2020-10-12 16:41:55', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(4, 'Вездеходы-амфибии', 1, 'Вездеходы-амфибии', 0, '', 0, NULL, '', 'vezdehody-amfibii', 0, '2020-10-12 16:42:09', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(5, 'Коммунальная техника', 1, 'Коммунальная техника', 0, '', 0, NULL, '', 'kommunalnaya-tehnika', 0, '2020-10-12 16:42:21', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(6, 'Погрузчики', 1, 'Погрузчики', 0, '', 0, NULL, '', 'pogruzchiki', 0, '2020-10-12 16:42:31', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(7, 'Строительная техника', 1, 'Строительная техника', 0, '', 0, NULL, '', 'stroitelnaya-tehnika', 0, '2020-10-12 16:42:42', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(8, 'Техника для лесозаготовки', 1, 'Техника для лесозаготовки', 0, '', 0, NULL, '', 'tehnika-dlya-lesozagotovki', 0, '2020-10-12 16:42:52', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(9, 'Тракторы, сельхозтехника', 1, 'Тракторы, сельхозтехника', 0, '', 0, NULL, '', 'traktory-selhoztehnika', 0, '2020-10-12 16:43:03', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL),
(10, 'Экскаваторы', 1, 'Экскаваторы', 0, '', 0, NULL, '', 'ekskavatory', 0, '2020-10-12 16:43:15', 0, 1, 0, 1, 0, 0, NULL, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  ADD PRIMARY KEY (`ads_filters_id`);

--
-- Индексы таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  ADD PRIMARY KEY (`ads_filters_alias_id`);

--
-- Индексы таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  ADD PRIMARY KEY (`ads_filters_category_id`);

--
-- Индексы таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  ADD PRIMARY KEY (`ads_filters_items_id`),
  ADD KEY `id_filter` (`ads_filters_items_id_filter`);

--
-- Индексы таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  ADD PRIMARY KEY (`category_board_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `uni_ads_filters`
--
ALTER TABLE `uni_ads_filters`
  MODIFY `ads_filters_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_alias`
--
ALTER TABLE `uni_ads_filters_alias`
  MODIFY `ads_filters_alias_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_category`
--
ALTER TABLE `uni_ads_filters_category`
  MODIFY `ads_filters_category_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_ads_filters_items`
--
ALTER TABLE `uni_ads_filters_items`
  MODIFY `ads_filters_items_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uni_category_board`
--
ALTER TABLE `uni_category_board`
  MODIFY `category_board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
